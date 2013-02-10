//
//  HushWebViewController.h
//  HushWeb_iOS
//
//  Created by Noel Feliciano on 2012-10-20.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HushWebPanOptionsView.h"
#import "HushWebNavigatorView.h"

@class HushWebModel;

@interface HushWebViewController : UIViewController <UIGestureRecognizerDelegate, UIWebViewDelegate, PanOptionsDelegate> {
    
    UIWebView *currentWebView;
    UIImageView *currentTabImageView;
    
    BOOL panFromPaw;
    BOOL wentBackOrForward;
}

//Views
@property (nonatomic, strong) HushWebPanOptionsView *panOptions;
@property (nonatomic, strong) HushWebNavigatorView *navigatorView;

//Gestures
@property (nonatomic, weak) IBOutlet UIPanGestureRecognizer *panGestureRecognizer;

- (IBAction)handlePanGesture:(id)sender;
- (IBAction)handleTapGesture:(id)sender;

@end
