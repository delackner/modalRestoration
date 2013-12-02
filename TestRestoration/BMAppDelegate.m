//
//  BMAppDelegate.m
//  TestRestoration
//
//  Created by Seth Delackner on 12/2/13.
//  Copyright (c) 2013 BinaryMochi. All rights reserved.
//

#import "BMAppDelegate.h"

@implementation BMAppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}
							
- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
    return YES;
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder {
    return YES;
}

- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)path coder:(NSCoder *)coder {
    UIViewController* vc = nil;
    NSString* rid = [path lastObject];
    NSLog(@"restoring %@", rid);
    if ([rid isEqualToString: @"RootViewController"]) {
        return self.root;
    }
    
    Class class = NSClassFromString(rid);
    vc = [[class alloc] initWithNibName: nil bundle: nil];
    if (!vc.restorationIdentifier) {
        vc.restorationIdentifier = rid;
    }
    return vc;
}


@end
