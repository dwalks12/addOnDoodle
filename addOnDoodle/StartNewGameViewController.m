//
//  StartNewGameViewController.m
//  addOnDoodle
//
//  Created by Dawson Walker on 2015-09-13.
//  Copyright (c) 2015 Rise Digital. All rights reserved.
//

#import "StartNewGameViewController.h"
#import <Masonry/MASConstraintMaker.h>
#import <Masonry/View+MASAdditions.h>
#import <Parse/Parse.h>
#import "AODHexColors.h"
#import "ACEDrawingView.h"
#import "ColorPurchases.h"
#import "BorderedButton.h"

@interface StartNewGameViewController ()<ACEDrawingViewDelegate,UIScrollViewDelegate>
@property (strong, nonatomic)UIImageView *bannerBackground;
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
@property (strong, nonatomic)UIView *backgroundView;
@property (strong, nonatomic)UIButton *backButton;
@property (strong, nonatomic)UILabel *titleLabel;
@property (strong, nonatomic) ACEDrawingView *drawingView;
@property (strong, nonatomic) UIButton *undoButton;
@property (strong, nonatomic) UIButton *submitButton;

@end

@implementation StartNewGameViewController{
    int long numberOfColors;
    float colorWidth;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    colorWidth = (self.view.frame.size.width - 60)/11;
    NSArray *countOfOwnedColors = [NSArray arrayWithArray:[[PFUser currentUser]objectForKey:@"purchased"]];
    //NSLog(@"countof colors = %lu",countOfOwnedColors.count);
    numberOfColors = 12 + (countOfOwnedColors.count *5);
    [self addSubviews];
    [self defineLayouts];
    [self addPurchasedColors];
    // Do any additional setup after loading the view.
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
    [self.view addSubview:self.undoButton];
    [self.view addSubview:self.submitButton];
    
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
        make.width.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    [self.bannerBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(@60);
    }];
    [self.undoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(30.0f);
        make.top.equalTo(self.bannerBackground.mas_bottom).offset(10.0f);
        make.height.equalTo(@30);
        make.width.equalTo(@30);
    }];
    [self.colorScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.undoButton.mas_right).offset(10.0f);
        make.top.equalTo(self.bannerBackground.mas_bottom);
        make.width.equalTo(@(self.view.frame.size.width - (self.undoButton.frame.origin.y + self.undoButton.frame.size.width) - 10));
        make.height.equalTo(@(self.view.frame.size.height/14));
    }];
    [self.color1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.centerY.equalTo(self.colorScrollView);
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
        make.height.equalTo(@(self.view.frame.size.height - self.bannerBackground.frame.size.height - 40));
        make.width.equalTo(self.view);
        make.top.equalTo(self.bannerBackground.mas_bottom).offset(40.0f);
    }];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_right).offset(-40.0f);
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.width.equalTo(@80);
        make.height.equalTo(@40);
    }];


}
#pragma mark -- ACTIONS
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
    NSLog(@"drawingview height = %f",self.drawingView.frame.size.height);
    [self.drawingView undoLatestStep];
}
-(void)backToMain{
    UIViewAnimationTransition trans = UIViewAnimationTransitionCurlUp;
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition: trans forView: [self.view window] cache: YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    [UIView commitAnimations];
    
}
-(void)takeSnapShot{
    
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.view.frame.size.width, self.drawingView.frame.size.height), NO, [UIScreen mainScreen].scale);
    [self.view drawViewHierarchyInRect:CGRectMake(0, -self.drawingView.frame.origin.y, self.view.bounds.size.width, self.view.bounds.size.height) afterScreenUpdates:YES];
    UIImage *capturedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //ADD THIS LATER
   // NSMutableArray *pathArray = [[NSMutableArray alloc]init];
   // pathArray = self.drawingView.accessFinishedPathsArray;
    
    //NSTimeInterval timeInterval = self.drawingView.accessTimeInterval;
   // NSMutableArray *chosenColors = self.drawingView.accessChosenColors;
    //NSMutableArray *chosenWidth = self.drawingView.accessChosenWidths;
    //NSInteger timeInt = timeInterval;
    //NSData *data = [NSKeyedArchiver archivedDataWithRootObject:pathArray];
    //NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:chosenColors];
    
    NSData * fileData = UIImagePNGRepresentation(capturedImage);
    PFFile* file = [PFFile fileWithName:@"image.png" data:fileData];
    [file saveInBackground];
    
    NSMutableArray *imageArray = [[NSMutableArray alloc]initWithObjects:file, nil];
    NSArray *imageArrayCopy = [NSArray arrayWithArray:imageArray];
    NSMutableArray *userArray = [[NSMutableArray alloc]init];
    
    [userArray addObject:[PFUser currentUser].username];
    NSArray *userArrayCopy = [NSArray arrayWithArray:userArray];
    NSNumber *chainLength = @1;
    
    PFObject *object = [PFObject objectWithClassName:@"Game"];
    
    [object setObject:userArrayCopy forKey:@"usersInvolved"];
    [object setObject:imageArrayCopy forKey:@"imagesArray"];
    //[object setObject:[NSString stringWithFormat:@"writing"] forKey:@"whatsNext"];
    //[object setObject:data forKey:@"pathArray"];
    //[object setObject:colorData forKey:@"chosenColors"];
    //[object setObject:chosenWidth forKey:@"chosenWidth"];
   // [object setObject:[NSNumber numberWithInteger:timeInt] forKey:@"timeInterval"];
    [object setObject:chainLength forKey:@"chainLength"];
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(!error){
            //[self.activityIndicatorView stopAnimating];
            //self.activityIndicatorView.hidden = YES;
            //[self dismissViewControllerAnimated:YES completion:nil];
            [self backToMain];
        }
       
        
    }];
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


#pragma mark -- properties (lazy load)


- (ACEDrawingView *)drawingView {
    if (!_drawingView) {
        _drawingView = [ACEDrawingView new];
        _drawingView.delegate = self;
        
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
        _titleLabel.font = [UIFont fontWithName:@"BubblegumSans-Regular" size:35];
        _titleLabel.textColor = [UIColor aod_colorWithHexValue:0xFFFFFF alpha:1.0f];
        _titleLabel.text = @"Start Chain";
        _titleLabel.minimumScaleFactor = 0.4;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLabel;
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
-(UIScrollView *)colorScrollView{
    if(!_colorScrollView){
        _colorScrollView = [UIScrollView new];
        _colorScrollView.delegate = self;
        
        _colorScrollView.contentSize = CGSizeMake(5.0f + (numberOfColors *(colorWidth+5.0f) + 60), 1);
        
    }
    return _colorScrollView;
}
- (NSMutableArray *)arrayOfColorButtons {
    if (!_arrayOfColorButtons) {
        _arrayOfColorButtons = [NSMutableArray new];
        
    }
    return _arrayOfColorButtons;
}

@end
