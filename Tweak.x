#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>

static NSInteger forcedMaxLines;

%hook SBAwayBulletinCell

+ (CGFloat)rowHeightForSubtitle:(NSString *)subtitle message:(NSString *)message maxLines:(NSUInteger)maxLines rowWidth:(CGFloat)width
{
	if (forcedMaxLines != -1)
		maxLines = forcedMaxLines;
	return %orig;
}

- (void)setMaxMessageLines:(NSUInteger)maxLines
{
	if (forcedMaxLines != -1)
		maxLines = forcedMaxLines;
	%orig;
}

%end

%hook SBBulletinListCell

+ (CGFloat)heightForRowWithSubtitle:(NSString *)subtitle message:(NSString *)message maxLines:(NSUInteger)maxLines width:(CGFloat)width italicize:(BOOL)italicize
{
	if (forcedMaxLines != -1)
		maxLines = forcedMaxLines;
	return %orig;
}

- (void)setMaxMessageLines:(NSUInteger)maxLines
{
	if (forcedMaxLines != -1)
		maxLines = forcedMaxLines;
	%orig;
}

%end

static void LoadSettings()
{
	NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.rpetrich.morelinesnotificationcenter.plist"];
	id fml = [settings objectForKey:@"forcedMaxLines"];
	forcedMaxLines = fml ? [fml integerValue] : -1;
}

%ctor {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	%init;
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)LoadSettings, CFSTR("com.rpetrich.morelinesnotificationcenter/settingchanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	LoadSettings();
	[pool drain];
}
