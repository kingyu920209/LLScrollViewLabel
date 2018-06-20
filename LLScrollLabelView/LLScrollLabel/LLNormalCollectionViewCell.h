//
//  LLNormalCollectionViewCell.h
//  LLScrollLabelView
//
//  Created by 嘚嘚以嘚嘚 on 2018/6/19.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LLNormalCollectionViewCell : UICollectionViewCell
//titleLabel
/** 标题内容 */
@property (nonatomic, copy) NSString * title;
/** 图片地址or名称 */
@property (nonatomic, copy) NSString * imagePath;
/** 标题颜色 */
@property (nonatomic, strong) UIColor * titleColor;
/** 标题对齐方式 */
@property (nonatomic, assign) NSTextAlignment  titleAilgnment;
/** 标题字体大小 */
@property (nonatomic, strong) UIFont * titleFont;
/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;

@property(nonatomic,strong)UIView * bgView;
/** 是否横向滚动 */
@property (nonatomic, assign) BOOL horizontalScroll;
@end
