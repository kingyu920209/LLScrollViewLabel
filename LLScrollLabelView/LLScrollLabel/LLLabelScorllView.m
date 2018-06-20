//
//  LLLabelScorllView.m
//  LLScrollLabelView
//
//  Created by 嘚嘚以嘚嘚 on 2018/6/19.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "LLLabelScorllView.h"
#import "LLNormalCollectionViewCell.h"
#import "LLMoreCollectionViewCell.h"

static NSInteger const ScrollViewMaxSections = 100;
static NSString * const LLNormalCollectionViewCellID = @"LLNormalCollectionViewCellID";
static NSString * const LLMoreCollectionViewCellID = @"LLMoreCollectionViewCellID";

@interface LLLabelScorllView ()<UICollectionViewDelegate,UICollectionViewDataSource,CAAnimationDelegate>
@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong)NSTimer * timer;
@end
@implementation LLLabelScorllView

+ (instancetype)ll_initWithFrame:(CGRect)frame
                  topTitlesArray:(NSArray *)topTitlesArray
                 topImgPathArray:(NSArray *)topImgPathArray
               bottomTitlesArray:(NSArray *)bottomTitlesArray
              bottomImgPathArray:(NSArray *)bottomImgPathArray
                  interFaceStyle:(void (^) (LLLabelScorllView * view)) styleBlock
{
    LLLabelScorllView * view = [[LLLabelScorllView alloc]initWithFrame:frame];
    view.topTitleArray = topTitlesArray;
    view.topImgPathArray = topImgPathArray;
    view.bottomTitleArray = bottomTitlesArray;
    view.bottomImgPathArray = bottomImgPathArray;
    view.llCollectionViewCellStyle = LLCollectionViewCellStyleMore;
    styleBlock(view);
    return view;
}

+ (instancetype)ll_initWithFrame:(CGRect)frame
                     titlesArray:(NSArray *)titlesArray
                    imgPathArray:(NSArray *)imgPathArray
                  interFaceStyle:(void (^) (LLLabelScorllView * view)) styleBlock
{
    LLLabelScorllView * view = [[LLLabelScorllView alloc]initWithFrame:frame];
    view.titleArray = titlesArray;
    view.imgPathArray = imgPathArray;
    styleBlock(view);
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _scrollTimeInterval = 3.0;
        self.titleFont = [UIFont systemFontOfSize:13];
        self.horizontalScroll = NO;
        self.llCollectionViewCellStyle = LLCollectionViewCellStyleNormal;
        [self addTimer];
        [self setUpSubView];
    }
    return self;
}
- (void)setUpSubView
{
    [self addSubview:self.collectionView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _flowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    _collectionView.frame = self.bounds;
    
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        _flowLayout = [UICollectionViewFlowLayout new];
        _flowLayout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:_flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[LLNormalCollectionViewCell class] forCellWithReuseIdentifier:LLNormalCollectionViewCellID];
        
    }
    return _collectionView;
}
#pragma mark - - - UICollectionView 的 dataSource、delegate方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return ScrollViewMaxSections;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titleArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = nil;
    
    if (self.llCollectionViewCellStyle == LLCollectionViewCellStyleMore) {
        LLMoreCollectionViewCell * moreCell = [collectionView dequeueReusableCellWithReuseIdentifier:LLMoreCollectionViewCellID forIndexPath:indexPath];
        moreCell.topTitle = self.topTitleArray[indexPath.item];
        moreCell.topImgPath = self.topImgPathArray[indexPath.item];
        moreCell.bottomTitle = self.bottomTitleArray[indexPath.item];
        moreCell.bottomImgPath = self.bottomImgPathArray[indexPath.item];
        moreCell.titleFont = self.titleFont;
        moreCell.titleColor = self.titleColor;
        moreCell.titleAilgnment = self.textAlignment;
        cell = moreCell;
    }else{
        
        LLNormalCollectionViewCell * normalCell = [collectionView dequeueReusableCellWithReuseIdentifier:LLNormalCollectionViewCellID forIndexPath:indexPath];
        normalCell.title = self.titleArray[indexPath.item];
        normalCell.imagePath = self.imgPathArray[indexPath.item];
        normalCell.titleColor = self.titleColor;
        normalCell.titleAilgnment = self.textAlignment;
        normalCell.titleFont = self.titleFont;
        normalCell.horizontalScroll = self.horizontalScroll;
        cell = normalCell;
    }
    
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedItemAtIndex:)]) {
        [self.delegate didSelectedItemAtIndex:indexPath];
    }
    
    if (self.collectionDidSelectBlock) {
        self.collectionDidSelectBlock(indexPath);
    }
    
}
#pragma mark --- NSTimer
- (void)addTimer
{
    [self removeTimer];
    self.timer = [NSTimer timerWithTimeInterval:self.scrollTimeInterval target:self selector:@selector(beginUpdataUIAction) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

/** 开始动画 */
- (void)beginUpdataUIAction{
    
    if (self.titleArray.count == 0) return;
    
    NSIndexPath * currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    NSInteger nextItem = currentIndexPath.item + 1;
    
   __block NSInteger nextSection = currentIndexPath.section;
    
    if (nextItem == self.titleArray.count) {
        nextItem = 0;
        nextSection++;
    }
    
    // 判断是否需要横向滚动
    if (self.llCollectionViewCellStyle == LLCollectionViewCellStyleNormal) {
        
        if (self.horizontalScroll) {
            LLNormalCollectionViewCell * cell = (LLNormalCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:currentIndexPath];
            CGSize labelSize = CGSizeOfString(cell.titleLabel.text, CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX), cell.titleLabel.font);
            if (labelSize.width > CGRectGetWidth(cell.bgView.frame)) {
                
                [self removeTimer];
                [UIView animateWithDuration:(cell.titleLabel.frame.size.width - cell.bgView.frame.size.width)/50 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    CGRect frame = cell.titleLabel.frame;
                    frame.origin.x =-(cell.titleLabel.frame.size.width - cell.bgView.frame.size.width)-20;
                    cell.titleLabel.frame = frame;
                    
                } completion:^(BOOL finished) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [self addTimer];
                        CGRect frame = cell.titleLabel.frame;
                        frame.origin.x = 0;
                        cell.titleLabel.frame = frame;
                        
                        [self addCellAnimationnextSection:nextSection currentIndexPath:currentIndexPath nextItem:nextItem];
                        
                    });
                    
                }];
                return;
            }
            
        }
    }
    

    [self addCellAnimationnextSection:nextSection currentIndexPath:currentIndexPath nextItem:nextItem];
  
    
    
}

/** 对collectionView的layer层增加动画 */
- (void)addCellAnimationnextSection:(NSInteger )nextSection currentIndexPath:(NSIndexPath *)currentIndexPath nextItem:(NSInteger )nextItem
{
    if (nextSection >= ScrollViewMaxSections) {
        nextSection = nextSection * 0.5;
        NSIndexPath * resetCurrentIndexPath = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:0.5 * ScrollViewMaxSections];
        [self.collectionView scrollToItemAtIndexPath:resetCurrentIndexPath atScrollPosition:(UICollectionViewScrollPositionBottom) animated:NO];
        
    }
    
    NSIndexPath * nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    CATransition * animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5f;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    animation.type = @"cube";
    [self.collectionView.layer addAnimation:animation forKey:@"animationID"];
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];

}
#pragma mark --- setting
- (void)setLlCollectionViewCellStyle:(LLCollectionViewCellStyle)llCollectionViewCellStyle
{
    if (llCollectionViewCellStyle) {
        _llCollectionViewCellStyle = llCollectionViewCellStyle;
        if (llCollectionViewCellStyle == LLCollectionViewCellStyleMore) {
            [_collectionView registerClass:[LLMoreCollectionViewCell class] forCellWithReuseIdentifier:LLMoreCollectionViewCellID];
        }
    }
}

- (void)setScrollTimeInterval:(CFTimeInterval)scrollTimeInterval
{
    if (scrollTimeInterval) {
        _scrollTimeInterval = scrollTimeInterval;
        [self addTimer];
    }
}

- (void)setTitleFont:(UIFont *)titleFont
{
    if (titleFont) {
        _titleFont = titleFont;
    }
}
- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    if (textAlignment) {
        _textAlignment = textAlignment;
    }
}
- (void)setImgPathArray:(NSArray *)imgPathArray
{
    if (imgPathArray) {
        _imgPathArray = imgPathArray;
        [_collectionView reloadData];
    }
}
- (void)setTitleArray:(NSArray *)titleArray
{
    if (titleArray) {
        _titleArray = titleArray;
        [_collectionView reloadData];
    }
}
- (void)setTitleColor:(UIColor *)titleColor
{
    if (titleColor) {
        _titleColor = titleColor;
    }
}
- (void)setTopTitleArray:(NSArray *)topTitleArray
{
    if (topTitleArray) {
        _topTitleArray = topTitleArray;
        _titleArray = _topTitleArray;
    }
}
- (void)setTopImgPathArray:(NSArray *)topImgPathArray
{
    if (topImgPathArray) {
        _topImgPathArray = topImgPathArray;
    }
}
- (void)setBottomTitleArray:(NSArray *)bottomTitleArray
{
    if (bottomTitleArray) {
        _bottomTitleArray = bottomTitleArray;
    }
}
- (void)setBottomImgPathArray:(NSArray *)bottomImgPathArray
{
    if (bottomImgPathArray) {
        _bottomImgPathArray = bottomImgPathArray;
    }
}
- (void)setTopTitleColor:(UIColor *)topTitleColor
{
    if (topTitleColor) {
        _topTitleColor = topTitleColor;
    }
}
- (void)setBottomTitleColor:(UIColor *)bottomTitleColor
{
    if (bottomTitleColor) {
        _bottomTitleColor = bottomTitleColor;
    }
}

// 计算字体长度
CGSize CGSizeOfString(NSString * text, CGSize maxSize, UIFont * font)
{
    CGSize fitSize;
    if (text.length==0 || !text) {
        fitSize = CGSizeMake(0, 0);
    }else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            fitSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil].size;
        } else {
            fitSize = [text sizeWithFont:font constrainedToSize:maxSize];
        }
    }
    return fitSize;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
