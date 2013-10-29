//
//  ViewController.m
//  Morphology
//
//  Created by Johnnie Walker on 29/10/2013.
//  Copyright (c) 2013 Random Sequence. All rights reserved.
//

#import "ViewController.h"
#import "ErodeOperation.h"
#import "DilateOperation.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSOperationQueue *queue;
- (IBAction)erode:(id)sender;
- (IBAction)reset:(id)sender;
- (IBAction)dilate:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if (nil == self.queue) self.queue = [NSOperationQueue new];
    
    [self resetGlyph];
}

- (void)resetGlyph {
    NSString *glyph = @"&";
    UIFont *font = [UIFont fontWithName:@"Palatino-Italic" size:288];
    NSDictionary *attributes = @{NSFontAttributeName: font,
                                 NSForegroundColorAttributeName: [UIColor darkTextColor]};
    CGSize size = [glyph sizeWithAttributes:attributes];
    size = CGSizeMake(ceil(size.width), ceil(size.height));
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    
    [[UIColor whiteColor] setFill];
    UIRectFill((CGRect){CGPointZero, size});
    
    [glyph drawAtPoint:CGPointZero withAttributes:attributes];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.imageView.contentMode = UIViewContentModeCenter;
    self.imageView.image = image;
}

- (IBAction)erode:(id)sender {
    if (self.queue.operationCount == 0) {
        ImageOperation *erode = [[ErodeOperation alloc] initWithImage:self.imageView.image];
        __weak ViewController *weakSelf = self;
        __weak ImageOperation *weakOp = erode;
        erode.completionBlock = ^{
            UIImage *outputImage = weakOp.outputImage;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                weakSelf.imageView.image = outputImage;
            }];
        };
        [self.queue addOperation:erode];
    }
}

- (IBAction)reset:(id)sender {
    if (self.queue.operationCount == 0) {
        [self resetGlyph];
    }
}

- (IBAction)dilate:(id)sender {
    if (self.queue.operationCount == 0) {
        ImageOperation *dilate = [[DilateOperation alloc] initWithImage:self.imageView.image];
        __weak ViewController *weakSelf = self;
        __weak ImageOperation *weakOp = dilate;
        dilate.completionBlock = ^{
            UIImage *outputImage = weakOp.outputImage;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                weakSelf.imageView.image = outputImage;
            }];
        };
        [self.queue addOperation:dilate];
    }
}
@end
