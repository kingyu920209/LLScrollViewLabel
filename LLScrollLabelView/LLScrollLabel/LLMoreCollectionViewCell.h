//
//  LLMoreCollectionViewCell.h
//  LLScrollLabelView
//
//  Created by 嘚嘚以嘚嘚 on 2018/6/19.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLMoreCollectionViewCell : UICollectionViewCell
@property (nonatomic, copy) NSString * topTitle;
@property (nonatomic, copy) NSString * topImgPath;
@property (nonatomic, copy) NSString * bottomTitle;
@property (nonatomic, copy) NSString * bottomImgPath;
/** 标题颜色 */
@property (nonatomic, strong) UIColor * titleColor;
/** 标题对齐方式 */
@property (nonatomic, assign) NSTextAlignment  titleAilgnment;
/** 标题字体大小 */
@property (nonatomic, strong) UIFont * titleFont;
@end
