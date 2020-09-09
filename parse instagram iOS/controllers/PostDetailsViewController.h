//
//  PostDetailsViewController.h
//  parse instagram iOS
//
//  Created by Anna Goncharenko on 9/8/20.
//  Copyright © 2020 annagoncharenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostDetailsViewController : UIViewController

@property (nonatomic, strong) Post *post;

@end

NS_ASSUME_NONNULL_END
