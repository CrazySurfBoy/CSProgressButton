//
//  ViewController.m
//  CSProgressButton
//
//  Created by SurfBoy on 11/10/2016.
//  Copyright © 2016 CrazySurfboy. All rights reserved.
//

#import "ViewController.h"
#import "CSProgressButton.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WDITH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@property (nonatomic, strong) CSProgressButton *progressButton; // 进度按扭

@end

@implementation ViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Demo";
    
    // Add
    CSProgressButton *progressButton = [[CSProgressButton alloc] initWithFrame:CGRectMake(SCREEN_WDITH/2-25, 100.0f, 25.0f, 25.0f)];
    progressButton.startButtonImage = [UIImage imageNamed:@"subscribed_add_blue_button_icon"];
    progressButton.endButtonImage = [UIImage imageNamed:@"subscribed_button_icon"];
    [self.view addSubview:progressButton];
    
    // 开始
    // @weakify(self);
    progressButton.startButtonDidTapBlock = ^(CSProgressButton *progressButton) {
        // @strongify(self);
        
        // 2秒
        NSLog(@"startButtonDidTapBlock");
        [self progressButtonClick:progressButton];
    };

    // 结束
    progressButton.endButtonDidTapBlock = ^(CSProgressButton *progressButton) {
            
        NSLog(@"endButtonDidTapBlock");
    };
}


// 点击事件
- (void)progressButtonClick:(CSProgressButton *)progressButton {
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        
        [progressButton endProgress];
    });
    
    
}




@end
