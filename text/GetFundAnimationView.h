//
//  GetFundAnimationView.h
//  text
//
//  Created by 余晔 on 2017/3/27.
//  Copyright © 2017年 余晔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetFundAnimationView : UIView
@property (nonatomic,assign)NSInteger moneys;   //初始值

- (void)animationWithMoney:(NSInteger)addMoney; //增加值
@end
