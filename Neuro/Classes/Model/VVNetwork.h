#import <Foundation/Foundation.h>

@interface VVNetwork : NSObject

- (void)addFigure:(NSArray *)array;
- (void)removeRowAtIndex:(NSUInteger)number;
- (NSInteger)startRecognition:(NSArray *)array;

@end
