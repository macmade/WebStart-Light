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

@class ApplicationController;

@interface ServerHelper: NLObjectSingleton
{
@protected
    
    ApplicationController * app;
}

- ( BOOL )isRunning: ( NSString * )processName;

@end
