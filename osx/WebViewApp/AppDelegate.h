//
//  AppDelegate.h
//  WebViewApp
//
//  Created by Wilson Young on 7/9/16.
//  Copyright © 2016 Wilson Yang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet WebView *webView;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) IBOutlet WebView *webView;

@end
