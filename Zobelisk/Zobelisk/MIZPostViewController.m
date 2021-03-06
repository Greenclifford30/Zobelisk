//
//  MIZPostViewController.m
//  Zobelisk
//
//  Created by Victor Tran on 4/30/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import "MIZPostViewController.h"
#import "MIZPostFeedCellTableViewCell.h"
#import "MIZPost.h"

@implementation MIZPostViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *addPost = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPostButtonTapped:)];
    
    self.navigationItem.rightBarButtonItem = addPost;
    
    [MIZPostFetch fetchPostFavorite];

     //self.body.numberOfLines = 0;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.email.text = self.post.email;
            self.date.text = self.post.date;
            self.postTitle.text = self.post.postTitle;
            self.body.text = self.post.content;
    }];
}

- (IBAction)pocket:(UIButton *)sender {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defaults objectForKey:@"userID"];
    NSString* pid = [NSString stringWithFormat:@"%ld", (long)self.post.postID];
    
    MIZPost *favoritedPost = [[MIZPost alloc] init] ;
    [favoritedPost favoritePost:pid forUser:uid];
}

- (IBAction)commentOnPost:(id)sender {
   // NSDictionary *post = [[NSDictionary alloc] initWithObjectsAndKeys: @"post_id", self.post.postID, nil];
    [self performSegueWithIdentifier:@"postToComment" sender:self];
    
}


/*- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MIZPost *post = self.post[self.post.count - indexPath.row-1];
    MIZPostFeedCellTableViewCell *cell = (MIZPostFeedCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    CGSize labelSize = CGSizeZero;
    CGRect boundingRect = [post.content boundingRectWithSize:CGSizeMake(self.tableView.frame.size.width - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[cell.body.attributedText attributesAtIndex:0 effectiveRange:NULL] context:nil];
    labelSize = boundingRect.size;
    
    return boundingRect.size.height+120.0f;
}*/

- (void)MIZAddPostViewControllerDidCancel:(MIZAddPostViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addPostButtonTapped:(id)sender{
    //Add button taps begins segue to addPostView
    [self performSegueWithIdentifier:@"addPost" sender:sender];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Controls what view to segue based on identifier
    if([segue.identifier isEqualToString:@"addPost"])
    {
        //Sets navigation controller as destination
        UINavigationController *navigationController = segue.destinationViewController;
        //Goes to first view controller in navigation stack
        MIZAddPostViewController* AddPostViewController = [navigationController viewControllers][0];
        AddPostViewController.delegate = self;
    }
    else if([segue.identifier isEqualToString:@"postToComment"])
    {
        NSString* pid = [NSString stringWithFormat:@"%ld", (long)self.post.postID];
        NSDictionary *post = [[NSDictionary alloc] initWithObjectsAndKeys:pid, @"post_id", nil];
        MIZCommentsViewController* controller = (MIZCommentsViewController*)segue.destinationViewController;
        controller.postObj = post;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


@end
