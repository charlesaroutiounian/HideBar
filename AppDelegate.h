//
//  AppDelegate.h
//  Bifocals
//
//  Created by Charles Aroutiounian on 27/12/14.
//  Copyright (c) 2014 Charles Aroutiounian. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

{
    BOOL shown;

}

- (void)statusItemClick:(id)sender;
- (void)startAtLogin:(id)sender;

@property (nonatomic, strong) NSStatusItem *statusItem;
@property (nonatomic, strong) NSMenu *statusBarMenu;

@end

