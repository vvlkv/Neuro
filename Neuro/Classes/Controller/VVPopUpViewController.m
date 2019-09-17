#import "VVPopUpViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "VVDrawView.h"

@interface VVPopUpViewController () <UITextFieldDelegate> {
    VVDrawView *drawView;
}

@property (weak, nonatomic) IBOutlet UIView *hideView;
@property (weak, nonatomic) IBOutlet UITextField *letterLabel;

- (IBAction)closePopup:(id)sender;

@end

@implementation VVPopUpViewController


#pragma mark - Init

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.hideView setHidden:YES];
    drawView = [[NSBundle mainBundle] loadNibNamed:@"VVDrawView" owner:self options:nil][0];
    drawView.frame = self.hideView.frame;
    [self.letterLabel setDelegate:self];
    [self.view addSubview:drawView];
    [super viewDidLoad];
}


#pragma mark - Actions

- (IBAction)closePopup:(id)sender {
    if ([self.letterLabel.text isEqualToString:@""]) {
        [self showAlert:@"Set Letter"];
    } else {
        NSLog(@"%@", self.letterLabel.text);
        [drawView addLetter:self.letterLabel.text];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Alerts

- (void)showAlert:(NSString *)message {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Error"
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                }];
    
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
