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

@property TaskPONSO *taskToBeAdded;
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
        _titleValue.text=_taskToBeUpdated.title;
        _detailsValue.text=_taskToBeUpdated.details;

        
        if(_taskToBeUpdated.status==@"L"){
            _periorityValue.selectedSegmentIndex=0;
        }
        else if(_taskToBeUpdated.status==@"M"){
            _periorityValue.selectedSegmentIndex=1;
        }
        else if(_taskToBeUpdated.status==@"H"){
            _periorityValue.selectedSegmentIndex=2;
        }
        
        if(_taskToBeUpdated.isInProgress){
            _statusValue.selectedSegmentIndex=0;
        }
        else{
            _statusValue.selectedSegmentIndex=1;

        }

        
        

        
        

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
            self.taskToBeAdded.status=@"L";
            break;
        }
        case 1:{
            //medium
            self.taskToBeAdded.status=@"M";

            break;
        }
        case 2:{
            //high
            self.taskToBeAdded.status=@"H";

            break;
        }
    }
}
- (IBAction)setIsInProgress:(id)sender {
    switch ([sender selectedSegmentIndex]) {
            
        case 0:{
            //InProgress
            self.taskToBeAdded.isInProgress=YES;
            break;
        }
        case 1:{
            //done
            self.taskToBeAdded.isInProgress=NO;
            break;
        }
            
    }
}
- (IBAction)insertTask:(id)sender {
    //insert here
    if(_taskToBeUpdated==nil){
        self.taskToBeAdded.title=_titleValue.text;
        self.taskToBeAdded.details=_detailsValue.text;
    }


    
    
    
    _tasks=[self getTasksWithNewTask:(self.taskToBeAdded.isInProgress)?@"INPROGRESS":@"DONE"];
    if(_tasks==nil){
        _tasks=[NSMutableArray new];
    }
    [_tasks addObject:_taskToBeAdded];

    [self saveTasksWithNewTask:_tasks :(self.taskToBeAdded.isInProgress)?@"INPROGRESS":@"DONE"];
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
