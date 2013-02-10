//
//  HushWebPanOptionsView.h
//  HushWeb_iOS
//
//  Created by Noel Feliciano on 2012-11-14.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PanOptionsDelegate

-(void)urlEntered:(NSString *)url;

@end

@interface HushWebPanOptionsView : UIView <UITextFieldDelegate, UIGestureRecognizerDelegate>

//Subviews
@property (nonatomic, weak) IBOutlet UITextField *urlEntry;
@property (nonatomic, weak) IBOutlet UIView *additionalKeyboard;
@property (nonatomic, weak) IBOutlet UIImageView *keyboardTab;

@property (nonatomic, weak) IBOutlet UISwipeGestureRecognizer *swipeDownOnTab;

@property (nonatomic) id <PanOptionsDelegate> delegate;

@end
