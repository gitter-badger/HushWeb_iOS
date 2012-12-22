//
//  HushWebPanOptionsView.h
//  HushWeb_iOS
//
//  Created by Noel Feliciano on 2012-11-14.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HushWebPanOptionsView : UIView

//Subviews
@property (nonatomic, weak) IBOutlet UIImageView *pawPrint;
@property (nonatomic) CGPoint touchPoint;

@property (nonatomic, weak) IBOutlet UIImageView *urlEntry;
@property (nonatomic, weak) IBOutlet UIImageView *backButton;
@property (nonatomic, weak) IBOutlet UIImageView *forwardButton;

@end
