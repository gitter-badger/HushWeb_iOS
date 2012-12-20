//
//  HushWebViewController.h
//  HushWeb_iOS
//
//  Created by Noel Feliciano on 2012-10-20.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HushWebPanOptionsView.h"

@class HushWebModel;

@interface HushWebViewController : UIViewController <UIGestureRecognizerDelegate, UIWebViewDelegate, UITextFieldDelegate> {
    
    UIWebView *currentWebView;
    UIImageView *currentTabImageView;
    
    BOOL panFromPaw;
}

//Views
@property (nonatomic, strong) HushWebPanOptionsView *panOptions;
@property (nonatomic, weak) IBOutlet UITextField *urlTextField;

@property (nonatomic, strong) UIImageView *grayOverlay;

//Gestures
@property (nonatomic, weak) IBOutlet UIPanGestureRecognizer *panGestureRecognizer;

- (IBAction)handlePanGesture:(id)sender;

@end
