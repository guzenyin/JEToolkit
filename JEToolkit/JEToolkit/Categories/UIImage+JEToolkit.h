//
//  UIImage+JEToolkit.h
//  JEToolkit
//
//  Copyright (c) 2013 John Rommel Estropia
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import <UIKit/UIKit.h>

#import "JECompilerDefines.h"


@interface UIImage (JEToolkit)

/*! Convenience method for loading an image from file while providing a custom scale and orientation
 @param filePath The file path of an image
 @param scale The scale of the image
 @param orientation The orientation of the image
 @return A UIImage from file, or nil if loading failed
 */
+ (instancetype)imageFromFile:(NSString *)filePath
                        scale:(CGFloat)scale
                  orientation:(UIImageOrientation)orientation;

/*! Takes a screenshot
 */
+ (UIImage *)screenshot;

/*! Creates a UIImage filled with the specified color
 @param color The color to fill the image
 @param size The size of the image
 @return A UIImage filled with the specified color and size
 */
+ (UIImage *)imageFromColor:(UIColor *)color
                       size:(CGSize)size JE_NONNULL(1);

/*! Creates a decoded UIImage from the receiver. This is usually used to preload an image to prevent slight lags in the UI
 */
- (instancetype)decodedImage;

@end
