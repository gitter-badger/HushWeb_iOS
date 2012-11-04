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

@synthesize tabImageView = _tabImageView;
@synthesize navigator = _navigator;

@synthesize tabPanRecognizer = _tabPanRecognizer;
@synthesize navigatorPanRecognizer = _navigatorPanRecognizer;

@synthesize model = _model;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // alloc navigator
    // add subview to self.frame.origin.y - navigator.view.frame.size.height
    // add button subview for pulling and pushing
    self.navigator = [[HushWebNavigatorView alloc] init];
    self.navigator.frame = CGRectMake(self.view.frame.size.width / 2 - self.navigator.frame.size.width / 2, 0 - self.navigator.frame.size.height, self.navigator.frame.size.width, self.navigator.frame.size.height);
    self.navigator.delegate = self;
    [self.view addSubview:self.navigator];
    
    self.navigatorPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    self.navigatorPanRecognizer.maximumNumberOfTouches = 1;
    self.navigatorPanRecognizer.delaysTouchesEnded = YES;
    self.navigatorPanRecognizer.cancelsTouchesInView = YES;
    self.navigatorPanRecognizer.delegate = self;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.model = [[HushWebModel alloc] init];
    [self.model createNewTab];
    //[self.model createNewTab];
    
    [self tabWasSelectedAt:0];
    //[self performSelector:@selector(hush) withObject:nil afterDelay:4.0];
    
    tabAndManagerAnchor = self.tabImageView.center.y - self.navigator.center.y;
    
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
    
    UIWebView *webView = nextTab.webView;
    webView.frame = self.view.bounds;
    NSURLRequest *urlRequest;
    if (index == 0) urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com"]];
    else urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.apple.com"]];
    [webView loadRequest:urlRequest];
    
    [self.view bringSubviewToFront:self.tabImageView];
    [UIView animateWithDuration:0.4 animations:^(void) {
        currentTabImageView.frame = self.view.bounds;
    } completion:^(BOOL finished) {
        [self.view addSubview:webView];
        [currentTabImageView removeFromSuperview];
        [currentWebView removeFromSuperview];
        currentWebView = webView;
        [self.view bringSubviewToFront:self.tabImageView];
    }];
    
    //add gesture recognizers
}

- (void)closeCurrentTab {
    [self tabWasSelectedAt:[self.model closeCurrentTab]];
}

#pragma Navigator Delegate
- (void)urlEntered:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:[self checkStringURL:urlString]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [currentWebView loadRequest:urlRequest];
}

#pragma Gesture Recognizers
- (IBAction)handlePanGesture:(id)sender {
    if (sender == self.tabPanRecognizer) {
        CGPoint fingerLocation = [sender locationInView:self.view];
        
        switch ([sender state]) {
            case UIGestureRecognizerStateBegan:
                [self.view bringSubviewToFront:self.navigator];
                
                break;
            case UIGestureRecognizerStateChanged:
                //this is a check to make sure the navigator doesn't go too far in or out
                if (self.navigator.frame.origin.y > -40) {
                    [sender setEnabled:NO];
                    [sender setEnabled:YES];
                    [self snapNavigatorToPlace];
                } else if (self.tabImageView.frame.origin.y < 0) {
                    [self.tabImageView setFrame:CGRectMake(self.tabImageView.frame.origin.x, 0, self.tabImageView.frame.size.width, self.tabImageView.frame.size.height)];
                    [self.navigator setCenter:CGPointMake(self.navigator.center.x, self.tabImageView.center.y - tabAndManagerAnchor)];
                } else {
                    //here we do the appearance/disappearances
                    [self.tabImageView setCenter:CGPointMake(self.tabImageView.center.x, fingerLocation.y) ];
                    [self.navigator setCenter:CGPointMake(self.navigator.center.x, self.tabImageView.center.y - tabAndManagerAnchor)];
                    
                    [self changeNavigatorAppearances];
                }
                
                break;
                
            case UIGestureRecognizerStateEnded:
                if (self.navigator.frame.origin.y > -40) {
                    [self.navigator setFrame:CGRectMake(self.navigator.frame.origin.x, -40, self.navigator.frame.size.width, self.navigator.frame.size.height)];
                    [self.tabImageView setCenter:CGPointMake(self.tabImageView.center.x, self.navigator.center.y + tabAndManagerAnchor)];
                } else if (self.tabImageView.frame.origin.y < 0) {
                    [self.tabImageView setFrame:CGRectMake(self.tabImageView.frame.origin.x, 0, self.tabImageView.frame.size.width, self.tabImageView.frame.size.height)];
                    [self.navigator setCenter:CGPointMake(self.navigator.center.x, self.tabImageView.center.y - tabAndManagerAnchor)];
                }

                [self snapNavigatorToPlace];
                //[self changeNavigatorAppearances];
                
                [sender setEnabled:YES];
                break;
            default:
                break;
        }
    }
    
    else if (sender == self.navigatorPanRecognizer) {
        CGPoint fingerLocation = [sender locationInView:self.view];
        
        switch ([sender state]) {
            case UIGestureRecognizerStateBegan:
                [self.view bringSubviewToFront:self.navigator];
                if ([sender locationInView:self.navigator].y > self.navigator.frame.size.height - 60) {
                    panningFromBottom = YES;
                    [self.navigator.fingerAnimationImage setHidden:YES];
                }
                
                break;
            case UIGestureRecognizerStateChanged:
                if (panningFromBottom) {
                    if (self.navigator.frame.origin.y > -40) {
                        [sender setEnabled:NO];
                        [sender setEnabled:YES];
                        [self snapNavigatorToPlace];
                    } else {
                        [self.tabImageView setCenter:CGPointMake(self.tabImageView.center.x, fingerLocation.y + 40) ];
                        [self.navigator setCenter:CGPointMake(self.navigator.center.x, self.tabImageView.center.y - tabAndManagerAnchor)];
                        [self changeNavigatorAppearances];
                    }
                }
                break;
                
            case UIGestureRecognizerStateEnded:
                panningFromBottom = NO;
                if (self.navigator.frame.origin.y > -40) {
                    [self.navigator setFrame:CGRectMake(self.navigator.frame.origin.x, -40, self.navigator.frame.size.width, self.navigator.frame.size.height)];
                    [self.tabImageView setCenter:CGPointMake(self.tabImageView.center.x, self.navigator.center.y + tabAndManagerAnchor)];
                } else if (self.tabImageView.frame.origin.y < 0) {
                    [self.tabImageView setFrame:CGRectMake(self.tabImageView.frame.origin.x, 0, self.tabImageView.frame.size.width, self.tabImageView.frame.size.height)];
                    [self.navigator setCenter:CGPointMake(self.navigator.center.x, self.tabImageView.center.y - tabAndManagerAnchor)];
                }
                
                [self snapNavigatorToPlace];
                
                [sender setEnabled:YES];
                break;
            default:
                break;
        }
    }
}

- (void)snapNavigatorToPlace {
    if (self.navigator.frame.origin.y > self.view.frame.origin.y - self.navigator.frame.size.height + 0 &&
        self.navigator.frame.origin.y <= self.view.frame.origin.y - self.navigator.frame.size.height + 50) {
        [UIView animateWithDuration:0.4 animations:^(void) {
            [self.navigator setFrame:(CGRect){{self.navigator.frame.origin.x, self.view.frame.origin.y - self.navigator.frame.size.height}, self.navigator.frame.size}];
            [self.tabImageView setCenter:CGPointMake(self.tabImageView.center.x, self.navigator.center.y + tabAndManagerAnchor)];
            [self changeNavigatorAppearances];
        } completion:^(BOOL finished) {
            [self.navigator removeGestureRecognizer:self.navigatorPanRecognizer];
        }];
    } else if (self.navigator.frame.origin.y > self.view.frame.origin.y - self.navigator.frame.size.height + 50 &&
        self.navigator.frame.origin.y <= self.view.frame.origin.y - self.navigator.frame.size.height + 170) {
        [UIView animateWithDuration:0.4 animations:^(void) {
            [self.navigator setFrame:(CGRect){{self.navigator.frame.origin.x, self.view.frame.origin.y - self.navigator.frame.size.height + 106}, self.navigator.frame.size}];
            [self.tabImageView setCenter:CGPointMake(self.tabImageView.center.x, self.navigator.center.y + tabAndManagerAnchor)];
            [self changeNavigatorAppearances];
        } completion:^(BOOL finished) {
            [self.navigator removeGestureRecognizer:self.navigatorPanRecognizer];
        }];
    }  else if (self.navigator.frame.origin.y > -120) {
        [UIView animateWithDuration:0.4 animations:^(void) {
            [self.navigator setFrame:CGRectMake(self.navigator.frame.origin.x, -40, self.navigator.frame.size.width, self.navigator.frame.size.height)];
            [self.tabImageView setCenter:CGPointMake(self.tabImageView.center.x, self.navigator.center.y + tabAndManagerAnchor)];
            [self changeNavigatorAppearances];
        } completion:^(BOOL finished) {
            [self.navigator addGestureRecognizer:self.navigatorPanRecognizer];
            
            NSLog(@"NO");
            [self.navigator.fingerAnimationImage setHidden:NO];
            [UIView animateWithDuration:2.0 animations:^(void) {
                [UIView setAnimationRepeatCount:3];
                self.navigator.fingerAnimationImage.frame = (CGRect){{self.navigator.frame.size.width - 35, self.navigator.frame.size.height - 60}, self.navigator.fingerAnimationImage.frame.size};
            } completion:^(BOOL finished) {
                [self.navigator.fingerAnimationImage setHidden:YES];
            }];
        }];
    }
}

- (void)changeNavigatorAppearances {
    if (self.navigator.frame.origin.y > (self.view.frame.origin.y - self.navigator.frame.size.height + 105)) {
        [UIView animateWithDuration:0.4 animations:^(void) {
            [self.navigator.urlAndControlsView setAlpha:1.0];
        } completion:^(BOOL completed) {
            
        }];
        [self.navigator.urlAndControlsView setCenter:
         CGPointMake(self.navigator.urlAndControlsView.center.x,
                     self.navigator.frame.size.height - (self.navigator.frame.size.height + self.navigator.frame.origin.y - 60))];
        if (self.navigator.frame.origin.y > -40) {
            [self.navigator.urlAndControlsView setCenter:
             CGPointMake(self.navigator.urlAndControlsView.center.x,
                         self.navigator.frame.size.height - (self.navigator.frame.size.height - 40 - 60))];
        }
    } else {
        [self.navigator.urlAndControlsView setCenter:
         CGPointMake(self.navigator.urlAndControlsView.center.x,
                     self.navigator.frame.size.height - (self.navigator.frame.size.height + self.navigator.frame.origin.y - 60))];
        [UIView animateWithDuration:0.2 animations:^(void) {
            [self.navigator.urlAndControlsView setAlpha:0.0];
        } completion:^(BOOL completed) {
            
        }];
    }
}



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