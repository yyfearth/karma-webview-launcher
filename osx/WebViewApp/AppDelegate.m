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
    //[window miniaturize:self];
}

- (void)awakeFromNib {
    NSURL *url;
    NSArray *arguments = [[NSProcessInfo processInfo] arguments];
    NSString *argUrl = arguments[1];
    if ([argUrl hasPrefix:@"http://"] || [argUrl hasPrefix:@"https://"] || [argUrl hasPrefix:@"file://"]) {
        url=[NSURL URLWithString:argUrl];
    }
    if (url == nil) {
        url=[NSURL URLWithString:@"https://html5test.com"];
    }
    NSLog(@"url: %@", url);

    [[self.webView mainFrame] loadRequest:[NSURLRequest requestWithURL:url]];
    [self.webView setUIDelegate:(id)self];

    [window setContentView:self.webView];
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
