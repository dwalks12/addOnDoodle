//
//  PlayWithFriendViewController.m
//  addOnDoodle
//
//  Created by Dawson Walker on 2015-09-29.
//  Copyright (c) 2015 Rise Digital. All rights reserved.
//

#import "PlayWithFriendViewController.h"
#import <Masonry/MASConstraintMaker.h>
#import <Masonry/View+MASAdditions.h>
#import "AODHexColors.h"


@interface PlayWithFriendViewController ()
@property (strong, nonatomic)UILabel *titleLabel;
@property (strong, nonatomic)UIImageView *backgroundImageView;
@property (strong, nonatomic)UIImageView *bannerImageView;
@property (strong, nonatomic)UIButton *backButton;
@property (strong, nonatomic)UIButton *searchUsernameButton;
@property (strong, nonatomic)UIButton *searchFacebookButton;


@end

@implementation PlayWithFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubviews];
    [self defineLayouts];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)addSubviews{
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.bannerImageView];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.titleLabel];
    
    [self.view addSubview:self.searchUsernameButton];
    [self.view addSubview:self.searchFacebookButton];
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
}


-(void)backToMain{
    UIViewAnimationTransition trans = UIViewAnimationTransitionCurlUp;
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition: trans forView: [self.view window] cache: YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    [UIView commitAnimations];
}

-(void)searchUsername{
    
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

- (UIButton *)searchFacebookButton{
    if(!_searchFacebookButton){
        _searchFacebookButton = [UIButton new];
        _searchFacebookButton.backgroundColor = [UIColor aod_colorWithHexValue:0x009999 alpha:1.0f];
        _searchFacebookButton.layer.cornerRadius = 10.0f;
        _searchFacebookButton.layer.masksToBounds = YES;
        [_searchFacebookButton setTitle:@"Search by Facebook" forState:UIControlStateNormal];
        [_searchFacebookButton.titleLabel setFont:[UIFont fontWithName:@"BubblegumSans-Regular" size:30]];
        [_searchFacebookButton addTarget:self action:@selector(searchFacebook) forControlEvents:UIControlEventTouchUpInside];
        _searchFacebookButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        _searchFacebookButton.titleLabel.minimumScaleFactor = 0.2;
        _searchFacebookButton.titleLabel.textColor = [UIColor whiteColor];
    }
    return _searchFacebookButton;
}

@end
