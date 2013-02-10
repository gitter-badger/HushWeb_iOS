//
//  HushWebPanOptionsView.m
//  HushWeb_iOS
//
//  Created by Noel Feliciano on 2012-11-14.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import "HushWebPanOptionsView.h"

@implementation HushWebPanOptionsView

@synthesize urlEntry = _urlEntry;
@synthesize swipeDownOnTab = _swipeDownOnTab;

@synthesize delegate = _delegate;

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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.urlEntry) {
        [self.delegate urlEntered:[self checkStringURL:textField.text]];
    }
    return YES;
//    if (textField == self.urlTextField) {
//        wentBackOrForward = NO;
//        NSString *url = [self checkStringURL:textField.text];
//        [self urlEntered:url];
//        [UIView animateWithDuration:0.2 animations:^(void) {
//            [self.urlTextField setCenter:CGPointMake(self.view.center.x, 0 - self.urlTextField.frame.size.height / 2)];
//            [self.grayOverlay setAlpha:0.0];
//        } completion:^(BOOL finished) {
//            [self.grayOverlay removeFromSuperview];
//            self.grayOverlay = nil;
//        }];
//        [textField resignFirstResponder];
//    }
//    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
//    [UIView animateWithDuration:0.2 animations:^(void) {
//        [self.urlTextField setCenter:CGPointMake(self.view.center.x, 0 - self.urlTextField.frame.size.height / 2)];
//        [self.grayOverlay setAlpha:0.0];
//    } completion:^(BOOL finished) {
//        [self.grayOverlay removeFromSuperview];
//        self.grayOverlay = nil;
//    }];
}

#pragma mark Gesture Recognizers
- (IBAction)handleSwipeGesture:(id)sender {
    if (sender == self.swipeDownOnTab) {
        [UIView animateWithDuration:0.1 animations:^(void) {
            [self.keyboardTab setAlpha:0.0];
            [self.additionalKeyboard setAlpha:0.0];
            
        } completion:^(BOOL finished) {
            [self.urlEntry resignFirstResponder];
        }];
    }
}

#pragma mark Other Methods
//Extraneous Methods - put in a different file?
- (NSString *)checkStringURL:(NSString *)string {
    if ([string hasPrefix:@"http://"]) {
        return string;
    } else {
        if ([string hasPrefix:@"www."]) {
            return [NSString stringWithFormat:@"http://%@", string];
        } else {
            if ([string hasSuffix:@".com"] || [string hasSuffix:@".net"] || [string hasSuffix:@".org"]) {
                return [NSString stringWithFormat:@"http://www.%@", string];
            } else {
                return nil;
            }
        }
    }
    return nil;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 }
 */

@end
