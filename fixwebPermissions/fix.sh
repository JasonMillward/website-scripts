#!/bin/bash
#
# Directory permission fixer
#
#
# This small script trawls through all files and directories in the 
# web directory and changes the permissions of their respective type.
#	
#
# Version    $Id: 1.0.2, 2012-07-23 13:24:14 CEST $;
# Author     Jason Millward
# Copyright  2012 Jason Millward
#
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.


# Lets include the reqired files
source $(pwd)/config.cfg

# Find all files
find $WWW_DATA_DIR -type f -exec chmod 644 {} \;

# Find all folders
find $WWW_DATA_DIR -type d -exec chmod 755 {} \;
# Done