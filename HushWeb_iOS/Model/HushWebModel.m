//
//  HushWebModel.m
//  HushWeb_iOS
//
//  Created by Noel Feliciano on 2012-10-08.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import "HushWebModel.h"
#import "HushWebTabManager.h"

@implementation HushWebModel
@synthesize tabManager = _tabManager;

- (id)init {
    self = [super init];
    if (self) {
        self.tabManager = [[HushWebTabManager alloc] init];
    }
    return self;
}

- (void)createNewTab {
    [self.tabManager createNewTab];
}

- (void)createNewTabWithURL:(NSURL *)url {
    
}

- (NSInteger)closeCurrentTab {
    return [self.tabManager closeCurrentTab];
}

- (HushWebTab *)switchToTabAt:(NSInteger)index {
    return [self.tabManager switchToTabAt:index];
}

- (void)printState {
    NSLog(@"Number of tabs: %d", self.tabManager.tabs.count);
}

@end
