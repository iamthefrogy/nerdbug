#!/bin/bash

# Download and update domains
./chaospy.py --download-new
./chaospy.py --download-updated
unzip -o '*.zip'
rm *.zip
cat *.txt >> newdomains.md
rm *.txt
awk 'NR==FNR{lines[$0];next} !($0 in lines)' alltargets.txtls newdomains.md >> domains.txtls

# Send new domains result to notify
echo Hourly scan result $(date +%F-%T) | notify -provider <<provider to send the notification to (eg. telegram, discord, slack)>>
echo "Total $(wc -l < domains.txtls) new domains found" | notify -provider <<provider to send the notification to (eg. telegram, discord, slack)>>

# Update nuclei and nuclei-templates
nuclei -update
nuclei -ut

# Find live host/domain using httpx and send result to notify
if [ -s domains.txtls ]
then
        cat domains.txtls >> alltargets.txtls
        cat domains.txtls | httpx -fl 0 -mc 200 >> newurls.txtls
        echo "Total $(wc -l < newurls.txtls) live websites found" | notify -provider <<provider to send the notification to (eg. telegram, discord, slack)>>
        cat alltargets.txtls | anew >> alltargets2.txtls
        rm alltargets.txtls
        mv alltargets2.txtls alltargets.txtls
        echo Below vulnerability $(date +%F-%T) | notify -provider <<provider to send the notification to (eg. telegram, discord, slack)>>
 
# Scan live host/domain for vulnerability using nuclei and send result to notify      
        echo "Starting nuclei"
        cat newurls.txtls | nuclei -t /root/nuclei-templates/ -silent -severity critical,high,medium | notify -provider <<provider to send the notification to (eg. telegram, discord, slack)>>
        echo "nuclei completed"
        rm newurls.txtls domains.txtls newdomains.md

else

# Send result to notify if no new domains found
        echo No new domains $(date +%F-%T) | notify -provider <<provider to send the notification to (eg. telegram, discord, slack)>>
        rm domains.txtls
        rm newdomains.md
fi
