//
//  ErodeOperation.m
//  Morphology
//
//  Created by Johnnie Walker on 29/10/2013.
//  Copyright (c) 2013 Random Sequence. All rights reserved.
//

#import "ErodeOperation.h"

@implementation ErodeOperation

- (void)processImage:(vImage_Buffer *)inputBuffer outputBuffer:(vImage_Buffer *)outputBuffer {
    const unsigned char kernel[] = {1,1,1,1,1,1,1,1,1};
    vImageErode_ARGB8888(inputBuffer,
                         outputBuffer,
                         0,
                         0,
                         kernel,
                         3,
                         3,
                         kvImageLeaveAlphaUnchanged);
}

@end