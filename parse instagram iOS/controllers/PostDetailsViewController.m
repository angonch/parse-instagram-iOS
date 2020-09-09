//
//  PostDetailsViewController.m
//  parse instagram iOS
//
//  Created by Anna Goncharenko on 9/8/20.
//  Copyright © 2020 annagoncharenko. All rights reserved.
//

#import "PostDetailsViewController.h"
#import <Parse/PFImageView.h>

@interface PostDetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;



@end

@implementation PostDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.usernameLabel.text = self.post.user.username;
    self.captionLabel.text = self.post[@"description"];
    self.createdAtLabel.text = self.post.createdAtString;
    self.postImageView.file = self.post[@"image"];
    [self.postImageView loadInBackground];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
