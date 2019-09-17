#import "VVStorage.h"
#import "VVDrawView.h"
#import "UIView+ColorOfPoint.h"
#import <math.h>

@interface VVDrawView() {
    CGPoint lastPoint;
    UIBezierPath *path;
    CGFloat leftPoint, rightPoint, upperPoint, lowerPoint;
    CGPoint leftUpperPoint, rightLowerPoint;
    NSMutableArray *arrayOfPoints;
    CGRect rect;
}

@end

@implementation VVDrawView

- (void)awakeFromNib {
    [super awakeFromNib];
    CALayer *layer = self.layer;
    arrayOfPoints = [[NSMutableArray alloc] init];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:4.0];
    [layer setBorderWidth:1.0];
    [layer setBorderColor:[[UIColor colorWithWhite:0.8 alpha:1.0] CGColor]];
    [[UITableViewHeaderFooterView appearance] setHidden:YES];
    [self setMultipleTouchEnabled:NO];
    [self setBackgroundColor:[UIColor whiteColor]];
    leftPoint = rightPoint = upperPoint = lowerPoint = 1000;
    leftUpperPoint = CGPointMake(1000, 1000);
    rightLowerPoint = CGPointMake(0, 0);
    path = [UIBezierPath bezierPath];
    rect = CGRectMake(1000, 1000, self.frame.size.width, self.frame.size.height);
    [path setLineWidth:10.0f];
}

- (void) drawRect:(CGRect)rect {
    [path stroke];
}


#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [path moveToPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [path addLineToPoint:point];
    leftUpperPoint.x = MIN(leftUpperPoint.x, point.x);
    leftUpperPoint.y = MIN(leftUpperPoint.y, point.y);
    rightLowerPoint.x = MAX(rightLowerPoint.x, point.x);
    rightLowerPoint.y = MAX(rightLowerPoint.y, point.y);
    rect = CGRectMake(leftUpperPoint.x, leftUpperPoint.y, rightLowerPoint.x - leftUpperPoint.x, rightLowerPoint.y - leftUpperPoint.y);
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesMoved:touches withEvent:event];
}


#pragma mark - User methods

- (void)clear {
    leftUpperPoint = CGPointMake(1000, 1000);
    rect = CGRectMake(1000, 1000, self.frame.size.width, self.frame.size.height);
    rightLowerPoint = CGPointZero;
    path = nil;
    path = [UIBezierPath bezierPath];
    [path setLineWidth:10.0f];
    [self setNeedsDisplay];
}

- (void)check {
    UIImage *img = [VVDrawView imageForView:self andFrame:rect];
    [[VVStorage instance] checkVector:[UIView vectorRepresentationFromImage:img withSize:CGSizeMake(50, 50)]];
}

- (void)addLetter:(NSString *)letter {
    UIImage *img = [VVDrawView imageForView:self andFrame:rect];
    [[VVStorage instance] setLetter:letter
                         withVector:[UIView vectorRepresentationFromImage:img withSize:CGSizeMake(50, 50)]];
    [[VVStorage instance] setImage:[UIView newImage:img withSize:CGSizeMake(50, 50)]];
}

@end
