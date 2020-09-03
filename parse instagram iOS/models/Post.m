//
//  Post.m
//  parse instagram iOS
//
//  Created by Anna Goncharenko on 9/3/20.
//  Copyright © 2020 annagoncharenko. All rights reserved.
//

#import "Post.h"
#import <Parse/Parse.h>

@implementation Post

// @synthetic - generates getter/setter methods
// @dynamic - getter/setter not implemented by the class but somewhere else
@dynamic postID;
@dynamic userID;
@dynamic user;
@dynamic description;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;
@dynamic createdAt;
@dynamic createdAtString;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.user = [PFUser currentUser];
    newPost.description = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    
    // create at date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
     
    NSDate *date = [[NSDate alloc] init];
     
    // US English Locale (en_US)
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSLog(@"%@", [dateFormatter stringFromDate:date]); // Jan 2, 2001
    
    newPost.createdAt = date;
    newPost.createdAtString = [dateFormatter stringFromDate:date];
    
    [newPost saveInBackgroundWithBlock: completion];
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end
