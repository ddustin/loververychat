//
//  MessagesPage.m
//  Lovevery Test App
//
//  Created by Dustin Dettmer on 11/19/20.
//

#import "MessagesPage.h"

@interface MessagesPage ()

@property (weak) UITableView *tableView;

@property (strong) NSArray *messages;

@end

@implementation MessagesPage

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // TODO: Load the messages
}

- (NSString*)userFor:(NSIndexPath*)indexPath
{
    // TODO: Return the user
    
    return nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender
{
    if([segue.identifier isEqual:@"userMessages"]) {
        
        MessagesPage *page = segue.destinationViewController;
        
        page.user = [self userFor:[self.tableView indexPathForCell:sender]];
    }
}

@end
