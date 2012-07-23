#!/bin/bash


# Copyright (C) 2012    Jason Millward
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


WWW_DATA_DIR="/data/www"

$(find $WWW_DATA_DIR -type d -exec ls -d {} \; | grep "\/wp-content$" > listOfwpContent.txt)

LINES_ARRAY=( $(cat "listOfwpContent.tmp") )

for idx in $(seq 0 $((${#LINES_ARRAY[@]} - 1))); do
    LINE="${LINES_ARRAY[$idx]}"
    echo "Fixing $LINE"
    chmod 777 $LINE
done
