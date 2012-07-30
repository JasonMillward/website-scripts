#!/bin/bash 
#
# SQL backup -> Dropbox uploader v1.0

# Copyright (C) 2012	Jason Millward
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


# Path for bash dropbox uploader, can be found at; 
#	https://github.com/andreafabrizi/Dropbox-Uploader
DROPBOX_UPLOADER_PATH="/data/scripts/dropbox"

# Dropbox save path
DROPBOX_SAVE_PATH="/Website Backups/SQL Backups"


perl /var/www-81/dumper/msd_cron/crondump.pl

for FILE in /var/www-81/dumper/work/backup/*; do
    TITLE=${FILE/\/var\/www-81\/dumper\/work\/backup\///}
    $DROPBOX_UPLOADER_PATH/dropbox_uploader.sh upload "$FILE" \
	"$DROPBOX_SAVE_PATH/$TITLE" >> /dev/null
    rm $FILE
done

echo "Backup script completed"

