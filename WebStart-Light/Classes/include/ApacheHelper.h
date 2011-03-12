/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

/*!
 * @header      
 * @copyright   eosgarden 2011 - Jean-David Gadina <macmade@eosgarden.com>
 * @abstract    ...
 */

#import "ServerHelper.h"

@interface ApacheHelper: ServerHelper
{
@protected
    
    BOOL                      isStarting;
    BOOL                      isStopping;
    BOOL                      isRestarting;
    int                       status;
    
@private
    
    id r1;
    id r2;
}

@property( readonly ) int status;

- ( BOOL )isRunning;
- ( IBAction )start: ( id )sender;
- ( IBAction )stop: ( id )sender;
- ( IBAction )restart: ( id )sender;

@end
