//
//  StudentAddViewController.h
//  studentsInfoWithLoc
//
//  Created by Ramez Hamdi Saeed on 31/03/2024.
//

#import <UIKit/UIKit.h>
#import "studentsTableViewDelegator.h"

NS_ASSUME_NONNULL_BEGIN

@interface StudentAddViewController : UIViewController
@property id<studentsTableViewDelegator> studentTableViewInstance;

@end

NS_ASSUME_NONNULL_END
