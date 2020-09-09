//
//  HomeFeedViewController.m
//  parse instagram iOS
//
//  Created by Anna Goncharenko on 8/31/20.
//  Copyright © 2020 annagoncharenko. All rights reserved.
//

#import "HomeFeedViewController.h"
#import "PostCell.h"
#import "ComposeViewController.h"
#import "SceneDelegate.h"

@interface HomeFeedViewController () <UITableViewDataSource, UITableViewDelegate, ComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *posts;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // setting to self calls this object to do the required methods
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // add refresh control to tableview
    // addtarget - call fetch events when refreshed
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshPosts:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    // get movies/ load up table view
    [self fetchPosts];
}

- (IBAction)logoutOnClick:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
        [self performSegueWithIdentifier:@"logoutSegue" sender:nil];
    }];
}

-(void)fetchPosts {
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"user"];
    postQuery.limit = 20;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            self.posts = posts;
            
            // reload table view
            [self.tableView reloadData];
        }
        else {
            // handle error
            NSLog(@"%@", error.localizedDescription);
        }
        // stop refresh control
        [self.refreshControl endRefreshing];
    }];
}

- (void)refreshPosts:(UIRefreshControl *)refreshControl {
    [self fetchPosts];
    [refreshControl endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // user post template
    // get post at index
    // set post object to cell -> sets fields in PostCell.h
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    Post *post = self.posts[indexPath.row];
    [cell setCellPost:post];
    
    return cell;
}

-(void)didShare{
    [self fetchPosts];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     Get the new view controller using [segue destinationViewController].
//     Pass the selected object to the new view controller.
    
    // when compose button clicked - set delegate
    if([[segue identifier] isEqualToString:@"composeSegue"]) {
           UINavigationController *navigationController = [segue destinationViewController];
           ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
           composeController.delegate = self;
       }
}


@end
