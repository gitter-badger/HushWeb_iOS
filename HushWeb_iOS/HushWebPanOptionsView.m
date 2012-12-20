//
//  HushWebPanOptionsView.m
//  HushWeb_iOS
//
//  Created by Noel Feliciano on 2012-11-14.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import "HushWebPanOptionsView.h"

@implementation HushWebPanOptionsView

@synthesize pawPrint = _pawPrint;
@synthesize touchPoint;

@synthesize urlEntry = _urlEntry;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"HushWebPanOptionsView" owner:nil options:nil];
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[HushWebPanOptionsView class]]) {
                self = currentObject;
            }
        }
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context    = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGContextSetLineWidth(context, 8.0);
    
    
    CGContextMoveToPoint(context, self.pawPrint.center.x,self.pawPrint.center.y); //start at this point
    
    CGContextAddLineToPoint(context, self.touchPoint.x, self.touchPoint.y); //draw to this point
    
    // and now draw the Path!
    CGContextStrokePath(context);
}


@end
