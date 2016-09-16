//
//  JsonHelper.m
//  PartyApp
//
//  Created by SANDY on 05/02/14.
//
//

#import "JsonHelper.h"

@implementation JsonHelper

@synthesize json_writer,json_parser;

+ (id)sharedJSON{
    static JsonHelper *_sharedJSON = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedJSON = [[JsonHelper alloc] init];
        _sharedJSON.json_writer=[[SBJsonWriter alloc] init];
        _sharedJSON.json_parser=[[SBJsonParser alloc] init];
    });
    return _sharedJSON;
}

@end
