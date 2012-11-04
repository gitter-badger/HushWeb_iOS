//
//  HushWebNavigatorView.h
//  HushWeb_iOS
//
//  Created by Noel Feliciano on 2012-10-20.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HushWebNavigatorDelegate

- (void)urlEntered:(NSString *)urlString;

@optional

@end

@interface HushWebNavigatorView : UIView <UITextFieldDelegate>

@property (nonatomic) id <HushWebNavigatorDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *urlAndControlsView;
@property (nonatomic, weak) IBOutlet UITextField *urlTextField;
@property (nonatomic, weak) IBOutlet UIImageView *fingerAnimationImage;

@end
