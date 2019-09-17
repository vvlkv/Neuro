#import <UIKit/UIKit.h>

@class VVTableView, UIImageView;
@protocol VVLettersTableViewDataSource <NSObject>
@required
- (NSUInteger)numberOfItemsInTableView:(VVTableView*)tableView;
- (NSString *)tableView:(VVTableView *)tableView titleAtIndex:(NSUInteger)index;
- (UIImage *)tableView:(VVTableView *)tableView imageAtIndex:(NSUInteger)index;
- (void)tableView:(VVTableView *)tableView removeObjectAtIndex:(NSUInteger)index;

@end

@interface VVTableView : UIView

@property (strong, nonatomic) id <VVLettersTableViewDataSource> dataSource;

@end
