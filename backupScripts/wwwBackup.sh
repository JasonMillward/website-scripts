#!/bin/bash 
#
# WWW Dir backup -> Dropbox uploader v1.2
# 
# This script;
#	Scours a set web directory for htdocs folders 
#	Zips them into a nice archive
#	Splits them if they are greater then 100MB in size
#	Uploads the archive(s) to Drobox
#
#
# It relies upon directories being in a similar structure to the one below
#	 
# /data/www
# |-- jason
# |   |-- jcode.me
# |   |   |-- etc
# |   |   |-- htdocs
# |   |   `-- logs
# |   `-- thatcatstat.com
# |       |-- etc
# |       |-- htdocs
# |       `-- logs
# ...
#
# When uploading to dropbox, it saves the archive in a subdirectory 
#	similar to the folderstructure above.
#
# TODO: Fill in more information :)
#
#
#
# Version    $Id: 1.1, 2012-07-30 07:54:52 CEST $;
# Author     Jason Millward
# Copyright  2012 Jason Millward
#
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



source $(pwd)/config.cfg

NOW=`date +%s`;OLD=`stat -c %Z $DIR/$TMP_FILE_LIST`;((DIFF = ($NOW - $OLD)/60 ))
OLD_IFS=$IFS; IFS=$'\n'

rm -rf $BACKUP_DIR
mkdir -p "$BACKUP_DIR"


if [ -z $1 ]; then
    TITLE="TEMP"
fi 

if [[ "$1" == "Monthly" ]]; then
    TITLE=`date "+%B"`
    TITLE="$TITLE"      
else 
    TITLE="$1"
fi

if [ $DIFF -gt "120" ]; then
    echo "Scanning for new directories"
    $(find $WWW_DATA_DIR -type d -exec ls -d {} \; | grep "\/htdocs$" > $DIR/$TMP_FILE_LIST)
else 
    echo "Not scanning for new directories"
fi

echo "Loading directories into array"

LINES_ARRAY=( $(cat "$DIR/$TMP_FILE_LIST") )
IFS=$OLD_IFS

for idx in $(seq 0 $((${#LINES_ARRAY[@]} - 1))); do
    LINE="${LINES_ARRAY[$idx]}"
    UPATH=${LINE/\/data\/www\//}
    UPATH=${UPATH/\/htdocs//}

    echo ""
    echo "> Backing up ${LINE}"

    zip -1 -q -r $BACKUP_DIR/$TITLE.zip $LINE
    FILESIZE=$(stat -c%s "$BACKUP_DIR/$TITLE.zip")

    if [ $FILESIZE -gt 104857600 ]; then
        zipsplit -q -n 104857600 -b $BACKUP_DIR $BACKUP_DIR/$TITLE.zip
        rm $BACKUP_DIR/$TITLE.zip
    fi
    
    echo "> Uploading backup"

    for FILE in $BACKUP_DIR/*; do
        FTITLE=${FILE/\/tmp\/backups\///}
        $DROPBOX_UPLOADER_PATH/dropbox_uploader.sh upload "$FILE" "$DROPBOX_SAVE_PATH/$UPATH/$FTITLE"
        rm $FILE
    done

    echo "> Uploading Complete"
done

echo "Backup script completed"

