//
//  MessagesPage.m
//  Lovevery Test App
//
//  Created by Dustin Dettmer on 11/19/20.
//

#import "MessagesPage.h"
#import "Messages.h"
#import "misc.h"

@interface MessagesPage ()

@property (weak) IBOutlet UITableView *tableView;

@property (strong) NSDictionary *messages;

@end

@implementation MessagesPage

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    __weak MessagesPage *weakSelf = self;
    
    [Messages.shared loadMessages:self.user result:^(NSDictionary *result) {
        
        MessagesPage *strongSelf = weakSelf;
        
        strongSelf.messages = result;
        
        [strongSelf.tableView reloadData];
    }];
}

- (NSString*)userFor:(NSIndexPath*)indexPath
{
    NSInteger counter = indexPath.row;
    
    for(NSString *user in self.messages)
        for(NSDictionary *message UNUSED in self.messages[user])
            if(0 == counter--)
                return user;
    
    return nil;
}

- (NSDictionary*)payloadFor:(NSIndexPath*)indexPath
{
    NSInteger counter = indexPath.row;
    
    for(NSString *user in self.messages)
        for(NSDictionary *message in self.messages[user])
            if(0 == counter--)
                return message;
    
    return nil;
}

- (NSInteger)numberOfPayloads
{
    NSInteger counter = 0;
    
    for(NSString *user in self.messages)
        counter += [self.messages[user] count];
    
    return counter;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self numberOfPayloads];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Message"];
    
    UILabel *user = [cell viewWithTag:1];
    UILabel *subject = [cell viewWithTag:2];
    UILabel *message = [cell viewWithTag:3];
    
    user.text = [NSString stringWithFormat:@"%@ says:", [self userFor:indexPath]];
    subject.text = [NSString stringWithFormat:@"subject: %@", [self payloadFor:indexPath][@"subject"]];
    message.text = [self payloadFor:indexPath][@"message"];
    
    user.accessibilityValue = user.text;
    subject.accessibilityValue = subject.text;
    message.accessibilityValue = message.text;
    
    return cell;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(nullable id)sender
{
    if([identifier isEqual:@"userMessages"] && self.user)
        return NO;
    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender
{
    if([segue.identifier isEqual:@"userMessages"]) {
        
        MessagesPage *page = segue.destinationViewController;
        
        page.user = [self userFor:[self.tableView indexPathForCell:sender]];
    }
}

@end
