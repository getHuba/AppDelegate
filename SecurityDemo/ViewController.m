//
//  ViewController.m
//  SecurityDemo
//
//  Created by TaiHuiTao on 16/8/29.
//  Copyright © 2016年 Lee2Go. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "AppDelegate.h"
@interface ViewController ()

@property (nonatomic,strong)LAContext *LAContent;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.myStr = @"jic";
    AppDelegate *appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDel.myViewController = self;
    
}

//判断是否支持指纹或人脸
 - (void)isSupportTouchIDOrFaceID
{
    LAContext *context = [[LAContext alloc] init];
    // 支持手势密码或者人脸识别功能，iOS8.0以下没指纹和人脸
//    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0 ) {
    NSError *authError = nil;
    //是否可以调用指纹或人脸成功
    [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError];
    NSLog(@"authError= %@",authError);
    // 判断当前手机支持人脸识别还是指纹解锁
    if (@available(iOS 11.0, *)) {
        if (context.biometryType == LABiometryTypeTouchID) {
             NSLog(@"当前支持指纹密码");
           
        }else if (context.biometryType == LABiometryTypeFaceID){
            NSLog(@"当前支持指纹密码 “人脸识别”");
           
            
        }else{
           //不支持人脸和指纹
        }
    }else{
        //iOS 11以下系统没人脸识别
     
    }
    if (authError.code == -6) {
        //当前人脸权限没开启，";
        NSLog(@"authError= %@",authError);
       
    }else if (authError.code == -7)
    {
        //或者设置里指纹，人脸。密码，没开
       NSLog(@"authError= %@",authError);
    }
    NSLog(@"authError= %@",authError);
// }
}

- (void)getLaunchImageName{
    
    NSString *launchImageName = @"";  //启动图片名称变量
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height; //屏幕高度
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width; //屏幕宽度
    
    //设备界面方向
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    BOOL isPortrait = UIInterfaceOrientationIsPortrait(orientation);// 是否竖屏
    BOOL isLandscape = UIInterfaceOrientationIsLandscape(orientation);//是否横屏
    
    //获取与当前设备匹配的启动图片名称
    //4、4S 竖屏，横屏
    if ((isPortrait && screenHeight == 480) || (isLandscape && screenWidth == 480)){
        launchImageName = @"LaunchImage-700";
    }
    //5、5C、5S、iPod 竖屏，横屏
    else if ((isPortrait && screenHeight == 568) || (isLandscape && screenWidth == 568)){
        launchImageName = @"LaunchImage-700-568h";
    }
    //6、6S 竖屏，横屏
    else if ((isPortrait && screenHeight == 667) || (isLandscape && screenWidth == 667)){
        launchImageName = @"LaunchImage-800-667h";
    }
    //6Plus、6SPlus竖屏
    else if (isPortrait && screenHeight == 736){
        launchImageName = @"LaunchImage-800-Portrait-736h";
    }
    //6Plus、6SPlus 横屏
    else if (isLandscape && screenWidth == 736){
        launchImageName = @"LaunchImage-800-Landscape-736h";
    }
    //iphoneX 竖屏
    else if (isPortrait && screenHeight == 812){
        launchImageName = @"LaunchImage-1100-Portrait-2436h";
    }
    //iPad 竖屏
    else if (isPortrait && screenHeight == 1024){
        launchImageName = @"LaunchImage-700-Portrait";
    }
    //iPad 横屏
    else if (isLandscape && screenWidth == 1024){
        launchImageName = @"LaunchImage-700-Landscape";
    }else{
        launchImageName = [self getIphoneLaunchImageName];
    }
    
    if (launchImageName.length < 1) return;
    
    //设备启动图片为控制器的背景图片
    UIImage *img = [UIImage imageNamed:launchImageName];
    self.view.layer.contents = (id) img.CGImage;

}


//获取手机启动页图片名字
- (NSString *)getIphoneLaunchImageName
{
    NSString *viewOrientation = @"Portrait";
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        viewOrientation = @"Landscape";
    }
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    
    UIWindow *currentWindow = [[UIApplication sharedApplication].windows firstObject];
    CGSize viewSize = currentWindow.bounds.size;
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    return launchImageName;
}

-(IBAction)touchDownVerification:(id)sender {
    
//   NSString *launchImageName = [self getIphoneLaunchImageName];
//    //设备启动图片为控制器的背景图片
//    UIImage *img = [UIImage imageNamed:launchImageName];
//    self.view.layer.contents = (id) img.CGImage;
    //调用APPdelegate里的方法
    AppDelegate *appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDel loadOtherLoginView];
    
//    [self getLaunchImageName];
//    [self isSupportTouchIDOrFaceID];
//    [self selfAddLockWay];
    
}

-(void)selfAddLockWay
{
        LAContext *laContext = [[LAContext alloc] init];
        NSError *error;
    //    // For a passcode authentication , when biometric fails, use: LAPolicyDeviceOwnerAuthentication
        if ([laContext canEvaluatePolicy: LAPolicyDeviceOwnerAuthentication error:&error]) {
        if ([laContext canEvaluatePolicy: LAPolicyDeviceOwnerAuthentication error:&error]) {
            if (error != NULL) {
                // handle error
            } else {

                if (@available(iOS 11, *)) {
                    if (laContext.biometryType == LABiometryTypeFaceID) {
                        //localizedReason = "Unlock using Face ID"
                        NSLog(@"FaceId support");
                    } else if (laContext.biometryType == LABiometryTypeTouchID) {
                        //localizedReason = "Unlock using Touch ID"
                        NSLog(@"TouchId support");
                    } else {
                        //localizedReason = "Unlock using Application Passcode"
                        NSLog(@"No biometric support or Denied biometric support");
                    }
                } else {
                    // Fallback on earlier versions
                }


                [laContext evaluatePolicy: LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Test Reason" reply:^(BOOL success, NSError * _Nullable error) {

                    if (error != NULL) {
                        // handle error
                    } else if (success) {
                        // handle success response
                    } else {
                        // handle false response
                    }
                }];
            }
        }
        }
}
     
#pragma mark -
#pragma mark -------------------- private actions --------------------
// 开始验证按钮点击事件
- (IBAction)didClickBtnCheck:(id)sender {
    NSString *myLocalizedReasonString = @"验证";
    
    [self.LAContent evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:myLocalizedReasonString reply:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            NSLog(@"身份验证成功！");
            [self showAlertView:@"验证成功"];
        } else {
            // 做特定的错误判断处理逻辑。
            NSLog(@"身份验证失败！ \nerrorCode : %ld, errorMsg : %@",(long)error.code, error.localizedDescription);
            // error 参考 LAError.h
            [self showAlertView:[NSString stringWithFormat:@"身份验证失败！\nerrCode : %ld\nerrorMsg : %@",(long)error.code, error.localizedDescription]];
        }
    }];
}
 
// 弹框
- (void)showAlertView:(NSString *)msg
{
    NSLog(@"%@",msg);
    if (@available(iOS 8.0, *)) {
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        // Fallback on earlier versions
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
