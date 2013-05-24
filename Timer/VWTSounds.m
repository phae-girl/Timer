//
//  VWTSounds.m
//  Timer
//
//  Created by Phaedra Deepsky on 2013-05-24.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "VWTSounds.h"

@interface VWTSounds ()
@property (copy, readwrite)NSMutableArray *sounds;

@end

@implementation VWTSounds
- (id)init
{
    self = [super init];
    if (self) {
        NSString *path = @"/System/Library/Sounds";
		NSFileManager *fm = [NSFileManager defaultManager];
		NSArray *files = [fm contentsOfDirectoryAtPath:path error:nil];
		[self populateSoundsFromFiles:files];
    }
    return self;
}

- (void)populateSoundsFromFiles:(NSArray *)fileList
{
	if (!_sounds) {
		_sounds = [NSMutableArray array];
	}
	
	[fileList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		NSString *soundName = [obj stringByDeletingPathExtension];
		[self.sounds addObject:soundName];
		
	}];
}

@end
