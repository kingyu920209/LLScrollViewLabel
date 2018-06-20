//
//  LLNormalCollectionViewCell.m
//  LLScrollLabelView
//
//  Created by 嘚嘚以嘚嘚 on 2018/6/19.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "LLNormalCollectionViewCell.h"
#import <UIImageView+WebCache.h>
@interface LLNormalCollectionViewCell ()
@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation LLNormalCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubView];
    }
    return self;
}
- (void)addSubView
{
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.iconImageView];
    [self.bgView addSubview:self.titleLabel];
}
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor clearColor];
    }
    return _bgView;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
    }
    return _iconImageView;
}
- (void)setTitleFont:(UIFont *)titleFont
{
    if (titleFont) {
        _titleFont = titleFont;
        _titleLabel.font = _titleFont;
    }
}
- (void)setTitleAilgnment:(NSTextAlignment)titleAilgnment
{
    if (titleAilgnment) {
        _titleAilgnment = titleAilgnment;
        _titleLabel.textAlignment = _titleAilgnment;
    }
}
- (void)setTitleColor:(UIColor *)titleColor
{
    if (titleColor) {
        _titleColor = titleColor;
        _titleLabel.textColor = _titleColor;
    }
}
- (void)setTitle:(NSString *)title
{
    if (title) {
        _title = title;
        _titleLabel.text = _title;
    }
}

- (void)setImagePath:(NSString *)imagePath
{
    if (imagePath) {
        _imagePath = imagePath;
        
        if ([imagePath isKindOfClass:[NSString class]]) {
            if ([imagePath hasPrefix:@"http"]) {
                [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_imagePath]];
            }else{
                UIImage * image = [UIImage imageNamed:imagePath];
                if (!image) {
                    image = [UIImage imageWithContentsOfFile:imagePath];
                }
                _iconImageView.image = image;
            }
        }else if ([imagePath isKindOfClass:[UIImage class]]){
            _iconImageView.image = (UIImage *)imagePath;
        }
        
    }
}
- (void)setHorizontalScroll:(BOOL)horizontalScroll
{
    _horizontalScroll = horizontalScroll;
}
-(void)layoutSubviews
{
    
    CGFloat iconImgW = self.iconImageView.image.size.width;
    CGFloat iconImgH = self.iconImageView.image.size.height;
    CGFloat iconImgX = 0;
    CGFloat iconImgY = 0;
    self.iconImageView.frame = CGRectMake(iconImgX, iconImgY, iconImgW, iconImgH);
    
    CGFloat labelX = 0;
    if (self.iconImageView.image == nil) {
        labelX = 0;
    }else{
        
        labelX = CGRectGetMaxX(self.iconImageView.frame);
    }
    CGFloat labelY = 0;
    CGFloat labelW = self.frame.size.width - labelX;
    CGFloat labelH = self.frame.size.height;
    
    self.bgView.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
    if (_horizontalScroll) {
        
        CGSize fitSize = [self.titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.titleLabel.font} context:nil].size;
        
        self.titleLabel.frame = CGRectMake(0, 0, fitSize.width, CGRectGetHeight(self.bgView.frame));
        
    }else{
        self.titleLabel.frame = CGRectMake(0, 0, labelW, CGRectGetHeight(self.bgView.frame));
    }
    
    CGPoint imgPoint = self.iconImageView.center;
    imgPoint.y = self.titleLabel.center.y;
    self.iconImageView.center = imgPoint;
    
}

@end
