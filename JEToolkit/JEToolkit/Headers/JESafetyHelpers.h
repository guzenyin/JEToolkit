//
//  JESafetyHelpers.h
//  JEToolkit
//
//  Created by John Rommel Estropia on 2013/10/14.
//  Copyright (c) 2013 John Rommel Estropia. All rights reserved.
//

#ifndef JEToolkit_JESafetyHelpers_h
#define JEToolkit_JESafetyHelpers_h

#import "JECompilerDefines.h"
#import "JEDebugging.h"


#pragma mark - Key-Value Coding

#if DEBUG

#define JEKeypath(type, property) \
    ({ \
        type _##property##_dummy; \
        _##property##_dummy.property, @#property; \
    })

#else

#define JEKeypath(class, property) \
    ( @#property )

#endif



#pragma mark - Localizable Strings

JE_STATIC_INLINE JE_NONNULL_ALL JE_OVERLOAD
NSString *JEL8N(NSString *keyString)
{
	NSString *localizedString = NSLocalizedString(keyString, nil);
    JEAssert(keyString != localizedString,
              @"\"%@\" not found in Localizable.strings",
              keyString);
    return localizedString;
}

JE_STATIC_INLINE JE_NONNULL_ALL JE_OVERLOAD
NSString *JEL8N(NSString *keyString, NSString *stringsFile)
{
	NSString *localizedString = NSLocalizedStringFromTable(keyString, stringsFile, nil);
    JEAssert(keyString != localizedString,
              @"\"%@\" not found in %@.strings",
              keyString,
              stringsFile);
    return localizedString;
}



#pragma mark - Convenience

#define JEEnumBitmasked(enumVar, enumBit) ( (enumVar & enumBit) == enumBit )



#pragma mark - ARC

#define JEScopeWeak(object) \
    typeof(object) __weak __je_scopeweak_##object = object

#define JEScopeStrong(object) \
    JE_PRAGMA_PUSH \
    JE_PRAGMA_IGNORE("-Wshadow") \
    typeof(object) __strong object = __je_scopeweak_##object \
    JE_PRAGMA_POP



#pragma mark - Blocks

#define JEBlock(returnType, identifier, arguments, block...) \
    returnType (^identifier)arguments = ({ \
        typeof(identifier) __weak __block __je_block_weak_##identifier; \
        typeof(identifier) __je_block_strong_##identifier; \
        __je_block_weak_##identifier = __je_block_strong_##identifier = [^returnType(arguments){ \
            JE_PRAGMA_PUSH \
            JE_PRAGMA_IGNORE("-Wunused-variable") \
            returnType (^identifier)arguments = __je_block_weak_##identifier; \
            JE_PRAGMA_POP \
            { block } \
        } copy]; \
        __je_block_strong_##identifier; \
    })




#endif