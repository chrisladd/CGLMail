//
//    CGLMailHelper.m
//    Copyright (c) 2013 Chris Ladd. All rights reserved.
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in
//    all copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//    THE SOFTWARE.


#import "CGLMailHelper.h"
#import <MessageUI/MessageUI.h>

@interface CGLMailHelper() <MFMailComposeViewControllerDelegate>
@property (nonatomic) NSMutableDictionary *completionDictionary;
@end

@implementation CGLMailHelper

+ (NSString *)appInfo {
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    NSString *prodName = info[@"CFBundleDisplayName"];
    NSString *prodVersion = info[@"CFBundleVersion"];
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    NSString *deviceName = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? @"iPad" : @"iPhone";

    
    NSString *message = [NSString stringWithFormat:@"\n\n\n\n.....................................\nMy App: %@\nMy Version: %@\nMy iOS: %@ %@\n..................................", prodName, prodVersion, deviceName, currSysVer];
    
    return message;
}


+ (UIViewController *)supportMailViewControllerWithRecipient:(NSString *)recipient
                                                     subject:(NSString *)subject
                                                  completion:(CGLMailHelperCompletionBlock)completion{
    return [self mailViewControllerWithRecipients:@[recipient]
                                          subject:subject
                                          message:nil
                                           isHTML:NO
                                   includeAppInfo:YES
                                       completion:completion];
}

+ (UIViewController *)mailViewControllerWithRecipients:(NSArray *)recipients
                                               subject:(NSString *)subject
                                               message:(NSString *)message
                                                isHTML:(BOOL)isHTML
                                        includeAppInfo:(BOOL)shouldInclude
                                            completion:(CGLMailHelperCompletionBlock)completion {

    UIViewController *mailViewController = nil;
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *vc = [[MFMailComposeViewController alloc] init];
        [vc setMailComposeDelegate:[CGLMailHelper sharedHelper]];
        [vc setSubject:subject];

        NSMutableString *appendableMessage = [NSMutableString string];
        
        if ([message length]) {
            [appendableMessage appendString:message];
        }
        
        if (shouldInclude) {
            [appendableMessage appendString:[self appInfo]];
        }

        [vc setMessageBody:appendableMessage
                    isHTML:isHTML];
        
        if ([recipients count]) {
            [vc setToRecipients:recipients];
        }
        
        if (completion) {
            [CGLMailHelper sharedHelper].completionDictionary[@(vc.hash)] = [completion copy];
        }
        
        mailViewController = vc;
    }
    
    return mailViewController;
}


+ (instancetype)sharedHelper {
    static CGLMailHelper *helper = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[CGLMailHelper alloc] init];
    });
    
    return helper;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _completionDictionary = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (NSString *)descriptionForResult:(MFMailComposeResult)result {
    NSString *desc;
    switch (result) {
        case MFMailComposeResultCancelled:
            desc = @"Cancelled";
            break;
        case MFMailComposeResultSaved:
            desc = @"Saved";
            break;
        case MFMailComposeResultSent:
            desc = @"Sent";
            break;
        case MFMailComposeResultFailed:
            desc = @"Failed";
            break;
        default:
            desc = @"Unknown";
            break;
    }

    return desc;
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error {

    CGLMailHelperCompletionBlock completion = self.completionDictionary[@(controller.hash)];
    
    if (completion) {
        completion([self descriptionForResult:result], error);
        [self.completionDictionary removeObjectForKey:@(controller.hash)];
    }
    
    if (controller.presentingViewController) {
        [controller dismissViewControllerAnimated:YES
                                       completion:NULL];
    }
}

+ (BOOL)canSendMail {
    return [MFMailComposeViewController canSendMail];
}

+ (void)showNoMailAvailableAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No Mail Available", @"No Mail Available") message:NSLocalizedString(@"It appears you have not set up an email account on this device.", @"Set up account message.") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
    
    [alert show];
}

@end
