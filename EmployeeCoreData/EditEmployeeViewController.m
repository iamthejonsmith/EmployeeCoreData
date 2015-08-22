//
//  EditEmployeeViewController.m
//  EmployeeCoreData
//
//  Created by Jon Smith on 8/6/15.
//  Copyright (c) 2015 Jon Smith. All rights reserved.
//

#import "EditEmployeeViewController.h"
#import "AppDelegate.h"

@interface EditEmployeeViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *editFirstNameField;
@property (strong, nonatomic) IBOutlet UITextField *editLastNameField;
@property (strong, nonatomic) IBOutlet UITextField *editDOBField;
@property (strong, nonatomic) IBOutlet UITextField *editSSNField;
@property (strong, nonatomic) IBOutlet UITextField *editDepartmentField;
@property (strong, nonatomic) IBOutlet UITextField *editSalaryField;


@end

@implementation EditEmployeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _editFirstNameField.delegate = self;
    _editLastNameField.delegate = self;
    _editDOBField.delegate = self;
    _editSSNField.delegate = self;
    _editDepartmentField.delegate = self;
    _editSalaryField.delegate = self;
    
    _editFirstNameField.text = _employeeToEdit.firstName;
    _editLastNameField.text = _employeeToEdit.lastName;
    _editDOBField.text = _employeeToEdit.dob;
    int empSSN = [_employeeToEdit.ssn intValue];
    _editSSNField.text = [NSString stringWithFormat:@"%i", empSSN];
    _editDepartmentField.text = _employeeToEdit.department;
    int empSalary = [_employeeToEdit.salary intValue];
    _editSalaryField.text = [NSString stringWithFormat:@"%i", empSalary];
}

// UITextFieldDelegate method that is called when the return key is pressed on the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Dismiss the keyboard
    [textField resignFirstResponder];
    
    return YES;
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

-(Employee *)createEmployeeWithValues
{
    _employeeToEdit.firstName = _editFirstNameField.text;
    _employeeToEdit.lastName = _editLastNameField.text;
    _employeeToEdit.dob = _editDOBField.text;
    int ssn = [_editSSNField.text intValue];
    _employeeToEdit.ssn = [NSNumber numberWithInt:ssn];
    _employeeToEdit.department = _editDepartmentField.text;
    int salary = [_editSalaryField.text intValue];
    _employeeToEdit.salary = [NSNumber numberWithInt:salary];
    
    return _employeeToEdit;
}
- (IBAction)saveEmployeePressed:(id)sender
{
    Employee *employee = [self createEmployeeWithValues];
    [_delegate editEmployee:employee];
    [self.delegate save];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
