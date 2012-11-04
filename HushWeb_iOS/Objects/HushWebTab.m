//
//  HushWebTab.m
//  HushWeb_iOS
//
//  Created by Noel Feliciano on 2012-10-08.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import "HushWebTab.h"

@implementation HushWebTab

@synthesize tabHistory = _tabHistory;
@synthesize cachedImage = _cachedImage;
@synthesize webView = _webView;

- (id)init {
    self = [super init];
    if (self) {
        self.tabHistory = [[NSMutableArray alloc] init];
        self.cachedImage = [[UIImageView alloc] init];
        self.cachedImage.backgroundColor = [UIColor whiteColor];
        self.webView = [[UIWebView alloc] init];
        self.webView.scalesPageToFit = YES;
        
        //we don't worry about the frames until we set them in VC
    }
    return self;
}

@end
