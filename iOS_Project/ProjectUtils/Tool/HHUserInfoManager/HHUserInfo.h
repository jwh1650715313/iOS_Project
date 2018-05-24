//
//  HHUserInfo.h
//  iOS_Project
//
//  Created by 景文浩 on 2018/3/26.
//  Copyright © 2018年 景文浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHUserInfo : NSObject


//appId
@property (strong, nonatomic) NSString *appUserId;

//姓名
@property (strong, nonatomic) NSString *name;

//手机号
@property (strong, nonatomic) NSString *phone;

//身份证
@property (strong, nonatomic) NSString *idCard;

//头像
@property (strong, nonatomic) NSString *photo;

//实时地址
@property (strong, nonatomic) NSString *livingAddress;

//省
@property (strong, nonatomic) NSString *province;

//市
@property (strong, nonatomic) NSString *city;

//区
@property (strong, nonatomic) NSString *country;

//是否上传身份证
@property (strong, nonatomic) NSString *isCheckedIdCard;

//是否上传驾驶证
@property (strong, nonatomic) NSString *isCheckedDrivingLicense;

//是否人脸识别
@property (strong, nonatomic) NSString *isCheckedFace;

//运营商授权
@property (strong, nonatomic) NSString *operatorCredit;


//银行授权
@property (strong, nonatomic) NSString *bankCredit;


//芝麻信用
@property (strong, nonatomic) NSString *zhimaCredit;


//是否启用
@property (strong, nonatomic) NSString *enabled;

//创建时间
@property (strong, nonatomic) NSString *createTime;


//创建用户
@property (strong, nonatomic) NSString *createUser;

//更新时间
@property (strong, nonatomic) NSString *updateTime;

//更新用户
@property (strong, nonatomic) NSString *updateUser;

//是否设置交易密码
@property (strong, nonatomic) NSString *isSetTranPassword;


//还款银行卡号
@property (strong, nonatomic) NSString *repayBankCardNo;

//还款银行编码
@property (strong, nonatomic) NSString *repayBankCode;

//还款银行
@property (strong, nonatomic) NSString *repayBankName;

//驾驶证反面
@property (strong, nonatomic) NSString *driverBack;

//驾驶证正面
@property (strong, nonatomic) NSString *driverFront;

//身份证反面
@property (strong, nonatomic) NSString *idCardBack;

//身份证正面
@property (strong, nonatomic) NSString *idCardFront;


@end
