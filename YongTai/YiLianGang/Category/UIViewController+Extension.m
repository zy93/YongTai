//
//  UIViewController+Extension.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/6/28.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import "UIViewController+Extension.h"
#import "UISearchBar+JCSearchBarPlaceholder.h"
#import "UIDevice+Resolutions.h"
#import "WOTUitls.h"

@implementation UIViewController(Extension) 
-(void)configNaviBackItem{
    if (self.navigationController.navigationBar.isHidden) {
        //如果nav隐藏，则加载一个button
        CGFloat  buff = [[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina58 ? 50: 20;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, buff, 50*[WOTUitls GetLengthAdaptRate], 30*[WOTUitls GetLengthAdaptRate])];
        [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    else {
        //否则加载baritem
        UIBarButtonItem *backitem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(goback)];
        
        [self.navigationItem.backBarButtonItem setBackButtonBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self.navigationItem setHidesBackButton:YES];
        [self.navigationItem setLeftBarButtonItem:backitem];
    }
}


-(void)configNaviView:(NSString *)searchTitle searchBlock:(searchBlock)block clearBlock:(clearSearchBlock)clearBlock
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, 30.0)];
    [bgView setBackgroundColor:[UIColor clearColor]];
    UISearchBar *searchview = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, bgView.frame.size.width-130, 30.0)];
    self.block = block;  //此处崩溃请检查目标VC里是否有这两个block定义。
    self.clearBlock = clearBlock;
    [searchview changeLeftPlaceholder:searchTitle];
    [searchview setBarTintColor:[UIColor grayColor]];
    [searchview setBarStyle:UIBarStyleBlackTranslucent];
    searchview.delegate = self;
    
    UIView *searchTextField = nil;
    
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    
    if (is7Version) {
       
        searchTextField = [[[searchview.subviews firstObject] subviews] lastObject];
       
    }else{// iOS6以下版本searchBar内部子视图的结构不一样
        for(UIView *subview in searchview.subviews)
        {
            if ([subview isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                searchTextField = subview;
                
            }
        }
    }
    searchTextField.backgroundColor = [UIColor grayColor];
    [bgView addSubview:searchview];
    
    UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
    [butt setFrame:CGRectMake(CGRectGetMaxX(searchview.frame)+10, 0, 50, 30)];
    [butt.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [butt setTitle:@"取消" forState:UIControlStateNormal];
    [butt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butt addTarget:self action:@selector(clearSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:butt];
    [self.navigationItem setTitleView:bgView];
    
}


-(void)configNaviRightItemWithImage:(UIImage *)image{
    UIButton *rightbtn = [[UIButton alloc]init];
    [rightbtn setFrame:CGRectMake(0,0,25,25)];
    [rightbtn setImage:image forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(rightItemAction) forControlEvents: UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightbtn];
    
}


-(void)configNaviRightItemWithTitle:(NSString *)title textColor:(UIColor *)textColor{
    UIButton *rightbtn = [[UIButton alloc]init];
    [rightbtn setFrame:CGRectMake(0,0,50,30)];
    [rightbtn setTitle:title forState:UIControlStateNormal];
    [rightbtn.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
    [rightbtn.titleLabel setTextAlignment:NSTextAlignmentRight];
    [rightbtn setTitleColor:textColor forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(rightItemAction) forControlEvents: UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightbtn];
    
}



-(void)goback{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)rightItemAction{
    //跳转页面
}

-(void)clearSearchBtn:(id)sender
{
    if (self.clearBlock) {
        self.clearBlock();
    }
}


#pragma mark - UISearchBar Delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (self.block) {
        self.block(searchText);
    }
}




@end
