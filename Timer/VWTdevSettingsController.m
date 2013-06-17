//
//  VWTPlistCOntroller.m
//  Timer
//
//  Created by Phaedra Deepsky on 2013-06-17.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "VWTdevSettingsController.h"

@implementation VWTdevSettingsController

- (id)init
{
    self = [super init];
    if (self) {
        NSString *errorDesc = nil;
        NSPropertyListFormat format;
        NSString *plistPath;
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		
        plistPath = [rootPath stringByAppendingPathComponent:@"dev-options.plist"];
        
		if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
			
            plistPath = [[NSBundle mainBundle] pathForResource:@"dev-options" ofType:@"plist"];
        }
        
		NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
        
		NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML
																			  mutabilityOption:NSPropertyListMutableContainersAndLeaves
																						format:&format
																			  errorDescription:&errorDesc];
        if (!temp) {
            NSLog(@"Error reading plist: %@, format: %ld", errorDesc, format);
        }
        
		if (!_devSettings) {
			_devSettings = [NSDictionary dictionaryWithDictionary:temp];
		}
    }
    return self;
}
@end
