//
//  AddEmployeeViewController.m
//  EmployeeCoreData
//
//  Created by Jon Smith on 8/6/15.
//  Copyright (c) 2015 Jon Smith. All rights reserved.
//

#import "AddEmployeeViewController.h"

@interface AddEmployeeViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *addFirstNameField;
@property (strong, nonatomic) IBOutlet UITextField *addLastNameField;
@property (strong, nonatomic) IBOutlet UITextField *addDOBField;
@property (strong, nonatomic) IBOutlet UITextField *addSSNField;
@property (strong, nonatomic) IBOutlet UITextField *addDepartmentField;
@property (strong, nonatomic) IBOutlet UITextField *addSalaryField;

@end

@implementation AddEmployeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _addFirstNameField.delegate = self;
    _addLastNameField.delegate = self;
    _addDOBField.delegate = self;
    _addSSNField.delegate = self;
    _addDepartmentField.delegate = self;
    _addSalaryField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// UITextFieldDelegate method that is called when the return key is pressed on the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Dismiss the keyboard
    [textField resignFirstResponder];
    
    return YES;
}

-(Employee *)createEmployeeWithValues
{
    // Create an NSEntityDescription with the name Employee and the managed object context.
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:_managedObjectContext];
    
    // Initialize a state instance with the entity description and insert it into the managed object context.
    Employee *employeeToAdd = [[Employee alloc]initWithEntity:description insertIntoManagedObjectContext:_managedObjectContext];
    
    // Assign the text of the text fields to the instance variables of the state object
    employeeToAdd.firstName = _addFirstNameField.text;
    employeeToAdd.lastName = _addLastNameField.text;
    employeeToAdd.dob = _addDOBField.text;
    int empSSN = [_addSSNField.text intValue];
    employeeToAdd.ssn = [NSNumber numberWithInt:empSSN];
    employeeToAdd.department = _addDepartmentField.text;
    int empSalary = [_addSalaryField.text intValue];
    employeeToAdd.salary = [NSNumber numberWithInt:empSalary];
    
    return employeeToAdd;
}
- (IBAction)addEmployeePressed:(id)sender
{
    // Assign the state that's returned from the createStateWithValues to an instance of State.
    Employee *employee = [self createEmployeeWithValues];
    
    // Call the addState method and pass in the state object.
    [_delegate addEmployee:employee];
    
    // Pop the view controller off the stack.
    [self.navigationController popViewControllerAnimated:YES];
}

@end
