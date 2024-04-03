//
//  TasksTable2ViewController.h
//  studentsInfoWithLoc
//
//  Created by Ramez Hamdi Saeed on 01/04/2024.
//

#import <UIKit/UIKit.h>
#import "TaskPONSO.h"

NS_ASSUME_NONNULL_BEGIN

@interface TasksTable2ViewController : UIViewController <UITableViewDataSource>
//@property TaskPONSO *taskToBeAdded;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
-(void) saveTasks:(NSArray *)tasksToBeSaved :(NSString*)status;
-(NSMutableArray*) getTasks :(NSString*)status;


@end

NS_ASSUME_NONNULL_END
