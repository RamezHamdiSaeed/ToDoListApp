//
//  studentsTableViewDelegator.h
//  studentsInfoWithLoc
//
//  Created by Ramez Hamdi Saeed on 31/03/2024.
//

#import <Foundation/Foundation.h>
#import "StudentPONSO.h"

NS_ASSUME_NONNULL_BEGIN

@protocol studentsTableViewDelegator <NSObject>
@property StudentPONSO *studentToBeAdded;

@end

NS_ASSUME_NONNULL_END
