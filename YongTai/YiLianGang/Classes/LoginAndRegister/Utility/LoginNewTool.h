//
//  LoginNewTool.h
//  YiLianGang
//
//  Created by 编程 on 2017/11/27.
//  Copyright © 2017年 Way_Lone. All rights reserved.
//

#import <Foundation/Foundation.h>
#define HTTP_HOST @"http://www.yiliangang.net:8012/"
typedef void (^LoginNewFinishBlock) (NSDictionary *dict);

@protocol LoginNewToolDelegate<NSObject>
-(void)loginNewToolDidLogin:(BOOL)isSuccess withDict:(NSDictionary*)dict;
@end

@interface LoginNewTool : NSObject

@property (nonatomic, strong) NSDictionary *parameterDict;
@property (nonatomic, strong) NSString *urlString;
@property(nonatomic,weak) id<LoginNewToolDelegate> delegate;
@property(nonatomic,strong) NSString *userTel;
@property(nonatomic,strong) NSString *userID;//userName
@property(nonatomic,strong) NSString *userName;
@property(nonatomic,strong) NSString *houseId;

+(instancetype)sharedLoginNewTool;

-(void)sendGetVerificationCodeRequestWithResponse:(LoginNewFinishBlock)block;

-(void)sendLoginNewRequestWithResponse:(LoginNewFinishBlock)block;

-(void)setUserIDWithOriginDict:(NSDictionary*)dict;

@end
