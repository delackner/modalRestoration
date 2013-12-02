//
//  PresentedViewController.m
//  TestRestoration
//
//  Created by Seth Delackner on 12/2/13.
//  Copyright (c) 2013 BinaryMochi. All rights reserved.
//

#import "PresentedViewController.h"

@interface PresentedViewController ()
@property (nonatomic, strong) UIButton* b;
@end

@implementation PresentedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.restorationIdentifier = NSStringFromClass([self class]);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];

    self.b = [UIButton buttonWithType:UIButtonTypeCustom];
    [_b setFrame: CGRectMake(100,200,100,50)];
    [_b setTitle: self.title forState: 0];
    [_b addTarget: self action:@selector(present:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: _b];

    UIButton* back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame: CGRectMake(0,0,100,50)];
    [back setTitle: @"Dismiss" forState: 0];
    [back addTarget: self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: back];
}

- (void) dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder: coder];
    self.title = [coder decodeObjectForKey: @"title"];
    NSLog(@"decoded %@", self.title);
}

- (void) encodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"encoding %@", self.title);
    [coder encodeObject:self.title forKey:@"title"];
    if (self.presentedViewController) {
        [coder encodeObject: self.presentedViewController forKey: @"presented"];
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [self.b setTitle: self.title forState: 0];
}

- (void) present: sender {
    UIViewController* p = [[PresentedViewController alloc] initWithNibName:nil bundle:nil];
    p.title = [self.title stringByAppendingString: @">"];
    [self presentViewController:p animated:YES completion:nil];
}

@end
