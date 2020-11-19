//
//  Messages.h
//  Lovevery Test App
//
//  Created by Dustin Dettmer on 11/19/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Messages : NSObject

+ (instancetype)shared;

- (void)loadMessages:(nullable NSString*)user result:(void (^)(NSDictionary *result))callback;

- (void)postMessage:(NSString*)user subject:(NSString*)subject message:(NSString*)message result:(void (^)(BOOL success))callback;

@end

NS_ASSUME_NONNULL_END
