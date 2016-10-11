//
//  CSProgressButton.m
//  CSProgressButton
//
//  Created by SurfBoy on 11/10/2016.
//  Copyright © 2016 CrazySurfboy. All rights reserved.
//

#import "CSProgressButton.h"

typedef NS_ENUM(NSUInteger, CSProgressButtonState) {

    CSProgressButtonStateUnstarted,
    CSProgressButtonStateProgressing,
    CSProgressButtonStateFinished
};

@interface CSProgressButton ()

@property (nonatomic, strong) UIImageView *buttonImageView;
@property (nonatomic, assign) CSProgressButtonState state;
@property (nonatomic, strong) UIImageView *animateImageView;

@end


@implementation CSProgressButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {

    //  转动的图片
    self.animateImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading-circle.png"]];
    self.animateImageView.hidden = YES;
    [self addSubview:self.animateImageView];

    // 默认状态
    self.state = CSProgressButtonStateUnstarted;

    // 添加事件
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(progressButtonWasTapped:)]];
    self.buttonImageView = [UIImageView new];
    [self addSubview:self.buttonImageView];
}




// 设置开始的图片
- (void)setStartButtonImage:(UIImage *)startButtonImage {

    _startButtonImage = startButtonImage;
    if (self.state == CSProgressButtonStateUnstarted) {
        [self updateButtonImageForState:self.state];
    }
}


// 设置结束的图片
- (void)setEndButtonImage:(UIImage *)endButtonImage {

    _endButtonImage = endButtonImage;
    if (self.state == CSProgressButtonStateFinished) {
        [self updateButtonImageForState:self.state];
    }
}


// 根据状态更新按扭
- (void)updateButtonImageForState:(CSProgressButtonState)state {

    self.buttonImageView.image = [self imageForState:state];
    self.buttonImageView.frame = (CGRect) { CGPointZero, self.buttonImageView.image.size };
}


// 状态图片
- (UIImage *)imageForState:(CSProgressButtonState)state {
    
    UIImage *image = nil;
    if (state == CSProgressButtonStateUnstarted) {
        image = self.startButtonImage;
    } 
    else if (state == CSProgressButtonStateFinished) {
        image = self.endButtonImage;
    }
    
    return image;
}



// 重新设置
- (void)reset {

    self.state = CSProgressButtonStateUnstarted;
    [self stopAnimating];
    [self updateButtonImageForState:self.state];

    [UIView animateWithDuration:0.2 animations:^{
        
        self.buttonImageView.alpha = 1.0f;
    } 
    completion:^(BOOL finished) {
    
    }];
}



#pragma mark - Actions

// 点击
- (void)progressButtonWasTapped:(UIGestureRecognizer *)gestureRecognizer {

    // 开始
    if (self.state == CSProgressButtonStateUnstarted) {

        [self startProgress];

        if (self.startButtonDidTapBlock) {
            
            self.startButtonDidTapBlock(self);
        }
    } 

    // 结束
    else if (self.state == CSProgressButtonStateFinished) {

        if (self.endButtonDidTapBlock) {
            self.endButtonDidTapBlock(self);
        }
    }
}


// 开始动画
- (void)startProgress {

    self.state = CSProgressButtonStateProgressing;
    [UIView animateWithDuration:0.2 animations:^{

        self.buttonImageView.alpha = 0.0f;        
    }];
    
    [self startAnimating];
}


// 结束动画
- (void)endProgressWithState:(CSProgressButtonState)state {

    // Block
    if (self.endButtonDidTapBlock) {
            self.endButtonDidTapBlock(self);
    }

    self.state = CSProgressButtonStateUnstarted;
    [self updateButtonImageForState:CSProgressButtonStateFinished];
    [self stopAnimating];

    [UIView animateWithDuration:0.2 animations:^{
        
        self.buttonImageView.alpha = 1.0f;
    } 
    completion:^(BOOL finished) {
    
    }];
}


// 结束进度
- (void)endProgress {

    [self endProgressWithState:CSProgressButtonStateFinished];
}


#pragma mark - Animation

- (void)startAnimating {

    // 判断是否已经常见过动画，如果已经创建则不再创建动画
    self.animateImageView.hidden = NO;
    CAAnimation *exiestAnimation = [self.animateImageView.layer animationForKey:@"rotate"];
    if (exiestAnimation) {
        return;
    }
    
    // 设置动画让它旋转起来
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @0;
    animation.toValue = @(2*M_PI);
    animation.repeatCount = HUGE_VALF;
    animation.duration = 1.0f;
    [self.animateImageView.layer addAnimation:animation forKey:@"rotate"];
}



// 停止动画
- (void)stopAnimating {

    self.animateImageView.hidden = YES;
    [self.animateImageView.layer removeAllAnimations];
}



@end
