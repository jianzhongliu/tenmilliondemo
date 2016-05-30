//
//  DSConfig.h
//  DistributionProject
//
//  Created by liujianzhong on 15/7/13.
//  Copyright © 2015年 T.E.N_. All rights reserved.
//

#ifndef DSConfig_h
#define DSConfig_h

#define APPNAME @"i-3laz"
#define DPSIGNATURE @"psmtoiyrpyqofhfo7atdofdby4eqc02p"//加密key
#define API_PhotoUpload @"http://upd1.ajkimg.com/upload"

#define DEBUG_slaz

#ifdef DEBUG_slaz
#define DPHOST @"http://1.tianti.applinzi.com/yungou/REST/"
//#define HOST @"http://182.92.158.7/Love/REST/"

//#define DPHOST @"http://liujianongdembp:8080/yungou/REST/"

//#define DPHOST @"http://api.51diansong.com/api"
//#define DPHOST @"http://192.168.0.90/api/v1"
#define UmengAppkey @"5741648ae0f55a68e7001dd5"

#define WeiXinAppID @"wx2429bb7fad250662"
#define WeiXinAppSecret @"84f23aa567fd48d2c05bf5409fa615f8"

#define HuanXinAppKey @"jobcube#ihelu"
#define HuanXinAppPushCer @"3laz_dev"

#define WeiBoKey @"227063147"
#define WeiBoAppSecret @"ee652d163490211ee06956ace711d5ba"

#define BaiduMapSdkKey @"RnoS3EoGVa011SoUtcEDP521"//正式版百度地图sdkkey

//#define BaiduMapSdkKey @"AbEs9RrT8XYLQGa2qtXrETIy"//企业版百度地图sdkkey

#else

#define NSLog(...) {}
#define DPHOST @"http://182.92.158.7/yungou/REST/"
#define UmengAppkey @"5741648ae0f55a68e7001dd5"
#define WeiXinAppID @"wx2429bb7fad250662"
#define WeiXinAppSecret @"84f23aa567fd48d2c05bf5409fa615f8"

#define HuanXinAppKey @"3laz#3laz"
#define HuanXinAppPushCer @"3laz_release"

#define WeiBoKey @"227063147"
#define WeiBoAppSecret @"ee652d163490211ee06956ace711d5ba"

//#define HuanXinAppPushCer @"3laz_dev"
#define BaiduMapSdkKey @"yea7ZsFb8vwD9Kl1xmxUOj7T"//正式版百度地图sdkkey
//#define BaiduMapSdkKey @"AbEs9RrT8XYLQGa2qtXrETIy"//企业版百度地图sdkkey
#endif

/**屏幕尺寸*/
#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
/**封装颜色*/
#define DSColorMake(r, g, b)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define DSColorAlphaMake(r, g, b, a)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define DSColorFromHex(rgb)     [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:1.0]
#define DSColorAlphaFromHex(rgb,a)     [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:a]
/**设置主题色*/
#define DSColor DSColorFromHex(0x0D94E5) //蓝色风格主题色调00ad88
#define DSNavi DSColorFromHex(0xEC633C) //navigation的颜色
#define DSRedColor DSColorFromHex(0xe36062)//红色风格主题色调
#define DSGrayColor DSColorFromHex(0x99999c)//灰色字体
#define DSGrayColor3 DSColorFromHex(0x333333)//灰色字体
#define DSGrayColor6 DSColorFromHex(0x666666)//灰色字体
#define DSGrayColor9 DSColorFromHex(0x999999)//灰色字体

#define DSBackColor DSColorFromHex(0xEFEFF4)//背景浅灰
#define DSBackLightColor DSColorFromHex(0xf4f4f4)//背景浅灰
#define DSLineSepratorColor DSColorFromHex(0xE5E9EC)//分割线颜色

#define DSBlackColor DSColorFromHex(0x333333)//浅黑色
/**判断系统版本*/
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define BigButtonTextFont 18  //大button的字号
#define CommonFont 15  //统一字体
#define InputCellHeight 60//所有输入框高度
#define cachePropertyPath @"uploadPropertyCache.archive"
#define FirstLoadAD @"firstLoadAD"//第一次加载广告

#define GlobalConfigInfo @"GlobalConfigInfo"//全局配置项本地缓存key
#define FilterConfigInfo @"FilterConfigInfo"//筛选项本地缓存key
#define SendPropertyToday @"SendPropertyToday"//存储自动给顾问发送的房源
#define LocalFoundsCar  @"LocalFoundsCar"//本地购物车数据

/**通知**/
#define DidReceiveNewMessage @"DidReceiveNewMessage"//收到新消息通知
#endif /* DSConfig_h */
