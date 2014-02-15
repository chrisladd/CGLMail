//
//    CGLMailHelper.h
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

typedef void(^CGLMailHelperCompletionBlock)(NSString *result, NSError *error);

/**
 *  This helper is capable of generating view controllers for sending mail, as well as dismissing those controllers once they finish.
 *
*/
@interface CGLMailHelper : NSObject

/**
 *  Convenience method to return a single mail view controller, given a single recipient and a subject.
 *
 *  This is the same as using the more verbose version, and passing nil for the subject, NO for isHTML,
 *  and YES for includeAppInfo.
 *
 *  @param recipient a string representing the email address of a recipient.
 *  @param subject   the subject of the email.
 *
 *  @return A view controller. There is no need to act as its MFMailComposeDelegate.
 */
+ (UIViewController *)supportMailViewControllerWithRecipient:(NSString *)recipient
                                                     subject:(NSString *)subject
                                                  completion:(CGLMailHelperCompletionBlock)completion;;

/**
 *  Returns a view controller to send email, given an array of recipients, and other optional fields
 *
 *  @param recipients    An array of recipients, strings, representing email addresses.
 *  @param subject       The subject
 *  @param message       The message
 *  @param isHTML        a BOOL indicating whether this message is in HTML, or plaintext.
 *  @param shouldInclude whether or not diagnostic information about the user's current app and device should be included. This is fetched from the app's plist, and from the device itself.
 *
 *  @return A view controller. There is no need to act as its MFMailComposeDelegate.
 */
+ (UIViewController *)mailViewControllerWithRecipients:(NSArray *)recipients
                                               subject:(NSString *)subject
                                               message:(NSString *)message
                                                isHTML:(BOOL)isHTML
                                        includeAppInfo:(BOOL)shouldInclude
                                            completion:(CGLMailHelperCompletionBlock)completion;

/**
 *  Equivalent to calling [MFMailComposeViewController canSendMail], but this way you don't need the headers.
 *
 */
+ (BOOL)canSendMail;

/**
 *  Shows an alert that makes the problem plain to users. Possibly localized, depending on the app's strings file. 
 */
+ (void)showNoMailAvailableAlert;

@end
