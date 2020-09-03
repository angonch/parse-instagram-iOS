//
//  ComposeViewController.h
//  parse instagram iOS
//
//  Created by Anna Goncharenko on 9/2/20.
//  Copyright © 2020 annagoncharenko. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// delegate used to trigger function in other class with didShare is called here
@protocol ComposeViewControllerDelegate

- (void)didShare;

@end

@interface ComposeViewController : UIViewController

@property (nonatomic, weak) id <ComposeViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
