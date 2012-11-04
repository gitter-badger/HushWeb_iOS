//
//  HushWebNavigatorView.m
//  HushWeb_iOS
//
//  Created by Noel Feliciano on 2012-10-20.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import "HushWebNavigatorView.h"

@implementation HushWebNavigatorView

@synthesize delegate = _delegate;
@synthesize urlAndControlsView = _urlAndControlsView;
@synthesize urlTextField = _urlTextField;
@synthesize fingerAnimationImage = _fingerAnimationImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"HushWebNavigatorView" owner:nil options:nil];
        for(id currentObject in topLevelObjects)
        {
            if ([currentObject isKindOfClass:[HushWebNavigatorView class]])
            {
                self = currentObject;
                break;
            }
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *urlString = [[textField text] lowercaseString];
    [self.delegate urlEntered:urlString];
    [self.urlTextField resignFirstResponder];
    return YES;
}

@end
