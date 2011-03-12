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

#import "ServerHelper.h"
#import "ApplicationController.h"

@implementation ServerHelper

- ( id )init
{
    if( ( self = [ super init ] ) )
    {
        app = ( ApplicationController * )NSApp;
    }
    
    return self;
}

- ( BOOL )isRunning: ( NSString * )processName
{
    NSFileHandle * io;
    NSTask       * task;
    NSPipe       * execPipe;
    NSArray      * args;
    NSString     * ps;
    NSRange        result;
    
    task     = [ [ [ NSTask alloc ] init ] autorelease ];
    execPipe = [ NSPipe pipe ];
    io       = [ execPipe fileHandleForReading ];
    args     = [ NSArray arrayWithObjects: @"-ax", nil ];
    
    [ task setLaunchPath: NSSTR( SYS_PS ) ];
    [ task setArguments: args ];
    [ task setStandardOutput: execPipe ];
    [ task launch ];
    
    ps     = [ [ NSString alloc ] initWithData: [ io readDataToEndOfFile ] encoding: NSASCIIStringEncoding ];
    result = [ ps rangeOfString: processName ];
    
    [ ps release ];
    
    if( result.location != NSNotFound )
    {
        return YES;
    }
    
    return NO;
}

@end
