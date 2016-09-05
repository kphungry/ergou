//
//  EGEditViewController.m
//  MealRecord
//
//  Created by 周文杰 on 16/9/3.
//  Copyright © 2016年 com.ergou. All rights reserved.
//

#import "EGEditViewController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface EGEditViewController (){
    UITextField *_weekdayField;
    UITextField *_restuarantField;
//    UIDatePicker *_picker;
}

@end

@implementation EGEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done:) ];
    
    _weekdayField = [[UITextField alloc]initWithFrame:CGRectMake(50, 64 + 50 , SCREEN_WIDTH - 100, 50)];
    _weekdayField.placeholder = @"周几的哪顿饭呢？";
    _weekdayField.delegate = self;
    _weekdayField.layer.borderWidth = 1;
    _weekdayField.layer.borderColor = [UIColor blackColor].CGColor;
    _weekdayField.layer.cornerRadius = 5;
    [self.view addSubview:_weekdayField];
 
    _restuarantField = [[UITextField alloc]initWithFrame:CGRectMake(50, 64 + 150 , SCREEN_WIDTH - 100, 50)];
    _restuarantField.delegate = self;
    _restuarantField.placeholder = @"哪家餐馆呢？";
    _restuarantField.layer.borderWidth = 1;
    _restuarantField.layer.borderColor = [UIColor blackColor].CGColor;
    _restuarantField.layer.cornerRadius = 5;
    [self.view addSubview:_restuarantField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - **UITextFieldDelegate**
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == _weekdayField) {
//        [self showDatePicker ];
        return YES;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}

- (IBAction)done:(id)sender{
    self.weekDay = _weekdayField.text;
    self.restaurant = _restuarantField.text;

    [self.navigationController popViewControllerAnimated:YES ];
    if (self.onFinish) {
        self.onFinish(self.weekDay,self.restaurant);
    }
}

//- (void)showDatePicker{
//    picker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 270, SCREEN_WIDTH, 270)];
//    picker.datePickerMode = UIDatePickerModeDate;
//    [self.view addSubview:picker];
//}

@end
