#import <UIKit/UIKit.h>

@interface UIView (ColorOfPoint)

+ (UIImage *)imageForView:(UIView *)view andFrame:(CGRect) rect;
+ (NSArray *)vectorRepresentationFromImage:(UIImage *)img
                                   withSize:(CGSize)size;
+ (UIImage *)newImage:(UIImage *)img withSize:(CGSize)size;

@end
