/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

/*!
 * @header      MainWindowController.h
 * @copyright   eosgarden 2011 - Jean-David Gadina <macmade@eosgarden.com>
 * @abstract    ...
 */

@class ApacheHelper;
@class MySQLHelper;

/*!
 * @class       MainWindowController
 * @abstract    ...
 */
@interface MainWindowController: NSWindowController
{
@protected
    
    ApacheHelper * apache;
    MySQLHelper  * mysql;
    NSButton     * apacheButton;
    NSButton     * mySQLButton;
    NSButton     * openSiteButton;
    NSButton     * openMySQLAdminButton;
    NSTimer      * timer;
    
@private
    
    id r1;
    id r2;
}

@property( nonatomic, retain ) IBOutlet NSButton * apacheButton;
@property( nonatomic, retain ) IBOutlet NSButton * mySQLButton;
@property( nonatomic, retain ) IBOutlet NSButton * openSiteButton;
@property( nonatomic, retain ) IBOutlet NSButton * openMySQLAdminButton;

- ( IBAction )toggleApache: ( id )sender;
- ( IBAction )toggleMySQL: ( id )sender;
- ( IBAction )openWebRoot: ( id )sender;
- ( IBAction )openSite: ( id )sender;
- ( IBAction )openMySQLAdmin: ( id )sender;

@end
