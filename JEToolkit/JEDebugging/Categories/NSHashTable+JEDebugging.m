//
//  NSHashTable+JEDebugging.m
//  JEToolkit
//
//  Created by John Rommel Estropia on 2013/11/26.
//  Copyright (c) 2013 John Rommel Estropia. All rights reserved.
//

#import "NSHashTable+JEDebugging.h"

#import "NSMutableString+JEDebugging.h"


@implementation NSHashTable (JEDebugging)

#pragma mark - NSObject

- (NSString *)debugDescription
{
    return [super debugDescription];
}


#pragma mark - NSObject+JEDebugging

- (NSString *)loggingDescription
{
    NSMutableString *description = [NSMutableString string];
    NSUInteger count = [self count];
    if (count == 1)
    {
        [description appendString:@"1 entry ("];
    }
    else
    {
        [description appendFormat:@"%lu entries (", (unsigned long)count];
        
        if (count <= 0)
        {
            [description appendString:@")"];
            return description;
        }
    }
    
    BOOL isFirstEntry = YES;
    for (id obj in self)
    {
        @autoreleasepool {
            
            if (isFirstEntry)
            {
                [description appendString:@"\n"];
                isFirstEntry = NO;
            }
            else
            {
                [description appendString:@",\n"];
            }
            
            [description appendString:[obj
                                       loggingDescriptionIncludeClass:YES
                                       includeAddress:NO]];
            
        }
        
    };
    
    [description indentByLevel:1];
    [description appendString:@"\n)"];
    
    return description;
}

@end
