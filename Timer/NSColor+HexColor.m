//
//  NSColor+HexColor.m
//  Hex2RGB
//
//  Created by Phaedra Deepsky on 2013-06-04.
//  Copyright (c) 2013 Phaedra Deepsky. All rights reserved.
//

#import "NSColor+HexColor.h"

@implementation NSColor (HexColor)

+ (NSColor *)colorWithHexValue:(NSString *)hexValue alpha:(CGFloat)alpha
{
	NSString *hexString = [hexValue stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
	if ([hexString length] !=6) {
		@throw([NSException exceptionWithName:@"Invalid Hex Color" reason:@"Hex colors must contain six digits and must be in the form of either ABC123 or #ABC123" userInfo:nil]);
		
	}

	NSString *redString = [hexString substringWithRange:NSMakeRange(0, 2)];
	CGFloat red = [self calculateCGFloat:redString];
	
	
	NSString *greenString = [hexString substringWithRange:NSMakeRange(2, 2)];
	CGFloat green = [self calculateCGFloat:greenString];
	
	
	NSString *blueString = [hexString substringWithRange:NSMakeRange(4, 2)];
	CGFloat blue = [self calculateCGFloat:blueString];
	
	return [self colorWithDeviceRed:red green:green blue:blue alpha:alpha];
}

+ (CGFloat)calculateCGFloat:(NSString *)hexValue
{
	CGFloat numerator = [self integerForHexValue:hexValue];
	CGFloat denominator = 255.0;
	CGFloat result = numerator/denominator;
	return result;
}


+ (CGFloat)integerForHexValue:(NSString *)hexValue
{
	unsigned result = 0;
	NSScanner *scanner = [NSScanner scannerWithString:hexValue];
	
	[scanner setScanLocation:0]; 
	[scanner scanHexInt:&result];
	
	return (CGFloat)result;
}



@end
