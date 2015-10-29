//
//  InfoViewController.m
//  InformationSystem
//
//  Created by Hongjin Su on 10/9/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import "InfoViewController.h"
//#import <QuartzCore/QuartzCore.h> // To change the shape of button_department

@interface InfoViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *text_fullName;
@property (weak, nonatomic) IBOutlet UITextField *text_location;
@property (weak, nonatomic) IBOutlet UITextField *text_reason;
@property (weak, nonatomic) IBOutlet UITextField *text_remarks;
@property (weak, nonatomic) IBOutlet UITextField *text_timeLate;
// Submit button and its action
@property (weak, nonatomic) IBOutlet UIButton *button_submit;
- (IBAction)ButtonAction:(id)sender;
// Department pickerview-in-actionsheet button and its action
@property (weak, nonatomic) IBOutlet UIButton *button_department;
- (IBAction)DepartmentButtonAction:(id)sender;

@end
// Department pickerview data
NSArray *departments;

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _button_submit.enabled = NO;
    
    // To make the button as round rectangular
    _button_department.layer.cornerRadius = 4;
    
    // To set the button text
    [_button_department setTitle:@" Choose a Department" forState:UIControlStateNormal];
    
    // Department pickerview data
    departments = @[@"Labor", @"Education", @"Finance", @"Revenue", @"Motor Vehicles", @"Workforce Services"];
    // Do any additional setup after loading the view.
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

- (IBAction)ButtonAction:(id)sender {
    // To delete all the spaces
    NSString *string_fullName = [_text_fullName.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *string_location = [_text_location.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *string_reason = [_text_reason.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *string_remarks = [_text_remarks.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    // To check if anyone is empty
    if ([string_fullName isEqualToString:@""] || [string_location isEqualToString:@""] || [string_reason isEqualToString:@""] || [string_remarks isEqualToString:@""] || [_text_timeLate.text isEqualToString:@""] || [_button_department.titleLabel.text isEqualToString:@" Choose a Department"]) {
        
        UIAlertController *alertCont =[UIAlertController alertControllerWithTitle:@"Warning!" message:@"Information Should Not Be Empty." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okButton =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        [alertCont addAction:okButton];
        
        [self presentViewController:alertCont animated:YES completion:nil];
    }
}

#pragma mark UITextFeild Delegate Methods
//return the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    // To check if the text field is empty
    NSString *stringT = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (![stringT isEqualToString:@""]) {
        // To check the time
        if ([textField isEqual:_text_timeLate]) {
            NSString *stringTL = _text_timeLate.text;
            if (!(stringTL.length<5)) {
                // To check the time slot one digit by one digit
                NSString *stringH1 =[stringTL substringWithRange:NSMakeRange(0, 1)];
                NSString *stringH2 =[stringTL substringWithRange:NSMakeRange(1, 1)];
                NSString *stringS =[stringTL substringWithRange:NSMakeRange(2, 1)];
                NSString *stringM1 =[stringTL substringWithRange:NSMakeRange(3, 1)];
                NSString *stringM2 =[stringTL substringWithRange:NSMakeRange(4, 1)];
                NSString *stringH =[stringTL substringWithRange:NSMakeRange(0, 2)];
                NSString *stringM =[stringTL substringWithRange:NSMakeRange(3, 2)];
                
                int intH1 = [stringH1 intValue];
                int intH2 = [stringH2 intValue];
                int intM1 = [stringM1 intValue];
                int intM2 = [stringM2 intValue];
                int intH = [stringH intValue];
                int intM = [stringM intValue];
                
                if (!((intH1 < 3) && (intH2 < 10) && (intH < 24))) {
                    //Alert
                    [self displayAlert_ForInvaliedDate];
                }
                if (![stringS isEqualToString:@":"]) {
                    //alert
                    [self displayAlert_ForInvaliedDate];
                }
                if (!((intM1 < 7) && (intM2 < 10) && (intM < 60))) {
                    //alert
                    [self displayAlert_ForInvaliedDate];
                }
            }
            else {
                [self displayAlert_ForInvaliedDate];
            }
        }
        // To delete all the spaces and check if they are empty and enable the button ???
        NSString *string_fullName = [_text_fullName.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *string_location = [_text_location.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *string_reason = [_text_reason.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *string_remarks = [_text_remarks.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (!([string_fullName isEqualToString:@""] || [string_location isEqualToString:@""] || [string_reason isEqualToString:@""] || [string_remarks isEqualToString:@""] || [_text_timeLate.text isEqualToString:@""])) {
            _button_submit.enabled = YES;
        }
        return YES;
    }
    else {
        UIAlertController *alertCont =[UIAlertController alertControllerWithTitle:@"Warning!" message:@"Information Should Not Be Empty." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okButton =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        [alertCont addAction:okButton];
        
        [self presentViewController:alertCont animated:YES completion:nil];
        
        return NO;
    }
}

#pragma mark Touch Event Methods
// To touch the screen and resign the keyboard
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_text_fullName resignFirstResponder];
    [_button_department resignFirstResponder];
    [_text_location resignFirstResponder];
    [_text_reason resignFirstResponder];
    [_text_remarks resignFirstResponder];
    [_text_timeLate resignFirstResponder];
}

// The alert for the time slot
- (void)displayAlert_ForInvaliedDate
{
    UIAlertController *alertCont =[UIAlertController alertControllerWithTitle:@"Warning!" message:@"Please Enter the Time in the Correct Form" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alertCont addAction:okButton];
    
    [self presentViewController:alertCont animated:YES completion:nil];
}

// To process to the next screen
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"SubmitInfo"]) {
        [segue destinationViewController];
    }
}

#pragma the pickerview in actionsheet
// To create a alert controller when pressing the button
- (IBAction)DepartmentButtonAction:(id)sender {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n"
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"Done"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action)
    {
        //doDoneAction()
    }];
    
    
    UIPickerView *picker = [[UIPickerView alloc] init]; //WithFrame:CGRectMake(0, 6, 0, 0)
    
    picker.delegate = self;
    picker.dataSource = self;
    
    [picker setShowsSelectionIndicator:YES];
    [picker selectRow:0 inComponent:0 animated:YES];
    
    [alertController.view addSubview:picker];
    [alertController addAction:doneAction];
    [self.view bringSubviewToFront:picker];
    [self presentViewController:alertController animated:YES completion:nil];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return departments.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return departments[row];
}

// To set the button text as what you choose
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [_button_department setTitle: departments[row] forState:UIControlStateNormal];
}

@end
