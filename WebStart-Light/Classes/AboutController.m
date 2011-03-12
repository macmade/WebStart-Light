/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

/*!
 * @file        AboutController.m
 * @copyright   eosgarden 2011 - Jean-David Gadina <macmade@eosgarden.com>
 * @abstract    ...
 */

#import "AboutController.h"

@implementation AboutController

- ( id )init
{
    if( ( self = [ super initWithWindowNibName: @"About" ] ) )
    {}
    
    return self;
}

- ( void )dealloc
{
    [ super dealloc ];
}

@end
