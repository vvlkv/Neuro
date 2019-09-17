#import "VVTableView.h"
#import "VVTableViewCell.h"

@interface VVTableView()<UITableViewDataSource> {
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation VVTableView


#pragma mark - Init

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    self.tableView.dataSource = self;
}


#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfItemsInTableView:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    VVTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = (VVTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"VVTableViewCell"
                                                                    owner:self
                                                                  options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.title = [self.dataSource tableView:self titleAtIndex:indexPath.row];
    cell.figure = [self.dataSource tableView:self imageAtIndex:indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataSource tableView:self removeObjectAtIndex:indexPath.row];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
