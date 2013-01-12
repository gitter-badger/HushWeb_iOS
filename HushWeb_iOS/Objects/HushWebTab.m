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
        currentPlaceInHistory = 0;
        
        //we don't worry about the frames until we set them in VC
    }
    return self;
}

- (void)visitNewUrl:(NSURL *)url {
    if (currentPlaceInHistory == self.tabHistory.count - 1 || self.tabHistory.count == 0) {
        [self.tabHistory addObject:url];
        currentPlaceInHistory = self.tabHistory.count - 1;
    } else {
        NSRange range = NSMakeRange(currentPlaceInHistory+1, (self.tabHistory.count - 1 - currentPlaceInHistory));
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.tabHistory removeObjectsAtIndexes:indexSet];
        [self.tabHistory addObject:url];
        currentPlaceInHistory = self.tabHistory.count - 1;
    }
    NSLog(@"URL added to history: %@. Now has %d sites logged. Current place is now %d.", url.absoluteString, self.tabHistory.count, currentPlaceInHistory);
}

- (NSURL *)getCurrentURL {
    if (self.tabHistory > 0) {
        NSURL *url = [self.tabHistory objectAtIndex:currentPlaceInHistory];
        return url;
    } else {
        return nil;
    }
}

- (NSURL *)backButtonPressed {
    if ([self checkIfCanGoBack]) {
        currentPlaceInHistory = currentPlaceInHistory - 1;
        NSURL *url = [self.tabHistory objectAtIndex:currentPlaceInHistory];
        NSLog(@"Go back to %@", url.absoluteString);
        return url;
    }
    return nil;
}

- (BOOL)checkIfCanGoBack {
    if (currentPlaceInHistory == 0) return NO;
    return YES;
}

- (NSURL *)forwardButtonPressed {
    if ([self checkIfCanGoForward]) {
        currentPlaceInHistory = currentPlaceInHistory + 1;
        NSURL *url = [self.tabHistory objectAtIndex:currentPlaceInHistory];
        NSLog(@"Go forward to %@", url.absoluteString);
        return url;
    }
    return nil;
}

- (BOOL)checkIfCanGoForward {
    if (currentPlaceInHistory == self.tabHistory.count - 1) return NO;
    return YES;
}

@end
