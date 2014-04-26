## CGLMail

CGLMail makes it easy to send email from any class in your app, without implementing the `MFMailComposeViewControllerDelegate` protocol all over the place. It was initially written to centralize the submission of feedback emails into one class. 

### Usage

If you're using cocoapods like you should, add CGLMail to your podfile:

`pod 'CGLMail', '~> 0.1'`

For example, you can get a view controller to send an email like so:

````objc
UIViewController *mailVC = [CGLMailHelper mailViewControllerWithRecipients:@[@"my@mom.com"] 
                                                                   subject:@"Hi Mom!" 
                                                                   message:@"Hi Mom, \n\nJust wanted to check in and say hello!\n\nLove, \nChris" 
                                                                    isHTML:NO 
                                                            includeAppInfo:NO 
                                                                completion:nil];
````

Which would end up looking somthing like this:

![Support Screenshot](https://raw.github.com/chrisladd/CGLMail/master/screenshots/email-screenshot.png)






Or, to generate a user support email, with diagnostic info about the user's app and device:

````objc
UIViewController *mailVC = [CGLMailHelper supportMailViewControllerWithRecipient:@"support@support.com" 
                                                                         subject:@"Support Email" 
                                                                      completion:nil];
````

Which would yield a view controller that looks like this:

![Support Screenshot](https://raw.github.com/chrisladd/CGLMail/master/screenshots/support-screenshot.png)

