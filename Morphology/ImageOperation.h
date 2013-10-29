//
//  ImageOperation.h
//  Morphology
//
//  Created by Johnnie Walker on 29/10/2013.
//  Copyright (c) 2013 Random Sequence. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Accelerate;

typedef struct {
    u_int8_t opacity, red, green, blue;
} ARGBPixel;

@interface ImageOperation : NSOperation
@property (nonatomic, strong, readonly) UIImage *outputImage;
@property (nonatomic, strong, readonly) UIImage *inputImage;
- (instancetype)initWithImage:(UIImage *)image;
- (void)processImage:(vImage_Buffer *)inputBuffer outputBuffer:(vImage_Buffer *)outputBuffer;
@end
