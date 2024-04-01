//
//  StudentsTableViewController.h
//  studentsInfoWithLoc
//
//  Created by Ramez Hamdi Saeed on 31/03/2024.
//

#import <UIKit/UIKit.h>
#import "StudentPONSO.h"
#import "studentsTableViewDelegator.h"

NS_ASSUME_NONNULL_BEGIN

@interface StudentsTableViewController : UITableViewController <studentsTableViewDelegator>
@property StudentPONSO *studentToBeAdded;
@end

NS_ASSUME_NONNULL_END
