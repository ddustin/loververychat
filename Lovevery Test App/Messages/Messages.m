//
//  Messages.m
//  Lovevery Test App
//
//  Created by Dustin Dettmer on 11/19/20.
//

#import "Messages.h"
#import "misc.h"

@implementation Messages

+ (instancetype)shared
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [Messages new];
    });
    
    return instance;
}

- (void)loadMessages:(NSString *)user result:(void (^)(NSDictionary *))callback
{
    // Server isn't designed to handle empty string usernames
    if(!user.length)
        user = nil;
    
    NSString *url = @"https://abraxvasbh.execute-api.us-east-2.amazonaws.com/proto/messages";
    
    if(user)
        url = [url stringByAppendingFormat:@"/%@", user];
    
    dispatch_async(dispatch_queue_create("MessageDownload", NULL), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        NSDictionary *object = data ? [NSJSONSerialization JSONObjectWithData:data options:0 error:nil] : nil;
        
        if(![object isKindOfClass:[NSDictionary class]])
            object = nil;
        
        if(![object[@"statusCode"] isEqual:@200])
            object = nil;
        
        object = object[@"body"] ? [NSJSONSerialization JSONObjectWithData:[object[@"body"] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil] : nil;
        
        if(user) {
            
            object = @{ user: object[@"message"] };
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            callback(object);
        });
    });
}

- (void)postMessage:(NSString *)user subject:(NSString *)subject message:(NSString *)message result:(void (^)(BOOL))callback
{
    NSDictionary *obj =
    @{
        @"operation": @"add_message",
        @"user": user ?: @"",
        @"subject": subject ?: @"",
        @"message": message ?: @"",
    };

    NSMutableURLRequest *req = [NSMutableURLRequest new];

    req.URL = [NSURL URLWithString:@"https://abraxvasbh.execute-api.us-east-2.amazonaws.com/proto/messages"];
    req.HTTPMethod = @"POST";
    req.HTTPBody = [NSJSONSerialization dataWithJSONObject:obj options:0 error:nil];
    
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        id result UNUSED = data ? [NSJSONSerialization JSONObjectWithData:data options:0 error:nil] : nil;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            callback(YES);
        });
    }];
    
    [task resume];
}

@end
