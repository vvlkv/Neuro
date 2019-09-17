#import "VVTableViewCell.h"

@interface VVTableViewCell() {
    
}

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation VVTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


#pragma mark - Setters

- (void)setTitle:(NSString *)title {
    _title = title;
    self.textLabel.text = _title;
}

- (void)setFigure:(UIImage *)figure {
    self.imageView.frame = CGRectMake(300, 0, 20, 20);
    self.image.frame = CGRectMake(0, 0, 10, 10);
    self.imageView.image = figure;
}

@end
