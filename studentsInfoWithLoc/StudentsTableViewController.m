//
//  StudentsTableViewController.m
//  studentsInfoWithLoc
//
//  Created by Ramez Hamdi Saeed on 31/03/2024.
//

#import "StudentsTableViewController.h"
#import "StudentPONSO.h"
#import "StudentAddViewController.h"
#import "StudentInfoViewController.h"

@interface StudentsTableViewController ()
{
    NSMutableArray *students;

}

@end

@implementation StudentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    students=[NSMutableArray new];
    
    StudentPONSO *ramez=[StudentPONSO new];
    ramez.name=@"Ramez";
    ramez.age=@"25";
    ramez.longitude=@"31.5041";
    ramez.longitude=@"30.5765";
    
    [students addObject:ramez];
    


    
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    if(_studentToBeAdded!=nil){
        NSLog(@"1transfered student ponso from the add screen: %@",_studentToBeAdded);
        [students addObject:_studentToBeAdded];
        [self.tableView reloadData];
        _studentToBeAdded=nil;
    }
    NSLog(@"2transfered student ponso from the add screen: %@",_studentToBeAdded);
}
- (IBAction)addStudent:(id)sender {
    StudentAddViewController *studentVC=[self.storyboard instantiateViewControllerWithIdentifier:@"StudentAddViewController"];
    studentVC.studentTableViewInstance=self;
    [self.navigationController pushViewController:studentVC animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [students count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    StudentPONSO *studentTemp=[StudentPONSO new];
    studentTemp=[students objectAtIndex:indexPath.row];
    cell.textLabel.text=studentTemp.name;
    cell.accessoryType=UITableViewCellAccessoryDetailButton;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    StudentInfoViewController *studentInfovc=[self.storyboard instantiateViewControllerWithIdentifier:@"StudentInfoViewController"];
    studentInfovc.studentToShow=[students objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:studentInfovc animated:YES];
    
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
        [students removeObjectAtIndex:indexPath.row];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
