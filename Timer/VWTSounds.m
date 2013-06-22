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
	}
    return self;
}

+ (NSArray *)getSounds
{
	// Idea - This could be expanded to handle multiple directories by enumerating through an array of path strings.
	NSString *path = @"/System/Library/Sounds";
	NSFileManager *fm = [NSFileManager defaultManager];
	NSArray *files = [[fm contentsOfDirectoryAtPath:path error:nil] mutableCopy];
	NSMutableArray *sounds = [NSMutableArray array];
	
	[files enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		[sounds addObject: [obj stringByDeletingPathExtension]];
	}];
	return [NSArray arrayWithArray:sounds];
}

@end
