//
//  HushWebTabManager.h
//  HushWeb_iOS
//
//  Created by Noel Feliciano on 2012-10-08.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HushWebTab;

@interface HushWebTabManager : NSObject

@property (nonatomic, strong) NSMutableArray *tabs;
@property (nonatomic, strong) HushWebTab *currentTab;

-(void)createNewTab;
-(void)visitNewUrl:(NSURL *)url;
-(NSInteger)closeCurrentTab;
-(HushWebTab *)switchToTabAt:(NSInteger)index;


@end



/*******
 
 This is the tab manager, interacting only with the main model.
 
 It contains a mutable array of tabs.
 
 What is a tab?
    - A Mutable Array of urls
    - An image for the current url
    - A webview
 
 What does it need to do?
    - Create a new tab
    - Create a new tab with a link
    - Close a tab
    - Go back/forward on a tab
    - Enter a new url in a tab
    - 
 
 */