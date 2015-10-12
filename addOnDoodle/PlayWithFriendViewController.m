//
//  PlayWithFriendViewController.m
//  addOnDoodle
//
//  Created by Dawson Walker on 2015-09-29.
//  Copyright (c) 2015 Rise Digital. All rights reserved.
//

#import "PlayWithFriendViewController.h"
#import "ContinuePlayingFriendViewController.h"
#import "FriendsGamesViewController.h"
#import "MainMenuViewController.h"
#import "PlayerAndPlayerViewController.h"
#import <Masonry/MASConstraintMaker.h>
#import <Masonry/View+MASAdditions.h>
#import "AODHexColors.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface PlayWithFriendViewController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic)UILabel *titleLabel;
@property (strong, nonatomic)UIImageView *backgroundImageView;
@property (strong, nonatomic)UIImageView *bannerImageView;
@property (strong, nonatomic)UIButton *backButton;
@property (strong, nonatomic)UIButton *searchUsernameButton;
@property (strong, nonatomic)UIButton *searchFacebookButton;
@property (strong, nonatomic)UIButton *search;
@property (strong, nonatomic)UITextField *textField;
@property (strong, nonatomic)UIActivityIndicatorView *activityInd;
@property (strong, nonatomic)UITableView *currentGames;
@property (strong, nonatomic)NSArray *theGamesArray;
@property (strong, nonatomic)NSMutableArray *nameOfFriendsArray;
@property (strong, nonatomic)NSMutableArray *fileArray;
@property (strong, nonatomic)NSMutableArray *objectIdArray;
@property (strong, nonatomic)NSMutableArray *imageArray;
@property (strong, nonatomic)NSMutableArray *usersInvolved;
@property (strong, nonatomic)NSMutableArray *arrayOfChainLengths;
@end

@implementation PlayWithFriendViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    [self addSubviews];
    [self defineLayouts];
    [self findGames];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)findGames{
    PFQuery * query = [PFQuery queryWithClassName:@"GameWithFriend"];
    [query orderByDescending:@"updatedAt"];
    //query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            self.fileArray = [[NSMutableArray alloc]init];
            self.theGamesArray = [[NSMutableArray alloc]init];
            self.nameOfFriendsArray = [[NSMutableArray alloc]init];
            self.objectIdArray = [[NSMutableArray alloc]init];
            self.imageArray = [[NSMutableArray alloc]init];
            self.usersInvolved = [[NSMutableArray alloc]init];
            self.arrayOfChainLengths = [[NSMutableArray alloc]init];
            for(int i = 0; i<objects.count;i++){
                NSArray *arrayOfUsers = [objects[i]valueForKey:@"usersInvolved"];
                for(int l = 0;l<arrayOfUsers.count;l++){
                    if([arrayOfUsers[l] isEqualToString:[PFUser currentUser].username]){
                        NSLog(@"youre playing a game wooo");
                        [self.nameOfFriendsArray addObject:[objects[i]valueForKey:@"whoseTurn"]];
                        [self.objectIdArray addObject:[objects[i]valueForKey:@"objectId"]];
                        [self.imageArray addObject:[objects[i]valueForKey:@"imagesArray"]];
                        [self.usersInvolved addObject:[objects[i]valueForKey:@"usersInvolved"]];
                        [self.arrayOfChainLengths addObject:[objects[i]valueForKey:@"chainLength"]];
                        NSMutableArray *check = [NSMutableArray arrayWithObject:objects[i]];
                        self.theGamesArray = [NSArray arrayWithArray:check];
                        [self.fileArray addObject:[self.theGamesArray[0] valueForKey:@"imagesArray"]];
                    }
                }
            }
        }
        [self.currentGames reloadData];
    }];
}
-(void)addSubviews{
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.bannerImageView];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.titleLabel];
    
    [self.view addSubview:self.searchUsernameButton];
    [self.view addSubview:self.searchFacebookButton];
    [self.view addSubview:self.currentGames];
}
-(void)defineLayouts{
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(self.view);
    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_left).offset(35.0f);
        make.centerY.equalTo(self.titleLabel);
        make.width.equalTo(@60);
        make.height.equalTo(@30);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(20.0f);
        make.width.equalTo(self.view);
        make.height.equalTo(@60);
    }];
    [self.bannerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(@80);
    }];
    [self.searchUsernameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.bannerImageView.mas_bottom).offset(30.0f);
        make.width.equalTo(self.view).offset(-80.0f);
        make.height.equalTo(self.bannerImageView.mas_height).offset(-20.0f);
    }];
    [self.searchFacebookButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.searchUsernameButton.mas_bottom).offset(30.0f);
        make.width.equalTo(self.searchUsernameButton);
        make.height.equalTo(self.searchUsernameButton);
        
    }];
    [self.currentGames mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.searchFacebookButton.mas_bottom).offset(10.0f);
        make.width.equalTo(self.searchFacebookButton).offset(-40);
        make.bottom.equalTo(self.view);
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.nameOfFriendsArray.count; //array count returns 10
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.currentGames.frame.size.width, 10)];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.; // you can have your own choice, of course
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.friendsGameArray = nil;
    appDelegate.friendsGameArray = [NSMutableArray arrayWithArray:self.fileArray[indexPath.section]];
    appDelegate.objectId = self.objectIdArray[indexPath.section];
    appDelegate.imagesArray = self.imageArray[indexPath.section];
    
    if([self.nameOfFriendsArray[indexPath.section]isEqualToString:[PFUser currentUser].username]){
        // then go to the drawing view
        NSLog(@"the objectID = %@", appDelegate.objectId);
        for(int i = 0; i < [self.usersInvolved[indexPath.section] count]; i ++){
            NSLog(@"the users = %@", [self.usersInvolved[indexPath.section]objectAtIndex:i]);
            if(![[self.usersInvolved[indexPath.section]objectAtIndex:i]isEqualToString:[PFUser currentUser].username]){
                appDelegate.friendsName = [self.usersInvolved[indexPath.section]objectAtIndex:i];
                NSLog(@"friends name = %@", appDelegate.friendsName);
            }
            
        }
        
        ContinuePlayingFriendViewController *contView = [ContinuePlayingFriendViewController new];
        UIViewAnimationTransition trans = UIViewAnimationTransitionCurlUp;
        [UIView beginAnimations: nil context: nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationTransition: trans forView: [self.view window] cache: YES];
        [self presentViewController:contView animated:NO completion:nil];
        [UIView commitAnimations];

    }
    else{
        for(int i = 0; i < [self.usersInvolved[indexPath.section] count]; i ++){
            NSLog(@"the users = %@", [self.usersInvolved[indexPath.section]objectAtIndex:i]);
            if(![[self.usersInvolved[indexPath.section]objectAtIndex:i]isEqualToString:[PFUser currentUser].username]){
                appDelegate.friendsName = [self.usersInvolved[indexPath.section]objectAtIndex:i];
                NSLog(@"friends name = %@", appDelegate.friendsName);
            }
            
        }
        appDelegate.chainLength = self.arrayOfChainLengths[indexPath.section];
        FriendsGamesViewController *contView = [FriendsGamesViewController new];
        UIViewAnimationTransition trans = UIViewAnimationTransitionCurlUp;
        [UIView beginAnimations: nil context: nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationTransition: trans forView: [self.view window] cache: YES];
        [self presentViewController:contView animated:NO completion:nil];
        [UIView commitAnimations];
        //goto the display of games
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor aod_colorWithHexValue:0xFFB3DD alpha:0.8];
    cell.selectedBackgroundView = selectionColor;
    UILabel *nameOfFriend = [[UILabel alloc]initWithFrame:CGRectZero];
    nameOfFriend.textColor = [UIColor whiteColor];
    nameOfFriend.adjustsFontSizeToFitWidth = YES;
    nameOfFriend.minimumScaleFactor = 0.5;
    if([self.nameOfFriendsArray[indexPath.section]isEqualToString:[PFUser currentUser].username]){
        nameOfFriend.text = @"It is your turn to play";
        cell.backgroundColor = [UIColor aod_colorWithHexValue:0x98FB98];
        cell.layer.cornerRadius = 10.0f;
        cell.layer.masksToBounds = YES;
    }
    else{
        nameOfFriend.text = [NSString stringWithFormat:@"Waiting on %@'s turn", self.nameOfFriendsArray[indexPath.section] ];
        cell.backgroundColor = [UIColor aod_colorWithHexValue:0xFB9898];
        cell.layer.cornerRadius = 10.0f;
        cell.layer.masksToBounds = YES;
    }
    nameOfFriend.textAlignment = NSTextAlignmentCenter;
    nameOfFriend.font = [UIFont fontWithName:@"BubblegumSans-Regular" size:24];
    
    UIImageView *indicator = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Line.png"]];
    indicator.frame = CGRectMake(0, 0, 10, 15);
    cell.accessoryView = indicator;
    
    [cell setTintColor:[UIColor whiteColor]];
    [cell addSubview:nameOfFriend];
    [nameOfFriend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(cell).offset(-80);
        make.centerX.equalTo(cell);
        make.centerY.equalTo(cell).offset(-1);
        make.height.equalTo(cell);
    }];
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)backToMain{
    MainMenuViewController *mainMen = [MainMenuViewController new];
    UIViewAnimationTransition trans = UIViewAnimationTransitionCurlUp;
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition: trans forView: [self.view window] cache: YES];
    [self presentViewController:mainMen animated:NO completion:nil];
    [UIView commitAnimations];
}
-(void)searchForUser{
   
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.search.transform = CGAffineTransformMakeScale(0.05, 0.1);
        
        
    }completion:^(BOOL finished) {
        self.search.hidden = YES;
        
        [self.view addSubview:self.activityInd];
        [self.activityInd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.search);
            make.centerY.equalTo(self.search);
            make.width.equalTo(@40);
            make.height.equalTo(@40);
        }];
        self.activityInd.hidesWhenStopped = YES;
        
        
        [self.activityInd startAnimating];
        [self performSelector:@selector(query) withObject:nil afterDelay:1.0];
    }];
    
   
}

-(void)query{
PFUser *currentUser = [PFUser currentUser];
PFUser *searchedUser;
PFQuery *query = [PFUser query];
[query whereKey:@"username" equalTo:self.textField.text];
searchedUser = (PFUser *)[query getFirstObject];
if(searchedUser != NULL && ![self.textField.text isEqualToString:currentUser.username]){
    NSLog(@"Searched Player = %@", self.textField.text);
    NSLog(@"user exists!");
    NSLog(@"%@",searchedUser.objectId);
    [self.activityInd stopAnimating];
    self.search.hidden = NO;
    self.search.transform = CGAffineTransformMakeScale(1, 1);
    [self.search setTitle:[NSString stringWithFormat:@"Play %@",self.textField.text] forState:UIControlStateNormal];
    [self.search removeTarget:self action:@selector(searchForUser) forControlEvents:UIControlEventTouchUpInside];
    [self.search addTarget:self action:@selector(playYourFriend) forControlEvents:UIControlEventTouchUpInside];
}

else if([searchedUser.username isEqualToString:[PFUser currentUser].username]){
    NSLog(@"You Can't play against yourself");
    [self.activityInd stopAnimating];
    self.search.hidden = NO;
    self.search.transform = CGAffineTransformMakeScale(1, 1);
    [self.search setTitle:[NSString stringWithFormat:@"Cannot Play Yourself"] forState:UIControlStateNormal];
    [self performSelector:@selector(changeText) withObject:nil afterDelay:1.0];
    
}
else if(searchedUser != [PFUser currentUser] || self.textField.text == NULL){
    NSLog(@"user does not exist!");
    [self.activityInd stopAnimating];
    self.search.hidden = NO;
    self.search.transform = CGAffineTransformMakeScale(1, 1);
    [self.search setTitle:[NSString stringWithFormat:@"User does not exist"] forState:UIControlStateNormal];
    [self performSelector:@selector(changeText) withObject:nil afterDelay:1.0];
}
}
-(void)changeText{
    [self.search setTitle:[NSString stringWithFormat:@"Search Again"] forState:UIControlStateNormal];
}
-(void)playYourFriend{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.friendsName = self.textField.text;
    PlayerAndPlayerViewController *playFriendsController = [PlayerAndPlayerViewController new];
    UIViewAnimationTransition trans = UIViewAnimationTransitionCurlUp;
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition: trans forView: [self.view window] cache: YES];
    [self presentViewController: playFriendsController animated: NO completion:nil];
    [UIView commitAnimations];
    
    //Go to playFriendsArea
    
}
-(void)searchUsername{
    [UIView animateWithDuration:1.0 animations:^{
        [self.searchFacebookButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.searchUsernameButton.mas_bottom).offset(150);
        }];
    }];
    
       [self.view addSubview:self.textField];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchUsernameButton.mas_bottom).offset(10);
        make.width.equalTo(self.searchUsernameButton);
        make.height.equalTo(self.searchUsernameButton);
        make.centerX.equalTo(self.searchUsernameButton);
    }];
    
    
    [self.view addSubview:self.search];
    
    [self.search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.mas_bottom).offset(10.0f);
        make.width.equalTo(self.textField).offset(-50);
        make.centerX.equalTo(self.textField);
        make.height.equalTo(@40);
        
    }];
    [UIView animateWithDuration:0.8 animations:^{
        self.textField.alpha = 1.0f;
        self.search.alpha = 1.0f;
    }];
}

-(void)searchFacebook{
    
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"Play Friends";
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont fontWithName:@"BubblegumSans-Regular" size:38];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.minimumScaleFactor = 0.2;
        
        
    }
    return _titleLabel;
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [UIImageView new];
        _backgroundImageView.backgroundColor = [UIColor aod_colorWithHexValue:0xFFFFFF alpha:1.0f];
        
    }
    return _backgroundImageView;
}

- (UIImageView *)bannerImageView {
    if (!_bannerImageView) {
        _bannerImageView = [UIImageView new];
        _bannerImageView.backgroundColor = [UIColor aod_colorWithHexValue:0x33CCCC alpha:1.0f];
    }
    return _bannerImageView;
}
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton new];
        _backButton.titleLabel.textColor = [UIColor aod_colorWithHexValue:0xFF9500 alpha:1.0f];
        _backButton.titleLabel.font = [UIFont fontWithName:@"BubblegumSans-Regular" size:25];
        [_backButton setTitle:@"Back" forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIButton *)searchUsernameButton{
    if(!_searchUsernameButton){
        _searchUsernameButton = [UIButton new];
        _searchUsernameButton.backgroundColor = [UIColor aod_colorWithHexValue:0xFF7400 alpha:1.0f];
        _searchUsernameButton.layer.cornerRadius = 10.0f;
        _searchUsernameButton.layer.masksToBounds = YES;
        [_searchUsernameButton setTitle:@"Search by Username" forState:UIControlStateNormal];
        [_searchUsernameButton.titleLabel setFont:[UIFont fontWithName:@"BubblegumSans-Regular" size:30]];
        [_searchUsernameButton addTarget:self action:@selector(searchUsername) forControlEvents:UIControlEventTouchUpInside];
        _searchUsernameButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        _searchUsernameButton.titleLabel.minimumScaleFactor = 0.2;
        _searchUsernameButton.titleLabel.textColor = [UIColor whiteColor];
    }
    return _searchUsernameButton;
}
-(UIButton *)search{
    if(!_search){
        _search = [UIButton new];
        [_search setTitle:@"Search" forState:UIControlStateNormal];
        _search.backgroundColor = [UIColor aod_colorWithHexValue:0xFFB800 alpha:1.0f];
        _search.titleLabel.font = [UIFont fontWithName:@"BubblegumSans-Regular" size:20];
        [_search setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _search.layer.cornerRadius = 10.0f;
        _search.layer.masksToBounds = YES;
        _search.alpha = 0.0;
        [_search addTarget:self action:@selector(searchForUser) forControlEvents:UIControlEventTouchUpInside];
    }
    return _search;
}
- (UIButton *)searchFacebookButton{
    if(!_searchFacebookButton){
        _searchFacebookButton = [UIButton new];
        _searchFacebookButton.backgroundColor = [UIColor aod_colorWithHexValue:0x9898FB alpha:1.0f];
        _searchFacebookButton.layer.cornerRadius = 10.0f;
        _searchFacebookButton.layer.masksToBounds = YES;
        [_searchFacebookButton setTitle:@"Currently Playing" forState:UIControlStateNormal];
        [_searchFacebookButton.titleLabel setFont:[UIFont fontWithName:@"BubblegumSans-Regular" size:30]];
        [_searchFacebookButton addTarget:self action:@selector(searchFacebook) forControlEvents:UIControlEventTouchUpInside];
        _searchFacebookButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        _searchFacebookButton.titleLabel.minimumScaleFactor = 0.2;
        _searchFacebookButton.titleLabel.textColor = [UIColor whiteColor];
    }
    return _searchFacebookButton;
}
- (UITextField *)textField{
    if(!_textField){
        _textField = [UITextField new];
        _textField.placeholder = @"Enter friends Username";
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.font = [UIFont fontWithName:@"BubblegumSans-Regular" size:20];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.layer.borderColor = [UIColor grayColor].CGColor;
        _textField.layer.borderWidth = 0.5;
        _textField.layer.cornerRadius = 10;
        _textField.layer.masksToBounds = YES;
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.alpha = 0.0;
        _textField.delegate = self;
    }
    return _textField;
}
-(UIActivityIndicatorView*)activityInd{
    if(!_activityInd){
        _activityInd = [UIActivityIndicatorView new];
        [_activityInd setColor:[UIColor aod_colorWithHexValue:0xFFB800 alpha:1.0f]];
    }
    return _activityInd;
}
-(UITableView *)currentGames{
    if(!_currentGames){
        _currentGames = [UITableView new];
        _currentGames.delegate= self;
        _currentGames.dataSource = self;
        _currentGames.rowHeight = 60;
        _currentGames.separatorStyle = UITableViewCellSeparatorStyleNone;
        _currentGames.backgroundColor = [UIColor whiteColor];
    }
    return _currentGames;
}

@end
