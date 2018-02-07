//
//  AnnouncementTool.h
//  YongTai
//
//  Created by 张雨 on 2018/2/7.
//  Copyright © 2018年 Way_Lone. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^BLOCK) (NSString *city);

@interface AnnouncementInfo : NSObject


@end



@interface AnnouncementTool : NSObject

+(instancetype)sharedTool;

-(void)sendRequestToGetOKAListWithResponse:(BLOCK)block;



@end
