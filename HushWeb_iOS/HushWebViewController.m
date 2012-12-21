//
//  HushWebViewController.m
//  HushWeb_iOS
//
//  Created by Noel Feliciano on 2012-10-20.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import "HushWebViewController.h"
#import "HushWebModel.h"
#import "HushWebTab.h"

@interface HushWebViewController ()
//Model
@property (nonatomic, strong) HushWebModel *model;
@end

@implementation HushWebViewController

@synthesize panOptions = _panOptions;
@synthesize urlTextField = _urlTextField;

@synthesize grayOverlay = _grayOverlay;

@synthesize panGestureRecognizer = _panGestureRecognizer;

@synthesize model = _model;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.panOptions = [[HushWebPanOptionsView alloc] init];
    self.panOptions.frame = self.view.frame;
    self.panOptions.pawPrint.frame = (CGRect){{self.panOptions.pawPrint.frame.origin.x, self.panOptions.frame.size.height - 48}, {48, 48}};
    
    self.urlTextField.center = CGPointMake(self.view.center.x, self.view.frame.origin.y - self.urlTextField.frame.size.height);
    
    self.model = [[HushWebModel alloc] init];
    [self.model createNewTab];
    //[self.model createNewTab];
    
    [self tabWasSelectedAt:0];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)hush {
    [self closeCurrentTab];
}

#pragma Tab and Model methods
- (void)tabWasSelectedAt:(NSInteger)index {
    [self.model printState];
    
    HushWebTab *nextTab = [self.model switchToTabAt:index];
    currentTabImageView = nextTab.cachedImage;
    currentTabImageView.frame = CGRectMake(0, 0, 133, 200);
    [self.view addSubview:currentTabImageView];
    
    currentWebView.delegate = nil;
    [currentWebView removeGestureRecognizer:self.panGestureRecognizer];
    
    UIWebView *webView = nextTab.webView;
    webView.delegate = self;
    webView.frame = self.view.bounds;
    NSURLRequest *urlRequest;
    urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com"]];
    [webView loadRequest:urlRequest];
    [webView addGestureRecognizer:self.panGestureRecognizer];
    
    [UIView animateWithDuration:0.4 animations:^(void) {
        currentTabImageView.frame = self.view.bounds;
    } completion:^(BOOL finished) {
        [self.view addSubview:webView];
        [currentTabImageView removeFromSuperview];
        [currentWebView removeFromSuperview];
        currentWebView = webView;
    }];
}

- (void)closeCurrentTab {
    [self tabWasSelectedAt:[self.model closeCurrentTab]];
}

#pragma UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //[self hideNavigator];
}


#pragma TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.urlTextField) {
        NSString *url = [self checkStringURL:textField.text];
        [self urlEntered:url];
        [UIView animateWithDuration:0.2 animations:^(void) {
            [self.urlTextField setCenter:CGPointMake(self.view.center.x, 0 - self.urlTextField.frame.size.height / 2)];
            [self.grayOverlay setAlpha:0.0];
        } completion:^(BOOL finished) {
            [self.grayOverlay removeFromSuperview];
            self.grayOverlay = nil;
        }];
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.2 animations:^(void) {
        [self.urlTextField setCenter:CGPointMake(self.view.center.x, 0 - self.urlTextField.frame.size.height / 2)];
        [self.grayOverlay setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self.grayOverlay removeFromSuperview];
        self.grayOverlay = nil;
    }];
}

#pragma Navigator Delegate
- (void)urlEntered:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:[self checkStringURL:urlString]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [currentWebView loadRequest:urlRequest];
}

#pragma Gesture Recognizers
- (IBAction)handlePanGesture:(id)sender {
    if (sender == self.panGestureRecognizer) {
        CGPoint startingPoint = [sender locationInView:currentWebView];
        switch ([self.panGestureRecognizer state]) {
            case UIGestureRecognizerStateBegan:
                if (startingPoint.y >= currentWebView.frame.size.height - 60) {
                    currentWebView.scrollView.scrollEnabled = NO;
                    panFromPaw = YES;
                    [self.view addSubview:self.panOptions];
                    [UIView animateWithDuration:0.2 animations:^(void) {
                        [self.panOptions setAlpha:0.8];
                    } completion:^(BOOL finished) {
                        
                    }];
                }
                break;
            case UIGestureRecognizerStateChanged:
                if (!panFromPaw) {
                    
                } else {
                    self.panOptions.touchPoint = [self.panGestureRecognizer locationInView:self.panOptions];
                    [self.panOptions setNeedsDisplay];
                }
                break;
            case UIGestureRecognizerStateEnded:
                if (panFromPaw) {
                    currentWebView.scrollView.scrollEnabled = YES;
                    
                    CGPoint endingPoint = [sender locationInView:self.panOptions];
                    
                    [UIView animateWithDuration:0.2 animations:^(void) {
                        [self.panOptions setAlpha:0.0];
                        
                    } completion:^(BOOL finished) {
                        [self.panOptions removeFromSuperview];
                        
                        if (CGRectContainsPoint(self.panOptions.urlEntry.frame, endingPoint)) {
                            self.grayOverlay = [[UIImageView alloc] initWithFrame:self.view.frame];
                            self.grayOverlay.backgroundColor = [UIColor lightGrayColor];
                            self.grayOverlay.alpha = 0.0;
                            [self.view addSubview:self.grayOverlay];
                            
                            [self.view bringSubviewToFront:self.urlTextField];
                            [UIView animateWithDuration:0.2 animations:^(void) {
                                [self.grayOverlay setAlpha:0.5];
                                [self.urlTextField setCenter:CGPointMake(self.view.center.x, self.view.frame.origin.y + self.urlTextField.frame.size.height)];
                                [self.urlTextField becomeFirstResponder];
                            } completion:^(BOOL finished) {
                            }];
                        }
                    }];
                }
                panFromPaw = NO;
                
                break;
            default:
                break;
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma navigator stuff




//Extraneous Classes - put in a different file?
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

@end