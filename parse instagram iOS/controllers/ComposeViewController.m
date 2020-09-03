//
//  ComposeViewController.m
//  parse instagram iOS
//
//  Created by Anna Goncharenko on 9/2/20.
//  Copyright © 2020 annagoncharenko. All rights reserved.
//

#import "ComposeViewController.h"
#import <UIKit/UIKit.h>
#import "Post.h"
#import <Parse/Parse.h>

@interface ComposeViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *captionTextView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.captionTextView.delegate = self;
    // Do any additional setup after loading the view.
}
- (IBAction)CancelOnClick:(id)sender {
  [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)ShareOnClick:(id)sender {
    // 414x414 = square width of the screen
    UIImage *postImage = [self resizeImage:self.photoImageView.image withSize:CGSizeMake(414, 414)];
    [Post postUserImage:postImage withCaption:self.captionTextView.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded){
            NSLog(@"Image successfully posted");
            [self.delegate didShare];
            //finish and notify via delegate that a new post was shared
            [self dismissViewControllerAnimated:YES completion:^{
   //             [self.delegate didShare];
            }];
        }
        else{
            NSLog(@"Failure posting: %@", error.localizedDescription);
        }
    }];
    
    
}

- (IBAction)onTapImage:(id)sender {
    NSLog(@"Tapped on image");
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    
    // Do something with the images (based on your use case)
    [self.photoImageView setImage:originalImage];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.captionTextView.text = @"";
    self.captionTextView.textColor = [UIColor blackColor];
}

@end
