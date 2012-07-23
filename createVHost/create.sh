#!/bin/bash
#
# Directory permission fixer
#
#
# This small script trawls through all files and directories in the 
# web directory and changes the permissions of their respective type.
#	
#
# Version    $Id: 1.0.1, 2012-07-23 09:54:08 CEST $;
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
source $(pwd)/functions.cfg

# Clear the screen of junk
clear

# Make a nice title
echo "Domain creation kit"

# Get the user 
echo -n "Who is the domain for? "
read -e USER

# Check for the user specified
LINES=$(cat /etc/passwd | grep "^$USER\:" | wc -l)
if [ $LINES -eq 0 ]; then
    echo ""
    echo "User does not exist"
    exit 0
fi

# Ask for the domain name
echo -n "Domain name: "
read -e DOMAIN

# Check to see if it exists already
if [ -d "$WWW_DATA_DIR/$USER/$DOMAIN" ]; then
    echo ""
    echo "Domain exists already"
    exit 0
fi

# It seems everything checks out, lets create the directories and virtualhosts


# Create the directories
CREATE 

# Create the virtualhost
VIRTUALHOST

# Enable the website
ENABLE

# Ask if the website is for wordpress, if so download and extract it
WORDPRESS

# Fix up the permissions 
PERMISSIONS

# Restart apache
RESTART

