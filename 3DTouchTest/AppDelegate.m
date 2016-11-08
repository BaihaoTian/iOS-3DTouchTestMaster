//
//  AppDelegate.m
//  3DTouchTest
//
//  Created by Bc.whi1te_Lei on 15/10/16.
//  Copyright © 2015年 Bc.whi1te_Lei. All rights reserved.
//

#import "AppDelegate.h"

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"version %f",IOS_VERSION);
    
    if (IOS_VERSION >=9.0) {

    [self create3DShortcutItem];
    UIApplicationShortcutItem *item = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
    if (item)
    {
        NSLog(@"app未启动 我们从短item: %@ 进入", item.localizedTitle);
        return NO;
    }
    else
    {
        NSLog(@"正常进入.");
    }
    }
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


# pragma mark  3dTouch 按压后出现item 并判断用户选择哪个
//如果app在后台，通过快捷选项标签进入app，则调用该方法，如果app不在后台已杀死，则处理通过快捷选项标签进入app的逻辑在- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions中

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    
 
    //判断先前我们设置的快捷选项标签唯一标识，根据不同标识执行不同操作
    if([shortcutItem.type isEqualToString:@"index"]){
        NSLog(@"index is click");
    }else if([shortcutItem.type isEqualToString:@"category"]){
        NSLog(@"category is click");
    }else if([shortcutItem.type isEqualToString:@"personCenter"]){
        NSLog(@"personCenter is click");
    }
    
    if (completionHandler) {
        completionHandler(YES);
    }
}

#pragma mark -创建3DTouch下条目
-(void) create3DShortcutItem
{
    //自定义icon 的初始化方法
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"1"];
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"2"];
    UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"3"];

    
    UIMutableApplicationShortcutItem *item00 = [[UIMutableApplicationShortcutItem alloc] initWithType:@"index"
                                                                                       localizedTitle:@"闪电购首页"
                                                                                    localizedSubtitle:@"你想要的 应有尽有"
                                                                                                 icon:icon1
                                                                                             userInfo:nil];
    
    UIMutableApplicationShortcutItem *item01 = [[UIMutableApplicationShortcutItem alloc] initWithType:@"category"
                                                                                       localizedTitle:@"闪电购分类"
                                                                                    localizedSubtitle:nil
                                                                                                 icon:icon2
                                                                                             userInfo:nil];
    
    UIMutableApplicationShortcutItem *item02 = [[UIMutableApplicationShortcutItem alloc] initWithType:@"personCenter"
                                                                                       localizedTitle:@"闪电购我的"
                                                                                    localizedSubtitle:nil
                                                                                                 icon:icon3
                                                                                             userInfo:nil];

    NSArray *addArr = @[item00,item01,item02];
    
    NSArray *existArr = [UIApplication sharedApplication].shortcutItems;
    
    [UIApplication sharedApplication].shortcutItems = [existArr arrayByAddingObjectsFromArray:addArr];
    
    [UIApplication sharedApplication].shortcutItems = addArr;
}











@end
