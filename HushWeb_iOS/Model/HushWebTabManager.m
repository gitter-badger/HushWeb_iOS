//
//  HushWebTabManager.m
//  HushWeb_iOS
//
//  Created by Noel Feliciano on 2012-10-08.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import "HushWebTabManager.h"
#import "HushWebTab.h"

@implementation HushWebTabManager

@synthesize tabs = _tabs;
@synthesize currentTab = _currentTab;

- (id)init {
    self = [super init];
    if (self) {
        self.tabs = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)createNewTab {
    HushWebTab *newTab = [[HushWebTab alloc] init];
    [self.tabs insertObject:newTab atIndex:0];
}

- (NSInteger)closeCurrentTab {
    NSInteger currentIndex = [self.tabs indexOfObject:self.currentTab];
    [self.tabs removeObject:self.currentTab];
    self.currentTab = nil;
    if (currentIndex >= self.tabs.count) {
        currentIndex -= 1;
        self.currentTab = [self.tabs objectAtIndex:currentIndex];
        return currentIndex;
    } else {
        self.currentTab = [self.tabs objectAtIndex:currentIndex];
        return currentIndex;
    }
}

- (HushWebTab *)switchToTabAt:(NSInteger)index {
    HushWebTab *tab = [self.tabs objectAtIndex:index];
    self.currentTab = tab;
    return tab;
}

@end
