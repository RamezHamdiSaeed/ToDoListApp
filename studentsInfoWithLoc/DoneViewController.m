//
//  DoneViewController.m
//  studentsInfoWithLoc
//
//  Created by Ramez Hamdi Saeed on 02/04/2024.
//

#import "DoneViewController.h"
#import "TaskPONSO.h"
#import "TaskAddEditViewController.h"
#import "Constants.h"

@interface DoneViewController ()
{
NSMutableArray *currentTasks,*searchItems;
bool isSearchOperation;


}
-(NSMutableArray*) getTasks :(NSString*)status;
-(void) saveTasks:(NSArray *)tasksToBeSaved :(NSString*)status;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchKeyWord;
@property (weak, nonatomic) IBOutlet UILabel *noResultsFound;


@end

@implementation DoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    currentTasks=[NSMutableArray new];
    isSearchOperation=NO;

//    TaskPONSO *task1=[TaskPONSO new];
//    task1.title=@"task";
//    task1.status=@"L";
//    task1.details=@"asdf";//M or L
//    task1.isInProgress=YES;
//
//    TaskPONSO *task12=[TaskPONSO new];
//    task12.title=@"task12";
//    task12.status=@"H";
//    task12.details=@"asdf";//M or L
//    task12.isInProgress=YES;
//
//    [inProgressTasks addObject:task1];
//    [inProgressTasks addObject:task12];
//
//
//    doneTasks=[NSMutableArray new];
//
//    TaskPONSO *task2=[TaskPONSO new];
//    task2.title=@"task2";
//    task2.status=@"H";//M or L
//    task2.isInProgress=NO;
//    task2.details=@"asdf";//M or L
//
//
//    [doneTasks addObject:task2];
//
//    [self saveTasks:inProgressTasks:INPROGRESS];
//    [self saveTasks:doneTasks:DONE];

    currentTasks=[self getTasks:@"DONE"];
    
    [self.tableView reloadData];
    if(currentTasks.count!=0){
        _noResultsFound.hidden=YES;
    }
    else{
        _noResultsFound.hidden=NO;

    }
    
    
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return (isSearchOperation)?[searchItems count]:[currentTasks count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    TaskPONSO *taskTemp=[TaskPONSO new];
    taskTemp=(isSearchOperation)?[searchItems objectAtIndex:indexPath.row]:[currentTasks objectAtIndex:indexPath.row];
    UIImageView *priorityTemp=[cell viewWithTag:0];
    UILabel *taskNameTemp=[cell viewWithTag:1];

    taskNameTemp.text=taskTemp.title;

    priorityTemp.image=[UIImage imageNamed:taskTemp.status];

//    cell.accessoryType=UITableViewCellAccessoryDetailButton;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    TaskInfoViewController *studentInfovc=[self.storyboard instantiateViewControllerWithIdentifier:@"TaskInfoViewController"];
//    studentInfovc.taskToShow=(isSearchOperation)?[searchItems objectAtIndex:indexPath.row]:[currentTasks objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:studentInfovc animated:YES];
    
    TaskAddEditViewController *studentVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TaskAddViewController"];
//    studentVC.taskToBeUpdated=[];
    if(isSearchOperation){
       TaskPONSO *taskToBeUpdated= [searchItems objectAtIndex:indexPath.row];
        studentVC.taskToBeUpdated=taskToBeUpdated;
    }
    else{
        TaskPONSO *taskToBeUpdated= [currentTasks objectAtIndex:indexPath.row];
         studentVC.taskToBeUpdated=taskToBeUpdated;
    }
    [self.navigationController pushViewController:studentVC animated:YES];
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        if(isSearchOperation)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Do You Want To Delete The Task" preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                [searchItems removeObjectAtIndex:indexPath.row];
//                NSMutableArray *inProgress=[self getTasks:@"INPROGRESS"];
//                    for(TaskPONSO * taskToBeRemoved in inProgress){
//                        if([[searchItems objectAtIndex:indexPath.row] title] == taskToBeRemoved.title){
//                            [inProgress removeObject:taskToBeRemoved];
//                            currentTasks=inProgress;
//                            [self saveTasks:inProgress :@"INPROGRESS"];
//
//                        }
//                    }
                
                    NSMutableArray *done=[self getTasks:@"DONE"];
                    for(TaskPONSO * taskToBeRemoved in done){
                        if([[searchItems objectAtIndex:indexPath.row] title] == taskToBeRemoved.title){
                            [done removeObject:taskToBeRemoved];
                            currentTasks=done;
                            [self saveTasks:done :@"DONE"];


                        }
                    }
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

                
            }];

            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];

            [alertController addAction:okAction];
            [alertController addAction:cancelAction];

            [self presentViewController:alertController animated:YES completion:nil];
            

            
        }
        else{

 
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Do You Want To Delete The Task" preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                TaskPONSO *taskToBeDeletedTemp=[TaskPONSO new];
                taskToBeDeletedTemp=[currentTasks objectAtIndex:indexPath.row];
                [currentTasks removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [self saveTasks:currentTasks :@"DONE"];

 }];

            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];

            [alertController addAction:okAction];
            [alertController addAction:cancelAction];

            [self presentViewController:alertController animated:YES completion:nil];


        }

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) saveTasks:(NSMutableArray *)tasksToBeSaved :(NSString*)status{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tasksToBeSaved];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:status];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
-(NSMutableArray*) getTasks :(NSString*)status{
    NSData *savedData = [[NSUserDefaults standardUserDefaults] objectForKey:status];
    NSMutableArray<TaskPONSO *> *retrievedTasksArray = [NSKeyedUnarchiver unarchiveObjectWithData:savedData];
    return retrievedTasksArray;

}

- (IBAction)search:(id)sender {
    searchItems=[self getTasks:@"DONE"];
    isSearchOperation=YES;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@", _searchKeyWord.text];
    NSArray *temp = [searchItems filteredArrayUsingPredicate:predicate];
    searchItems=[NSMutableArray arrayWithArray:temp];
    if(searchItems.count!=0){
        _noResultsFound.hidden=YES;
    }
    else{
        _noResultsFound.hidden=NO;

    }
    [self.tableView reloadData];
}
- (IBAction)isInProgressValue:(id)sender {
    currentTasks=[self getTasks:@"DONE"];
    isSearchOperation=NO;

    switch ([sender selectedSegmentIndex]) {
        case 0:{
            //Low
            
            NSPredicate *predicate =
            [NSPredicate predicateWithFormat:@"status CONTAINS[cd] %@", @"L"];
            NSArray *temp = [currentTasks filteredArrayUsingPredicate:predicate];
            currentTasks=[NSMutableArray arrayWithArray:temp];
            [self.tableView reloadData];
            
            break;}
            
        case 1:{
            //   Medium
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"status CONTAINS[cd] %@", @"M"];
            NSArray *temp = [currentTasks filteredArrayUsingPredicate:predicate];
            currentTasks=[NSMutableArray arrayWithArray:temp];
            [self.tableView reloadData];
            break;}
            
        default:{
            //High
            NSPredicate *predicate =
            [NSPredicate predicateWithFormat:@"status CONTAINS[cd] %@", @"H"];
            NSArray *temp = [currentTasks filteredArrayUsingPredicate:predicate];
            currentTasks=[NSMutableArray arrayWithArray:temp];
            [self.tableView reloadData];
            break;
        }

            
    }
    if(currentTasks.count!=0){
        _noResultsFound.hidden=YES;
    }
    else{
        _noResultsFound.hidden=NO;

    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)addTask:(id)sender {
    TaskAddEditViewController *studentVC=[self.storyboard instantiateViewControllerWithIdentifier:@"TaskAddViewController"];
//    studentVC.taskToBeUpdated=self;
    [self.navigationController pushViewController:studentVC animated:YES];
}
@end
