#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const notificationLetterChecked;

@class UIImage;
@interface VVStorage : NSObject

#pragma mark - Root
+ (instancetype)instance;

#pragma mark - Get
- (NSString *)letterAtIndex:(NSUInteger)index;
- (UIImage *)imageAtIndex:(NSUInteger)NSUInteger;

- (void)setLetter:(NSString *)letter
       withVector:(NSArray *)vector;
- (void)setImage:(UIImage *)img;

- (void)checkVector:(NSArray *)vector;

- (void)removeLetterAtIndex:(NSUInteger)index;
- (NSUInteger)count;

@end
