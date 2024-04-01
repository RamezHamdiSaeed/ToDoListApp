//
//  StudentAddViewController.m
//  studentsInfoWithLoc
//
//  Created by Ramez Hamdi Saeed on 31/03/2024.
//

#import "StudentAddViewController.h"

@interface StudentAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameValue;
@property (weak, nonatomic) IBOutlet UITextField *ageValue;
@property (weak, nonatomic) IBOutlet UITextField *latValue;
@property (weak, nonatomic) IBOutlet UITextField *lonValue;
@property (weak, nonatomic) IBOutlet UITextField *cityValue;

@end

@implementation StudentAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)addStudent:(id)sender {
    StudentPONSO *studentTemp=[StudentPONSO new];
    studentTemp.name=self.nameValue.text;
    studentTemp.age=self.ageValue.text;
    studentTemp.latetude=self.latValue.text;
    studentTemp.longitude=self.lonValue.text;
    studentTemp.city=self.cityValue.text;

    self.studentTableViewInstance.studentToBeAdded= studentTemp;
    
    [self.navigationController popViewControllerAnimated:YES];

}

@end
