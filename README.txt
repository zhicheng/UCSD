This is Universal Character Set Detector (UCSD) for iOS

code is from https://github.com/batterseapower/libcharsetdetect
Thanks

Usage:
#import "NSStringAdditions.h"

NSString *path   = [[NSBundle mainBundle] pathForResource:@"test.txt" ofType:nil];
NSString *string = [NSString stringWithContentsOfFile:path
			     usingUCSDAndHintEncoding:NSUTF8StringEncoding 
						error:nil]);


You must declare you use *MPL* in You Project

