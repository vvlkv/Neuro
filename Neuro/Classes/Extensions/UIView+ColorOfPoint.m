#import "UIView+ColorOfPoint.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (ColorOfPoint)

+ (NSArray*)getRGBAsFromImage:(UIImage*)image atX:(int)x andY:(int)y count:(int)count {
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];
    CGImageRef imageRef = [image CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    NSUInteger byteIndex = (bytesPerRow * y) + x * bytesPerPixel;
    for (int i = 0 ; i < count ; ++i)
    {
        CGFloat alpha = ((CGFloat) rawData[byteIndex + 3] ) / 255.0f;
        CGFloat red   = ((CGFloat) rawData[byteIndex]     ) / alpha;
        CGFloat green = ((CGFloat) rawData[byteIndex + 1] ) / alpha;
        CGFloat blue  = ((CGFloat) rawData[byteIndex + 2] ) / alpha;
        byteIndex += bytesPerPixel;
        
        UIColor *acolor = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
        if ([acolor isEqual:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]]) {
            [result addObject:[NSNumber numberWithInt:-1]];
        } else {
            [result addObject:[NSNumber numberWithInt:1]];
        }
    }
    free(rawData);
    
    return result;
}

+ (UIImage *)imageForView:(UIView *)view andFrame:(CGRect) rect {
    UIGraphicsBeginImageContext(view.frame.size);
    [view.layer renderInContext: UIGraphicsGetCurrentContext()];
    UIImage *retval = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRef imageRef = CGImageCreateWithImageInRect(retval.CGImage, rect);
    UIImage *retImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    UIGraphicsEndImageContext();
    return retImage;
}

+ (NSArray *)vectorRepresentationFromImage:(UIImage *)img
                                   withSize:(CGSize)size {
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    newImage = [self newImage:img withSize:size];
    NSArray *pixelsArray = [[NSArray alloc] init];
    pixelsArray = [UIView getRGBAsFromImage:newImage atX:0 andY:0 count:(int)size.height * size.width];
    return pixelsArray;
}

+ (UIImage *)newImage:(UIImage *)img withSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
