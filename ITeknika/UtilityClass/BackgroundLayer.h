//
//  BackgroundLayer.h
//  ITeknika
//
//  Created by MIKE on 07/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface BackgroundLayer : NSObject

+(CAGradientLayer*) greyGradient;
+(CAGradientLayer*) blueGradient;
+ (CAGradientLayer*) blueOrangeGradient;

@end
