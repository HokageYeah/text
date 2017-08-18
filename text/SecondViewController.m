//
//  SecondViewController.m
//  text
//
//  Created by 余晔 on 2017/2/23.
//  Copyright © 2017年 余晔. All rights reserved.
//

#import "SecondViewController.h"
#import <SafariServices/SafariServices.h>
#import <StoreKit/StoreKit.h>


#import "GetFundAnimationView.h"
 #define MULITTHREEBYTEUTF16TOUNICODE(x,y) (((((x ^ 0xD800) << 2) | ((y ^ 0xDC00) >> 8)) << 8) | ((y ^ 0xDC00) & 0xFF)) + 0x10000

@interface SecondViewController ()<UIScrollViewDelegate,UITextViewDelegate,SFSafariViewControllerDelegate,SKStoreProductViewControllerDelegate>

@property (nonatomic, retain)NSTimer* rotateTimer;  //让视图自动切换
@property (nonatomic, retain)UIPageControl *myPageControl;

@property (nonatomic,strong) UITextView *textviews;


@property (nonnull,strong) SFSafariViewController *safariView;
@property(nonatomic,strong)UILabel* midLabel;

@property (nonatomic,strong) UIButton *nextBtn;

@property (nonatomic,strong) GetFundAnimationView *aniview;
@property (nonatomic,strong) UIButton *secondbtn;


@property (nonatomic,strong) UIView *someView;
@property (nonatomic,strong) UIView *view1;
@property (nonatomic,strong) UIView *view2;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    //初始化scrollView 大小为屏幕大小
//    UIScrollView *rotateScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
//    //设置滚动范围
//    rotateScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame)*3, CGRectGetHeight(self.view.frame));
//    //设置分页效果
//    rotateScrollView.pagingEnabled = YES;
//    //水平滚动条隐藏
//    rotateScrollView.showsHorizontalScrollIndicator = NO;
//    //添加三个子视图  UILabel类型
//    for (int i = 0; i< 3; i++) {
//        UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)*i, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
//        subLabel.tag = 1000+i;
//        subLabel.text = [NSString stringWithFormat:@"我是第%d个视图",i];
//        [subLabel setFont:[UIFont systemFontOfSize:80]];
//        subLabel.adjustsFontSizeToFitWidth = YES;
//        [subLabel setBackgroundColor:[UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0  blue:arc4random()%256/255.0  alpha:1.0]];
//        [rotateScrollView addSubview:subLabel];
//    }
//    
//    UILabel *tempLabel = [rotateScrollView viewWithTag:1000];
//    //为滚动视图的右边添加一个视图，使得它和第一个视图一模一样。
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)*3, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
//    label.backgroundColor = tempLabel.backgroundColor;
//    label.text = tempLabel.text;
//    label.font = tempLabel.font;
//    label.adjustsFontSizeToFitWidth = YES;
//    [rotateScrollView addSubview:label];
//    
//    
//    [self.view addSubview:rotateScrollView];
//    
//    rotateScrollView.tag = 1000;
//    
//    self.myPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-50, CGRectGetWidth(self.view.frame), 50)];
//    self.myPageControl.numberOfPages = 3;
//    self.myPageControl.currentPage = 0;
//    [self.view addSubview:self.myPageControl];
//    
//    //启动定时器
//    self.rotateTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeView) userInfo:nil repeats:YES];
//    //为滚动视图指定代理
//    rotateScrollView.delegate = self;
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    //leftlabel
    self.textviews = [[UITextView alloc] init];
    _textviews.translatesAutoresizingMaskIntoConstraints = NO;
    self.textviews.textAlignment = NSTextAlignmentLeft;
    self.textviews.backgroundColor = [UIColor clearColor];
    self.textviews.font = [UIFont systemFontOfSize:12.0];
    self.textviews.textColor = [UIColor grayColor];
    self.textviews.layer.borderWidth = 1;
    self.textviews.layer.borderColor= [[UIColor redColor] CGColor];
//    _textviews.editable = NO;
//    _textviews.scrollEnabled = NO;
    _textviews.delegate = self;
    [self.view addSubview:self.textviews];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-b-[_textviews]-b-|" options:0 metrics:@{@"b":@(10)} views:NSDictionaryOfVariableBindings(_textviews)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[_textviews(300)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textviews)]];
    
    
    
    
    _midLabel = [[UILabel alloc]init];
    _midLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_midLabel];
    _midLabel.text = @"三次体验机会已全部使用";
    _midLabel.font = [UIFont systemFontOfSize:15.0];
    _midLabel.textColor = [UIColor grayColor];
    _midLabel.backgroundColor = [UIColor yellowColor];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-12-[_midLabel]-12-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_midLabel)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_textviews]-10-[_midLabel(150)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_midLabel,_textviews)]];
    
    
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.translatesAutoresizingMaskIntoConstraints = NO;
    _nextBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    _nextBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _nextBtn.layer.cornerRadius = 5.0;
    _nextBtn.backgroundColor = [UIColor redColor];
    _nextBtn.clipsToBounds = YES;
    [self.view addSubview:_nextBtn];
    [self.nextBtn setTitle:@"发送短信" forState:UIControlStateNormal];
    [self.nextBtn setTitle:@"发送短信" forState:UIControlStateHighlighted];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[_nextBtn]-30-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nextBtn)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_nextBtn(35)]-30-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nextBtn)]];
    [_nextBtn addTarget:self action:@selector(buygoods:) forControlEvents:UIControlEventTouchUpInside];

    


    
//    //在app内调用系统safar。用的是同一个cookie
//    self.safariView = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"http://localhost:8000/?redirect"]];
//    self.safariView.delegate=self;
//    _safariView.modalPresentationStyle = UIModalPresentationCurrentContext;
////    self.safariView.view.alpha = 0.5;
//    [self presentViewController:self.safariView animated:false completion:nil];
//    [self addChildViewController:self.safariView];
//    [self.view addSubview:self.safariView.view];
//    [[[UIApplication sharedApplication] keyWindow] addSubview:_safariView.view];

    
    
    
    
    //app内跳转App Store
//    BOOL isInstalled =  [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"yizhen://"]];
//    
//    if (isInstalled) {//如果安装了该应该，打开该应用
//        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"yizhen://"]];
//        
//    } else {//如果未安装，跳转到App Store下载
//        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/yi-pai-quan-shou-gong-zhi/id980932555?mt=8"]];
//        
//    }
    
    
    
    
    
//    //第一种方法  直接跳转
//    
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
//    
//    btn.backgroundColor = [UIColor redColor];
//    
//    [btn setTitle:@"直接跳转" forState:UIControlStateNormal];
//    
//    btn.tag = 1;
//    
//    [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
//    
//    //第二中方法  应用内跳转
//    
//    UIButton *btnT = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 100, 50)];
//    
//    btnT.backgroundColor = [UIColor purpleColor];
//    
//    btnT.tag = 2;
//    
//    [btnT setTitle:@"应用内跳转" forState:UIControlStateNormal];
//    
//    [btnT addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:btn];
//    
//    [self.view addSubview:btnT];
    
    
    
    
    
    
    
    self.someView = [[UIView alloc] initWithFrame:CGRectMake(20, 40, 100, 100)];
    self.someView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.someView];
    
    _view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _view1.backgroundColor = [UIColor redColor];
    _view1.alpha = 0;
    [self.someView addSubview:_view1];
    
    _view2 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    _view2.backgroundColor = [UIColor blueColor];
    [self.someView addSubview:_view2];
    
    
    
    
    
    
    
    
    
    
    self.secondbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _secondbtn.translatesAutoresizingMaskIntoConstraints = NO;
    _secondbtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    _secondbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _secondbtn.layer.cornerRadius = 5.0;
    _secondbtn.backgroundColor = [UIColor redColor];
    _secondbtn.clipsToBounds = YES;
    [self.view addSubview:_secondbtn];
    [self.secondbtn setTitle:@"点我" forState:UIControlStateNormal];
    [self.secondbtn setTitle:@"点我" forState:UIControlStateHighlighted];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[_secondbtn]-30-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_secondbtn)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_secondbtn(35)]-70-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_secondbtn)]];
    [_secondbtn addTarget:self action:@selector(secondbuygoods:) forControlEvents:UIControlEventTouchUpInside];
    
    _aniview = [[GetFundAnimationView alloc] initWithFrame:CGRectMake(100, 200, 200, 50)];
    _aniview.backgroundColor = [UIColor yellowColor];
    _aniview.moneys = 50;
    [self.view addSubview:_aniview];
    
}

- (void)secondbuygoods:(UIButton *)sender{
    

    sender.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.userInteractionEnabled = YES;
    });

    [_aniview animationWithMoney:2];
}


- (void)buygoods:(UIButton *)sender{
    UIColor *maincolor = [UIColor redColor];
    UIColor *countcolor = [UIColor grayColor];
    
    [self setTheCountdownButton:_nextBtn startWithTime:59 title:@"重新获取" countDownTitle:@"重新发送" mainColor:maincolor countColor:countcolor];
}


- (void)setTheCountdownButton:(UIButton *)button startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color {
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0), 1.0 * NSEC_PER_SEC,0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束，关闭
        if (timeOut == 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                button.backgroundColor = mColor;
                [button setTitle: title forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:14];
                button.userInteractionEnabled =YES;
            });
        } else {
            int seconds = timeOut % 60;
            NSString *timeStr = [NSString stringWithFormat:@"%0.1d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                button.backgroundColor = color;
                [button setTitle:[NSString stringWithFormat:@"%@(%@)",subTitle,timeStr]forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:14];
                button.userInteractionEnabled =NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}




- (void)btn:(UIButton *)btn{
    
    if (btn.tag == 1) {
        
        //第一种方法  直接跳转
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1018221712"]];
        
    }else{
        
        //第二中方法  应用内跳转
        
        //1:导入StoreKit.framework,控制器里面添加框架#import
        
        //2:实现代理SKStoreProductViewControllerDelegate
        
        SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
        
        storeProductViewContorller.delegate = self;
        
        //        ViewController *viewc = [[ViewController alloc]init];
        
        //        __weak typeof(viewc) weakViewController = viewc;
        
        
        
        //加载一个新的视图展示
        
        [storeProductViewContorller loadProductWithParameters:
         
         //appId
         
         @{SKStoreProductParameterITunesItemIdentifier : @"1018221712"} completionBlock:^(BOOL result, NSError *error) {
             
             //回调
             
             if(error){
                 
                 NSLog(@"错误%@",error);
                 
             }else{
                 
                 //AS应用界面
                 
                 [self presentViewController: storeProductViewContorller animated:YES completion:nil];
             }
             
         }];
        
    }
    
    
    
}



#pragma mark - 评分取消按钮监听

//取消按钮监听

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}







//点击done按钮时调用
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller
{
    NSLog(@"%s",__func__);
}
//加载完成之后调用
- (void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully
{
    
    NSLog(@"%d",didLoadSuccessfully);
    if (didLoadSuccessfully) {
//        [controller dismissViewControllerAnimated:true completion:nil];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"text://"]];
    }
}

























#pragma mark -- 滚动视图的代理方法
//开始拖拽的代理方法，在此方法中暂停定时器。
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"正在拖拽视图，所以需要将自动播放暂停掉");
    //setFireDate：设置定时器在什么时间启动
    //[NSDate distantFuture]:将来的某一时刻
    [self.rotateTimer setFireDate:[NSDate distantFuture]];
}

//视图静止时（没有人在拖拽），开启定时器，让自动轮播
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //视图静止之后，过1.5秒在开启定时器
    //[NSDate dateWithTimeInterval:1.5 sinceDate:[NSDate date]]  返回值为从现在时刻开始 再过1.5秒的时刻。
    NSLog(@"开启定时器");
    [self.rotateTimer setFireDate:[NSDate dateWithTimeInterval:1.5 sinceDate:[NSDate date]]];
}


//定时器的回调方法   切换界面
- (void)changeView{
    //得到scrollView
    UIScrollView *scrollView = [self.view viewWithTag:1000];
    //通过改变contentOffset来切换滚动视图的子界面
    float offset_X = scrollView.contentOffset.x;
    //每次切换一个屏幕
    offset_X += CGRectGetWidth(self.view.frame);
    
    //说明要从最右边的多余视图开始滚动了，最右边的多余视图实际上就是第一个视图。所以偏移量需要更改为第一个视图的偏移量。
    if (offset_X > CGRectGetWidth(self.view.frame)*3) {
        scrollView.contentOffset = CGPointMake(0, 0);
        
    }
    //说明正在显示的就是最右边的多余视图，最右边的多余视图实际上就是第一个视图。所以pageControl的小白点需要在第一个视图的位置。
    if (offset_X == CGRectGetWidth(self.view.frame)*3) {
        self.myPageControl.currentPage = 0;
    }else{
        self.myPageControl.currentPage = offset_X/CGRectGetWidth(self.view.frame);
    }
    
    //得到最终的偏移量
    CGPoint resultPoint = CGPointMake(offset_X, 0);
    //切换视图时带动画效果
    //最右边的多余视图实际上就是第一个视图，现在是要从第一个视图向第二个视图偏移，所以偏移量为一个屏幕宽度
    if (offset_X >CGRectGetWidth(self.view.frame)*3) {
        self.myPageControl.currentPage = 1;
        [scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.view.frame), 0) animated:YES];
    }else{
        [scrollView setContentOffset:resultPoint animated:YES];
    }
    
}





 - (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
 {
     
         NSString *hexstr = @"";
    
         for (int i=0;i< [text length];i++)
             {
                     hexstr = [hexstr stringByAppendingFormat:@"%@",[NSString stringWithFormat:@"0x%1X ",[text characterAtIndex:i]]];
                 }
         NSLog(@"UTF16 [%@]",hexstr);
    
         hexstr = @"";
    
         long slen = strlen([text UTF8String]);
    
         for (int i = 0; i < slen; i++)
             {
                     //fffffff0 去除前面六个F & 0xFF
                     hexstr = [hexstr stringByAppendingFormat:@"%@",[NSString stringWithFormat:@"0x%X ",[text UTF8String][i] & 0xFF ]];
                 }
         NSLog(@"UTF8 [%@]",hexstr);
    
         hexstr = @"";
    
       if ([text length] >= 2) {
        
               for (int i = 0; i < [text length] / 2 && ([text length] % 2 == 0) ; i++)
                    {
                            // three bytes
                            if (([text characterAtIndex:i*2] & 0xFF00) == 0 ) {
                                    hexstr = [hexstr stringByAppendingFormat:@"Ox%1X 0x%1X",[text characterAtIndex:i*2],[text characterAtIndex:i*2+1]];
                                 }
                             else
                                {// four bytes
                                        hexstr = [hexstr stringByAppendingFormat:@"U+%1X ",MULITTHREEBYTEUTF16TOUNICODE([text characterAtIndex:i*2],[text characterAtIndex:i*2+1])];
                                    }
                
                        }
               NSLog(@"(unicode) [%@]",hexstr);
            }
       else
            {
                     NSLog(@"(unicode) U+%1X",[text characterAtIndex:0]);
                hexstr=text;
              }
     NSLog(@"%@",hexstr);
    
        return YES;
    }

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    NSLog(@"我来看编码：%@",textView.text);
}


@end
