/**
 * Copyright 2007, 2008 Soggy Waffles
 *
 * This file is part of Paintbrush.
 *
 * Paintbrush is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * Paintbrush is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Paintbrush; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */


#import "SWButtonCell.h"


@implementation SWButtonCell

- (void)setAlternateImage:(NSImage *)image
{
	return;
}

- (NSImage *)alternateImage
{
	if (!altImage) {
		NSImage *normal = [self image];
		NSImage *highlight;
		NSSize size = [normal size];
		
		if (NSEqualSizes(size, NSMakeSize(32, 32))) {
			highlight = [NSImage imageNamed:@"pressedsmall.png"];			
		} else if (NSEqualSizes(size, NSMakeSize(64, 32))) {
			highlight = [NSImage imageNamed:@"pressedwide.png"];
		} else if (NSEqualSizes(size, NSMakeSize(64, 48))) {
			highlight = [NSImage imageNamed:@"pressedwidetall.png"];
		} else {
			NSLog(@"Error: Button %@ is attempting to create alt image of size %@", [self title], [NSValue valueWithSize:size]);
			return nil;
		}

		altImage = [[NSImage alloc] initWithSize:size];
		[altImage lockFocus];
		[highlight drawAtPoint:NSZeroPoint
					  fromRect:NSZeroRect
					 operation:NSCompositeSourceOver
					  fraction:1.0];
		NSShadow *shadow = [NSShadow new];
		[shadow setShadowBlurRadius:4.0];
		[shadow setShadowColor:[NSColor whiteColor]];
		[shadow set];
		[normal drawAtPoint:NSZeroPoint
				   fromRect:NSZeroRect
				  operation:NSCompositeSourceOver
				   fraction:1.0];
		[altImage unlockFocus];
	}
	
	return altImage;
}

@end