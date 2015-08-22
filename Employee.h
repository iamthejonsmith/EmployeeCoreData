//
//  Employee.h
//  EmployeeCoreData
//
//  Created by Jon Smith on 8/7/15.
//  Copyright (c) 2015 Jon Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Employee : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * dob;
@property (nonatomic, retain) NSNumber * ssn;
@property (nonatomic, retain) NSString * department;
@property (nonatomic, retain) NSNumber * salary;

@end
