//
//  AODHexColors.m
//  addOnDoodle
//
//  Created by Dawson Walker on 2015-09-07.
//  Copyright (c) 2015 Rise Digital. All rights reserved.
//

#import "AODHexColors.h"

@implementation UIColor (AODHexColors)
+ (UIColor *)aod_colorWithHexValue:(uint32_t )hexValue {
    
    return [UIColor aod_colorWithHexValue:hexValue alpha:1.0f];
}

+ (UIColor *)aod_colorWithHexValue:(uint32_t)hexValue alpha:(float)alpha {
    // default values
    uint32_t r = 0xff;
    uint32_t g = 0xff;
    uint32_t b = 0xff;
    
    r = (hexValue & 0xff0000) >> 8*2;
    g = (hexValue & 0x00ff00) >> 8*1;
    b = (hexValue & 0x0000ff);
    
    UIColor *newColor = [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:alpha];
    
    return newColor;
}
@end
