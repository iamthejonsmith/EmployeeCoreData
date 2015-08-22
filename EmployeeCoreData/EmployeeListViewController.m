//
//  EmployeeListViewController.m
//  EmployeeCoreData
//
//  Created by Jon Smith on 8/6/15.
//  Copyright (c) 2015 Jon Smith. All rights reserved.
//

#import "EmployeeListViewController.h"
#import "AppDelegate.h"
#import "AddEmployeeViewController.h"
#import "EmployeeDetailViewController.h"
#import "Employee.h"

@interface EmployeeListViewController ()<UITableViewDelegate, UITableViewDataSource, AddEmployeeDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) NSArray *employees;

@end

@implementation EmployeeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create a pointer to the app delegate using UIApplication sharedApplication.
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    // Assign the app delegate's managedObjectContext to our managedObjectContext property. The managed object context of Core Data is a scratchpad where new managed objects are stored.
    _managedObjectContext = [delegate managedObjectContext];
    
    // Assign the array that is returned from the getAllStates method to our _states array.
    _employees = [self getAllEmployees];
}

-(void)viewWillAppear:(BOOL)animated
{
    _employees = [self getAllEmployees];
    [self.tableView reloadData];
}

-(NSArray *)getAllEmployees
{
    // Create an NSFetchRequest to fetch the data within the entities.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    // Create an NSEntityDescription with the entity name, State, and our managed object context.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:_managedObjectContext];
    
    // Set the entity of the fetch request.
    [fetchRequest setEntity:entity];
    
    // Create a sort descriptor and initialize it with the state name as this is what we will sort by. It will be sorted in ascending order
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"firstName" ascending:YES];
    
    // Create an array of sortDescriptors with our sortDescriptor object.
    NSArray *sortDescriptors = @[sortDescriptor];
    
    // Set the sort descriptors for your fetchRequest.
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    //execute fetch request
    NSArray *employeeArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    return employeeArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [_employees count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"EmployeeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    Employee *employeeAtIndex = _employees[indexPath.row];
    
    cell.textLabel.text = employeeAtIndex.firstName;
    
    cell.detailTextLabel.text = employeeAtIndex.department;
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Create an instance of employee and set it to the employee object at the index of the array.
        Employee *deletedEmployee = _employees[indexPath.row];
        
        // Delete the employee object from the managed object context.
        [self.managedObjectContext deleteObject:deletedEmployee];
        
        // Reset the _employee array.
        _employees = [self getAllEmployees];
        [self save];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - AddStateDelegate method
-(void)addEmployee:(Employee *)employee
{
    // Create a mutable copy of the _employees array and assign it to an instance of NSMutableArray called mutableEmployees.
    NSMutableArray *mutableEmployees = [_employees mutableCopy];
    
    // Add the state object to the mutable states array.
    [mutableEmployees addObject:employee];
    
    // Reset the _employees array.
    _employees = [self getAllEmployees];
    
    // Reload the tableView's data.
    [self.tableView reloadData];
    
    // Save the new array to Core Data.
    [self save];
}

#pragma mark - Method to save to Core Data
-(void)save
{
    // Create an object of type NSError.
    NSError *error = nil;
    
    // Test if the object has been saved successfully.
    if ([self.managedObjectContext save:&error]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Success" message:@"The new employee list has been saved." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }
    else {
        NSString *errorString = [NSString stringWithFormat:@"%@", error];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.destinationViewController isKindOfClass:[AddEmployeeViewController class]])
    {
        AddEmployeeViewController *asvc = (AddEmployeeViewController *)segue.destinationViewController;
        asvc.delegate = self;
        asvc.managedObjectContext = _managedObjectContext;
    }
    
    else if([segue.destinationViewController isKindOfClass:[EmployeeDetailViewController class]])
    {
        EmployeeDetailViewController *edvc = (EmployeeDetailViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Employee *selectedEmployee = _employees[indexPath.row];
        edvc.passedEmployee = selectedEmployee;
    }
}


@end

