//
//  LoginNewTool.m
//  YiLianGang
//
//  Created by 编程 on 2017/11/27.
//  Copyright © 2017年 Way_Lone. All rights reserved.
//

#import "LoginNewTool.h"
#import "AFNetworking.h"
#import "NSString+JSON.h"

static LoginNewTool *loginNewTool;

@interface LoginNewTool()

@property (nonatomic, copy)LoginNewFinishBlock block;

@end

@implementation LoginNewTool


+(instancetype)sharedLoginNewTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginNewTool = [LoginNewTool new];
    });
    return loginNewTool;
}

-(void)sendGetVerificationCodeRequestWithResponse:(LoginNewFinishBlock)block
{
    self.block = block;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSString *requestUrl = [HTTP_HOST stringByAppendingString:self.urlString];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json", nil];;
    [manager GET:requestUrl parameters:self.parameterDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"json:%@",responseObject);
        NSDictionary *dict = responseObject;
        NSLog(@"结果:%@",[responseObject objectForKey:@"result"]);
        self.block(dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure--%@",error);
    }];
}

-(void)sendLoginNewRequestWithResponse:(LoginNewFinishBlock)block
{
    self.block = block;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *requestUrl = [HTTP_HOST stringByAppendingString:self.urlString];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json", nil];;
    [manager GET:requestUrl parameters:self.parameterDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"json:%@",responseObject);
        NSDictionary *dict = responseObject;
        NSLog(@"结果:%@",[responseObject objectForKey:@"result"]);
        [self.delegate loginNewToolDidLogin:YES withDict:dict];
        self.block(dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure--%@",error);
    }];
}

-(void)setUserIDWithOriginDict:(NSDictionary *)dict{
    NSDictionary *userIdDict;
    if([(dict[@"msg"]) isKindOfClass:[NSDictionary class]]){
        userIdDict = dict[@"msg"];
    }else{
        NSString *str =dict[@"msg"];
        userIdDict = [NSString parseJSONStringToNSDictionary:str] ;
        
    }
    [LoginNewTool sharedLoginNewTool].userTel =[NSString stringWithFormat:@"%@",userIdDict[@"mobile"]];
    [LoginNewTool sharedLoginNewTool].userID =[NSString stringWithFormat:@"%@",userIdDict[@"uuid"]];
    [LoginNewTool sharedLoginNewTool].userName =[NSString stringWithFormat:@"%@",userIdDict[@"name"]];
    [LoginNewTool sharedLoginNewTool].houseId = [NSString stringWithFormat:@"%@",userIdDict[@"houseId"]];;
}



@end
