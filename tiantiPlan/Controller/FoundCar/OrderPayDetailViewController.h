//
//  OrderPayDetailViewController.h
//  tiantiPlan
//
//  Created by liujianzhong on 16/6/20.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "BaseViewController.h"
//商户在爱贝注册的应用ID
static NSString *mOrderUtilsAppId = @"3005531625";

//渠道号
static NSString *mOrderUtilsChannel = @"2";

//支付结果后台回调地址
static NSString *mOrderUtilsNotifyurl = @"http://182.92.158.7/yungou/REST/orderCenter/payResult";

//商户验签公钥
static NSString *mOrderUtilsCheckResultKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDGPSpOsrVjkToNkbtNOOg1xY41RDwhb4QXU6ZHzzPilpiI9PovmoHWE+4iLee//1LBZbajK/Ayxvyx7MlZRBSGWfjHhONOan8FVBuQXKo+TJ9eAc7shcCEyq2g1QsxoQHw9sVICPtNMMJsrqoBi1hJKstVrKj0fREXYc2i5ls5CwIDAQAB";

//商户在爱贝注册的应用ID对应的应用私钥
static NSString *mOrderUtilsCpPrivateKey = @"MIICXgIBAAKBgQDHeNnCfCRZi7dlLW3Gd4F8Bf8P6HlduCi3vWnHgC9zmNnagkSCQppRZEzaUgUG5ntg+QRjPTJe6xPzhuMPKKmRJcPcDqVxhM68848lnWQWhZAKsQN2guF7ZgWGFoovrHkL6poNg2+vgZy/XJXT7BH6tc5R2iBG8s2sQgqyy5Mo2QIDAQABAoGBAJr6234PBBMKyd/zjvH/kfwxkH3kqr9VQVWY9iHKB5Qx8zmhsubeJpYMbuXFiiBVXRD4CR+twYAb93FjoPD7L9q1NwBdjgSjUplkSTliJPTsz+AsOMHzPwEK2eEdcysbRut7M8NZLPAwrsRItCI60LmuFMpxARYiFfg9sD92j0C9AkEA81o2VPoeIFYk7Lq0px74SeNNTVKZ99d2DM/0SWS/juikEHNjdR7NpYqBc0O4jqcU9gwSJemlSBJczezzYIOycwJBANHW0EfyvJkg/phdkg0/2U0Kg7jxsQJZY9pVVDoNctFuXXRYmHb1dWvheCYP36wszyk69CUyItrmiTUOw8XnyIMCQQDO7up+rkXJ95bkmwudhS9bHWeRlekJoPVohblUY9CkxF0nBAgSAwSafUIA8xhQbfHcHH2eMaVzuPGjxpdafgLTAkB91rsVSqZ7lmPX79VUiMPCBdo0oQysAft1xdI69jGzEuKMkUztmgoO5inteXuDf2PEsAwV+lkYuUPzQ6V4G6YNAkEA1RoHka0i6oF0Ce2Xw/72PYYnkRSZHnmgppjXRuZPkJWojf6RwCgW+lM3BuOTlJDyoLrLAztHheuQTSOFefituQ==";
@interface OrderPayDetailViewController : BaseViewController

@end
