//
//  main.m
//  ITeknika
//
//  Created by MIKE on 06/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    
    
    @autoreleasepool {
        int retval;
        @try{
            retval = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        }
        @catch (NSException *exception)
        {
            NSLog(@"Diwakar Stacktrace !!! %@", [exception callStackSymbols]);
            NSLog(@"\nShow Stack Trace thread%@",[NSThread callStackSymbols]);
            @throw;
        }
        return retval;
    }

    
//    @autoreleasepool {
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//    }
}
