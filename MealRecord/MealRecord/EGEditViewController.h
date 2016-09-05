//
//  EGEditViewController.h
//  MealRecord
//
//  Created by 周文杰 on 16/9/3.
//  Copyright © 2016年 com.ergou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^twoStringBlock)(NSString*,NSString*);

@interface EGEditViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic,copy)NSString *restaurant;
@property (nonatomic,copy)NSString *weekDay;
@property (nonatomic,copy)twoStringBlock onFinish;

@end
