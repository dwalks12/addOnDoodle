//
//  ViewController.m
//  addOnDoodle
//
//  Created by Dawson Walker on 2015-09-07.
//  Copyright (c) 2015 Rise Digital. All rights reserved.
//

#import "MainMenuViewController.h"
#import <Masonry/MASConstraintMaker.h>
#import <Masonry/View+MASAdditions.h>
#import "AODHexColors.h"
#import "StartNewGameViewController.h"
#import "SettingsViewController.h"
#import "JoinAGameViewController.h"
#import "YourGamesViewController.h"
#import <StartApp/StartApp.h>
#import "ShopViewController.h"
#import "PlayWithFriendViewController.h"

@interface MainMenuViewController ()<STABannerDelegateProtocol>{
     STABannerView* bannerView;
}

@property (strong, nonatomic)UIButton *startNewGameButton;
@property (strong, nonatomic)UIButton *joinAGameButton;
@property (strong, nonatomic)UIButton *shopButton;
@property (strong, nonatomic)UIButton *settingsButton;
@property (strong, nonatomic)UIButton *yourGamesButton;
@property (strong, nonatomic)UILabel *titleLabel;
@property (strong, nonatomic)UIImageView *backgroundImageView;
@property (strong, nonatomic)UIImageView *bannerImageView;
@property (strong, nonatomic)UIButton *playFriendsButton;

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubviews];
    [self defineLayouts];
    [self showBannerAds];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)showBannerAds{
    bannerView = [[STABannerView alloc] initWithSize:STA_AutoAdSize
                                              origin:CGPointMake(0, self.view.frame.size.height - 50)
                                            withView:self.view
                                        withDelegate:self];
    [self.view addSubview:bannerView];
    [bannerView showBanner];
}
-(void)addSubviews{
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.bannerImageView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.startNewGameButton];
    [self.view addSubview:self.joinAGameButton];
    [self.view addSubview:self.settingsButton];
    [self.view addSubview:self.shopButton];
    [self.view addSubview:self.yourGamesButton];
    [self.view addSubview:self.playFriendsButton];
}

-(void)defineLayouts{
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(self.view);
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
    [self.startNewGameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.bannerImageView.mas_bottom).offset(20.0f);
        make.width.equalTo(self.view).offset(-40.0f);
        make.height.equalTo(@((self.view.frame.size.height - self.bannerImageView.frame.size.height)/5 - 60.0f));
    }];
    [self.joinAGameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.startNewGameButton.mas_bottom).offset(20.0f);
        make.width.equalTo(self.startNewGameButton);
        make.height.equalTo(self.startNewGameButton);
    }];
    [self.yourGamesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.joinAGameButton.mas_bottom).offset(20.0f);
        make.width.equalTo(self.startNewGameButton);
        make.height.equalTo(self.startNewGameButton);
    }];
    [self.settingsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_right).offset(-35.0f);
        make.centerY.equalTo(self.titleLabel);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    [self.shopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.yourGamesButton.mas_bottom).offset(20.0f);
        make.width.equalTo(self.yourGamesButton);
        make.height.equalTo(self.yourGamesButton);
    }];
    [self.playFriendsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.shopButton.mas_bottom).offset(20.0f);
        make.width.equalTo(self.yourGamesButton);
        make.height.equalTo(self.yourGamesButton);
    }];

}

#pragma mark -- Actions

-(void)goToSettings{
    SettingsViewController *settingsViewController = [SettingsViewController new];
    
    UIViewAnimationTransition trans = UIViewAnimationTransitionCurlUp;
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition: trans forView: [self.view window] cache: YES];
    [self presentViewController: settingsViewController animated: NO completion:nil];
    [UIView commitAnimations];
}
-(void)startNewGame{
    
    StartNewGameViewController *startNewGameController = [StartNewGameViewController new];
   
    UIViewAnimationTransition trans = UIViewAnimationTransitionCurlUp;
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition: trans forView: [self.view window] cache: YES];
    [self presentViewController: startNewGameController animated: NO completion:nil];
    [UIView commitAnimations];
    
}
-(void)joinAGame{
    JoinAGameViewController *joinAGameController = [JoinAGameViewController new];
    
    UIViewAnimationTransition trans = UIViewAnimationTransitionCurlUp;
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition: trans forView: [self.view window] cache: YES];
    [self presentViewController: joinAGameController animated: NO completion:nil];
    [UIView commitAnimations];
}
-(void)goToYourGames{
    YourGamesViewController *yourGamesController = [YourGamesViewController new];
    UIViewAnimationTransition trans = UIViewAnimationTransitionCurlUp;
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition: trans forView: [self.view window] cache: YES];
    [self presentViewController: yourGamesController animated: NO completion:nil];
    [UIView commitAnimations];
    
}
-(void)goToShop{
    ShopViewController *shopController = [ShopViewController new];
    UIViewAnimationTransition trans = UIViewAnimationTransitionCurlUp;
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition: trans forView: [self.view window] cache: YES];
    [self presentViewController: shopController animated: NO completion:nil];
    [UIView commitAnimations];
}
-(void)goToPlayFriends{
    PlayWithFriendViewController *playFriendsController = [PlayWithFriendViewController new];
    UIViewAnimationTransition trans = UIViewAnimationTransitionCurlUp;
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition: trans forView: [self.view window] cache: YES];
    [self presentViewController: playFriendsController animated: NO completion:nil];
    [UIView commitAnimations];
}
#pragma mark -- Properties

- (UIButton *)startNewGameButton {
    if (!_startNewGameButton) {
        _startNewGameButton = [UIButton new];
        _startNewGameButton.backgroundColor = [UIColor aod_colorWithHexValue:0xFF0000 alpha:1.0f];
        _startNewGameButton.layer.cornerRadius = 10.0f;
        _startNewGameButton.layer.masksToBounds = YES;
        [_startNewGameButton setTitle:@"Start a New Game" forState:UIControlStateNormal];
        [_startNewGameButton.titleLabel setFont:[UIFont fontWithName:@"BubblegumSans-Regular" size:30]];
        _startNewGameButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        _startNewGameButton.titleLabel.minimumScaleFactor = 0.2;
        _startNewGameButton.titleLabel.textColor = [UIColor whiteColor];
        [_startNewGameButton addTarget:self action:@selector(startNewGame) forControlEvents:UIControlEventTouchUpInside];

    }
    return _startNewGameButton;
}

- (UIButton *)shopButton {
    if (!_shopButton) {
        _shopButton = [UIButton new];
        _shopButton.backgroundColor = [UIColor aod_colorWithHexValue:0X00CC00 alpha:1.0f];
        _shopButton.layer.cornerRadius = 10.0f;
        _shopButton.layer.masksToBounds = YES;
         [_shopButton setTitle:@"Shop" forState:UIControlStateNormal];
        [_shopButton.titleLabel setFont:[UIFont fontWithName:@"BubblegumSans-Regular" size:30]];
        _shopButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        _shopButton.titleLabel.minimumScaleFactor = 0.2;
        _shopButton.titleLabel.textColor = [UIColor whiteColor];
        [_shopButton addTarget:self action:@selector(goToShop) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shopButton;
}

- (UIButton *)joinAGameButton {
    if (!_joinAGameButton) {
        _joinAGameButton = [UIButton new];
        _joinAGameButton.backgroundColor = [UIColor aod_colorWithHexValue:0xFF7400 alpha:1.0f];
        _joinAGameButton.layer.cornerRadius = 10.0f;
        _joinAGameButton.layer.masksToBounds = YES;
         [_joinAGameButton setTitle:@"Join a Game" forState:UIControlStateNormal];
        [_joinAGameButton.titleLabel setFont:[UIFont fontWithName:@"BubblegumSans-Regular" size:30]];
        [_joinAGameButton addTarget:self action:@selector(joinAGame) forControlEvents:UIControlEventTouchUpInside];
        _joinAGameButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        _joinAGameButton.titleLabel.minimumScaleFactor = 0.2;
        _joinAGameButton.titleLabel.textColor = [UIColor whiteColor];

    }
    return _joinAGameButton;
}

- (UIButton *)settingsButton {
    if (!_settingsButton) {
        _settingsButton = [UIButton new];
        [_settingsButton setBackgroundImage:[UIImage imageNamed:@"setting-icon.png"] forState:UIControlStateNormal];
        
        [_settingsButton addTarget:self action:@selector(goToSettings) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingsButton;
}

- (UIButton *)yourGamesButton {
    if (!_yourGamesButton) {
        _yourGamesButton = [UIButton new];
        _yourGamesButton.backgroundColor = [UIColor aod_colorWithHexValue:0x009999 alpha:1.0f];
        _yourGamesButton.layer.cornerRadius = 10.0f;
        _yourGamesButton.layer.masksToBounds = YES;
        [_yourGamesButton setTitle:@"Your Games" forState:UIControlStateNormal];
        [_yourGamesButton.titleLabel setFont:[UIFont fontWithName:@"BubblegumSans-Regular" size:30]];
        [_yourGamesButton addTarget:self action:@selector(goToYourGames) forControlEvents:UIControlEventTouchUpInside];
        _yourGamesButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        _yourGamesButton.titleLabel.minimumScaleFactor = 0.2;
        _yourGamesButton.titleLabel.textColor = [UIColor whiteColor];
    }
    return _yourGamesButton;
}

-(UIButton *)playFriendsButton{
    if(!_playFriendsButton){
        _playFriendsButton = [UIButton new];
        _playFriendsButton.backgroundColor = [UIColor aod_colorWithHexValue:0x9370DB];
        _playFriendsButton.layer.cornerRadius = 10.0f;
        _playFriendsButton.layer.masksToBounds = YES;
        [_playFriendsButton setTitle:@"Play Friends" forState:UIControlStateNormal];
        [_playFriendsButton.titleLabel setFont:[UIFont fontWithName:@"BubblegumSans-Regular" size:30]];
        [_playFriendsButton addTarget:self action:@selector(goToPlayFriends) forControlEvents:UIControlEventTouchUpInside];
        _playFriendsButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        _playFriendsButton.titleLabel.minimumScaleFactor = 0.2;
        _playFriendsButton.titleLabel.textColor = [UIColor whiteColor];
        
    }
    return _playFriendsButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"AddOnDoodle";
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


@end
