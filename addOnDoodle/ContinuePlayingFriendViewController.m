//
//  ContinuePlayingFriendViewController.m
//  addOnDoodle
//
//  Created by Dawson on 10/10/15.
//  Copyright © 2015 Rise Digital. All rights reserved.
//

#import "ContinuePlayingFriendViewController.h"
#import "PlayWithFriendViewController.h"
#import <Masonry/MASConstraintMaker.h>
#import <Masonry/View+MASAdditions.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "AODHexColors.h"
#import "ACEDrawingView.h"
#import "AppDelegate.h"
#import "BorderedButton.h"
#import "ColorPurchases.h"
#import <StartApp/StartApp.h>

@interface ContinuePlayingFriendViewController ()<ACEDrawingViewDelegate,UIScrollViewDelegate,STADelegateProtocol>

@property (strong, nonatomic)UIImageView *bannerBackground;
@property (strong, nonatomic)UIView *backgroundView;
@property (strong, nonatomic)UIButton *backButton;
@property (strong, nonatomic)UILabel *titleLabel;
@property (strong, nonatomic) UIScrollView *colorScrollView;
@property (nonatomic, strong) UIView *containerView;
@property (strong, nonatomic) UIButton *color1;
@property (strong, nonatomic) UIButton *color2;
@property (strong, nonatomic) UIButton *color3;
@property (strong, nonatomic) UIButton *color4;
@property (strong, nonatomic) UIButton *color5;
@property (strong, nonatomic) UIButton *color6;
@property (strong, nonatomic) UIButton *color7;
@property (strong, nonatomic) UIButton *color8;
@property (strong, nonatomic) UIButton *color9;
@property (strong, nonatomic) UIButton *color10;
@property (strong, nonatomic) UIButton *color11;
@property (strong, nonatomic) UIButton *color12;
@property (nonatomic, strong) NSMutableArray *arrayOfColorButtons;
@property (strong, nonatomic) ACEDrawingView *drawingView;
@property (strong, nonatomic) UIButton *undoButton;
@property (strong, nonatomic) UIButton *submitButton;
@property (strong, nonatomic) UIImageView *recievedImageView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) NSArray *gameArray;
@property (strong, nonatomic) UIButton *sizeOfBrushButton;
@property (strong, nonatomic) UISlider *slider;
@property (strong, nonatomic) UIImageView *sliderBackground;
@end

@implementation ContinuePlayingFriendViewController
{
    int attempts;
    int long numberOfColors;
    float colorWidth;
    STAStartAppAd* startAppAd;
    BOOL sizePressed;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    startAppAd = [[STAStartAppAd alloc] init];
    [startAppAd loadAdWithDelegate:self];
    attempts = 0;
    colorWidth = (self.view.frame.size.width - 60)/11;
    NSArray *countOfOwnedColors = [NSArray arrayWithArray:[[PFUser currentUser]objectForKey:@"purchased"]];
    numberOfColors = 12 + (countOfOwnedColors.count *5);
    
    
    self.activityIndicatorView.frame = CGRectMake(self.view.frame.size.width/2 - self.activityIndicatorView.frame.size.width/2, self.view.frame.size.height/2 - self.activityIndicatorView.frame.size.height/2  , self.activityIndicatorView.frame.size.width, self.activityIndicatorView.frame.size.width);
    [self.activityIndicatorView startAnimating];
    [self addSubviews];
    [self defineLayouts];
    [self addPurchasedColors];
    [self.view addSubview:self.activityIndicatorView];
    [self findADoodle];
    
    // Do any additional setup after loading the view.
}
-(void)findADoodle{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSMutableArray *fileArray = [[NSMutableArray alloc]init];
    fileArray = nil;
    fileArray = appDelegate.friendsGameArray;
    if(fileArray != nil){
        PFFile *imageFile = fileArray[fileArray.count-1];
        PFImageView *imageView = [[PFImageView alloc]init];
        imageView.file = imageFile;
        
        [imageView loadInBackground:^(UIImage *img, NSError *error){
            //[self.view addSubview:self.activityIndicatorView];
            [self.activityIndicatorView stopAnimating];
            NSLog(@"LOOOAD");
            self.activityIndicatorView.hidden = YES;
            
            self.recievedImageView.image = img;
            
            NSLog(@"the recievedImageView = %@", self.recievedImageView);
            [self.view bringSubviewToFront:self.drawingView];
            
        }];
        
    }
    
}
-(void)errorHandler{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Sorry"
                                                                   message:@"Please make sure you are connected to the internet"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self backToMain];
                                                          }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)addSubviews{
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.colorScrollView];
    //[self.view addSubview:self.containerView];
    [self.colorScrollView addSubview:self.color1];
    [self.colorScrollView addSubview:self.color2];
    [self.colorScrollView addSubview:self.color3];
    [self.colorScrollView addSubview:self.color4];
    [self.colorScrollView addSubview:self.color5];
    [self.colorScrollView addSubview:self.color6];
    [self.colorScrollView addSubview:self.color7];
    [self.colorScrollView addSubview:self.color8];
    [self.colorScrollView addSubview:self.color9];
    [self.colorScrollView addSubview:self.color10];
    [self.colorScrollView addSubview:self.color11];
    [self.colorScrollView addSubview:self.color12];
    [self.view addSubview:self.bannerBackground];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.drawingView];
    [self.view addSubview:self.recievedImageView];
    [self.view addSubview:self.undoButton];
    [self.view addSubview:self.submitButton];
    [self.view addSubview:self.sizeOfBrushButton];
    [self.drawingView getTheWidth:colorWidth];
    
}
-(void)defineLayouts{
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.width.equalTo(self.view).offset(60.0f);
        make.height.equalTo(@40);
    }];
    [self.bannerBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(@60);
    }];
    
    [self.colorScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sizeOfBrushButton.mas_right).offset(5.0f);
        make.top.equalTo(self.bannerBackground.mas_bottom);
        make.width.equalTo(@(self.view.frame.size.width - (self.sizeOfBrushButton.frame.origin.x + self.sizeOfBrushButton.frame.size.width) - 10));
        make.height.equalTo(@(self.view.frame.size.height/14));
    }];
    [self.color1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.centerY.equalTo(self.colorScrollView);
        make.width.equalTo(@(colorWidth));
        make.height.equalTo(@(colorWidth));
    }];
    [self.undoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(35.0f);
        make.centerY.equalTo(self.color1).offset(3.0f);
        make.height.equalTo(@(colorWidth));
        make.width.equalTo(@(colorWidth));
    }];
    [self.sizeOfBrushButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.undoButton.mas_right).offset(10.0f);
        make.centerY.equalTo(self.undoButton);
        make.width.equalTo(@(colorWidth));
        make.height.equalTo(@(colorWidth));
    }];
    [self.color2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.color1.mas_right).offset(5.0f + self.color1.frame.size.width);
        make.centerY.equalTo(self.colorScrollView);
        make.width.equalTo(self.color1);
        make.height.equalTo(self.color1);
    }];
    [self.color3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.color2.mas_right).offset(5.0f + self.color2.frame.size.width);
        make.centerY.equalTo(self.colorScrollView);
        make.width.equalTo(self.color1);
        make.height.equalTo(self.color1);
    }];
    [self.color4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.color3.mas_right).offset(5.0f + self.color3.frame.size.width);
        make.centerY.equalTo(self.colorScrollView);
        make.width.equalTo(self.color1);
        make.height.equalTo(self.color1);
    }];
    [self.color5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.color4.mas_right).offset(5.0f + self.color4.frame.size.width);
        make.centerY.equalTo(self.colorScrollView);
        make.width.equalTo(self.color1);
        make.height.equalTo(self.color1);
    }];
    [self.color6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.color5.mas_right).offset(5.0f + self.color5.frame.size.width);
        make.centerY.equalTo(self.colorScrollView);
        make.width.equalTo(self.color1);
        make.height.equalTo(self.color1);
    }];
    [self.color7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.color6.mas_right).offset(5.0f + self.color6.frame.size.width);
        make.centerY.equalTo(self.colorScrollView);
        make.width.equalTo(self.color1);
        make.height.equalTo(self.color1);
    }];
    [self.color8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.color7.mas_right).offset(5.0f + self.color7.frame.size.width);
        make.centerY.equalTo(self.colorScrollView);
        make.width.equalTo(self.color1);
        make.height.equalTo(self.color1);
    }];
    [self.color9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.color8.mas_right).offset(5.0f + self.color8.frame.size.width);
        make.centerY.equalTo(self.colorScrollView);
        make.width.equalTo(self.color1);
        make.height.equalTo(self.color1);
    }];
    [self.color10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.color9.mas_right).offset(5.0f + self.color9.frame.size.width);
        make.centerY.equalTo(self.colorScrollView);
        make.width.equalTo(self.color1);
        make.height.equalTo(self.color1);
    }];
    [self.color11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.color10.mas_right).offset(5.0f + self.color10.frame.size.width);
        make.centerY.equalTo(self.colorScrollView);
        make.width.equalTo(self.color1);
        make.height.equalTo(self.color1);
    }];
    [self.color12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.color11.mas_right).offset(5.0f + self.color11.frame.size.width);
        make.centerY.equalTo(self.colorScrollView);
        make.width.equalTo(self.color1);
        make.height.equalTo(self.color1);
    }];
    [self.drawingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.width.equalTo(self.view);
        make.top.equalTo(self.colorScrollView.mas_bottom);
    }];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_right).offset(-40.0f);
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.width.equalTo(@80);
        make.height.equalTo(@40);
    }];
    [self.recievedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.centerY.centerX.equalTo(self.drawingView);
    }];
    
    
}
#pragma mark -- ACTIONS

-(void)Size:(id)sender{
    UISlider *slider = (UISlider*)sender;
    float value = slider.value;
    self.drawingView.lineWidth = value;
}
-(void)selectBrushSize{
    if(sizePressed == NO){
        sizePressed = YES;
        [self.sizeOfBrushButton setBackgroundImage:[UIImage imageNamed:@"colorPalette.png"] forState:UIControlStateNormal];
        [self.view addSubview:self.sliderBackground];
        [self.view addSubview:self.slider];
        
        [self.sliderBackground mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.left.centerY.equalTo(self.colorScrollView);
            make.right.equalTo(self.view);
        }];
        [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.left.centerY.equalTo(self.sliderBackground);
            make.right.equalTo(self.view).offset(-10.0f);
        }];
    }else{
        sizePressed = NO;
        [self.sizeOfBrushButton setBackgroundImage:[UIImage imageNamed:@"paintBrush.png"] forState:UIControlStateNormal];
        [self.sliderBackground removeFromSuperview];
        [self.slider removeFromSuperview];
    }
}
-(void)addPurchasedColors{
    NSArray *arrayOfPurchasedColors = [[PFUser currentUser]objectForKey:@"purchased"];
    int count = 0;
    SEL method;
    float xn = 0;
    for(int i = 0;i < arrayOfPurchasedColors.count;i ++){
        for(int l = 0;l<[ColorPurchases nameOfColors].count;l++){
            
            
            //NSLog(@"array of purchased count = %lu  %@",(unsigned long)arrayOfPurchasedColors.count,arrayOfPurchasedColors);
            
            if([arrayOfPurchasedColors[i]isEqualToString:[ColorPurchases nameOfColors][l]]){
                count++;
                method = NSSelectorFromString( [NSString stringWithFormat:@"colorScheme%i",l+1]);
                NSArray *colorScheme1 = [ColorPurchases performSelector:method];
                //NSLog(@"colorScheme1 = %@",colorScheme1);
                for(int q = 0;q<colorScheme1.count;q++){
                    unsigned colorInt = 0;
                    
                    
                    [[NSScanner scannerWithString:colorScheme1[q]] scanHexInt:&colorInt];
                    
                    xn += (colorWidth+5.0f);
                    
                    UIButton *colorButton = [[BorderedButton alloc]init];
                    colorButton.backgroundColor = [UIColor aod_colorWithHexValue:colorInt alpha:1.0f];
                    //colorButton.backgroundColor = [UIColor blackColor];
                    colorButton.layer.cornerRadius = 4.0f;
                    colorButton.layer.masksToBounds = YES;
                    [colorButton addTarget:self action:@selector(Color:) forControlEvents:UIControlEventTouchUpInside];
                    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                                   {
                                       // Background work
                                       dispatch_async(dispatch_get_main_queue(), ^(void){
                                           [self.colorScrollView addSubview:colorButton];
                                           [colorButton mas_makeConstraints:^(MASConstraintMaker *make) {
                                               make.centerY.equalTo(self.colorScrollView);
                                               make.centerX.equalTo(self.color12).offset(xn);
                                               make.width.equalTo(self.color1);
                                               make.height.equalTo(self.color1);
                                           }];
                                       });
                                   });
                    // NSLog(@"%@",colorButton);
                    [self.arrayOfColorButtons addObject:colorButton];
                }
            }
        }
        
        
        
    }
    NSLog(@"number of added colors = %i",count);
}
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    // or if you are sure you wanna it always on top:
    // [aScrollView setContentOffset: CGPointMake(aScrollView.contentOffset.x, 0)];
}
-(void)Color:(id)sender{
    UIButton *clicked = (UIButton *) sender;
    for(int i = 0;i<self.arrayOfColorButtons.count;i++){
        if(self.arrayOfColorButtons[i] != sender){
            [(UIButton*)self.arrayOfColorButtons[i] setSelected:NO];
            
        }
        else{
            [(UIButton*)self.arrayOfColorButtons[i] setSelected:YES];
        }
    }
    
    
    
    self.drawingView.lineColor = clicked.backgroundColor;
}

-(void)undo{
    [self.drawingView undoLatestStep];
}

-(void)backToMain{
    PlayWithFriendViewController *playFriend = [PlayWithFriendViewController new];
    UIViewAnimationTransition trans = UIViewAnimationTransitionCurlUp;
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition: trans forView: [self.view window] cache: YES];
    [self presentViewController:playFriend animated:NO completion:nil];
    [UIView commitAnimations];
}

-(void)submitDrawing{
    self.submitButton.hidden = YES;
    UIActivityIndicatorView *activityInd = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self.view addSubview:activityInd];
    [activityInd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.submitButton);
        make.centerY.equalTo(self.submitButton);
    }];
    activityInd.hidesWhenStopped = YES;
    
    
    [activityInd startAnimating];
    
    [self takeSnapShot];
}
-(void)takeSnapShot{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.view.frame.size.width, self.drawingView.frame.size.height), NO, [UIScreen mainScreen].scale);
    [self.view drawViewHierarchyInRect:CGRectMake(0, -self.drawingView.frame.origin.y, self.view.bounds.size.width, self.view.bounds.size.height) afterScreenUpdates:YES];
    UIImage *capturedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData * fileData = UIImagePNGRepresentation(capturedImage);
    PFFile* file = [PFFile fileWithName:@"image.png" data:fileData];
    [file saveInBackground];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *objectID = appDelegate.objectId;
    NSString *friendsName = appDelegate.friendsName;
    NSMutableArray *imageArray = appDelegate.imagesArray;
    [imageArray addObject:file];
    NSArray *imageArrayCopy = [NSArray arrayWithArray:imageArray];
    PFObject *object = [PFObject objectWithoutDataWithClassName:@"GameWithFriend" objectId:objectID];
    [object setObject:imageArrayCopy forKey:@"imagesArray"];
    [object setObject:friendsName forKey:@"whoseTurn"];
    [object incrementKey:@"chainLength"];
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(!error){
            
            [startAppAd showAd];
        }
        
        
    }];
}
- (void) didLoadAd:(STAAbstractAd*)ad{
    
}
- (void) failedLoadAd:(STAAbstractAd*)ad withError:(NSError *)error{
    
}
- (void) didShowAd:(STAAbstractAd*)ad{
    
}
- (void) failedShowAd:(STAAbstractAd*)ad withError:(NSError *)error{
    [self backToMain];
}
- (void) didCloseAd:(STAAbstractAd*)ad{
    [self backToMain];
}
- (void) didClickAd:(STAAbstractAd*)ad{
    [self backToMain];
}
- (ACEDrawingView *)drawingView {
    if (!_drawingView) {
        _drawingView = [ACEDrawingView new];
        _drawingView.delegate = self;
        _drawingView.backgroundColor = [UIColor clearColor];
        _drawingView.lineColor = [UIColor blackColor];
        _drawingView.lineWidth = 5.0f;
        _drawingView.drawMode = ACEDrawingModeOriginalSize;
        _drawingView.drawTool = ACEDrawingToolTypePen;
    }
    return _drawingView;
}
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        _backgroundView.backgroundColor = [UIColor aod_colorWithHexValue:0xFFFFFF alpha:1.0f];
    }
    return _backgroundView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"BubblegumSans-Regular" size:24];
        _titleLabel.textColor = [UIColor aod_colorWithHexValue:0xFFFFFF alpha:1.0f];
        _titleLabel.text = @"Add A Doodle";
        _titleLabel.minimumScaleFactor = 0.4;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLabel;
}

- (UIImageView *)bannerBackground {
    if (!_bannerBackground) {
        _bannerBackground = [UIImageView new];
        _bannerBackground.backgroundColor = [UIColor aod_colorWithHexValue:0x33CCCC alpha:1.0f];
    }
    return _bannerBackground;
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
- (UIButton *)undoButton {
    if(!_undoButton){
        _undoButton = [UIButton new];
        [_undoButton setBackgroundImage:[UIImage imageNamed:@"undoIcon.png"] forState:UIControlStateNormal];
        [_undoButton addTarget:self action:@selector(undo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _undoButton;
}
- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton new];
        _submitButton.titleLabel.font = [UIFont fontWithName:@"BubblegumSans-Regular" size:25];
        _submitButton.titleLabel.textColor = [UIColor whiteColor];
        [_submitButton setTitle:@"Submit" forState:UIControlStateNormal];
        
        [_submitButton addTarget:self action:@selector(submitDrawing) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}
-(UIImageView *)recievedImageView{
    if(!_recievedImageView){
        _recievedImageView = [UIImageView new];
        //_recievedImageView.backgroundColor = [UIColor brownColor];
    }
    
    return _recievedImageView;
}
- (UIActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [UIActivityIndicatorView new];
        
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        [_activityIndicatorView setColor:[UIColor colorWithRed:1.0 green:0.4 blue:0.3 alpha:1.0]];
        
        [_activityIndicatorView setHidesWhenStopped:YES];
        
    }
    return _activityIndicatorView;
}
- (UIButton *)color1 {
    if (!_color1) {
        _color1 = [UIButton new];
        _color1.backgroundColor = [UIColor whiteColor];
        [_color1 setBackgroundImage:[UIImage imageNamed:@"eraser.png"] forState:UIControlStateNormal];
        _color1.layer.cornerRadius = 4.0f;
        _color1.layer.masksToBounds = YES;
        
        [_color1 addTarget:self action:@selector(Color:) forControlEvents:UIControlEventTouchUpInside];
        [self.arrayOfColorButtons addObject:_color1];
    }
    return _color1;
}

- (UIButton *)color2 {
    if (!_color2) {
        _color2 = [BorderedButton new];
        _color2.backgroundColor = [UIColor blackColor];
        _color2.layer.cornerRadius = 4.0f;
        _color2.layer.masksToBounds = YES;
        [_color2 setSelected:YES];
        [_color2 addTarget:self action:@selector(Color:) forControlEvents:UIControlEventTouchUpInside];
        [self.arrayOfColorButtons addObject:_color2];
    }
    return _color2;
}

- (UIButton *)color3 {
    if (!_color3) {
        _color3 = [BorderedButton new];
        _color3.backgroundColor = [UIColor redColor];
        _color3.layer.cornerRadius = 4.0f;
        _color3.layer.masksToBounds = YES;
        [_color3 addTarget:self action:@selector(Color:) forControlEvents:UIControlEventTouchUpInside];
        [self.arrayOfColorButtons addObject:_color3];
    }
    return _color3;
}

- (UIButton *)color4 {
    if (!_color4) {
        _color4 = [BorderedButton new];
        _color4.backgroundColor = [UIColor orangeColor];
        _color4.layer.cornerRadius = 4.0f;
        _color4.layer.masksToBounds = YES;
        [_color4 addTarget:self action:@selector(Color:) forControlEvents:UIControlEventTouchUpInside];
        [self.arrayOfColorButtons addObject:_color4];
    }
    return _color4;
}

- (UIButton *)color5 {
    if (!_color5) {
        _color5 = [BorderedButton new];
        _color5.backgroundColor = [UIColor yellowColor];
        _color5.layer.cornerRadius = 4.0f;
        _color5.layer.masksToBounds = YES;
        [_color5 addTarget:self action:@selector(Color:) forControlEvents:UIControlEventTouchUpInside];
        [self.arrayOfColorButtons addObject:_color5];
    }
    return _color5;
}

- (UIButton *)color6 {
    if (!_color6) {
        _color6 = [BorderedButton new];
        _color6.backgroundColor = [UIColor greenColor];
        _color6.layer.cornerRadius = 4.0f;
        _color6.layer.masksToBounds = YES;
        [_color6 addTarget:self action:@selector(Color:) forControlEvents:UIControlEventTouchUpInside];
        [self.arrayOfColorButtons addObject:_color6];
    }
    return _color6;
}

- (UIButton *)color7 {
    if (!_color7) {
        _color7 = [BorderedButton new];
        _color7.backgroundColor = [UIColor blueColor];
        _color7.layer.cornerRadius = 4.0f;
        _color7.layer.masksToBounds = YES;
        [_color7 addTarget:self action:@selector(Color:) forControlEvents:UIControlEventTouchUpInside];
        [self.arrayOfColorButtons addObject:_color7];
    }
    return _color7;
}

- (UIButton *)color8 {
    if (!_color8) {
        _color8 = [BorderedButton new];
        _color8.backgroundColor = [UIColor purpleColor];
        _color8.layer.cornerRadius = 4.0f;
        _color8.layer.masksToBounds = YES;
        [_color8 addTarget:self action:@selector(Color:) forControlEvents:UIControlEventTouchUpInside];
        [self.arrayOfColorButtons addObject:_color8];
    }
    return _color8;
}

- (UIButton *)color9 {
    if (!_color9) {
        _color9 = [BorderedButton new];
        _color9.backgroundColor = [UIColor brownColor];
        _color9.layer.cornerRadius = 4.0f;
        _color9.layer.masksToBounds = YES;
        [_color9 addTarget:self action:@selector(Color:) forControlEvents:UIControlEventTouchUpInside];
        [self.arrayOfColorButtons addObject:_color9];
    }
    return _color9;
}

- (UIButton *)color10 {
    if (!_color10) {
        _color10 = [BorderedButton new];
        _color10.backgroundColor = [UIColor grayColor];
        _color10.layer.cornerRadius = 4.0f;
        _color10.layer.masksToBounds = YES;
        [_color10 addTarget:self action:@selector(Color:) forControlEvents:UIControlEventTouchUpInside];
        [self.arrayOfColorButtons addObject:_color10];
    }
    return _color10;
}

- (UIButton *)color11 {
    if (!_color11) {
        _color11 = [BorderedButton new];
        _color11.backgroundColor = [UIColor lightGrayColor];
        _color11.layer.cornerRadius = 4.0f;
        _color11.layer.masksToBounds = YES;
        [_color11 addTarget:self action:@selector(Color:) forControlEvents:UIControlEventTouchUpInside];
        [self.arrayOfColorButtons addObject:_color11];
    }
    return _color11;
}

-(UIButton *)color12{
    if(!_color12){
        _color12 = [BorderedButton new];
        _color12.backgroundColor = [UIColor aod_colorWithHexValue:0x5856D6 alpha:1.0f];
        _color12.layer.cornerRadius = 4.0f;
        _color12.layer.masksToBounds = YES;
        [_color12 addTarget:self action:@selector(Color:) forControlEvents:UIControlEventTouchUpInside];
        [self.arrayOfColorButtons addObject:_color12];
        
    }
    return _color12;
}
-(UIScrollView *)colorScrollView{
    if(!_colorScrollView){
        _colorScrollView = [UIScrollView new];
        _colorScrollView.delegate = self;
        
        _colorScrollView.contentSize = CGSizeMake(5.0f + (numberOfColors *(colorWidth+5.0f) + 120), 1);
        
    }
    return _colorScrollView;
}
- (NSMutableArray *)arrayOfColorButtons {
    if (!_arrayOfColorButtons) {
        _arrayOfColorButtons = [NSMutableArray new];
        
    }
    return _arrayOfColorButtons;
}
- (UIButton*)sizeOfBrushButton{
    if(!_sizeOfBrushButton){
        _sizeOfBrushButton = [UIButton new];
        
        [_sizeOfBrushButton setBackgroundImage:[UIImage imageNamed:@"paintBrush.png"] forState:UIControlStateNormal];
        [_sizeOfBrushButton addTarget:self action:@selector(selectBrushSize) forControlEvents:UIControlEventTouchUpInside];
        _sizeOfBrushButton.layer.cornerRadius = _sizeOfBrushButton.frame.size.width/2;
        _sizeOfBrushButton.layer.masksToBounds = YES;
    }
    return _sizeOfBrushButton;
}
-(UIImageView *)sliderBackground{
    if(!_sliderBackground){
        _sliderBackground = [UIImageView new];
        _sliderBackground.backgroundColor = [UIColor whiteColor];
    }
    return _sliderBackground;
}
-(UISlider *)slider{
    if(!_slider){
        _slider = [UISlider new];
        [_slider addTarget:self action:@selector(Size:) forControlEvents:UIControlEventValueChanged];
        _slider.minimumValue = 1.0;
        _slider.maximumValue = 50.0;
        _slider.continuous = YES;
        _slider.value = 5.0;
    }
    return _slider;
}


@end
