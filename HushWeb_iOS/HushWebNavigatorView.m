//
//  HushWebNavigatorView.m
//  HushWeb_iOS
//
//  Created by Noel Feliciano on 2012-12-23.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import "HushWebNavigatorView.h"

@implementation HushWebNavigatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"HushWebNavigatorView" owner:nil options:nil];
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[HushWebNavigatorView class]]) {
                self = currentObject;
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

@end
