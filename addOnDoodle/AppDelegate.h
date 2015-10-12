//
//  AppDelegate.h
//  addOnDoodle
//
//  Created by Dawson Walker on 2015-09-07.
//  Copyright (c) 2015 Rise Digital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSArray *gameArray;
@property (strong, nonatomic)NSString *friendsName;
@property (strong, nonatomic) NSMutableArray *friendsGameArray;
@property (strong, nonatomic) NSString *objectId;
@property (strong, nonatomic) NSMutableArray *imagesArray;
@property (strong, nonatomic) NSNumber* chainLength;
@end

