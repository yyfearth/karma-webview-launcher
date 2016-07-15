//
//  AppDelegate.m
//  WebViewApp
//
//  Created by Wilson Young on 7/9/16.
//  Copyright © 2016 Wilson Yang. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window;
@synthesize webView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSArray *arguments = [[NSProcessInfo processInfo] arguments];
    if (![arguments containsObject:@"-hide"]) {
        [window makeKeyAndOrderFront:self];
        if ([arguments containsObject:@"-minimized"]) {
            [window miniaturize:self];
        }
    }
    if (![arguments containsObject:@"-no-dock-icon"]) {
        ProcessSerialNumber psn = { 0, kCurrentProcess };
        TransformProcessType(&psn, kProcessTransformToForegroundApplication);
    }
}

- (void)awakeFromNib {
    NSString *ua = [[NSUserDefaults standardUserDefaults] valueForKey:@"customUA"];
    if (ua == nil) {
        ua = [[NSUserDefaults standardUserDefaults] valueForKey:@"appendUA"];
        if (ua == nil) {
            NSBundle *webKit = [NSBundle bundleWithIdentifier:@"com.apple.WebKit"];
            NSString *build = [webKit objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey];
            NSString *version = [webKit objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
            NSLog(@"webkit: %@", build);
            ua = [NSString stringWithFormat: @"WebView/%@ (like Safari/%@)", build, version];
        }
        webView.applicationNameForUserAgent = ua;
    }
    else {
        webView.customUserAgent = ua;
    }

    NSURL *url;
    NSArray *arguments = [[NSProcessInfo processInfo] arguments];
    NSString *argUrl;
    for (int i = 1; i < [arguments count]; ++i) {
        argUrl = arguments[i];
        if ([argUrl hasPrefix:@"http://"] || [argUrl hasPrefix:@"https://"] || [argUrl hasPrefix:@"file://"]) {
            url = [NSURL URLWithString:argUrl];
            if (url != nil) {
                break;
            }
        }
    }
    if (url == nil) {
        url = [NSURL URLWithString:@"https://html5test.com"];
    }
    NSLog(@"url: %@", url);

    // webView.mainFrameURL = argUrl
    [[webView mainFrame] loadRequest:[NSURLRequest requestWithURL:url]];
    [webView setUIDelegate:(id)self];

    [window setContentView:webView];
}

- (void)windowWillClose:(NSNotification *)aNotification {
    [NSApp terminate:self];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

- (void)webView:(WebView *)sender frame:(WebFrame *)frame exceededDatabaseQuotaForSecurityOrigin:(id) origin database:(NSString *)databaseIdentifier {
    static const unsigned long long defaultQuota = 5 * 1024 * 1024;
    if ([origin respondsToSelector: @selector(setQuota:)]) {
        [origin performSelector:@selector(setQuota:) withObject:[NSNumber numberWithLongLong: defaultQuota]];
    } else {
        NSLog(@"could not increase quota for %lld", defaultQuota);
    }
}

@end
