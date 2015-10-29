//
//  ViewController.m
//  InformationSystem
//
//  Created by Hongjin Su on 10/9/15.
//  Copyright © 2015 Hongjin Su. All rights reserved.
//

#import "ViewController.h"
#import "InfoViewController.h"

@interface ViewController () <UITextFieldDelegate> // To relate the text to the view controller

@property (weak, nonatomic) IBOutlet UITextField *text_UserName;
@property (weak, nonatomic) IBOutlet UITextField *text_Password;
@property (weak, nonatomic) IBOutlet UIButton *button_Login;

- (IBAction)ButtonAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _button_Login.enabled = NO;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ButtonAction:(id)sender {
    if (![_text_Password.text isEqualToString:_text_UserName.text]) {
            UIAlertController *alertCont =[UIAlertController alertControllerWithTitle:@"Warning!" message:@"Login Information Should Be The Same." preferredStyle:UIAlertControllerStyleAlert];
            
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
    if (![textField.text isEqualToString:@""]) {
        // To check if both textfield are filled
        if (!([_text_Password.text isEqualToString:@""] || [_text_UserName.text isEqualToString:@""])) {
            _button_Login.enabled = YES;
        }
        return YES;
    }
    else {
        UIAlertController *alertCont =[UIAlertController alertControllerWithTitle:@"Warning!" message:@"Login Information Should Not Be Empty." preferredStyle:UIAlertControllerStyleAlert];
    
        UIAlertAction *okButton =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
        [alertCont addAction:okButton];
    
        [self presentViewController:alertCont animated:YES completion:nil];
    
        return NO;
    }
}

// To resign the keyboard by touch the screen
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_text_UserName resignFirstResponder];
    [_text_Password resignFirstResponder];
}

// To process to the next screen
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
    //if ([[segue identifier]isEqualToString:@"LoginPass"]) {
        //[segue destinationViewController];
    //}
//}
@end
