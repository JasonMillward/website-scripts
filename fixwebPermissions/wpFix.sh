#!/bin/bash
#
# Wordpress wp-content folder permissions fixer
#
#
# This small script trawls through all files and directories in the 
# web directory and changes the permissions of wp-content folders 
# to be writable by the apache user.
#	
#
# Version    $Id: 1.1, 2012-07-30 07:54:52 CEST $;
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

# Find all wp-content directories in the WWW_DATA_DIR 
$(find $WWW_DATA_DIR -type d -exec ls -d {} \; | grep "\/wp-content$" > $TMP_FILE_LIST)

# Read the lines into an array
LINES_ARRAY=( $(cat $TMP_FILE_LIST) )

# For each line (Or wp-content directory)
for idx in $(seq 0 $((${#LINES_ARRAY[@]} - 1))); do
    # Put the directory into a variable
    LINE="${LINES_ARRAY[$idx]}"
    # Tell the user we are fixing $LINE
    echo "Fixing $LINE"
    # Change the permissions for wp-content
    # It needs to be writable by the user and the group but not everyone.
    chmod 775 $LINE
done

rm $TMP_FILE_LIST
# Done
