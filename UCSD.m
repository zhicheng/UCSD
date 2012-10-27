/**
 *            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 *                    Version 2, December 2004
 *
 * Copyright (C) 2012 WEI Zhicheng <zhicheng1988@gmail.com>
 *
 * Everyone is permitted to copy and distribute verbatim or modified
 * copies of this license document, and changing it is allowed as long
 * as the name is changed.
 *
 *           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 *   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 *
 * 0. You just DO WHAT THE FUCK YOU WANT TO.
 *
 * This program is free software. It comes without any warranty, to
 * the extent permitted by applicable law. You can redistribute it
 * and/or modify it under the terms of the Do What The Fuck You Want
 * To Public License, Version 2, as published by Sam Hocevar. See
 * http://sam.zoy.org/wtfpl/COPYING for more details.
 **/


#import "UCSD.h"
#import <Foundation/Foundation.h>

#include "charsetdetect.h"

const char *
EnodingDetection(const char *file)
{
	const char *unknownEncoding = "Unknown";
	csd_t csd = csd_open();
	if (csd == (csd_t)-1)
		return unknownEncoding;
	
	int size;
	char buf[512] = {0};
	FILE *fp = fopen(file, "rb");
	while ((size = fread(buf, 1, sizeof(buf), fp)) != 0) {
		int result = csd_consider(csd, buf, size);
		if (result < 0)
			return unknownEncoding;
		else if (result > 0)
			break;
	}
	
	const char *result = csd_close(csd);
	if (result == NULL)
		return unknownEncoding;
	else
		return result;
}

@implementation UCSD

+ (NSStringEncoding)encodingWithContentsOfFile:(NSString *)path
{
	const char *file = [path UTF8String];
	NSString *encodingString = [NSString stringWithCString:EnodingDetection(file)
						      encoding:NSUTF8StringEncoding];
	CFStringEncoding encoding = kCFStringEncodingInvalidId;
	if ([encodingString isEqualToString:@"Big5"])
		encoding = kCFStringEncodingBig5;
	else if ([encodingString isEqualToString:@"EUC-JP"])
		encoding = kCFStringEncodingEUC_JP;
	else if ([encodingString isEqualToString:@"EUC-KR"])
		encoding = kCFStringEncodingEUC_KR;
	else if ([encodingString isEqualToString:@"GB18030"])
		encoding = kCFStringEncodingGB_18030_2000;
	else if ([encodingString isEqualToString:@"gb18030"])
		encoding = kCFStringEncodingGB_18030_2000;
	else if ([encodingString isEqualToString:@"HZ-GB-2312"])
		encoding = kCFStringEncodingHZ_GB_2312;
	else if ([encodingString isEqualToString:@"IBM855"])
		encoding = kCFStringEncodingDOSCyrillic;
	else if ([encodingString isEqualToString:@"IBM866"])
		encoding = kCFStringEncodingDOSRussian;
	else if ([encodingString isEqualToString:@"ISO-2022-CN"])
		encoding = kCFStringEncodingISO_2022_CN;
	else if ([encodingString isEqualToString:@"ISO-2022-JP"])
		encoding = kCFStringEncodingISO_2022_JP;
	else if ([encodingString isEqualToString:@"ISO-2022-KR"])
		encoding = kCFStringEncodingISO_2022_KR;
	else if ([encodingString isEqualToString:@"ISO-8859-2"])
		encoding = kCFStringEncodingISOLatin2;
	else if ([encodingString isEqualToString:@"ISO-8859-5"])
		encoding = kCFStringEncodingISOLatinCyrillic;
	else if ([encodingString isEqualToString:@"ISO-8859-7"])
		encoding = kCFStringEncodingISOLatinGreek;
	else if ([encodingString isEqualToString:@"ISO-8859-8"])
		encoding = kCFStringEncodingISOLatinHebrew;
	else if ([encodingString isEqualToString:@"KOI8-R"])
		encoding = kCFStringEncodingKOI8_R;
	else if ([encodingString isEqualToString:@"Shift_JIS"])
		encoding = kCFStringEncodingShiftJIS_X0213_00;
	else if ([encodingString isEqualToString:@"TIS-620"])
		NULL; /* unsupported */
	else if ([encodingString isEqualToString:@"UTF-8"])
		encoding = kCFStringEncodingUTF8;
	else if ([encodingString isEqualToString:@"UTF-16BE"])
		encoding = kCFStringEncodingUTF16BE;
	else if ([encodingString isEqualToString:@"UTF-16LE"])
		encoding = kCFStringEncodingUTF16LE;
	else if ([encodingString isEqualToString:@"UTF-32BE"])
		encoding = kCFStringEncodingUTF32BE;
	else if ([encodingString isEqualToString:@"UTF-32LE"])
		encoding = kCFStringEncodingUTF32LE;
	else if ([encodingString isEqualToString:@"windows-1250"])
		encoding = kCFStringEncodingWindowsLatin2;
	else if ([encodingString isEqualToString:@"windows-1251"])
		encoding = kCFStringEncodingWindowsCyrillic;
	else if ([encodingString isEqualToString:@"windows-1252"])
		NULL; /* unsupported */
	else if ([encodingString isEqualToString:@"windows-1253"])
		encoding = kCFStringEncodingWindowsGreek;
	else if ([encodingString isEqualToString:@"windows-1255"])
		encoding = kCFStringEncodingWindowsHebrew;
	else if ([encodingString isEqualToString:@"x-euc-tw"])
		encoding = kCFStringEncodingEUC_TW;
	else if ([encodingString isEqualToString:@"X-ISO-10646-UCS-4-2143"])
		NULL; /* unsupported */
	else if ([encodingString isEqualToString:@"X-ISO-10646-UCS-4-3412"])
		NULL; /* unsupported */
	else if ([encodingString isEqualToString:@"x-mac-cyrillic"])
		encoding = kCFStringEncodingMacCyrillic;

	return CFStringConvertEncodingToNSStringEncoding(encoding);
}

@end
