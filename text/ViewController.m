//
//  ViewController.m
//  text
//
//  Created by 余晔 on 2017/2/16.
//  Copyright © 2017年 余晔. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIDynamicAnimatorDelegate,UICollisionBehaviorDelegate>

@property (nonatomic,strong)UIImageView *bgimageview;
@property (nonatomic,strong)UIImageView *ballItem;
@property (nonatomic,strong)UIDynamicAnimator *animator;

//碰撞到边界 出现的图片
@property (nonatomic,strong)UIImageView *dungView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    UIImageView *bgimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 520)];
    bgimg.backgroundColor = [UIColor greenColor];
    [self.view addSubview:bgimg];
    
    [bgimg addSubview:self.ballItem];
}

-(UIImageView *)ballItem{
    if(_ballItem){
        return _ballItem;
    }
    _ballItem = [[UIImageView alloc] initWithFrame:CGRectMake(100, 50, 50, 50)];
    _ballItem.image = [UIImage imageNamed:@"btn_photo1"];
    return _ballItem;
}


- (UIDynamicAnimator *)animator{
    if(_animator){
        return _animator;
    }
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _animator.delegate = self;
    return _animator;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.ballItem.center = [[touches anyObject] locationInView:self.view];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.ballItem.center = [[touches anyObject] locationInView:self.view];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"Y:%f",self.ballItem.frame.origin.y);
//    [self gravity];
//    [self animatetest];
    [self UIDynamicItemBehavior];
}

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator{
    NSLog(@"开始");
}
- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator{
    NSLog(@"暂停");
}


//MARK:------重力效果-------
-(void)gravity{
    //    移除之前效果
    [self.animator removeAllBehaviors];
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc]initWithItems:@[self.ballItem]];
    /*
     CGVector 表示 方向的结构体
     struct CGVector {
     CGFloat dx; x轴的方向
     CGFloat dy; y轴的方向
     };
     gravityDirection 默认（0.0，1.0）向下 每秒下降 1000个像素点
     */
    
    gravityBehavior.gravityDirection = CGVectorMake(0,1);
    //    弧度 影响到重力的方向
//    gravityBehavior.angle = 30*M_PI/180;
    //    magnitude 影响下降速度
    gravityBehavior.magnitude = 3.5;
    //    把重力效果 添加到 动力效果的操纵者上
    [self.animator addBehavior:gravityBehavior];
    
    //注意要在结束之后调用
    [self collision];
}


//MARK:----------检验碰撞的行为---------
- (void)collision{
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.ballItem]];
    collisionBehavior.collisionDelegate = self;
    //设置 检测碰撞的模式
//    collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    //1.以参照试图为边境范围
//    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    // 2.设置碰撞边界以referenceView作为参考，设置insets作为边界。
    [collisionBehavior setTranslatesReferenceBoundsIntoBoundaryWithInsets:UIEdgeInsetsMake(0, 0, 60, 0)];
    // 3.用两个点的连线作为碰撞边界
//        [collisionBehavior addBoundaryWithIdentifier:@"pointBoundary" fromPoint:CGPointMake(0, 300) toPoint:CGPointMake(320, 600)];
    // 4.以某个贝塞尔曲线作为碰撞边界
    //    [collisionBehavior addBoundaryWithIdentifier:@"pathBoundary" forPath:_bezierPath];
    [self.animator addBehavior:collisionBehavior];
}


-(UIImageView *)dungView{
    if (_dungView) {
        return _dungView;
    }
    UIImage *image = [UIImage imageNamed:@"btn_sptx_1"];
    _dungView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    _dungView.image = image;
    [self.view addSubview:_dungView];
    return _dungView;
}


//----------------UIPushBehavior（推动行为）------------------------
- (void)animatetest{
    [self.animator removeAllBehaviors];

  //推动行为
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.ballItem] mode:UIPushBehaviorModeInstantaneous];
    pushBehavior.pushDirection = CGVectorMake(0, -80.0);
    pushBehavior.magnitude = 2.0;
    [_animator addBehavior:pushBehavior];
    
    //重力行为
    UIGravityBehavior *gravitybehavior = [[UIGravityBehavior alloc] initWithItems:@[self.ballItem]];
    gravitybehavior.gravityDirection = CGVectorMake(0, 1);
    gravitybehavior.magnitude = 2.5;
    [_animator addBehavior:gravitybehavior];
    
    //碰撞行为
    UICollisionBehavior *collisionbehavior = [[UICollisionBehavior alloc] initWithItems:@[self.ballItem]];
    [collisionbehavior setTranslatesReferenceBoundsIntoBoundaryWithInsets:UIEdgeInsetsMake(0, 0, 60, 0)];
    [_animator addBehavior:collisionbehavior];

}


//----------------UIDynamicItemBehavior （动力行为）------------------------
- (void)UIDynamicItemBehavior
{
    [self.animator removeAllBehaviors];
    //动力行为
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[_ballItem]];
    itemBehavior.elasticity = 0.6; //弹力
    itemBehavior.friction = 1;     //摩擦力
    itemBehavior.density = 10;    //密度
    itemBehavior.resistance = 10; // 阻力
    itemBehavior.allowsRotation = YES; //允许旋转
    [_animator addBehavior:itemBehavior];
    
    // 推动行为
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[_ballItem] mode:UIPushBehaviorModeInstantaneous];
    pushBehavior.pushDirection = CGVectorMake(0, - 80.0);
    pushBehavior.magnitude = 2.0;
    [_animator addBehavior:pushBehavior];
    
    // 碰撞行为
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[_ballItem]];
    //设置碰撞边界为referenceView的边界。
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:collisionBehavior];
}




- (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(nullable id <NSCopying>)identifier atPoint:(CGPoint)p{
    NSLog(@"开始 接触 到 边境");
    
    self.dungView.center = CGPointMake(p.x-10, p.y-10);
    [self.bgimageview exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
}
- (void)collisionBehavior:(UICollisionBehavior*)behavior endedContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(nullable id <NSCopying>)identifier{
    NSLog(@"结束 接触边镜");
}


@end
