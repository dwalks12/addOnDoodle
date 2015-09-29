//
//  AODHexColors.h
//  addOnDoodle
//
//  Created by Dawson Walker on 2015-09-07.
//  Copyright (c) 2015 Rise Digital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (AODHexColors)
+ (UIColor *)aod_colorWithHexValue:(uint32_t )hexValue;
+ (UIColor *)aod_colorWithHexValue:(uint32_t)hexValue alpha:(float)alpha;
@end
