//
//  ViewController.m
//  3DTouchTest
//
//  Created by Bc.whi1te_Lei on 15/10/16.
//  Copyright © 2015年 Bc.whi1te_Lei. All rights reserved.
//

#import "ViewController.h"
#import "peekVC.h"
@interface ViewController ()<UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) UIButton* btn;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.btn.backgroundColor = [UIColor lightGrayColor];
    self.btn.titleLabel.text = @"click";
    [self.btn addTarget:self action:@selector(jumpVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
#ifdef __IPHONE_9_0
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        NSLog(@"3DTouch 可以使用");
    }else if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityUnavailable){
        NSLog(@"3DTouch 不可使用");
    }else if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityUnknown){
        NSLog(@"3DTouch 未知");
    }
        // 判断设备是否支持3dTouch
        if(self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            [self registerForPreviewingWithDelegate:self sourceView:self.view];
        }
    
#endif
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)jumpVC{
    peekVC *vc = [[peekVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIViewControllerPreviewingDelegate

//peek(预览)
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    
    //[previewingContext sourceView]就是按压的那个视图
    
    UIView * sourceView = [previewingContext sourceView];
    
    if (!CGRectContainsPoint(self.btn.frame, location)) return nil;
   
    //调整不被虚化的范围，按压的那个cell不被虚化（轻轻按压时周边会被虚化，再少用力展示预览，再加力跳页至设定界面）
    CGRect sourceRect = self.btn.frame;

    /*
     如果self.locationView不是sourceView的直接子控件,这里同时也涉及到坐标系转换
     sourceRect = [self convertRect:self.locationView.frame toView:sourceView];
     */
    
    //调整不被虚化的范围，按压的那个cell不被虚化（轻轻按压时周边会被虚化，再少用力展示预览，再加力跳页至设定界面）
    previewingContext.sourceRect = sourceRect;
     //设定预览的界面
    //然后创建需要跳转的目标控制器返回就OK了
    peekVC *vc = [peekVC new];
    vc.preferredContentSize = CGSizeMake(0.0, 300.0);
    
    return vc;
}

//pop（按用点力进入）
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    peekVC *vc = [peekVC new];
    [self showViewController:vc sender:self];

}

//检测是否可以使用  设置发生改变时会进入这里
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    //do something
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        NSLog(@"3DTouch 可以使用");
    }else if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityUnavailable){
        NSLog(@"3DTouch 不可使用");
    }else if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityUnknown){
        NSLog(@"3DTouch 未知");
    }
}








@end
