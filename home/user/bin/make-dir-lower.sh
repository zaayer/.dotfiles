#!/usr/bin/env sh

ls | while read upName
do loName=`echo "${upName}" | tr '[:upper:]' '[:lower:]'`
mv "$upName" "$loName"
done
