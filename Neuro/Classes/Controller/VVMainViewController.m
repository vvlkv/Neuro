#import "VVMainViewController.h"
#import "VVPopUpViewController.h"
#import "VVTableViewController.h"
#import "VVDrawView.h"
#import "VVStorage+Alerts.h"

@interface VVMainViewController () {
    VVDrawView *drawView;
    VVPopUpViewController *popUp;
}

@property (weak, nonatomic) IBOutlet UIView *hideView;


- (IBAction)clear:(id)sender;
- (IBAction)add:(id)sender;
- (IBAction)check:(id)sender;
- (IBAction)showLetters:(id)sender;

@end

@implementation VVMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.hideView setHidden:YES];
    drawView = [[NSBundle mainBundle] loadNibNamed:@"VVDrawView" owner:self options:nil][0];
    drawView.frame = self.hideView.frame;
    [self.view addSubview:drawView];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showAlertWithMessage:)
                                                 name:notificationLetterChecked
                                               object:nil];
}


#pragma mark - Actions

- (IBAction)clear:(id)sender {
    [drawView clear];
}

- (IBAction)add:(id)sender {
    popUp = [[VVPopUpViewController alloc] init];
    [self presentViewController:popUp animated:YES completion:nil];
}

- (IBAction)check:(id)sender {
    [drawView check];
}

- (IBAction)showLetters:(id)sender {
    VVTableViewController *tableController = [[VVTableViewController alloc] init];
    [self presentViewController:tableController animated:YES completion:nil];
}


#pragma mark - Alert

- (void)showAlertWithMessage:(NSNotification *)notification {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Result"
                                 message:notification.object
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [drawView clear];
                                }];
    
    [alert addAction:yesButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
