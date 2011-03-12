/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

/*!
 * @header      ApplicationDelegate.h
 * @copyright   eosgarden 2011 - Jean-David Gadina <macmade@eosgarden.com>
 * @abstract    ...
 */

@class MainWindowController;
@class AboutController;

/*!
 * @class       ApplicationDelegate
 * @abstract    ...
 */
@interface ApplicationDelegate: NSObject < NSApplicationDelegate >
{
@protected
    
    MainWindowController * mainWindowController;
    AboutController      * aboutController;
    
@private
    
    id r1;
    id r2;
}

- ( IBAction )showAboutWindow: ( id )sender;

@end
