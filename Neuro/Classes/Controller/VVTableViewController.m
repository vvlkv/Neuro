#import "VVTableViewController.h"
#import "VVTableView.h"
#import "VVStorage.h"

@interface VVTableViewController () <UINavigationBarDelegate, UIBarPositioningDelegate, VVLettersTableViewDataSource> {
    VVTableView *tableView;
}

@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

- (IBAction)backButton:(id)sender;

@end

@implementation VVTableViewController 


#pragma mark - Init

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.delegate = self;
    tableView = [[NSBundle mainBundle] loadNibNamed:@"VVTableView" owner:self options:nil][0];
    CGRect tableFrame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+64, self.view.frame.size.width, self.view.frame.size.height - 64);
    tableView.frame = tableFrame;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}


#pragma mark - UIBarPositioningDelegate

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}


#pragma mark - VVLettersTableViewDataSource

- (NSUInteger)numberOfItemsInTableView:(VVTableView*)tableView {
    return [[VVStorage instance] count];
}
- (NSString *)tableView:(VVTableView *)tableView titleAtIndex:(NSUInteger)index {
    return [[VVStorage instance] letterAtIndex:index];
}

- (UIImage *)tableView:(VVTableView *)tableView imageAtIndex:(NSUInteger)index {
    return [[VVStorage instance] imageAtIndex:index];
}

- (void)tableView:(VVTableView *)tableView removeObjectAtIndex:(NSUInteger)index {
    [[VVStorage instance] removeLetterAtIndex:index];
}


#pragma mark - Actions

- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
