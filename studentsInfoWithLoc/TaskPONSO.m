//
//  StudentPONSO.m
//  studentsInfoWithLoc
//
//  Created by Ramez Hamdi Saeed on 31/03/2024.
//

#import "TaskPONSO.h"

@implementation TaskPONSO

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.details forKey:@"details"];
    [coder encodeObject:self.date forKey:@"date"];
    [coder encodeObject:self.status forKey:@"status"];
    [coder encodeBool:self.isInProgress forKey:@"isInProgress"];

}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self = [super init];
        if (self) {
            self.title = [coder decodeObjectForKey:@"title"];
            self.details = [coder decodeObjectForKey:@"details"];
            self.date = [coder decodeObjectForKey:@"date"];
            self.status = [coder decodeObjectForKey:@"status"];
            self.isInProgress = [coder decodeBoolForKey:@"isInProgress"];

        }
        return self;
}

@end
