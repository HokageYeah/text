//
//  GetFundAnimationView.m
//  text
//
//  Created by 余晔 on 2017/3/27.
//  Copyright © 2017年 余晔. All rights reserved.
//

#import "GetFundAnimationView.h"

#define addSpeed 100

@interface GetFundAnimationView ()
@property (nonatomic,strong) UILabel *firstlabel;
@property (nonatomic,strong) UILabel *secondlabel;


@end
@implementation GetFundAnimationView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.clipsToBounds = YES;
        [self addSubview:self.firstlabel];
        _firstlabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        [self addSubview:self.secondlabel];
        _secondlabel.frame = CGRectMake(0, -self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
        
        
    }
    return self;
}


- (UILabel *)firstlabel{
    if(nil==_firstlabel){
        _firstlabel = [UILabel new];
        _firstlabel.font = [UIFont boldSystemFontOfSize:25.0];
        _firstlabel.textAlignment = NSTextAlignmentCenter;
        _firstlabel.textColor = [UIColor redColor];
    }
    return _firstlabel;
}

- (UILabel *)secondlabel{
    if(nil==_secondlabel){
        _secondlabel = [UILabel new];
        _secondlabel.font = [UIFont boldSystemFontOfSize:25.0];
        _secondlabel.textAlignment = NSTextAlignmentCenter;
        _secondlabel.textColor = [UIColor redColor];
    }
    return _secondlabel;
}

- (void)setMoneys:(NSInteger)moneys{
    if(_moneys!=moneys){
        _moneys = moneys;
    }
    _firstlabel.text = [NSString stringWithFormat:@"%ld",moneys];
}

- (void)animationWithMoney:(NSInteger)addMoney{
    NSInteger almony = addMoney+[_firstlabel.text integerValue];
    NSString *allmoney = [NSString stringWithFormat:@"%ld",(long)almony];
//    _firstlabel.text = [NSString stringWithFormat:@"%@",allmoney];

//    [UIView animateWithDuration:0.05 delay:0 usingSpringWithDamping:0.3f initialSpringVelocity:15.0f options:UIViewAnimationOptionLayoutSubviews animations:^{
//        
//            _firstlabel.frame = CGRectMake(0, -10, self.bounds.size.width, self.bounds.size.height);
//
//        
//    } completion:^(BOOL finished) {
//        
//        [UIView animateWithDuration:0.15 delay:0 usingSpringWithDamping:0.3f initialSpringVelocity:15.0f options:UIViewAnimationOptionLayoutSubviews animations:^{
//            
//            _firstlabel.frame = CGRectMake(0, 10, self.bounds.size.width, self.bounds.size.height);
//            
//            
//        } completion:^(BOOL finished) {
//            
//            [UIView animateWithDuration:0.05 delay:0 usingSpringWithDamping:0.3f initialSpringVelocity:15.0f options:UIViewAnimationOptionLayoutSubviews animations:^{
//                
//                _firstlabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
//                
//                
//            } completion:^(BOOL finished) {
//                
//                
//            }];
//        }];
//   
//    }];
    
    
    
    [UIView animateWithDuration:0.25 animations:^{
        _firstlabel.frame = CGRectMake(0, 18, self.bounds.size.width, self.bounds.size.height);
    } completion:^(BOOL finished) {
        
        [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.1 animations:^{
                _firstlabel.frame = CGRectMake(0, -18, self.bounds.size.width, self.bounds.size.height);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.1 animations:^{
                _firstlabel.frame = CGRectMake(0, 10, self.bounds.size.width, self.bounds.size.height);
                
            }];
            [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.1 animations:^{
                _firstlabel.frame = CGRectMake(0, -10, self.bounds.size.width, self.bounds.size.height);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.1 animations:^{
                _firstlabel.frame = CGRectMake(0, 8, self.bounds.size.width, self.bounds.size.height);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.4 relativeDuration:0.1 animations:^{
                _firstlabel.frame = CGRectMake(0, -8, self.bounds.size.width, self.bounds.size.height);
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.1 animations:^{
                _firstlabel.frame = CGRectMake(0, 4, self.bounds.size.width, self.bounds.size.height);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.1 animations:^{
                _firstlabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
                _firstlabel.text = allmoney;
            }];
        } completion:^(BOOL finished) {
        }];

        
    }];
    

    
    

//    [UIView animateKeyframesWithDuration:0.8 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
// 
//        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.3 animations:^{
//            _firstlabel.frame = CGRectMake(0, 18, self.bounds.size.width, self.bounds.size.height);
//        }];
//        [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.1 animations:^{
//            _firstlabel.frame = CGRectMake(0, -18, self.bounds.size.width, self.bounds.size.height);
//        }];
//        [UIView addKeyframeWithRelativeStartTime:0.4 relativeDuration:0.1 animations:^{
//            _firstlabel.frame = CGRectMake(0, 10, self.bounds.size.width, self.bounds.size.height);
//
//        }];
//        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.1 animations:^{
//            _firstlabel.frame = CGRectMake(0, -10, self.bounds.size.width, self.bounds.size.height);
//        }];
//        [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.1 animations:^{
//            _firstlabel.frame = CGRectMake(0, 8, self.bounds.size.width, self.bounds.size.height);
//        }];
//        [UIView addKeyframeWithRelativeStartTime:0.7 relativeDuration:0.1 animations:^{
//            _firstlabel.frame = CGRectMake(0, -8, self.bounds.size.width, self.bounds.size.height);
//        }];
//        
//        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.1 animations:^{
//            _firstlabel.frame = CGRectMake(0, 4, self.bounds.size.width, self.bounds.size.height);
//        }];
//        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.1 animations:^{
//            _firstlabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
//            _firstlabel.text = allmoney;
//        }];
//    } completion:^(BOOL finished) {
//    }];
}



//- (void)animationWithMoney:(NSInteger)addMoney{
//    float frameyy = self.firstlabel.frame.origin.y;
//    
//    float framey = CGRectGetMaxY(_firstlabel.frame);
//    NSInteger almony = addMoney+(framey!=0?[_firstlabel.text integerValue]:[_secondlabel.text integerValue]);
//    NSString *allmoney = [NSString stringWithFormat:@"%ld",(long)almony];
//
//    float frameys = CGRectGetMidY(_firstlabel.frame);
//    float framex = CGRectGetMaxX(_firstlabel.frame);
//    float framexs = CGRectGetMidX(_firstlabel.frame);
//
//    NSLog(@"y:%f",framey);
//    NSLog(@"ys:%f",frameys);
//    NSLog(@"x:%f",framex);
//    NSLog(@"xs:%f",framexs);
//    
////    NSInteger firststr = [_firstlabel.text integerValue];
////    NSInteger secondstr = [_secondlabel.text integerValue];
////    for(int i=0;i<addMoney;i++){
////        if(frameyy==0){
////            [self changeFromNumber:firststr toNumber:almony withAnimationTime:0.02 withLabel:_firstlabel];
////        }else{
////            [self changeFromNumber:secondstr toNumber:almony withAnimationTime:0.02 withLabel:_secondlabel];
////        }
////    }
//
//        [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.3f initialSpringVelocity:15.0f options:UIViewAnimationOptionLayoutSubviews animations:^{
//            
//            if(frameyy==0){
//                _firstlabel.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
//                _secondlabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
//                _secondlabel.text = [NSString stringWithFormat:@"%@",allmoney];
//            }else{
//                _firstlabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
//                _secondlabel.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
//                _firstlabel.text = [NSString stringWithFormat:@"%@",allmoney];
//            }
//    
//    
//        } completion:^(BOOL finished) {
//            
//            if(frameyy==0){
//                _firstlabel.frame = CGRectMake(0, -self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
//            }else{
//                _secondlabel.frame = CGRectMake(0, -self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
//            }
//        }];
//}








@end
