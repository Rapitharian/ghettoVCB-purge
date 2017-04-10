# Author: J. Steven Vitale
# Created Date: 03/31/2017
# Modified Date: 03/31/3017
# This script is designed to be run 1 hour before gehttoVCB.sh to purge backups on a slow NAS.  
# This will remove the need for the slow NAS customizations in ghettoVCB, thus restoring the upgrade path.
# This script can use the backup list from ghettoVCB or a seperate list.  I recommend a seperate list.
# A seperate list will prevent deleting historical backups before you are ready.
##################################################################
#                   User Definable Parameters
##################################################################

# Set to the location where the purge list is stored. (Dont forget the tralling slash.)
files='/vmfs/volumes/datastore1/files/'

# Set to the name of the purgelist. EX. PurgeList.txt
filename='purgelist'

# Set to the location where the ghettoVCB backups are stored. (Don't forget the tralling slash.)
backupdir='/vmfs/volumes/backups/'

# Set to the number of days of backups to keep.  Equal to the number in ghettoVCB.sh (VM_BACKUP_ROTATION_COUNT=) minus 1.
Days='7' 

# Delay between each delete command, in seconds.
Sleep='120'

# Number of days to "step back".
StepBack='3'

##################################################################                                                    
#                   End User Definable Parameters                                                                     
##################################################################                                                    
                                                                                                                      
########################## DO NOT MODIFY PAST THIS LINE ##########################


# Exit the script If $Days equals zero.  This value will make the script do nothing.
if [ "$Days" -gt 0 ]; 
  then

    # Calculate the number of seconds that makeup the days to step back.
    Days=$(( $Days * 60*60*24 ))
    # Subtract the number of seconds to "step back" from today's date in seconds. 
    DeleteDate=$(( $(date +%s) - $Days ))

    # Read in the contents of the purge file.
    inputfile="$files""$filename"

    # For each line in the file store the value in $vm.
    while read -r vm; do
      # Splits off the first character of the line and tests if it is not a hash, if not then proceed, else skip line.
      if [ "${vm:0:1}" != "#" ]; 
        then
          # Delete all folders found under the base for the server ($vm) that are older than ($days).
          #find "$backupdir""$vm"/* -type d -mtime +"$days" -print -exec rm -rf {} \; >> /vmfs/volumes/datastore1/logs/ghettoVCB-purge-$(date +%Y-%m-%d).log
          # Deletes the file from 6 days ago and then looks back 3 more days to ensure nothing was missed.
          for i in `seq 1 $StepBack`;
            do
              # Delete the directory that is ($Days) old.
              echo rm -rf "$backupdir""$vm"/"$vm"-"$(date -d@"$DeleteDate" +%Y-%m-%d)"_* >> /vmfs/volumes/datastore1/logs/ghettoVCB-purge-$(date +%Y-%m-%d).log
              rm -rf "$backupdir""$vm"/"$vm"-"$(date -d@"$DeleteDate" +%Y-%m-%d)"_*
              # Update Delete date to move backward 1 more day.
              DeleteDate=$(( $DeleteDate - 86400 ))
              # Pause for the number of seconds the user defined in the Sleep variable.
              sleep $Sleep
            done
      fi
    # Works with the while line to read in the file.
    done < "$inputfile"
  else
    echo $Days is not a valid value. >> /vmfs/volumes/datastore1/logs/ghettoVCB-purge-$(date +%Y-%m-%d).log                                               
    Exit 0
fi
