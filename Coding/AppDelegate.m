//
//  AppDelegate.m
//  Coding
//
//  Created by 安宁 on 2017/6/30.
//  Copyright © 2017年 安宁. All rights reserved.
//

#import "AppDelegate.h"
#import "DataModel.h"
#import "HZBTextModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    NSLog(@"%@",NSHomeDirectory());
    
    DataModel * model = [[DataModel alloc]init];
//    model.str = @"12345" ;
    
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:model];
//    [[NSUserDefaults standardUserDefaults]setValue:@"11" forKey:@"data"];
    
    data = [[NSUserDefaults standardUserDefaults]objectForKey:@"data"];
    
//    model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    
    
    return YES;
}




@end
