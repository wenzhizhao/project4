//
//  DetailViewController.h
//  project4
//
//  Created by Yinchuan Zhou on 5/17/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface DetailViewController : UIViewController<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>
@property(strong,nonatomic) NSDictionary *dict;
@end
