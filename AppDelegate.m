//
//  AppDelegate.m
//  Bifocals
//
//  Created by Charles Aroutiounian on 27/12/14.
//  Copyright (c) 2014 Charles Aroutiounian. All rights reserved.
//

#import "AppDelegate.h"
#import "LLManager.h"

NSString *const HideBarLogin = @"HideBarLogin";


@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];

    NSString *osxMode = [[NSUserDefaults standardUserDefaults] stringForKey:@"AppleInterfaceStyle"];
    
    //NSLog(@"$$%@", osxMode);
    
    NSTask *task = [[NSTask alloc] init];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    [task setStandardError: pipe];
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task setLaunchPath:@"/bin/bash"];
    [task setArguments:[NSArray arrayWithObjects:[[NSBundle mainBundle] pathForResource:@"getstate" ofType:@"sh"], nil]];
    [task launch];
    
    NSData *data = [file readDataToEndOfFile];
    
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //NSLog(@"###%@", string);
    
    if ([string isEqualToString:@"YES"])
    {
        
      //  [img setTemplate:YES];
        
        NSImage *img = [NSImage new];
        
        if ([osxMode isEqualToString:@"Dark"]) {
            
          img  = [NSImage imageNamed:@"eye_w"];

           
        }
        
        else{
            
            img = [NSImage imageNamed:@"eye"];

        }
        
        
        
        self.statusItem.image = img;
    }
    else
    {
        
        
        NSImage *img = [NSImage imageNamed:@"eyeoff"];
        
       // [img setTemplate:YES];
        
        
        
        self.statusItem.image = img;
    }
    
    self.statusItem.action = @selector(statusItemClick:);
    
    
    self.statusItem.target = self;
    self.statusItem.enabled = YES;
    self.statusItem.highlightMode = YES;
    
  
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)startAtLogin:(id)sender{
    
    
    NSUserDefaults *SharedPrefs = [[NSUserDefaults alloc] initWithSuiteName:@"UKRL895MC4.hidebar"];
    
    NSButton *check =(NSButton *)sender;

    
    
    if (check.state) {
        
        //NSLog(@"yes");

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:check.state forKey:HideBarLogin];
        
        [defaults synchronize];
        
        
        // SharedPrefs = prefs;
        [SharedPrefs setBool:YES forKey:HideBarLogin];
        [SharedPrefs synchronize];
        
        [LLManager launchAtLogin]; // will the app launch at login?
        [LLManager setLaunchAtLogin:YES];
        
        
    }
    
    else {
        
        //NSLog(@"no");
        
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setBool:check.state forKey:HideBarLogin];
        
        [LLManager launchAtLogin]; // will the app launch at login?
        [LLManager setLaunchAtLogin:NO];
        [SharedPrefs setBool:check.state forKey:HideBarLogin];
        [SharedPrefs synchronize];
        
    }
}

- (void)show:(id)sender
{
 
    
    NSTask *task2 = [[NSTask alloc] init];
    [task2 setLaunchPath:@"/bin/bash"];
    [task2 setArguments:[NSArray arrayWithObjects:[[NSBundle mainBundle] pathForResource:@"on" ofType:@"sh"], nil]];
    [task2 launch];

    NSString *osxMode = [[NSUserDefaults standardUserDefaults] stringForKey:@"AppleInterfaceStyle"];

    
    NSImage *img = [NSImage new];
    
    if ([osxMode isEqualToString:@"Dark"]) {
        
        img  = [NSImage imageNamed:@"eye_w"];
        
        
    }
    
    else{
        
        img = [NSImage imageNamed:@"eye"];
        
    }
    
    
    self.statusItem.image = img;



}

- (void)hide:(id)sender
{
  
    
    NSTask *task2 = [[NSTask alloc] init];
    [task2 setLaunchPath:@"/bin/bash"];
    [task2 setArguments:[NSArray arrayWithObjects:[[NSBundle mainBundle] pathForResource:@"off" ofType:@"sh"], nil]];
    [task2 launch];
    
    
    NSImage *img = [NSImage imageNamed:@"eyeoff"];
    
    
    self.statusItem.image = img;
    
    
    
}


- (void)statusItemClick:(id)sender {
    
    
    self.statusBarMenu = [[NSMenu alloc] initWithTitle:@"Bifocals"];
    [NSApp activateIgnoringOtherApps:YES];
    
    
    NSTask *task = [[NSTask alloc] init];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    [task setStandardError: pipe];
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task setLaunchPath:@"/bin/bash"];
    [task setArguments:[NSArray arrayWithObjects:[[NSBundle mainBundle] pathForResource:@"getstate" ofType:@"sh"], nil]];
    [task launch];
    
    NSData *data = [file readDataToEndOfFile];
    
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //NSLog(@"--->%@, %hhd", string, [string isEqualToString:@"YES"]);
    
  
    
    
    NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:@"Show Files" action:@selector(show:) keyEquivalent:@"S"];
    
    NSMenuItem * item2 = [[NSMenuItem alloc] initWithTitle:@"Hide Files" action:@selector(hide:) keyEquivalent:@"H"];
    

    
    if ([string isEqualToString:@"YES\n"])
    {
        
        [item setState: NSOnState];
        //NSLog(@"<<<<--->%@", string);

    }
    
    else
    {
     
        [item2 setState: NSOnState];

    }
    [item setTarget:self];
    [item2 setTarget:self];

    
    
    [self.statusBarMenu addItem:item];
    
  
    [self.statusBarMenu addItem:item2];

    
    
    
    
    
    NSView *myView = [[NSView alloc] initWithFrame:NSMakeRect(180,100,200,35)];

    NSMenuItem *checkItem;
    checkItem = [[NSMenuItem alloc]
                 initWithTitle:@""
                 action:@selector(startAtLogin:)
                 keyEquivalent:@""];
    [checkItem setTarget:self];
    
    
    NSButton *myCheckBox = [[NSButton alloc] initWithFrame:NSMakeRect(20,10,20,20)];
    [myCheckBox setButtonType:NSSwitchButton];
    
    NSUserDefaults *SharedPrefs = [[NSUserDefaults alloc] initWithSuiteName:@"UKRL895MC4.hidebar"];

    if ([SharedPrefs boolForKey:HideBarLogin]) {
        [myCheckBox setState:NSOnState];
        //NSLog(@"%@", myCheckBox);
    }
  
    [myCheckBox setTarget:self];
    [myCheckBox setAction:@selector(startAtLogin:)];
    
    [myView addSubview:myCheckBox];
    [checkItem setView: myView];
    NSTextField *textField;
    
    textField = [[NSTextField alloc] initWithFrame:NSMakeRect(40, -5, 200, 35)];
    [textField setStringValue:@"Start at Login"];
    [textField setBezeled:NO];
    [textField setDrawsBackground:NO];
    [textField setEditable:NO];
    [textField setSelectable:NO];
    [textField setFont:[NSFont systemFontOfSize:14]];
    
    [myView addSubview:textField];
    [checkItem setTarget:self];
    [self.statusBarMenu addItem:checkItem];
    
    [self.statusBarMenu addItem:[[NSMenuItem alloc] initWithTitle:NSLocalizedStringFromTable(@"Quit", @"Strings",nil) action:@selector(terminate:) keyEquivalent:@"Q"]];
    
    [self.statusItem popUpStatusItemMenu:self.statusBarMenu];
    
}



@end
