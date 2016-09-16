//
//  WebServiceClass.m
//  ITeknika
//
//  Created by Diwakar Garg on 16/09/16.
//  Copyright © 2016 iTeknika. All rights reserved.
//

#import "WebServiceClass.h"
#import "JsonHelper.h"

@implementation WebServiceClass

dispatch_queue_t backgroundQueue;

//Instantiate the class
+ (WebServiceClass *)webServiceInstance
{
    
    static dispatch_once_t once;
    static id webServiceInstance;
    dispatch_once(&once, ^{
        webServiceInstance = [[self alloc] init]; 
        
    });
    return webServiceInstance;
}

//AsynchronousRequest for the web services.
-(void)callForURL:(NSString *)url withData:(NSDictionary *)parameters getOrPost:(NSString *)type ForComplettionHandler:(webCallCompletion)completion{
    
    dispatch_async(backgroundQueue, ^{
        NSDictionary *questionDict =parameters;
        
        NSString *jsonRequest = [questionDict JSONRepresentation];
        
        NSURL *requestURl = [NSURL URLWithString:url];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURl
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        
        
        NSData *requestData = [jsonRequest dataUsingEncoding:NSUTF8StringEncoding];
        
        [request setHTTPMethod:type];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        [request setValue:@"0.0" forHTTPHeaderField:@"latitude"];
//        [request setValue:@"0.0" forHTTPHeaderField:@"longitude"];
//        [request setValue:[MikeData DBApiInstance].city forHTTPHeaderField:@"city"];
//        [request setValue:[MikeData DBApiInstance].loginID forHTTPHeaderField:@"user_login"];
//        [request setValue:@"36dd0a17-e19c-4811-bac1-37f865d13e7d" forHTTPHeaderField:@"sessionToken"];
//        [request setValue:@"aaaa-aaaa-aaaa-aaaa" forHTTPHeaderField:@"AccessToken"];
//        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//        [request setValue:ola_X_APP_TOKEN forHTTPHeaderField:@"X-APP-TOKEN"];
//        //Taxi Api handling
//        if ([[NSUserDefaults standardUserDefaults] valueForKey:authKey])
//        {
//            [request setValue:[[NSUserDefaults standardUserDefaults] valueForKey:authKey] forHTTPHeaderField:@"Authorization"];
//        }
        
        [request setHTTPBody: requestData];
        
        [request setTimeoutInterval:60.0];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            
            if (connectionError) {
                completion(NO,Nil,connectionError);
            }
            else{
                
                NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                NSDictionary *jsonDict = [jsonString JSONValue];
                completion(YES,jsonDict,Nil);
            }
            
        }];
    });
}

//Login Service Call method
-(void)loginServiceCall:(login)completion
{
    NSMutableDictionary *parameters=[[NSMutableDictionary alloc] init];
    
    [parameters setValue:@"Value" forKey:@"message"];
    [parameters setValue:@"Value" forKey:@"message_id"];
    [parameters setValue:@"Value" forKey:@"keywords_found"];
    
    
    NSString *url=[NSString stringWithFormat:@"https://devapi.olacabs.com/v1/bookings/create"];
    
    [self callForURL:url withData:parameters getOrPost:@"POST" ForComplettionHandler:^(BOOL response, NSDictionary *responseData, NSError *error) {
        
        if (responseData) {
            completion(responseData);
        }
        else{
            completion(nil);
        }

    }];

}


@end
