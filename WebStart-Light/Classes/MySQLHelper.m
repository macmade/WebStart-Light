/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

/*!
 * file         
 * @copyright   eosgarden 2011 - Jean-David Gadina <macmade@eosgarden.com>
 * @abstract    ...
 */

#import "MySQLHelper.h"
#import "ApplicationController.h"

@implementation MySQLHelper

@synthesize status;

- ( id )init
{
    if( ( self = [ super init ] ) )
    {
        keychainItem = [ [ NLKeychainItem alloc ] initWithName: @"WebStart Light MySQL root password" username: @"root" ];
    }
    
    return self;
}

- ( void )dealloc
{
    [ keychainItem release ];
    
    [ super dealloc ];
}

- ( BOOL )isRunning
{
    BOOL running;
    
    running = [ super isRunning: NSSTR( SW_MYSQLD ) ];
    
    status = ( running == YES ) ? 3 : 1;
    
    if( running == YES )
    {
        if( isStarting == YES )
        {
            isStarting = NO;
        }
        
        if( isStopping == YES )
        {
            status = 2;
        }
    }
    else
    {
        if( isStarting == YES )
        {
            status = 2;
        }
        
        if( isStopping == YES )
        {
            isStopping = NO;
        }
    }
    
    return running;
}

- ( void )checkStatus: ( NSTimer * )timerObject
{
    ( void )timerObject;
    
    if( status == 2 )
    {
        isStarting   = NO;
        isStopping   = NO;
    }
}

- ( IBAction )start: ( id )sender
{
    OSStatus execStatus;
    char   * args[] = { "--user=_mysql", NULL };
    
    ( void )sender;
    
    if( status == 2 )
    {
        return;
    }
    
    if( [ self isRunning ] == NO )
    {
        isStarting = YES;
        
        execStatus = [ app.execution executeWithPrivileges: SW_MYSQLD_SAFE arguments: args io: NULL  ];
        
        if( execStatus == errAuthorizationCanceled )
        {
            isStarting = NO;
        }
        else if( execStatus != 0 )
        {
            isStarting = NO;
        }
        else
        {
            [ NSTimer scheduledTimerWithTimeInterval: 5 target: self selector: @selector( checkStatus: ) userInfo: nil repeats: NO ];
        }
    }
}

- ( IBAction )stop: ( id )sender
{
    OSStatus   execStatus;
    NSString * password;
    char     * argsPassword[ 3 ];
    char     * args[ 2 ];
    
    ( void )sender;
    
    [ keychainItem update ];
    
    if( status == 2 )
    {
        return;
    }
    
    password          = STRF( @"--password=%@", keychainItem.password );
    argsPassword[ 0 ] = CSTR( password );
    argsPassword[ 1 ] = "shutdown";
    argsPassword[ 2 ] = NULL;
    args[ 0 ]         = "shutdown";
    args[ 1 ]         = NULL;
    
    if( [ self isRunning ] == YES )
    {
        isStopping = YES;
        
        if( keychainItem.itemExists == YES && keychainItem.password != nil )
        {
            execStatus = [ app.execution executeWithPrivileges: SW_MYSQLADMIN arguments: argsPassword io: NULL ];
        }
        else
        {
            execStatus = [ app.execution executeWithPrivileges: SW_MYSQLADMIN arguments: args io: NULL ];
        }
        
        if( execStatus == errAuthorizationCanceled )
        {
            isStopping = NO;
        }
        else if( execStatus != 0 )
        {
            isStopping = NO;
        }
        else
        {
            [ NSTimer scheduledTimerWithTimeInterval: 5 target: self selector: @selector( checkStatus: ) userInfo: nil repeats: NO ];
        }
    }
}

- ( IBAction )restart: ( id )sender
{
    if( [ self isRunning ] == YES )
    {
        [ self stop: sender ];
        
        while( status != 1 && isStopping )
        {
            [ self isRunning ];
        }
    }
    
    if( status == 1 )
    {
        [ self start: sender ];
    }
}

@end
