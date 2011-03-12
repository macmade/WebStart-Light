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

#import "ApacheHelper.h"
#import "ApplicationController.h"

@implementation ApacheHelper

@synthesize status;

- ( id )init
{
    
    if( ( self = [ super init ] ) )
    {}
    
    return self;
}

- ( void )dealloc
{
    [ super dealloc ];
}

- ( BOOL )isRunning
{
    BOOL running;
    
    running = [ super isRunning: NSSTR( SW_HTTPD ) ];
    
    status = ( running == YES ) ? 3 : 1;
    
    if( isRestarting == YES )
    {
        isRestarting = NO;
        status       = 2;
    }
    else if( running == YES )
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
        if( isStopping == YES )
        {
            isStopping = NO;
        }
        
        if( isStarting == YES )
        {
            status = 2;
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
        isRestarting = NO;
    }
}

- ( IBAction )start: ( id )sender
{
    OSStatus execStatus;
    char   * args[] = { "start", NULL };
    
    ( void )sender;
    
    if( status == 2 )
    {
        return;
    }
    
    if( [ self isRunning ] == NO )
    {
        isStarting = YES;
        
        execStatus = [ app.execution executeWithPrivileges: SW_APACHECTL arguments: args io: NULL ];
        
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
    OSStatus execStatus;
    char   * args[] = { "stop", NULL };
    
    ( void )sender;
    
    if( status == 2 )
    {
        return;
    }
    
    if( [ self isRunning ] == YES )
    {
        isStopping = YES;
        
        execStatus = [ app.execution executeWithPrivileges: SW_APACHECTL arguments: args io: NULL  ];
        
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
    OSStatus execStatus;
    char   * args[ 2 ];
    
    ( void )sender;
    
    if( status == 2 )
    {
        return;
    }
    
    if( status == 1 )
    {
        [ self start: nil ];
    }
    else
    {
        args[ 0 ] = "restart";
        args[ 1 ] = NULL;
        
        isRestarting = YES;
        
        execStatus = [ app.execution executeWithPrivileges: SW_APACHECTL arguments: args io: NULL  ];
        
        if( execStatus == errAuthorizationCanceled )
        {
            isRestarting = NO;
        }
        else if( execStatus != 0 )
        {}
        else
        {
            [ NSTimer scheduledTimerWithTimeInterval: 5 target: self selector: @selector( checkStatus: ) userInfo: nil repeats: NO ];
        }
    }
}

@end
