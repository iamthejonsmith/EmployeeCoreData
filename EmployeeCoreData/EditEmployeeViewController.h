//
//  EditEmployeeViewController.h
//  EmployeeCoreData
//
//  Created by Jon Smith on 8/6/15.
//  Copyright (c) 2015 Jon Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Employee.h"

@protocol EditEmployeeDelegate <NSObject>

-(void)save;
-(void)editEmployee:(Employee *)employee;

@end

@interface EditEmployeeViewController : UIViewController

@property (weak, nonatomic) id <EditEmployeeDelegate> delegate;

@property (strong, nonatomic) Employee *employeeToEdit;

@end
