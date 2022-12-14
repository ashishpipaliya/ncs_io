#import "NcsIoPlugin.h"
#if __has_include(<ncs_io/ncs_io-Swift.h>)
#import <ncs_io/ncs_io-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ncs_io-Swift.h"
#endif

@implementation NcsIoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNcsIoPlugin registerWithRegistrar:registrar];
}
@end
