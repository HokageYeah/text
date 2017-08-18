//
//  AppDelegate.m
//  text
//
//  Created by 余晔 on 2017/2/16.
//  Copyright © 2017年 余晔. All rights reserved.
//

#import "AppDelegate.h"
#import "SecondViewController.h"
#import "OpenUDID.h"
#import "UMMobClick/MobClick.h"

@interface AppDelegate ()
@property (nonatomic,assign)NSInteger timeOut;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //  友盟的方法本身是异步执行，所以不需要再异步调用
    [self umengTrack];
    SecondViewController *login = [[SecondViewController alloc] init];
    UINavigationController *naviCtr = [[UINavigationController alloc] initWithRootViewController:login];
    self.window.rootViewController = naviCtr;
    NSString *openudid = [OpenUDID value];
    NSLog(@"openudid我来看看哈哈哈：%@",openudid);
    _timeOut = 0;
    return YES;
}

- (void)umengTrack {
    //    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    [MobClick setLogEnabled:YES];
    UMConfigInstance.appKey = @"58b7931e6e27a450da003464";
    UMConfigInstance.channelId = @"App Store";
    UMConfigInstance.ePolicy = (ReportPolicy)BATCH;
//    UMConfigInstance.secret = @"secretstringaldfkals";
    //    UMConfigInstance.eSType = E_UM_GAME;
    [MobClick startWithConfigure:UMConfigInstance];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    self. backgroundTaskIdentifier =[application beginBackgroundTaskWithExpirationHandler:^( void) {
        [self endBackgroundTask];
    }];
    
    // 模拟一个Long-Running Task
    self.myTimer =[NSTimer scheduledTimerWithTimeInterval:1.0f
                                                   target:self
                                                 selector:@selector(timerMethod:)
                                                 userInfo:nil
                                                  repeats:YES];
    
    
}

- (void) endBackgroundTask{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    AppDelegate *weakSelf = self;
    dispatch_async(mainQueue, ^(void) {
        
        AppDelegate *strongSelf = weakSelf;
        if (strongSelf != nil){
            [strongSelf.myTimer invalidate];// 停止定时器
            
            // 每个对 beginBackgroundTaskWithExpirationHandler:方法的调用,必须要相应的调用 endBackgroundTask:方法。这样，来告诉应用程序你已经执行完成了。
            // 也就是说,我们向 iOS 要更多时间来完成一个任务,那么我们必须告诉 iOS 你什么时候能完成那个任务。
            // 也就是要告诉应用程序：“好借好还”嘛。
            // 标记指定的后台任务完成
            [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTaskIdentifier];
            // 销毁后台任务标识符
            strongSelf.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
        }
    });
}


// 模拟的一个 Long-Running Task 方法
- (void) timerMethod:(NSTimer *)paramSender{
    _timeOut++;
    NSLog(@"时间：%ld",(long)_timeOut);
    // backgroundTimeRemaining 属性包含了程序留给的我们的时间
    NSTimeInterval backgroundTimeRemaining =[[UIApplication sharedApplication] backgroundTimeRemaining];
    if (backgroundTimeRemaining == DBL_MAX){
        NSLog(@"Background Time Remaining = Undetermined");
    } else {
        NSLog(@"Background Time Remaining = %.02f Seconds", backgroundTimeRemaining);
    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



//iOS9以上 URL Scheme
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(nonnull NSDictionary *)options
{
    NSString *path = url.path;
    NSLog(@"链接：%@ 信息：%@",url.host,options);
    return YES;
}

//ios9以下 URI Scheme
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    NSLog(@"链接：%@ 信息：%@",url,sourceApplication);
        return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    NSLog(@"链接：%@ ",url.host);

    return YES;
}




@end
