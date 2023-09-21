// This file is generated and will be overwritten automatically.

#import <Foundation/Foundation.h>
#import <MapboxCommon/MBXTelemetryCollectionState_Internal.h>
#import <MapboxCommon/MBXTelemetryUtilsResponseCallback_Internal.h>

@class MBXEventsServerOptions;

NS_SWIFT_NAME(TelemetryUtils)
__attribute__((visibility ("default")))
@interface MBXTelemetryUtils : NSObject

// This class provides custom init which should be called
- (nonnull instancetype)init NS_UNAVAILABLE;

// This class provides custom init which should be called
+ (nonnull instancetype)new NS_UNAVAILABLE;

+ (void)setEventsCollectionStateForEnableCollection:(BOOL)enableCollection
                                           callback:(nullable MBXTelemetryUtilsResponseCallback)callback;
+ (BOOL)getEventsCollectionState;
+ (MBXTelemetryCollectionState)getClientServerEventsCollectionStateForEventsServerOptions:(nonnull MBXEventsServerOptions *)eventsServerOptions;
+ (nonnull NSString *)getUserID __attribute((ns_returns_retained));

@end
