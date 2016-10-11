//
//  CSProgressButton.h
//  CSProgressButton
//
//  Created by SurfBoy on 11/10/2016.
//  Copyright © 2016 CrazySurfboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSProgressButton;

typedef void(^CSProgressButtonBlockAction)(CSProgressButton *progressButton);

@interface CSProgressButton : UIView

@property (nonatomic, strong) UIImage *startButtonImage;  // 开始的图片
@property (nonatomic, strong) UIImage *endButtonImage;  // 结束的图片

@property (nonatomic, copy) CSProgressButtonBlockAction startButtonDidTapBlock; // 开始 Block
@property (nonatomic, copy) CSProgressButtonBlockAction endButtonDidTapBlock;  // 结束 Block


/**
 *  结束进度
 */
- (void)endProgress;


/**
 *  重新设置
 */
- (void)reset;


/**
 *  开始动画
 */
- (void)startProgress;

@end
