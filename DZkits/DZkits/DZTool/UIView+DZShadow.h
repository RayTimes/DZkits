//
//  UIView+DZShadow.h
//  DZkits
//
//  Created by zhaold on 2020/11/27.
//  Copyright © 2020 365paotui. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (DZShadow)

typedef NS_ENUM(NSInteger, SSShadowPathSide){
    SSShadowPathLeft,
    SSShadowPathRight,
    SSShadowPathTop,
    SSShadowPathBottom,
    SSShadowPathNoTop,
    SSShadowPathNoBottom,
    SSShadowPathAllSide
};

typedef NS_ENUM(NSInteger, SSCornerPosition) {
    SSCornerPositionTop,
    SSCornerPositionLeft,
    SSCornerPositionBottom,
    SSCornerPositionRight,
    SSCornerPositionAll
};

#pragma mark  --------------  阴影
/*
 * shadowColor 阴影颜色
 * shadowOpacity 阴影透明度，默认0
 * shadowRadius  阴影半径，默认3
 * shadowPathSide 设置哪一侧的阴影，
 * shadowPathWidth 阴影的宽度，
 */

-(void)SS_SetShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(SSShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth;

#pragma mark  --------------  用于修改系统 UISearchBar圆角
- (UIView *)subViewOfClassName:(NSString*)className;

#pragma mark  --------------  圆角
@property (nonatomic, assign) SSCornerPosition ss_cornerPosition;
@property (nonatomic, assign) CGFloat ss_cornerRadius;

- (void)ss_setCornerOnTopWithRadius:(CGFloat)radius;
- (void)ss_setCornerOnLeftWithRadius:(CGFloat)radius;
- (void)ss_setCornerOnBottomWithRadius:(CGFloat)radius;
- (void)ss_setCornerOnRightWithRadius:(CGFloat)radius;
- (void)ss_setAllCornerWithCornerRadius:(CGFloat)radius;
- (void)ss_setNoneCorner;
@end

NS_ASSUME_NONNULL_END
