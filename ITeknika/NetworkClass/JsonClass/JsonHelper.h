//
//  JsonHelper.h
//  PartyApp
//
//  Created by SANDY on 05/02/14.
//
//

#import <Foundation/Foundation.h>
#import "SBJSON.h"


@interface JsonHelper : NSObject{
    
}
@property(nonatomic,strong)  SBJsonWriter *json_writer;
@property(nonatomic,strong)  SBJsonParser *json_parser;

+ (instancetype)sharedJSON;

@end
