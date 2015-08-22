//
//  EmployeeDetailViewController.m
//  EmployeeCoreData
//
//  Created by Jon Smith on 8/6/15.
//  Copyright (c) 2015 Jon Smith. All rights reserved.
//

#import "EmployeeDetailViewController.h"
#import "EditEmployeeViewController.h"
#import "AppDelegate.h"

@interface EmployeeDetailViewController ()<EditEmployeeDelegate>

@property (strong, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dobLabel;
@property (strong, nonatomic) IBOutlet UILabel *ssnLabel;
@property (strong, nonatomic) IBOutlet UILabel *departmentLabel;
@property (strong, nonatomic) IBOutlet UILabel *salaryLabel;


@end

@implementation EmployeeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _firstNameLabel.text = _passedEmployee.firstName;
    _lastNameLabel.text = _passedEmployee.lastName;
    _dobLabel.text = _passedEmployee.dob;
    _ssnLabel.text = [_passedEmployee.ssn stringValue];
    _departmentLabel.text = _passedEmployee.department;
    int salary = [_passedEmployee.salary intValue];
    NSString *salaryString = [NSString stringWithFormat:@"%i", salary];
    _salaryLabel.text = salaryString;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method to save to Core Data
-(void)save
{
    // Create an object of type NSError.
    NSError *error = nil;
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    // Test if the object has been saved successfully.
    if ([context save:&error]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Success" message:@"The new employee list has been saved." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else {
        NSString *errorString = [NSString stringWithFormat:@"%@", error];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }
}

-(void)editEmployee:(Employee *)employee
{

    self.title = employee.firstName;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.destinationViewController isKindOfClass:[EditEmployeeViewController class]])
    {
        EditEmployeeViewController *eevc = (EditEmployeeViewController *)segue.destinationViewController;
        eevc.employeeToEdit = _passedEmployee;
        eevc.delegate = self;
    }
}
- (IBAction)editEmployeePressed:(id)sender
{
    
}

@end
