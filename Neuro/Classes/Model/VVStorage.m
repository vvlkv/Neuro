#import "VVStorage.h"
#import "VVNetwork.h"
#import "VVStorage+Alerts.h"

@interface VVStorage() {
    VVNetwork *net;
    NSMutableArray *letters;
    NSMutableArray *images;
}

@end

@implementation VVStorage

#pragma mark - Root

+ (instancetype)instance {
    static VVStorage *storage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        storage = [[[self class] alloc] initPrivate];
    });
    return storage;
}

- (instancetype)init {
    NSLog(@"Use init");
    return nil;
}

- (instancetype)initPrivate {
    net = [[VVNetwork alloc] init];
    letters = [[NSMutableArray alloc] init];
    images = [[NSMutableArray alloc] init];
    return [super init];
}

#pragma mark - Get

- (NSString *)letterAtIndex:(NSUInteger)index {
    return letters[index];
}

- (UIImage *)imageAtIndex:(NSUInteger)index {
    return images[index];
}

- (void)setLetter:(NSString *)letter
       withVector:(NSArray *)vector {
    [letters addObject:letter];
    [net addFigure:vector];
}
- (void)setImage:(UIImage *)img {
    [images addObject:img];
}

- (void)checkVector:(NSArray *)vector {
    NSInteger index = -1;
    if (letters.count > 0) {
        index = [net startRecognition:vector];
    }
    
    NSString *message;
    if (index >= 0) {
        message = [NSString stringWithFormat:@"Your letter is %@", letters[index]];
    } else {
        message = @"Can't recognize letter :(";
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationLetterChecked
                                                        object:message];
}
- (void)removeLetterAtIndex:(NSUInteger)index {
    [letters removeObjectAtIndex:index];
    [images removeObjectAtIndex:index];
    [net removeRowAtIndex:index];
}

- (NSUInteger)count {
    return [letters count];
}

@end
