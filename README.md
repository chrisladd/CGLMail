## Usage

CGLMail makes it easy to send email from any class in your app, without implementing the `MFMailComposeViewControllerDelegate` protocol all over the place. It was initially written to centralize the submission of feedback emails into one class. For example, 

````objc
UIViewController *mailVC = [CGLMailHelper supportMailViewControllerWithRecipient:@"support@support.com" 
                                                                         subject:@"Support Email" 
                                                                      completion:nil];
````

Would yield a view controller that looks like this:

![Support Screenshot](https://raw.github.com/chrisladd/CGLMail/master/screenshots/support-screenshot.png)

Whereas this:

````objc
UIViewController *mailVC = [CGLMailHelper mailViewControllerWithRecipients:@[@"my@mom.com"] 
                                                                   subject:@"Hi Mom!" 
                                                                   message:@"Hi Mom, \n\nJust wanted to check in and say hello!\n\nLove, \nChris" 
                                                                    isHTML:NO 
                                                            includeAppInfo:NO 
                                                                completion:nil];
````

Would yield one that looks more like this:

![Support Screenshot](https://raw.github.com/chrisladd/CGLMail/master/screenshots/email-screenshot.png)

