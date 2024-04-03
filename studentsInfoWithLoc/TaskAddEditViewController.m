//
//  StudentAddViewController.m
//  studentsInfoWithLoc
//
//  Created by Ramez Hamdi Saeed on 31/03/2024.
//

#import "TaskAddEditViewController.h"
#import "Constants.h"


@interface TaskAddEditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleValue;
@property (weak, nonatomic) IBOutlet UITextField *detailsValue;
@property (weak, nonatomic) IBOutlet UISegmentedControl *periorityValue;
@property (weak, nonatomic) IBOutlet UISegmentedControl *statusValue;
@property (weak, nonatomic) IBOutlet UIButton *addUpdateButton;

@property TaskPONSO *taskToBeAdded,*updatedTask;
@property NSMutableArray *tasks;


@end
// NSString *DONE = @"DONE";
// NSString *INPROGRESS = @"INPROGRESS";
@implementation TaskAddEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tasks=[NSMutableArray new];

    if(_taskToBeUpdated==nil){
        _taskToBeAdded=[TaskPONSO new];
        _taskToBeAdded.status=@"L";
        _taskToBeAdded.isInProgress=YES;
    }
    else{
        _addUpdateButton.titleLabel.text=@"Update";
        _titleValue.text=_taskToBeUpdated.title;
        _detailsValue.text=_taskToBeUpdated.details;

        
        if([_taskToBeUpdated.status isEqual:@"L"]){
            _periorityValue.selectedSegmentIndex=0;
        }
        else if([_taskToBeUpdated.status isEqual:@"M"]){
            _periorityValue.selectedSegmentIndex=1;
        }
        else if([_taskToBeUpdated.status isEqual:@"H"]){
            _periorityValue.selectedSegmentIndex=2;
        }
        
        if(_taskToBeUpdated.isInProgress){
            _statusValue.selectedSegmentIndex=0;
        }
        else{
            _statusValue.selectedSegmentIndex=1;
            _statusValue.enabled=NO;

        }

        _updatedTask=[TaskPONSO new];
        _updatedTask.title=_taskToBeUpdated.title;
        _updatedTask.status=_taskToBeUpdated.status;
        _updatedTask.isInProgress=_taskToBeUpdated.isInProgress;
        _updatedTask.details=_taskToBeUpdated.details;
        _updatedTask.periority=_taskToBeUpdated.periority;



        

        
        

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
//- (IBAction)addStudent:(id)sender {
//    TaskPONSO *studentTemp=[TaskPONSO new];
//    studentTemp.title=self.nameValue.text;
//
////    self.taskTableViewInstance.taskToBeAdded= studentTemp;
//
//    [self.navigationController popViewControllerAnimated:YES];
//
//}
- (IBAction)setStatus:(id)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:{
            //low
            if(_taskToBeUpdated!=nil){

                self.updatedTask.status=@"L";

            }
            else{
                self.taskToBeAdded.status=@"L";

            }
            break;
        }
        case 1:{
            //medium
            if(_taskToBeUpdated!=nil){
                self.updatedTask.status=@"M";

            }
            else{
                self.taskToBeAdded.status=@"M";
            }
            break;
        }
        case 2:{
            //high
            if(_taskToBeUpdated!=nil){
                self.updatedTask.status=@"H";

            }
            else{
                self.taskToBeAdded.status=@"H";
            }
            break;
        }
    }
}
- (IBAction)setIsInProgress:(id)sender {
    switch ([sender selectedSegmentIndex]) {
            
        case 0:{
            //InProgress
            if(_taskToBeUpdated!=nil){
                self.updatedTask.isInProgress=YES;

            }
            else{
                self.taskToBeAdded.isInProgress=YES;
            }
            break;
        }
        case 1:{
            //done
            if(_taskToBeUpdated!=nil){
                self.updatedTask.isInProgress=NO;

            }else{
                self.taskToBeAdded.isInProgress=NO;
            }
            break;
        }
            
    }
}
- (IBAction)insertTask:(id)sender {
    //insert here
    if(_taskToBeUpdated==nil){
        self.taskToBeAdded.title=_titleValue.text;
        self.taskToBeAdded.details=_detailsValue.text;
        
        _tasks=[self getTasksWithNewTask:(self.taskToBeAdded.isInProgress)?@"INPROGRESS":@"DONE"];
        if(_tasks==nil){
            _tasks=[NSMutableArray new];
        }
        [_tasks addObject:_taskToBeAdded];

        [self saveTasksWithNewTask:_tasks :(self.taskToBeAdded.isInProgress)?@"INPROGRESS":@"DONE"];
    }
    else{
        
        _tasks=[self getTasksWithNewTask:(self.taskToBeUpdated.isInProgress)?@"INPROGRESS":@"DONE"];
        for(int i=0;i<_tasks.count;i++){
            TaskPONSO *currentTask=[TaskPONSO new];
            currentTask=[_tasks objectAtIndex:i];
            if(currentTask.title == _taskToBeUpdated.title){
                [_tasks removeObjectAtIndex:i];

            }
        }

        self.updatedTask.title=_titleValue.text;
        self.updatedTask.details=_detailsValue.text;
        
        if(_tasks==nil){
            _tasks=[NSMutableArray new];
        }
        [_tasks addObject:_updatedTask];

        [self saveTasksWithNewTask:_tasks :(self.taskToBeAdded.isInProgress)?@"INPROGRESS":@"DONE"];
        
        
    }


    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) saveTasksWithNewTask:(NSMutableArray *)tasksToBeSaved :(NSString*)status{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tasksToBeSaved];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:status];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
-(NSMutableArray*) getTasksWithNewTask :(NSString*)status{
    NSData *savedData = [[NSUserDefaults standardUserDefaults] objectForKey:status];
    NSMutableArray<TaskPONSO *> *retrievedTasksArray = [NSKeyedUnarchiver unarchiveObjectWithData:savedData];
    return retrievedTasksArray;

}

@end
