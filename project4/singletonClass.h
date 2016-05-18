//
//  singletonClass.h
//  project4
//
//  Created by Wenzhi Zhao on 5/18/16.
//  Copyright © 2016 Wenzhi Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol myProtocol <NSObject>

-(void)myProtocolMethod;

@end
@interface singletonClass : NSObject
+(instancetype)sharedObject;
@property (assign) id <myProtocol> delegate;
@end
