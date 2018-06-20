//
//  LLLabelScorllView.h
//  LLScrollLabelView
//
//  Created by 嘚嘚以嘚嘚 on 2018/6/19.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum: NSUInteger {
    LLCollectionViewCellStyleNormal,///< 默认一行文字
    LLCollectionViewCellStyleMore,///< 两行文字
}LLCollectionViewCellStyle;

@protocol CollectionDidSelectDelegate <NSObject>

- (void)didSelectedItemAtIndex:(NSIndexPath *)indexPath;

@end

typedef void (^CollectionDidSelectBlock) (NSIndexPath * indexPath);

@interface LLLabelScorllView : UIView

@property (nonatomic, weak) id<CollectionDidSelectDelegate> delegate;

@property (nonatomic, copy)CollectionDidSelectBlock collectionDidSelectBlock;
/** Cell样式 */
@property (nonatomic, assign)LLCollectionViewCellStyle llCollectionViewCellStyle;
/** 滚动时间间隔 默认3秒 */
@property (nonatomic, assign)CFTimeInterval scrollTimeInterval;
/** 字体大小 默认13 */
@property (nonatomic, strong)UIFont * titleFont;
/** 对齐方式 默认左对齐 */
@property (nonatomic, assign)NSTextAlignment textAlignment;

#pragma mark - - - LLCollectionViewCellStyleNormal 样式下的 API
/** 默认图片地址 */
@property (nonatomic, strong)NSArray * imgPathArray;
/** 默认标题数据 */
@property (nonatomic, strong)NSArray * titleArray;
/** 默认字体颜色 black */
@property (nonatomic, strong)UIColor * titleColor;
/** 是否横向滚动 默认NO */
@property (nonatomic, assign) BOOL horizontalScroll;
#pragma mark - - - LLCollectionViewCellStyleMore 样式下的 API
/** 更多上部标题 */
@property (nonatomic, strong)NSArray * topTitleArray;
/** 更多上部图片地址 */
@property (nonatomic, strong)NSArray * topImgPathArray;
/** 更多下部标题 */
@property (nonatomic, strong)NSArray * bottomTitleArray;
/** 更多下部图片地址 */
@property (nonatomic, strong)NSArray * bottomImgPathArray;
/** 更多上部字体颜色 */
@property (nonatomic, strong)UIColor * topTitleColor;
/** 更多下部字体颜色 */
@property (nonatomic, strong)UIColor * bottomTitleColor;


+ (instancetype)ll_initWithFrame:(CGRect)frame
                     titlesArray:(NSArray *)titlesArray
                    imgPathArray:(NSArray *)imgPathArray
                  interFaceStyle:(void (^) (LLLabelScorllView * view))styleBlock;

+ (instancetype)ll_initWithFrame:(CGRect)frame
                  topTitlesArray:(NSArray *)topTitlesArray
                 topImgPathArray:(NSArray *)topImgPathArray
               bottomTitlesArray:(NSArray *)bottomTitlesArray
              bottomImgPathArray:(NSArray *)bottomImgPathArray
                  interFaceStyle:(void (^) (LLLabelScorllView * view)) styleBlock;


@end
