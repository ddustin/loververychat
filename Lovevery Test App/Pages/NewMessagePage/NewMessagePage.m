//
//  NewMessagePage.m
//  Lovevery Test App
//
//  Created by Dustin Dettmer on 11/19/20.
//

#import "NewMessagePage.h"

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

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
        
        canceled = YES;
        
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];

    [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    __weak NewMessagePage *weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // Do message submit
        
        if(!canceled) {
            [alert dismissViewControllerAnimated:NO completion:^{
                
                NewMessagePage *strongSelf = weakSelf;
                
                [strongSelf.navigationController popViewControllerAnimated:YES];
            }];
        }
    });
}

@end
