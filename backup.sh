#! /bin/bash

<< Readme
This is a script for backup of files
Created by Ansh
Readme

function display_usage {
     echo "Usage: ./backup.sh <Source> <Destination>"
}

if [ $# -eq 0 ]; then
	display_usage
fi

timestamp=$(date '+%Y-%m-%d-%H-%M-%S')
source_dir=$1
backup_dir=$2

function create_backup {
	
	mkdir -p backup

	cd "${source_dir}" || exit 1
   	zip -r "${backup_dir}/backup_${timestamp}.zip" "${source_dir}" >/dev/null
	
	if [ $? -eq 0 ]; then
		echo -e "\nBackup created successfully for ${timestamp}\n"
	fi

}

function perform_rotation {
	backups=($(ls -t "${backup_dir}/backup_"*.zip 2>/dev/null))
	echo "${backups[@]}"
	echo -e "\nTotal backups: ${#backups[@]}\n"


	if [ "${#backups[@]}" -gt 5 ] ; then
		echo "Performing rotation for 5 days"
	        
		backups_to_remove=("${backups[@]:5}")	

	for backup in "${backups_to_remove[@]}";
	do 
		rm -f ${backup}
	done 

	fi
	
#	ls backup || echo "Failed to look into backup direc"
}

create_backup
perform_rotation

