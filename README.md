# 引言
- APP采用object-c纯代码开发，未使用故事面板(storyboard)，个别view采用xib（自定义cell可以是xib）。原因是：[传送门](http://blog.devtang.com/2015/03/22/ios-dev-controversy-2/)

- 布局我们采用Masonry布局。Masonry是一个轻量级的布局框架 拥有自己的描述语法 采用更优雅的链式语法封装自动布局 简洁明了 并具有高可读性 。非常简单的使用纯代码实现autoLayout布局，是目前非常流行的手工布局框架  [传送门](https://github.com/SnapKit/Masonry)

- 使用MVC的设计模式,显示模块与功能模块的分离。提高了程序的可维护性、可移植性、可扩展性与可重用性，降低了程序的开发难度。它主要分模型、视图、控制器三层

- 使用AFNetworking为网络请求引擎，目前被95%以上的app所采用。 [传送门](https://github.com/AFNetworking)

- 使用cocoapods进行库的统一管理，使用方便，清晰明了(前期我一个人阔以不要)。[传送门](http://blog.csdn.net/wzzvictory/article/details/18737437)

# 项目版本管理
使用git管理代码,便于团队开发！

# 开发环境
操作系统：Mac os
开发软件：Xcode8.0
手机系统：iOS8.0~iOS10.3.3

# 安全策略
在涉及个人帐户信息有关网络请求，采用https方式，通过非对称密钥对请求串加解密,加密方式（MD5、AES ） 

# 框架目录结构
![项目目录.png](http://upload-images.jianshu.io/upload_images/1818626-9ba3007720ab58b6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

# 工具箱
![工具箱.png](http://upload-images.jianshu.io/upload_images/1818626-38593fbf65879e95.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

工具箱：开发中用到的常用工具，让开发者的开发更加简易
- XLBMacro：宏定义字段和方法、公用枚举
- XLBCTool（工具类）：loading框、浏览器、轮播图、扫码、自定义视图控件、常用方法工具类、定位、获取相册及相机、弹出菜单、第三方分享二次封装
- XLBFoundation：Foundation类别
- XLBUIKit：YNCUIKit类别

# 基类（XLBBase）

##### 基类继承关系图
![XLBBase.png](http://upload-images.jianshu.io/upload_images/1818626-1a8301bbf41d5281.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##### 项目基类列表

- ViewControllers
  -  BaseViewController：所有控制器基类
  -  BaseTabBarController：标签控制器基类
  -  ListViewController：下拉刷新，上拉加载基类
  -  WebViewController : 加载H5页面基类
- BaseModel（ 所有model的基类）
- Views
    -  BaseView：所有view的基类
    -  BaseTableViewCell：所有自定义Cell基类

##### 项目基类列表
   - BaseViewController
  <pre>
      －属性：
  －控制器推出类型
  －自定义导航条
  －导航条左侧按钮
  －导航条右侧按钮
  －导航条左侧按钮样式
－方法：
  －显示重新加载视图
  －隐藏重新加载视图
  －没有网时，点击重新加载按钮(重新方法)
  －有网时的处理(重新方法)
  －无网络时的处理(重新方法)
  －创建没有数据时的视图
  －隐藏没有数据时的视图
  －设置导航条背景颜色
  －设置导航标题
  －导航条左侧按钮点击事件（重写方法）
  －导航条右侧按钮点击事件（重写方法）
  －推出模态视图
 －返回模态视图
  －推出导航视图
  －返回导航视图
  －返回到导航根视图
  </pre>

- BaseViewModel

  -  BaseModel.h
<pre>#import <Foundation/Foundation.h>
@interface BaseModel : NSObject <NSCoding>
@end</pre>

 -  BaseModel.mm
<pre>#import "BaseModel.h <br>#import <objc/runtime.h><br>#import <objc/message.h>
@implementation BaseModel
-(void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int outCount = 0;
    Ivar *vars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i ++) {
        Ivar var = vars[i];
        const char *name = ivar_getName(var);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        if (value) {
            [aCoder encodeObject:value forKey:key];
        }
    }
}
-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int outCount = 0;
        Ivar *vars = class_copyIvarList([self class], &outCount);
        for (int i = 0; i < outCount; i ++) {
            Ivar var = vars[i];
            const char *name = ivar_getName(var);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            if (value) {
                [self setValue:value forKey:key];
            }
        }
    }
    return self;
}
@end
</pre>

# 网络请求 (XLBNetwork)
采用AFNetworking，目前被95%以上的app所采用，并进行了二次封装，加入了缓存策略。采用block进行回调，返回成功、请求异常、请求失败。

##### 项目基类列表
![XLBNetWork.png](http://upload-images.jianshu.io/upload_images/1818626-ac4e9a30db184461.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##### 使用工具
- AFnetworking网络框架
- SQLite数据库
- FMDB数据库操作工具

##### 示例代码
<pre> WEAKSELF
    [self showProgress];
    
    [BaseHttpRequstManager loginu_name:u_name u_passwd:u_passwd type:type listener:^(NSString *error, NSDictionary *resultDic) {
        
        if ([CommonUtils IsOkNSDictionary:resultDic]>0) {
            
            if ([resultDic[@"code"] isEqualToString:@"CSD000"]) {
                
                [weakSelf HttpLoginResponse:resultDic];
            }
            else{
            
                [weakSelf hideProgress];
                
                NSString  *error=resultDic[@"msg"];
                NSString  *code=resultDic[@"code"];
                [self checkRetCode:code str:error];
            }
            
        }
        else{
            
            [weakSelf hideProgress];
        }
        
        
    }];
</pre>

# 项目开发模块目录
![项目开发模块.png](http://upload-images.jianshu.io/upload_images/1818626-e71b6dfe2297178a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##### 业务模块开发
- 首页
- 我的页面
- 存管版（普通版）切换

##### 业务模块开发
- app启动：AppDelegate，启动广告，引导页，更新
- 登录注册
- 根视图控制器

# 开发模块设计模式
#####MVC 设计框架
- model：数据模型
- view：视图显示
- viewcontroller：视图控制器

##### 基本流程
Model请求并对数据进行处理，将处理后的模型数据传递给viewcontroller,viewcontroller拿到数据后控制view的显示。
MVC 设计模式,显示模块与功能模块的分离。提高了程序的可维护性、可移植性、可扩展性与可重用性，降低了程序的开发难度
![MVC模型图.png](http://upload-images.jianshu.io/upload_images/1818626-d36e7b9ad3f6e36b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

# 界面布局
使用Masnory工具，对Autolayerout和Size Classes的布局方式进行了封装，简单实用，节省了大量代码

# 数据存储方式

根据产品需要，数据从服务器下载和本地存储，本地数据分缓存和内存保留，经常读取的写入缓存，内存数据按大小，小的写入plist文件，大的写入数据库，用FMDB

地址信息：
plist文件写入。路径：（沙盒/Library/Caches）
用户数据本地化：
NSUserdefuat 本地存储。路径：（沙盒/Library/Preferences）
本地文件路径使用规范
1.Documents：
只有用户生成的文件、其他数据及其他程序不能重新创建的文件，应该保存在<Application_Home>/Documents 目录下面，并将通过iCloud自动备份。
2.Library：
可以重新下载或者重新生成的数据应该保存在 <Application_Home>/Library/Caches 目录下面。举个例子，比如杂志、新闻、地图应用使用的数据库缓存文件和可下载内容应该保存到这个文件夹。
3.tmp:
只是临时使用的数据应该保存到 <Application_Home>/tmp 文件夹。尽管 iCloud 不会备份这些文件，但在应用在使用完这些数据之后要注意随时删除，避免占用用户设备的空间

# 事件处理
有通知，代理和block(使用代理最多)

# 模型定义
使用MJExtension对请求数据进行model转化，是一套字典和模型之间互相转换的超轻量级框架，能对不同数据类型和不同数据结构进行处理。

# 网络图片加载
采用SDWebImage库进行处理，可以对图片进行异步加载并缓存

# 热补丁
ReactNative（跟王者荣耀一样）

# 支付功能
支付宝，微信,银行等支付功能严格按照文档开发,并做二次封装

# 地图
高德地图,百度地图（推荐使用百度,百度的定位准,开发简单）

# 代码规范

按照自己定制的代码开发规范进行开发，规范文档和代码要上传git，或者svn

# 统计
友盟统计,TalkingData
# 项目打包
通过蒲公英快速打包，生成二维码提供给出测试扫码下载

# 模块功能细分
由于整个APP都是我一个人做，我就是不细分了

# 总结
- 合理的命名规则，推荐使用Class prefix name就是Class的前缀名，使用前缀名能够一定程度的避免你的Class和其他Framework / Library中的内容重名，也能够让你在Import或使用Class的时候比较方便寻找
- 将一个大型Project其中的内容分组,不论Project的大小，我们都应该将View Controllers, Views, Objects, Frameworks, Resources,等等不同类型的文件，都按照他们的种类和具体用途进行了归类，这样在日后修改和添加内容时候都会同样的事半功倍
- 常用代码的封装
- 最后就是Comments（注释）的重要性

#### GitHub地址:  https://github.com/jwh1650715313/app_demo
