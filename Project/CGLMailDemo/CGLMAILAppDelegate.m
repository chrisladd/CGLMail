//
//  CGLMAILAppDelegate.m
//  CGLMailDemo
//
//  Created by Christopher Ladd on 2/15/14.
//  Copyright (c) 2014 Christopher Ladd. All rights reserved.
//

#import "CGLMAILAppDelegate.h"
#import <CGLMail/CGLMailHelper.h>

@implementation CGLMAILAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.rootViewController = [[UIViewController alloc] init];
    
//    UIViewController *mailVC = [CGLMailHelper supportMailViewControllerWithRecipient:@"support@support.com" subject:@"Support Email" completion:^(NSString *result, NSError *error) {
//        NSLog(@"%s: %@, %@", __PRETTY_FUNCTION__, result, error);
//    }];

    UIViewController *mailVC = [CGLMailHelper mailViewControllerWithRecipients:@[@"my@mom.com"] subject:@"Hi Mom!" message:@"Hi Mom, \n\nJust wanted to check in and say hello!\n\nLove, \nChris" isHTML:NO includeAppInfo:NO completion:nil];

    
    [self.window.rootViewController presentViewController:mailVC animated:YES completion:NULL];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
