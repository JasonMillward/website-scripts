#!/bin/bash
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



function PERMISSIONS ()
{
	chown -R $USER.users $WWW_DATA_DIR/$USER/$DOMAIN

	find $WWW_DATA_DIR/$USER/$DOMAIN -type f -exec chmod 644 {} \;
	find $WWW_DATA_DIR/$USER/$DOMAIN -type d -exec chmod 755 {} \;
}

function WORDPRESS ()
{
	cd $WWW_DATA_DIR/$USER/$DOMAIN/htdocs
	wget http://wordpress.org/latest.zip 
	unzip latest.zip 
	mv wordpress/* . 
	rm -rf $WWW_DATA_DIR/$USER/$DOMAIN/htdocs/wordpress/
}

function VIRTUALHOST () 
{
    cp $(pwd)/blankVhost $APACHE_PATH/$DOMAIN
    
    ESCP_DATA_DIR=${WWW_DATA_DIR//\//\\\/}
    
    sed -i "s/WWW_DATA_DIR/$ESCP_DATA_DIR/g" $APACHE_PATH/$DOMAIN
    sed -i "s/DOMAIN/$DOMAIN/g" $APACHE_PATH/$DOMAIN
    sed -i "s/USER/$USER/g" $APACHE_PATH/$DOMAIN    
}

function CREATE() 
{
	mkdir -p $WWW_DATA_DIR/$USER/$DOMAIN/htdocs/
	mkdir -p $WWW_DATA_DIR/$USER/$DOMAIN/logs
	mkdir -p $WWW_DATA_DIR/$USER/$DOMAIN/etc
}

function ENABLE()
{
	a2ensite $DOMAIN
}

function RESTART()
{
	/etc/init.d/apache2 restart
}





