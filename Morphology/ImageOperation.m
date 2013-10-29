//
//  ImageOperation.m
//  Morphology
//
//  Created by Johnnie Walker on 29/10/2013.
//  Copyright (c) 2013 Random Sequence. All rights reserved.
//

#import "ImageOperation.h"

@interface ImageOperation ()
@property (nonatomic, strong) UIImage *outputImage;
@property (nonatomic, strong) UIImage *inputImage;
@end

@implementation ImageOperation
- (instancetype)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        _inputImage = image;
    }
    return self;
}

- (void)main {
    UIImage *image = self.inputImage;
    CGImageRef imageRef = image.CGImage;
    
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    CGContextRef inputContext = CGBitmapContextCreate(NULL,
                                                      width,
                                                      height,
                                                      8,
                                                      width*sizeof(ARGBPixel),
                                                      CGImageGetColorSpace(imageRef),
                                                      (CGBitmapInfo) kCGImageAlphaPremultipliedFirst);
    
    CGContextRef outputContext = CGBitmapContextCreate(NULL,
                                                      width,
                                                      height,
                                                      8,
                                                      width*sizeof(ARGBPixel),
                                                      CGImageGetColorSpace(imageRef),
                                                      (CGBitmapInfo) kCGImageAlphaPremultipliedFirst);
    
    CGFloat scale = image.scale;
    CGAffineTransform t = CGAffineTransformIdentity;
    t = CGAffineTransformScale(t, scale, scale);
    CGContextDrawImage(inputContext, (CGRect){CGPointZero, CGSizeApplyAffineTransform(image.size, t)}, imageRef);
    
    vImage_Buffer inputBuffer;
    inputBuffer.data = CGBitmapContextGetData(inputContext);
    inputBuffer.width = width;
    inputBuffer.height = height;
    inputBuffer.rowBytes = CGBitmapContextGetBytesPerRow(inputContext);
    
    vImage_Buffer outputBuffer = inputBuffer;
    outputBuffer.data = CGBitmapContextGetData(outputContext);
    
    [self processImage:&inputBuffer outputBuffer:&outputBuffer];
    
    CGImageRef outputRef = CGBitmapContextCreateImage(outputContext);
    self.outputImage = [UIImage imageWithCGImage:outputRef scale:image.scale orientation:image.imageOrientation];
    CGImageRelease(outputRef);
    CGContextRelease(inputContext);
    CGContextRelease(outputContext);
}

- (void)processImage:(vImage_Buffer *)inputBuffer outputBuffer:(vImage_Buffer *)outputBuffer {}
@end
