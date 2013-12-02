//
//  BMViewController.m
//  TestRestoration
//
//  Created by Seth Delackner on 12/2/13.
//  Copyright (c) 2013 BinaryMochi. All rights reserved.
//

#import "BMAppDelegate.h"
#import "RootViewController.h"
#import "PresentedViewController.h"

@interface RootViewController ()

@property (nonatomic) BOOL restored;

@end

@implementation RootViewController

- (id) initWithCoder:(NSCoder *)aDecoder {
    if (nil != (self = [super initWithCoder:aDecoder])) {
        if ([self isMemberOfClass: [RootViewController class]]) {
            BMAppDelegate* a = (BMAppDelegate*)[[UIApplication sharedApplication] delegate];
            a.root = self;
        }
    }
    return self;
}

- (void) decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder: coder];
    _restored = [[coder decodeObjectForKey: @"restored"] intValue];

//    UIViewController* v = [coder decodeObjectForKey: @"p"];
//    if (v) {
//        [self presentViewController:v animated:NO completion:nil];
//    }
//
//  This causes:
//
//  Warning: Attempt to present <PresentedViewController: 0x8f22ca0> on <RootViewController: 0x8b6f340> whose view is not in the window hierarchy!
}

- (void) encodeRestorableStateWithCoder:(NSCoder *)coder {
    [coder encodeObject:@(1) forKey:@"restored"];
    if (self.presentedViewController) {
        [coder encodeObject: self.presentedViewController forKey: @"p"];
    }
    [super encodeRestorableStateWithCoder:coder];
}


- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (nil != (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.restorationIdentifier = NSStringFromClass([self class]);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
}

- (void) viewWillAppear:(BOOL)animated {
    if (!_restored) {
        [self setup];
    }
}

- (void) setup {
    UIButton* b = [UIButton buttonWithType:UIButtonTypeCustom];
    [b setFrame: CGRectMake(100,100,100,50)];
    [b setTitle: @"Root" forState: 0];
    [b addTarget: self action:@selector(present:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: b];
}

- (void) present: sender {
    UIViewController* p = [[PresentedViewController alloc] initWithNibName:nil bundle:nil];
    p.title = @">";
    [self presentViewController:p animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
