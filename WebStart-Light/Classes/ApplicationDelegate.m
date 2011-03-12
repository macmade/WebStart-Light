/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

/*!
 * @file        ApplicationDelegate.m
 * @copyright   eosgarden 2011 - Jean-David Gadina <macmade@eosgarden.com>
 * @abstract    ...
 */

#import "ApplicationDelegate.h"
#import "MainWindowController.h"
#import "AboutController.h"

@implementation ApplicationDelegate

- ( void )dealloc
{
    [ mainWindowController release ];
    [ aboutController      release ];
    
    [ super dealloc ];
}

- ( void )applicationDidFinishLaunching: ( NSNotification * )notification
{
    ( void )notification;
    
    mainWindowController = [ MainWindowController new ];
    
    [ mainWindowController.window center ];
    [ mainWindowController showWindow: self ];
    [ NSApp activateIgnoringOtherApps: YES ];
}

- ( IBAction )showAboutWindow: ( id )sender
{
    if( aboutController == nil )
    {
        aboutController = [ AboutController new ];
    }
    
    ( void )sender;
    
    [ aboutController.window center ];
    [ aboutController showWindow: sender ];
    [ NSApp activateIgnoringOtherApps: YES ];
}

- ( NSApplicationTerminateReply )applicationShouldTerminate: ( NSApplication * )sender
{
    ( void )sender;
    
    return NSTerminateNow;
}

@end
