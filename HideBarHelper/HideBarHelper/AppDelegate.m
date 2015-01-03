//
//  AppDelegate.m
//  HideBarHelper
//
//  Created by Charles Aroutiounian on 28/12/14.
//  Copyright (c) 2014 Charles Aroutiounian. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end
NSString *const HideBarLogin = @"HideBarLogin";


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    
    NSUserDefaults *SharedPrefs = [[NSUserDefaults alloc] initWithSuiteName:@"hide"];
    
    
    [SharedPrefs synchronize];
    NSLog(@"/Applications/HideBar.app");
    
    
    if ([SharedPrefs boolForKey:HideBarLogin]) {
        NSLog(@"/Applications/HideBar.app");
        
        [[NSWorkspace sharedWorkspace] launchApplication:@"/Applications/HideBar.app"];
        
    }
    
    
    [NSApp terminate:self];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
