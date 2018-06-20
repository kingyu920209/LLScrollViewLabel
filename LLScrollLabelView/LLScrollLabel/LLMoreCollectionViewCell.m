//
//  LLMoreCollectionViewCell.m
//  LLScrollLabelView
//
//  Created by 嘚嘚以嘚嘚 on 2018/6/19.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "LLMoreCollectionViewCell.h"
#import <UIImageView+WebCache.h>
@interface LLMoreCollectionViewCell ()
@property (nonatomic, strong) UIImageView *topImg;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UIImageView *bottomImg;
@property (nonatomic, strong) UILabel *bottomLabel;
@end

@implementation LLMoreCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self addSubView];
    }
    return self;
}
- (void)addSubView
{
    [self.contentView addSubview:self.topImg];
    [self.contentView addSubview:self.topLabel];
    [self.contentView addSubview:self.bottomImg];
    [self.contentView addSubview:self.bottomLabel];
}
- (UIImageView *)topImg
{
    if (!_topImg) {
        _topImg = [[UIImageView alloc] init];
    }
    return _topImg;
}
- (UIImageView *)bottomImg
{
    if (!_bottomImg) {
        _bottomImg = [[UIImageView alloc] init];
    }
    return _bottomImg;
}
- (UILabel *)topLabel
{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.font = [UIFont systemFontOfSize:13];
        _topLabel.textColor = [UIColor blackColor];
        _topLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _topLabel;
}
- (UILabel *)bottomLabel
{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.font = [UIFont systemFontOfSize:13];
        _bottomLabel.textColor = [UIColor blackColor];
        _bottomLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _bottomLabel;
}
- (void)setTopTitle:(NSString *)topTitle
{
    if (topTitle) {
        _topTitle = topTitle;
        _topLabel.text = topTitle;
    }
}
- (void)setTopImgPath:(NSString *)topImgPath
{
    if (topImgPath) {
        _topImgPath = topImgPath;
        if ([topImgPath isKindOfClass:[NSString class]]) {
            if ([topImgPath hasPrefix:@"http"]) {
                [_topImg sd_setImageWithURL:[NSURL URLWithString:topImgPath]];
            }else{
                UIImage * image = [UIImage imageNamed:topImgPath];
                if (!image) {
                    image = [UIImage imageWithContentsOfFile:topImgPath];
                }
                _topImg.image = image;
            }
        }else if ([topImgPath isKindOfClass:[UIImage class]]){
            _topImg.image = (UIImage *)topImgPath;
        }
    }
}
- (void)setBottomTitle:(NSString *)bottomTitle
{
    if (bottomTitle) {
        _bottomTitle = bottomTitle;
        _bottomLabel.text = bottomTitle;
    }
}
- (void)setBottomImgPath:(NSString *)bottomImgPath
{
    if (bottomImgPath) {
        _bottomImgPath = bottomImgPath;
        if ([bottomImgPath isKindOfClass:[NSString class]]) {
            if ([bottomImgPath hasPrefix:@"http"]) {
                [_bottomImg sd_setImageWithURL:[NSURL URLWithString:bottomImgPath]];
            }else{
                UIImage * image = [UIImage imageNamed:bottomImgPath];
                if (!image) {
                    image = [UIImage imageWithContentsOfFile:bottomImgPath];
                }
                _bottomImg.image = image;
            }
        }else if ([bottomImgPath isKindOfClass:[UIImage class]]){
            _bottomImg.image = (UIImage *)bottomImgPath;
        }

    }
}
- (void)setTitleColor:(UIColor *)titleColor
{
    if (titleColor) {
        _titleColor = titleColor;
        self.topLabel.textColor = titleColor;
        self.bottomLabel.textColor = titleColor;
    }
}
- (void)setTitleFont:(UIFont *)titleFont
{
    if (titleFont) {
        _titleFont = titleFont;
        self.topLabel.font = titleFont;
        self.bottomLabel.font = titleFont;
    }
}
- (void)setTitleAilgnment:(NSTextAlignment)titleAilgnment
{
    if (titleAilgnment) {
        _titleAilgnment = titleAilgnment;
        self.topLabel.textAlignment = titleAilgnment;
        self.bottomLabel.textAlignment = titleAilgnment;
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat topImgViewW = self.topImg.image.size.width;
    CGFloat topImgViewH = self.topImg.image.size.height;
    CGFloat topImgViewX = 0;
    CGFloat topImgViewY = 5;
    self.topImg.frame = CGRectMake(topImgViewX, topImgViewY, topImgViewW, topImgViewH);
    
    CGFloat topLabelX = 0;
    if (self.topImg.image == nil) {
        topLabelX = 0;
    }else{
        topLabelX = CGRectGetMaxX(self.topImg.frame) + 5;
    }
    CGFloat topLabelY = topImgViewY;
    CGFloat topLabelW = self.frame.size.width - topLabelX;
    CGFloat topLabelH = 0.5 * (self.frame.size.height - 2 * topLabelY);
    self.topLabel.frame = CGRectMake(topLabelX, topLabelY, topLabelW, topLabelH);
    
    CGPoint topPoint = self.topImg.center;
    topPoint.y = _topLabel.center.y;
    self.topImg.center = topPoint;

    
    CGFloat bottomSignImageViewW = self.bottomImg.image.size.width;
    CGFloat bottomSignImageViewH = self.bottomImg.image.size.height;
    CGFloat bottomSignImageViewX = 0;
    CGFloat bottomSignImageViewY = CGRectGetMaxY(self.topLabel.frame);
    self.bottomImg.frame = CGRectMake(bottomSignImageViewX, bottomSignImageViewY, bottomSignImageViewW, bottomSignImageViewH);
    
    CGFloat bottomLabelX = 0;
    if (self.bottomImg.image == nil) {
        bottomLabelX = 0;
    } else {
        bottomLabelX = CGRectGetMaxX(self.bottomImg.frame) + 5;
    }
    CGFloat bottomLabelY = CGRectGetMaxY(self.topLabel.frame);
    CGFloat bottomLabelW = self.frame.size.width - bottomLabelX;
    CGFloat bottomLabelH = topLabelH;
    self.bottomLabel.frame = CGRectMake(bottomLabelX, bottomLabelY, bottomLabelW, bottomLabelH);
    
    CGPoint bottomPoint = self.bottomImg.center;
    bottomPoint.y = _bottomLabel.center.y;
    self.bottomImg.center = bottomPoint;
    
    
}
@end
