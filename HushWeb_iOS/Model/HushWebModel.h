//
//  HushWebModel.h
//  Hush    Web_iOS
//
//  Created by Noel Feliciano on 2012-10-08.
//  Copyright (c) 2012 Noel Feliciano. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HushWebTabManager;
@class HushWebTab;

@interface HushWebModel : NSObject

+ (id)sharedModel;                            //this is a singleton

//Tab Manager Stuff
@property (nonatomic, strong) HushWebTabManager *tabManager;
-(void)createNewTab;
-(void)createNewTabWithURL:(NSURL *)url;
-(void)visitNewUrl:(NSURL *)url;                //adds new url to history
-(NSURL *)backButtonPressed;
-(NSURL *)forwardButtonPressed;
-(NSInteger)closeCurrentTab;                    //returns next tab's index
-(HushWebTab *)getCurrentTab;
-(HushWebTab *)switchToTabAt:(NSInteger)index;

-(void)printState;

@end



/*******

 This is the main model, interacting with specific sub models.
 SubModels:
    - Tabs
    - Saved Sites/Favorites/Bookmarks
    - History
    - iCloud sync
    - Sharing
    - RSS/Read Later
 
 Interacts only with the main view controller
 
 What does it need to do?
    - Create a new tab
    - Close a tab
    - Go back/forward on a tab
    - Return the current web view
    - Return the next web view (arbitrary choice)
    - Save the current web view
 
*/