//
//  StudentPONSO.h
//  studentsInfoWithLoc
//
//  Created by Ramez Hamdi Saeed on 31/03/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskPONSO : NSObject <NSCoding>

@property NSString *title;
@property NSString *status;
@property NSString *date;
@property NSString *periority;
@property bool isInProgress;
@property NSString *details;



@end

NS_ASSUME_NONNULL_END
