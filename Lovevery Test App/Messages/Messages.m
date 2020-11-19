//
//  Messages.m
//  Lovevery Test App
//
//  Created by Dustin Dettmer on 11/19/20.
//

#import "Messages.h"

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

- (void)loadMessages:(NSString *)user result:(void (^)(NSDictionary * _Nonnull))callback
{
    NSDictionary *result =
    @{
        @"dan": @[ @{
        @"subject": @"pets",
        @"message": @"dogs are happy" },
        @{
        @"subject": @"pets", @"message": @"cats are grumpy"
        } ],
        @"bob": @[ @{
        @"subject": @"bob stuff",
        @"message": @"bob bob bob" },
        @{
        @"subject": @"bob stuff",
        @"message": @"there once was a guy named bob"
        } ]
    };
    
    callback(result);
}

- (void)postMessage:(NSString *)user subject:(NSString *)subject message:(NSString *)message result:(void (^)(BOOL))callback
{
    // TODO
}

@end
