//
//  UIView+DZShadow.m
//  DZkits
//
//  Created by zhaold on 2020/11/27.
//  Copyright © 2020 365paotui. All rights reserved.
//

#import "UIView+DZShadow.h"
#import <objc/runtime.h>

static NSString * const SSCornerPositionKey = @"SSCornerPositionKey";
static NSString * const SSCornerRadiusKey = @"SSCornerRadiusKey";
@implementation UIView (DZShadow)
@dynamic ss_cornerPosition;

#pragma mark  --------------  阴影
/*
 * shadowColor 阴影颜色
 * shadowOpacity 阴影透明度，默认0
 * shadowRadius  阴影半径，默认3
 * shadowPathSide 设置哪一侧的阴影，
 * shadowPathWidth 阴影的宽度，
 */

-(void)SS_SetShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(SSShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth{
    if([self isKindOfClass:[UITabBar class]]){
        
    }else{
        [self.superview layoutIfNeeded];
    }
    self.layer.masksToBounds = NO;
    
    self.layer.shadowColor = shadowColor.CGColor;
    
    self.layer.shadowOpacity = shadowOpacity;
    
    self.layer.shadowRadius =  shadowRadius;
    
    self.layer.shadowOffset = CGSizeZero;
    CGRect shadowRect;
    
    CGFloat originX = 0;
    
    CGFloat originY = 0;
    
    CGFloat originW = self.bounds.size.width;
    
    CGFloat originH = self.bounds.size.height;
    
    
    switch (shadowPathSide) {
        case SSShadowPathTop:
            shadowRect  = CGRectMake(originX, originY - shadowPathWidth/2, originW,  shadowPathWidth);
            break;
        case SSShadowPathBottom:
            shadowRect  = CGRectMake(originX, originH -shadowPathWidth/2, originW, shadowPathWidth);
            break;
            
        case SSShadowPathLeft:
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
            
        case SSShadowPathRight:
            shadowRect  = CGRectMake(originW - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
        case SSShadowPathNoTop:
            shadowRect  = CGRectMake(originX -shadowPathWidth/2, originY +1, originW +shadowPathWidth,originH + shadowPathWidth/2 );
            break;
        case SSShadowPathNoBottom:
            shadowRect  = CGRectMake(originX -shadowPathWidth/2, originY -1, originW +shadowPathWidth,originH + shadowPathWidth/2 );
            break;
        case SSShadowPathAllSide:
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY - shadowPathWidth/2, originW +  shadowPathWidth, originH + shadowPathWidth);
            break;
            
    }
    
    UIBezierPath *path =[UIBezierPath bezierPathWithRect:shadowRect];
    
    self.layer.shadowPath = path.CGPath;
    
}

#pragma mark  --------------  圆角

- (SSCornerPosition)ss_cornerPosition
{
    return [objc_getAssociatedObject(self, &SSCornerPositionKey) integerValue];
}


- (void)setSs_cornerPosition:(SSCornerPosition)ss_cornerPosition
{
    objc_setAssociatedObject(self, &SSCornerPositionKey, @(ss_cornerPosition), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@dynamic ss_cornerRadius;
- (CGFloat)ss_cornerRadius
{
    return [objc_getAssociatedObject(self, &SSCornerRadiusKey) floatValue];
}

- (void)setSs_cornerRadius:(CGFloat)ss_cornerRadius
{
    objc_setAssociatedObject(self, &SSCornerRadiusKey, @(ss_cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load
{
    SEL ori = @selector(layoutSublayersOfLayer:);
    SEL new = NSSelectorFromString([@"ss_" stringByAppendingString:NSStringFromSelector(ori)]);
    ss_swizzle(self, ori, new);
}

void ss_swizzle(Class c, SEL orig, SEL new)
{
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    
    method_exchangeImplementations(origMethod, newMethod);
}

- (void)ss_layoutSublayersOfLayer:(CALayer *)layer
{
    [self ss_layoutSublayersOfLayer:layer];
    
    if (self.ss_cornerRadius > 0) {
        
        UIBezierPath *maskPath;
        switch (self.ss_cornerPosition) {
            case SSCornerPositionTop:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                       cornerRadii:CGSizeMake(self.ss_cornerRadius, self.ss_cornerRadius)];
                break;
            case SSCornerPositionLeft:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft)
                                                       cornerRadii:CGSizeMake(self.ss_cornerRadius, self.ss_cornerRadius)];
                break;
            case SSCornerPositionBottom:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                                       cornerRadii:CGSizeMake(self.ss_cornerRadius, self.ss_cornerRadius)];
                break;
            case SSCornerPositionRight:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight)
                                                       cornerRadii:CGSizeMake(self.ss_cornerRadius, self.ss_cornerRadius)];
                break;
            case SSCornerPositionAll:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:UIRectCornerAllCorners
                                                       cornerRadii:CGSizeMake(self.ss_cornerRadius, self.ss_cornerRadius)];
                break;
        }
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
    }
}

- (void)ss_setCornerOnTopWithRadius:(CGFloat)radius
{
    self.ss_cornerPosition = SSCornerPositionTop;
    self.ss_cornerRadius = radius;
}

- (void)ss_setCornerOnLeftWithRadius:(CGFloat)radius
{
    self.ss_cornerPosition = SSCornerPositionLeft;
    self.ss_cornerRadius = radius;
}

- (void)ss_setCornerOnBottomWithRadius:(CGFloat)radius
{
    self.ss_cornerPosition = SSCornerPositionBottom;
    self.ss_cornerRadius = radius;
}

- (void)ss_setCornerOnRightWithRadius:(CGFloat)radius
{
    self.ss_cornerPosition = SSCornerPositionRight;
    self.ss_cornerRadius = radius;
}

- (void)ss_setAllCornerWithCornerRadius:(CGFloat)radius
{
    self.ss_cornerPosition = SSCornerPositionAll;
    self.ss_cornerRadius = radius;
}

- (void)ss_setNoneCorner
{
    self.layer.mask = nil;
}


- (UIView *)subViewOfClassName:(NSString*)className {
    for (UIView* subView in self.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            return subView;
        }
        
        UIView* resultFound = [subView subViewOfClassName:className];
        if (resultFound) {
            return resultFound;
        }
    }
    return nil;
}

@end
