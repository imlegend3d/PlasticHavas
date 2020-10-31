//
//  ViewController.m
//  Taste
//
//  Created by David on 2019-01-30.
//  Copyright © 2019 Omar Tehsin. All rights reserved.
//

#import "ViewControllerInOBJC.h"
#import "PlasticHavas-Swift.h"
#import "RedditPost.h"

@interface ViewControllerInOBJC () < UISplitViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>{

    
}

@property (weak, nonatomic) IBOutlet UITableView *redditTableView;

@property (strong, nonatomic) NSMutableArray<RedditPost *> *redditPosts;

@property (strong, nonatomic) NSIndexPath *indexPath;


@end

@implementation ViewControllerInOBJC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchRedditInfo];
    
    [self.redditTableView registerNib: [RedditPostTableViewCell nib] forCellReuseIdentifier:RedditPostTableViewCell.identifier];
    self.redditTableView.delegate = self;
    self.redditTableView.dataSource = self;
    //    self.redditTableView.rowHeight = UITableViewAutomaticDimension;
    self.redditTableView.rowHeight = 175;
//    self.redditTableView.estimatedRowHeight = UITableViewAutomaticDimension;
//    self.redditTableView.estimatedRowHeight = 175;
    
    //self.splitViewController.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}
- (void)awakeFromNib{
    [super awakeFromNib];
    //self.splitViewController.delegate = self;
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController{
    return YES;
}

-(void) fetchRedditInfo{
    //    "https://www.reddit.com/.json"
    NSString *urlString = @"https://www.reddit.com/.json";
    NSURL *url = [NSURL URLWithString: urlString];
    
    [[NSURLSession.sharedSession dataTaskWithURL: url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError * err;
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &err];
        if (err){
            NSLog(@"Failed to serialize into JSON: %@", err);
            return;
        }
        
        NSDictionary *redditData1 = [jsonData objectForKey:@"data"];
        NSArray *redditChildren = [redditData1 objectForKey:@"children"];
        NSMutableArray< RedditPost * > *posts = NSMutableArray.new;
        for (NSDictionary *redditData in redditChildren){
            RedditPost* redditPost = RedditPost.new;
            redditPost.title = redditData[@"data"][@"title"];
            redditPost.ups = redditData[@"data"][@"ups"];
            redditPost.selftext = redditData[@"data"][@"selftext"];
            redditPost.num_comments = redditData[@"data"][@"num_comments"];
            redditPost.author = redditData[@"data"][@"author"];
            redditPost.thumbnail = redditData[@"data"][@"thumbnail"];
            if (redditData[@"data"][@"post_hint"] != nil) {
                redditPost.post_hint = redditData[@"data"][@"post_hint"];
                if ([redditPost.post_hint  isEqual: @"image"]) {
                    redditPost.image = redditData[@"data"][@"url"];
                    redditPost.url = redditData[@"data"][@"url"];
                } else if ([redditPost.post_hint  isEqual: @"link"]){
                    redditPost.image = @"";
                    redditPost.url = redditData[@"data"][@"url"];
                }
            }
            [posts addObject:redditPost];
        }
        self.redditPosts = posts;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.redditTableView reloadData];
        });
        
    }] resume];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RedditPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: RedditPostTableViewCell.identifier];
    if (cell == nil) {
        cell = [[RedditPostTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: RedditPostTableViewCell.identifier];
    }
    NSString *hint = self.redditPosts[indexPath.row].post_hint;
    if ([hint isEqual: @"link"]) {
        //cell without image
        cell.postImage.image = nil;
        [cell configureWith:self.redditPosts[indexPath.row].title upVotes:[self.redditPosts[indexPath.row].ups intValue] comments:[self.redditPosts[indexPath.row].num_comments intValue] hint: self.redditPosts[indexPath.row].post_hint imageName:@"" iwidth: 0 iheight: 0 post: self.redditPosts[indexPath.row]];
    } else {
        cell.postImage.image = nil;
        [cell configureWith:self.redditPosts[indexPath.row].title upVotes:[self.redditPosts[indexPath.row].ups intValue] comments:[self.redditPosts[indexPath.row].num_comments intValue] hint: self.redditPosts[indexPath.row].post_hint imageName:self.redditPosts[indexPath.row].thumbnail iwidth:[self.redditPosts[indexPath.row].thumbnail_width intValue] iheight: [self.redditPosts[indexPath.row].thumbnail_height intValue] post: self.redditPosts[indexPath.row]];
    }
    
//    [cell.postImage setImageWithURL:[NSURL URLWithString: self.redditPosts[indexPath.row].thumbnail] placeholderImage: [UIImage imageNamed:@"burger.png"]];
//    [cell configureWith:self.redditPosts[indexPath.row].title upVotes:[self.redditPosts[indexPath.row].ups intValue] comments:[self.redditPosts[indexPath.row].num_comments intValue] hint: self.redditPosts[indexPath.row].post_hint imageName:self.redditPosts[indexPath.row].url iwidth:[self.redditPosts[indexPath.row].thumbnail_width intValue] iheight: [self.redditPosts[indexPath.row].thumbnail_height intValue]];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.redditPosts.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *hint = self.redditPosts[indexPath.row].post_hint;
    if ([hint isEqual:@"link"]) {
        return 80;
    } else if ([hint isEqual:@"image"]) {
        return 225;
    } else {
        return 65;
    }
    
    //return [self.redditPosts[indexPath.row].post_hint isEqual:@"link"] ? 80 : 225;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    RedditPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: RedditPostTableViewCell.identifier];
//
//
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.redditTableView deselectRowAtIndexPath:indexPath animated:YES];
    self.indexPath = indexPath;
    [self performSegueWithIdentifier:@"cellToDetail" sender:self];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"cellToDetail"]){
//        NSIndexPath *indexPath = self.redditTableView.indexPathForSelectedRow;
//        DetailVC *detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewController"];
        DetailVC * detailVC = (DetailVC*)segue.destinationViewController;
        detailVC.redditPostInfo = self.redditPosts[self.indexPath.row];
    }
}


@end
