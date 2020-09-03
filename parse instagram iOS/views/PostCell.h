//
//  PostCell.h
//  parse instagram iOS
//
//  Created by Anna Goncharenko on 9/3/20.
//  Copyright © 2020 annagoncharenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import <Parse/Parse.h>
#import <Parse/PFImageView.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;

@property (strong, nonatomic) Post *post;

-(void)setCellPost:(Post *)postPassed;

@end

NS_ASSUME_NONNULL_END
