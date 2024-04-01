//
//  StudentInfoViewController.m
//  studentsInfoWithLoc
//
//  Created by Ramez Hamdi Saeed on 31/03/2024.
//

#import "StudentInfoViewController.h"
#import <MapKit/MapKit.h>

@interface StudentInfoViewController () <MKMapViewDelegate>
@property  IBOutlet UIImageView *avatar;
@property  IBOutlet UILabel *nameValue;
@property  IBOutlet MKMapView *studentLocation;

@end

@implementation StudentInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _nameValue.text=_studentToShow.name;
    
        CLLocationCoordinate2D initialCoordinate =
    CLLocationCoordinate2DMake([_studentToShow.latetude  doubleValue],[_studentToShow.longitude doubleValue]);
        MKCoordinateRegion initialRegion = MKCoordinateRegionMakeWithDistance(initialCoordinate, 5000, 5000);
        [self.studentLocation setRegion:initialRegion animated:YES];
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = initialCoordinate;
        annotation.title = _studentToShow.city;
        [self.studentLocation addAnnotation:annotation];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
