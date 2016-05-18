//
//  singletonClass.m
//  project4
//
//  Created by Wenzhi Zhao on 5/18/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import "singletonClass.h"

@implementation singletonClass

+(singletonClass*)sharedObject{
    static singletonClass *sharedObject = nil;
    if (!sharedObject) {
        sharedObject = [[singletonClass alloc]init];
    }
    return sharedObject;
}
+(singletonClass*)sharedObject2{
    static singletonClass *sharedObject = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        sharedObject = [[singletonClass alloc]init];
    });
    return sharedObject;
}

@end
