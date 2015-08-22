//
//  AddEmployeeViewController.h
//  EmployeeCoreData
//
//  Created by Jon Smith on 8/6/15.
//  Copyright (c) 2015 Jon Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Employee.h"

@protocol AddEmployeeDelegate <NSObject>

- (void)addEmployee:(Employee *)employee;

@end

@interface AddEmployeeViewController : UIViewController

@property (weak, nonatomic)id <AddEmployeeDelegate> delegate;

@property(strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

