/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

/*!
 * @file        MainWindowController.m
 * @copyright   eosgarden 2011 - Jean-David Gadina <macmade@eosgarden.com>
 * @abstract    ...
 */

#import "MainWindowController.h"
#import "ApacheHelper.h"
#import "MySQLHelper.h"

@interface MainWindowController( Private )

- ( void )refresh: ( id )nothing;

@end

@implementation MainWindowController( Private )

- ( void )refresh: ( id )nothing
{
    ( void )nothing;
    
    if( apache.isRunning == YES )
    {
        [ apacheButton setTitle: L10N( @"ApacheStop" ) ];
        [ apacheButton setImage: [ NSImage imageNamed: @"NSStopProgressTemplate" ] ];
        [ openSiteButton setEnabled: YES ];
    }
    else
    {
        [ apacheButton setTitle: L10N( @"ApacheStart" ) ];
        [ apacheButton setImage: [ NSImage imageNamed: @"NSGoRightTemplate" ] ];
        [ openSiteButton setEnabled: NO ];
    }
    
    if( mysql.isRunning == YES )
    {
        [ mySQLButton setTitle: L10N( @"MySQLStop" ) ];
        [ mySQLButton setImage: [ NSImage imageNamed: @"NSStopProgressTemplate" ] ];
    }
    else
    {
        [ mySQLButton setTitle: L10N( @"MySQLStart" ) ];
        [ mySQLButton setImage: [ NSImage imageNamed: @"NSGoRightTemplate" ] ];
    }
    
    if( apache.isRunning == YES && mysql.isRunning == YES )
    {
        [ openMySQLAdminButton setEnabled: YES ];
    }
    else
    {
        [ openMySQLAdminButton setEnabled: NO ];
    }
}

@end

@implementation MainWindowController

@synthesize apacheButton;
@synthesize mySQLButton;
@synthesize openSiteButton;
@synthesize openMySQLAdminButton;

- ( id )init
{
    if( ( self = [ super initWithWindowNibName: @"MainWindow" ] ) )
    {
        apache = [ ApacheHelper getInstance ];
        mysql  = [ MySQLHelper getInstance ];
    }
    
    return self;
}

- ( void )awakeFromNib
{
    [ self refresh: nil ];
    
    timer = [ [ NSTimer scheduledTimerWithTimeInterval: 2.0 target: self selector: @selector( refresh: ) userInfo: nil repeats: YES ] retain ];
}

- ( void )dealloc
{
    [ apacheButton release ];
    [ mySQLButton  release ];
    [ timer        release ];
    
    [ super dealloc ];
}

- ( IBAction )toggleApache: ( id )sender
{
    if( apache.isRunning == YES )
    {
        [ apache stop: sender ];
    }
    else
    {
        [ apache start: sender ];
    }
}

- ( IBAction )toggleMySQL: ( id )sender
{
    if( mysql.isRunning == YES )
    {
        [ mysql stop: sender ];
    }
    else
    {
        [ mysql start: sender ];
    }
}

- ( IBAction )openWebRoot: ( id )sender
{
    ( void )sender;
    
    [ [ NSWorkspace sharedWorkspace ] openFile: @"/Library/WebStart/WWW/localhost/public/" ];
}

- ( IBAction )openSite: ( id )sender
{
    ( void )sender;
    
    [ [ NSWorkspace sharedWorkspace ] openURL: [ NSURL URLWithString: @"http://localhost/" ] ];
}

- ( IBAction )openMySQLAdmin: ( id )sender
{
    ( void )sender;
    
    [ [ NSWorkspace sharedWorkspace ] openURL: [ NSURL URLWithString: @"http://localhost/phpmyadmin/" ] ];
}

@end
