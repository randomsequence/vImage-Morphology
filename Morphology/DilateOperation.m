//
//  DilateOperation.m
//  Morphology
//
//  Created by Johnnie Walker on 29/10/2013.
//  Copyright (c) 2013 Random Sequence. All rights reserved.
//

#import "DilateOperation.h"

@implementation DilateOperation

- (void)processImage:(vImage_Buffer *)inputBuffer outputBuffer:(vImage_Buffer *)outputBuffer {
    vImageMax_ARGB8888(inputBuffer,
                       outputBuffer,
                       NULL,
                       0,
                       0,
                       3,
                       3,
                       kvImageLeaveAlphaUnchanged);
}

@end
