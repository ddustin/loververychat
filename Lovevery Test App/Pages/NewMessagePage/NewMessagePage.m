//
//  NewMessagePage.m
//  Lovevery Test App
//
//  Created by Dustin Dettmer on 11/19/20.
//

#import "NewMessagePage.h"
#import "Messages.h"

@interface NewMessagePage ()

@property (weak) IBOutlet UITextField *user;
@property (weak) IBOutlet UITextField *subject;
@property (weak) IBOutlet UITextField *message;

@end

@implementation NewMessagePage

- (IBAction)submit
{
    __block BOOL canceled = NO;
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Submitting message"
                               message:@"please wait"
                               preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive
                                   handler:^(UIAlertAction * action) {
        
        canceled = YES;
        
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];

    [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    __weak NewMessagePage *weakSelf = self;
    
        [Messages.shared postMessage:self.user.text subject:self.subject.text message:self.message.text result:^(BOOL success) {
        
            if(success && !canceled) {
                
                [alert dismissViewControllerAnimated:NO completion:^{
                    
                    NewMessagePage *strongSelf = weakSelf;
                    
                    [strongSelf.navigationController popViewControllerAnimated:YES];
                }];
            }
    }];
}

@end
