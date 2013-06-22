//
//  NSColor+HexColor.h
//  Hex2RGB
//
//  Created by Phaedra Deepsky on 2013-06-04.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSColor (HexColor)

+ (NSColor *)colorWithHexValue:(NSString *)hexValue alpha:(CGFloat)alpha;

@end
