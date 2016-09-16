//
//  WebServiceClass.h
//  ITeknika
//
//  Created by Diwakar Garg on 16/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^webCallCompletion)(BOOL response, NSDictionary *responseData, NSError *error);
typedef void(^login)(NSDictionary *response);

@interface WebServiceClass : NSObject

//Instantiate the class
+ (WebServiceClass *)webServiceInstance;

//Login Service Call method
-(void)loginServiceCall:(login)completion;


@end
