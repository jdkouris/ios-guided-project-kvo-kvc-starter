//
//  ViewController.m
//  KVO KVC Demo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "LSIDepartment.h"
#import "LSIEmployee.h"
#import "LSIHRController.h"


@interface ViewController ()

@property (nonatomic) LSIHRController *hrController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    LSIDepartment *marketing = [[LSIDepartment alloc] init];
    marketing.name = @"Marketing";
    LSIEmployee * philSchiller = [[LSIEmployee alloc] init];
    philSchiller.name = @"Phil";
    philSchiller.jobTitle = @"VP of Marketing";
    philSchiller.salary = 10000000; 
    marketing.manager = philSchiller;

    
    LSIDepartment *engineering = [[LSIDepartment alloc] init];
    engineering.name = @"Engineering";
    LSIEmployee *craig = [[LSIEmployee alloc] init];
    craig.name = @"Craig";
    craig.salary = 9000000;
    craig.jobTitle = @"Head of Software";
    engineering.manager = craig;
    
    LSIEmployee *e1 = [[LSIEmployee alloc] init];
    e1.name = @"Chad";
    e1.jobTitle = @"Engineer";
    e1.salary = 200000;
    
    LSIEmployee *e2 = [[LSIEmployee alloc] init];
    e2.name = @"Lance";
    e2.jobTitle = @"Engineer";
    e2.salary = 250000;
    
    LSIEmployee *e3 = [[LSIEmployee alloc] init];
    e3.name = @"Joe";
    e3.jobTitle = @"Marketing Designer";
    e3.salary = 100000;
    
    [engineering addEmployee:e1];
    [engineering addEmployee:e2];
    [marketing addEmployee:e3];

    LSIHRController *controller = [[LSIHRController alloc] init];
    [controller addDepartment:engineering];
    [controller addDepartment:marketing];
    self.hrController = controller;
    
//    NSLog(@"%@", self.hrController);
    
    NSString *key = @"salary";
//    NSString *key = @"jobTitle";
//    NSString *key = @"name";
    
//    NSString *name = [craig name]; // craig.name
//    NSLog(@"name: %@", name);
    
    [craig setValue:@(42) forKey:key]; // using the @ to convert a primitive type to objc type
    
    NSString *value = [craig valueForKey:key];
    NSLog(@"value for key %@: %@", key, value);
    
//    @try {
//        NSString *key = @"firstName";
//
//        NSString *value = [craig valueForKey:key];
//        NSLog(@"value for key %@: %@", key, value);
//    } @catch (NSException *exception) {
//        NSLog(@"There was an exception");
//    }
    
//    LSIEmployee *employee = self.hrController.departments.lastObject.manager;
    NSArray *employees = [self.hrController valueForKeyPath:@"departments.@distinctUnionOfArrays.employees"];
    NSLog(@"employees1: %@", employees);
    
    NSArray *employees2 = [self.hrController valueForKeyPath:@"departments.employees"];
    NSLog(@"employees2: %@", employees2);
    
    NSArray *names = [self.hrController valueForKeyPath:@"departments.name"];
    NSLog(@"names: %@", names);
    
    NSLog(@"Salaries: %@", [employees valueForKeyPath:@"salary"]);
    NSLog(@"Avg Salary: %@", [employees valueForKeyPath:@"@avg.salary"]);
    NSLog(@"Salary Count: %@", [employees valueForKeyPath:@"@count.salary"]);
    NSLog(@"Max Salary: %@", [employees valueForKeyPath:@"@max.salary"]);
    
    [engineering setValue:@"John" forKeyPath:@"manager.name"];
    NSString *managersName = [engineering valueForKeyPath:@"manager.name"];
    NSLog(@"Manager's Name: %@", managersName);
}


@end
