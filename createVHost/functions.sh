#!/bin/bash
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
	echo "<VirtualHost *:80>"                                        					>  $APACHE_PATH/$DOMAIN
	echo "        ServerAdmin webmaster@partyc.at"                   					>> $APACHE_PATH/$DOMAIN
	echo "        ServerName  $DOMAIN"                               					>> $APACHE_PATH/$DOMAIN
	echo "        ServerAlias *.$DOMAIN"                             					>> $APACHE_PATH/$DOMAIN
	echo ""                                                          					>> $APACHE_PATH/$DOMAIN
	echo "        DocumentRoot $WWW_DATA_DIR/$USER/$DOMAIN/htdocs/"  					>> $APACHE_PATH/$DOMAIN
	echo "        <Directory />"                                     					>> $APACHE_PATH/$DOMAIN
	echo "                Options FollowSymLinks"                    					>> $APACHE_PATH/$DOMAIN
	echo "                AllowOverride all"                         					>> $APACHE_PATH/$DOMAIN
	echo "        </Directory>"                                      					>> $APACHE_PATH/$DOMAIN
	echo "        <Directory $WWW_DATA_DIR/$USER/$DOMAIN/htdocs/>"   					>> $APACHE_PATH/$DOMAIN
	echo "                Options Indexes FollowSymLinks MultiViews" 					>> $APACHE_PATH/$DOMAIN
	echo "                AllowOverride all"                         					>> $APACHE_PATH/$DOMAIN
	echo "                Order allow,deny"                          					>> $APACHE_PATH/$DOMAIN
	echo "                allow from all"                            					>> $APACHE_PATH/$DOMAIN
	echo "        </Directory>"                                      					>> $APACHE_PATH/$DOMAIN
	echo ""                                                          					>> $APACHE_PATH/$DOMAIN
	echo "        ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/"           					>> $APACHE_PATH/$DOMAIN
	echo "        <Directory \"$WWW_DATA_DIR/$USER/$DOMAIN/etc/\">"  					>> $APACHE_PATH/$DOMAIN
	echo "                AllowOverride None"                        					>> $APACHE_PATH/$DOMAIN
	echo "                Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch" 			>> $APACHE_PATH/$DOMAIN
	echo "                Order allow,deny"                                   			>> $APACHE_PATH/$DOMAIN
	echo "                Allow from all"                                     			>> $APACHE_PATH/$DOMAIN
	echo "        </Directory>"                                               			>> $APACHE_PATH/$DOMAIN
	echo ""                                                                   			>> $APACHE_PATH/$DOMAIN
	echo "        ErrorLog $WWW_DATA_DIR/$USER/$DOMAIN/logs/error.log"       		  	>> $APACHE_PATH/$DOMAIN
	echo ""                                                                           	>> $APACHE_PATH/$DOMAIN
	echo "        # Possible values include: debug, info, notice, warn, error, crit," 	>> $APACHE_PATH/$DOMAIN
	echo "        # alert, emerg."                                                    	>> $APACHE_PATH/$DOMAIN
	echo "        LogLevel warn"                                                      	>> $APACHE_PATH/$DOMAIN
	echo ""                                                                           	>> $APACHE_PATH/$DOMAIN
	echo "        CustomLog $WWW_DATA_DIR/$USER/$DOMAIN/logs/access.log combined"     	>> $APACHE_PATH/$DOMAIN
	echo "</VirtualHost>"                                                             	>> $APACHE_PATH/$DOMAIN
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





