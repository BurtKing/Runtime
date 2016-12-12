//
//  ViewController.m
//  Runtime
//
//  Created by Burt on 2016/11/21.
//  Copyright © 2016年 Burt. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "RuntimeForward.h"
#import "TestViewController.h"

@interface ViewController ()

@end

void dynamicMethodIMP(id self, SEL _cmd)
{
    // implementation ....
    NSLog(@"1");
}


@implementation ViewController

+(void)load
{
    [super load];
    NSLog(@"load111");
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"viewDidLoad");
    
    
    
    UIImageView * imgV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imgV.image=[UIImage imageNamed:@"52DA287E5A77C1AB35F7C28916F89848.jpg"];
    [self.view addSubview:imgV];
    
    UIInterpolatingMotionEffect *motionEffect;
    motionEffect = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x"
                                                                  type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    motionEffect.minimumRelativeValue = @(-250);
    motionEffect.maximumRelativeValue = @(250);
    [imgV addMotionEffect:motionEffect];
    
    motionEffect = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y"
                                                                  type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    motionEffect.minimumRelativeValue = @(-250);
    motionEffect.maximumRelativeValue = @(250);
    [imgV addMotionEffect:motionEffect];
    
    
    
    
    
    
    
    
    
    
    

    /*
     //验证替换方法(2-1)/(steps-step)；
    class_replaceMethod([self class], @selector(resolveThisMethodDynamically), (IMP) dynamicMethodIMP, "v@:");
     */
    [self performSelector:@selector(resolveThisMethodDynamically)];
    
    //forwarding
    [self performSelector:@selector(noneClassMethod)];
}


+ (BOOL) resolveInstanceMethod:(SEL)aSEL
{
    if (aSEL == @selector(resolveThisMethodDynamically))
    {
        class_addMethod([self class], aSEL, (IMP) dynamicMethodIMP, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:aSEL];
}

/*
 //验证替换方法(2-2)；
-(void)resolveThisMethodDynamically
{
    NSLog(@"2");
}
 */



//forwarding
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    NSLog(@"MyTestObject _cmd: %@\n", NSStringFromSelector(_cmd));
    
    RuntimeForward *none = [[RuntimeForward alloc] init];
    if ([none respondsToSelector: aSelector]) {
        return none;
    }
    
    return [super forwardingTargetForSelector: aSelector];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    TestViewController * vc=[[TestViewController alloc]init];
    [vc performSelector:@selector(touched)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
