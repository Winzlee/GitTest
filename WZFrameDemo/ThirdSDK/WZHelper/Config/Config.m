//
//  Config.m
//  Winzlee
//
//  Created by liwenzhi on 15/10/16.
//  Copyright (c) 2015年 lwz. All rights reserved.
//

#import "Config.h"

@implementation Config

@synthesize defaults;

@dynamic isLogin;
@dynamic isTracking;
@dynamic logo;
@dynamic macAddress;
@dynamic latitude;
@dynamic longitude;

-(id) init {
	
    if(!(self = [super init]))
        return self;
	
    self.defaults = [NSUserDefaults standardUserDefaults];
	
    [self.defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [NSNumber numberWithBool:NO],  dIsLogin,
                                     @"",           dLogo,
                                     @"",           dIsTracking,
                                     @"",           dMacAddress,
                                     @"",           dLatitude,
                                     @"",           dLongitude,
                                     nil]];
	return self;
}

-(void) dealloc
{
    self.isLogin = nil;
    self.isTracking = nil;
    self.logo = nil;
    self.macAddress = nil;
    self.latitude = nil;
    self.longitude = nil;
}

+(Config *) currentConfig {
    
    static Config *instance;
	
    if(!instance)
		
        instance = [[Config alloc] init];
    
    return instance;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
	
    if ([NSStringFromSelector(aSelector) hasPrefix:@"set"]){
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
	}
    //DLog(@"methodSignatureForSelector 2\n");
    return [NSMethodSignature signatureWithObjCTypes:"@@:"];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    NSString *selector = NSStringFromSelector(anInvocation.selector);
    if ([selector hasPrefix:@"set"]) {
        NSRange firstChar, rest;
        firstChar.location  = 3;
        firstChar.length    = 1;
        rest.location       = 4;
        rest.length         = selector.length - 5;
        
        selector = [NSString stringWithFormat:@"%@%@",
                    [[selector substringWithRange:firstChar] lowercaseString],
                    [selector substringWithRange:rest]];
        
        __unsafe_unretained id value;
        [anInvocation getArgument:&value atIndex:2];
		
		//DLog(@"forwardInvocation 1\n");
        
        if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]])
        {
            [self.defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:value] forKey:selector];
        }
        else
        {
            [self.defaults setObject:value forKey:selector];
        }
        
    }
    
    else {
		//DLog(@"forwardInvocation 2\n");
        id value = [self.defaults objectForKey:selector];
        
        if ([value isKindOfClass:[NSData class]])
        {
            void *cfValue = (__bridge void *)[NSKeyedUnarchiver unarchiveObjectWithData:value];
            [anInvocation setReturnValue:&cfValue];
        }
        else
        {
            [anInvocation setReturnValue:&value];
        }
        
    }
}



@end
