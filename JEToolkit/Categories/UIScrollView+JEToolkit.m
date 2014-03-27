//
//  UIScrollView+JEToolkit.m
//  JEToolkit
//
//  Created by DIT John Estropia on 2014/03/26.
//  Copyright (c) 2014年 John Rommel Estropia. All rights reserved.
//

#import "UIScrollView+JEToolkit.h"
#import "UIView+JEToolkit.m"

#import "JEAssociatedObject.h"


@interface UIScrollView (_JEToolkit)

@property (nonatomic, strong) id je_keyboardUpObserver;
@property (nonatomic, strong) id je_keyboardDownObserver;

@end


@implementation UIScrollView (JEToolkit)

#pragma mark - Private

JESynthesize(strong, id, je_keyboardUpObserver, setJe_keyboardUpObserver);
JESynthesize(strong, id, je_keyboardDownObserver, setJe_keyboardDownObserver);


#pragma mark - Public

- (void)addKeyboardObserver
{
	CGFloat originalContentInsetBottom = self.contentInset.bottom;
	CGFloat originalScrollInsetBottom = self.scrollIndicatorInsets.bottom;
	
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	typeof(self) __weak weakSelf = self;
	self.je_keyboardUpObserver =
    [center
     addObserverForName:UIKeyboardWillShowNotification
     object:nil
     queue:nil
     usingBlock:^(NSNotification *note) {
         
         typeof(self) strongSelf = weakSelf;
         if (!strongSelf)
         {
             return;
         }
         
         NSDictionary *userInfo = [note userInfo];
         CGRect keyboardFrameInScrollView = [strongSelf convertRect:[(NSValue *)userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue] fromView:nil];
         CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
         UIViewAnimationOptions animationCurve = kNilOptions;
         switch ([userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue])
         {
             case UIViewAnimationCurveEaseInOut:
                 animationCurve = UIViewAnimationOptionCurveEaseInOut;
                 break;
             case UIViewAnimationCurveEaseIn:
                 animationCurve = UIViewAnimationOptionCurveEaseIn;
                 break;
             case UIViewAnimationCurveEaseOut:
                 animationCurve = UIViewAnimationOptionCurveEaseOut;
                 break;
             case UIViewAnimationCurveLinear:
                 animationCurve = UIViewAnimationOptionCurveLinear;
                 break;
         }
         
         CGFloat coveredHeight = (CGRectGetMaxY(strongSelf.bounds)
                                  - CGRectGetMinY(keyboardFrameInScrollView));
         
         UIEdgeInsets contentInsets = strongSelf.contentInset;
         contentInsets.bottom = (coveredHeight
                                 + originalContentInsetBottom);
         
         UIEdgeInsets scrollInsets = strongSelf.scrollIndicatorInsets;
         scrollInsets.bottom = (coveredHeight
                                + originalScrollInsetBottom);
         
         UIView *firstResponder = [strongSelf findFirstResponder];
         CGRect textViewFrameInScrollView = [strongSelf
                                             convertRect:firstResponder.bounds
                                             fromView:firstResponder];
         
         [UIView
          animateWithDuration:duration
          delay:0.0f
          options:(UIViewAnimationOptionBeginFromCurrentState | animationCurve)
          animations:^{
              
              strongSelf.contentInset = contentInsets;
              strongSelf.scrollIndicatorInsets = scrollInsets;
              if (firstResponder)
              {
                  [strongSelf scrollRectToVisible:textViewFrameInScrollView animated:NO];
              }
              
          }
          completion:NULL];
         
     }];
    
	self.je_keyboardDownObserver =
    [center
     addObserverForName:UIKeyboardWillHideNotification
     object:nil
     queue:nil
     usingBlock:^(NSNotification *note) {
         
         typeof(self) strongSelf = weakSelf;
         if (!strongSelf)
         {
             return;
         }
         
         NSDictionary *userInfo = [note userInfo];
         CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
         UIViewAnimationOptions animationCurve = kNilOptions;
         switch ([userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue])
         {
             case UIViewAnimationCurveEaseInOut:
                 animationCurve = UIViewAnimationOptionCurveEaseInOut;
                 break;
             case UIViewAnimationCurveEaseIn:
                 animationCurve = UIViewAnimationOptionCurveEaseIn;
                 break;
             case UIViewAnimationCurveEaseOut:
                 animationCurve = UIViewAnimationOptionCurveEaseOut;
                 break;
             case UIViewAnimationCurveLinear:
                 animationCurve = UIViewAnimationOptionCurveLinear;
                 break;
         }
         
         UIEdgeInsets contentInsets = strongSelf.contentInset;
         contentInsets.bottom = originalContentInsetBottom;
         
         UIEdgeInsets scrollInsets = strongSelf.scrollIndicatorInsets;
         scrollInsets.bottom = originalScrollInsetBottom;
         
         [UIView
          animateWithDuration:duration
          delay:0.0f
          options:(UIViewAnimationOptionBeginFromCurrentState | animationCurve)
          animations:^{
              
              strongSelf.contentInset = contentInsets;
              strongSelf.scrollIndicatorInsets = scrollInsets;
              
          }
          completion:NULL];
         
     }];
}

- (void)removeKeyboardObserver
{
	id keyboardUpObserver = self.je_keyboardUpObserver;
	id keyboardDownObserver = self.je_keyboardDownObserver;
	
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    if (keyboardUpObserver)
    {
        [center
         removeObserver:keyboardUpObserver
         name:UIKeyboardWillShowNotification
         object:nil];
        self.je_keyboardUpObserver = nil;
    }
    if (keyboardDownObserver)
    {
        [center
         removeObserver:keyboardDownObserver
         name:UIKeyboardWillHideNotification
         object:nil];
        self.je_keyboardDownObserver = nil;
    }
}

@end
