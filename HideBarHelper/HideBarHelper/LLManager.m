//
//  LLManager.m
//  LaunchAtLogin
//
//  Created by David Keegan on 4/20/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import "LLManager.h"
#import "LLStrings.h"
#import <ServiceManagement/ServiceManagement.h>
#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@implementation LLManager

+ (BOOL)launchAtLogin{
    BOOL launch = NO;

    return launch;
}

+ (void)setLaunchAtLogin:(BOOL)value{
    if(!SMLoginItemSetEnabled((CFStringRef)LLHelperBundleIdentifier, value)){
        NSLog(@"SMLoginItemSetEnabled failed!");
    }
}

#pragma mark - Bindings support

- (BOOL)launchAtLogin {
    return [[self class] launchAtLogin];
}

- (void)setLaunchAtLogin:(BOOL)launchAtLogin {
  //  [self willChangeValueForKey:@"launchAtLogin"];
   // [[self class] setLaunchAtLogin:launchAtLogin];
    //[self didChangeValueForKey:@"launchAtLogin"];
}

@end
