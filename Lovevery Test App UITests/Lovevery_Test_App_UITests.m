//
//  Lovevery_Test_App_UITests.m
//  Lovevery Test App UITests
//
//  Created by Dustin Dettmer on 11/19/20.
//

#import <XCTest/XCTest.h>

@interface Lovevery_Test_App_UITests : XCTestCase

@end

@implementation Lovevery_Test_App_UITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    
    sleep(1);
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // UI tests must launch the application that they test.
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];
    
    sleep(1);
    
    XCUIElement *tableView = app.tables.firstMatch;
    
    id pred = nil;
    
    NSString *robotRon = @"Robot-Ron";
    
    NSString *user = robotRon;
    NSString *subject = @"Updates From The Field";
    NSString *message = @"Automaton Alex went into the forest to look for a friend for Sally. Not much exploring of this region has been done, we remain hopeful nearby robots will be friendly. The little one made its first few steps.";

    [app.buttons[@"Add Message"] tap];
    
    sleep(1);
    
    [app.textFields[@"User Name"] tap];
    [app.textFields[@"User Name"] typeText:user];
    
    sleep(1);
    
    [app.textFields[@"Subject"] tap];
    [app.textFields[@"Subject"] typeText:subject];
    
    sleep(1);
    
    [app.textFields[@"Message"] tap];
    [app.textFields[@"Message"] typeText:message];
    
    sleep(1);

    [app.buttons[@"Submit"] tap];
    
    XCTAssert([app.staticTexts[@"Name"] waitForExistenceWithTimeout:2]);
    
    pred = [NSPredicate predicateWithFormat:@"value like %@", [user stringByAppendingString:@" says:"]];
    
    XCTAssert([app.staticTexts matchingPredicate:pred].count);
    
    pred = [NSPredicate predicateWithFormat:@"value like %@", [@"subject: " stringByAppendingString:subject]];
    
    XCTAssert([app.staticTexts matchingPredicate:pred].count);
    
    pred = [NSPredicate predicateWithFormat:@"value like %@", message];
    
    XCTAssert([app.staticTexts matchingPredicate:pred].count);
    
    sleep(1);
    
    [app.buttons[@"Add Message"] tap];
    
    user = @"Automaton-Alex";
    subject = @"Updates From The Forest";
    message = @"I have journeyed deep into the forest and can hardly believe what I've found. There is an ancient tribe of robots that have apparently been here for thousands of years. They were gratuitous and offered me gifts of lavender oil and some kind of anti rust ointment. I am headed back to camp to share the good news.";
    
    sleep(1);
    
    [app.textFields[@"User Name"] tap];
    [app.textFields[@"User Name"] typeText:user];
    
    sleep(1);
    
    [app.textFields[@"Subject"] tap];
    [app.textFields[@"Subject"] typeText:subject];
    
    sleep(1);
    
    [app.textFields[@"Message"] tap];
    [app.textFields[@"Message"] typeText:message];
    
    sleep(1);
    
    [app.buttons[@"Submit"] tap];
    
    sleep(5);
    
    XCTAssert([app.staticTexts[@"Name"] waitForExistenceWithTimeout:2]);
    
    pred = [NSPredicate predicateWithFormat:@"value like %@", [user stringByAppendingString:@" says:"]];
    
    XCTAssert([app.staticTexts matchingPredicate:pred].count);
    
    pred = [NSPredicate predicateWithFormat:@"value like %@", [@"subject: " stringByAppendingString:subject]];
    
    XCTAssert([app.staticTexts matchingPredicate:pred].count);
    
    pred = [NSPredicate predicateWithFormat:@"value like %@", message];
    
    XCTAssert([app.staticTexts matchingPredicate:pred].count);
    
    sleep(1);
    
    XCUIElement *cell = [app.staticTexts matchingPredicate:[NSPredicate predicateWithFormat:@"value like %@", [user stringByAppendingString:@" says:"]]].firstMatch;
    
    for(int i = 0; i < 10 && [cell exists] && [tableView exists]; i++) {
        
        if(cell.frame.origin.y + cell.frame.size.height >= tableView.frame.origin.y + tableView.frame.size.height) {
            
            [tableView swipeUp];
            sleep(1);
        }
    }
    
    sleep(1);
    
    [cell tap];
    
    sleep(1);
    
    pred = [NSPredicate predicateWithFormat:@"value like %@", [user stringByAppendingString:@" says:"]];
    
    XCTAssert([app.staticTexts matchingPredicate:pred].count);
    
    pred = [NSPredicate predicateWithFormat:@"value like %@", [robotRon stringByAppendingString:@" says:"]];
    
    // Check there is no robot ron in this chat
    XCTAssert([app.staticTexts matchingPredicate:pred].count == 0);
    
    sleep(5);
    
    [app.buttons[@"Back"] tap];
}

- (void)testLaunchPerformance {
    if (@available(macOS 10.15, iOS 13.0, tvOS 13.0, *)) {
        // This measures how long it takes to launch your application.
        [self measureWithMetrics:@[[[XCTApplicationLaunchMetric alloc] init]] block:^{
            [[[XCUIApplication alloc] init] launch];
        }];
    }
}

@end
