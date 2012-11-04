//
//  HushWebViewController.h
//  HushWeb_iOS
//
//  Created by Noel Feliciano on 2012-10-20.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HushWebNavigatorView.h"

@class HushWebModel;

@interface HushWebViewController : UIViewController <HushWebNavigatorDelegate, UIGestureRecognizerDelegate> {
    float tabAndManagerAnchor;
    BOOL panningFromBottom;
    
    UIWebView *currentWebView;
    UIImageView *currentTabImageView;
}

//Views
@property (nonatomic, weak) IBOutlet UIImageView *tabImageView;
@property (nonatomic, strong) HushWebNavigatorView *navigator;

//Gestures
@property (nonatomic, weak) IBOutlet UIPanGestureRecognizer *tabPanRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer *navigatorPanRecognizer;
- (IBAction)handlePanGesture:(id)sender;



@end
