#!/bin/bash
python3 chaospy.py -dnew
python3 chaospy.py -dupd
unzip -o '*.zip'
rm *.zip
cat *.txt >> newdomains.md
rm *.txt
awk 'NR==FNR{lines[$0];next} !($0 in lines)' alltargets.txtls newdomains.md >> domains.txtls
echo Hourly scan result $(date +%F-%T) | notify -telegram -telegram-api-key <<enter api key>> -telegram-chat-id <<enter chat id>>
echo "Total $(wc -l < domains.txtls) new domains found" | notify -telegram -telegram-api-key <<enter api key>> -telegram-chat-id <<enter chat id>>
nuclei -ut
if [ -s domains.txtls ]
then
        cat domains.txtls >> alltargets.txtls
        cat domains.txtls | httpx -fl 0 -mc 200 >> newurls.txtls
        echo "Total $(wc -l < newurls.txtls) live websites found" | notify -telegram -telegram-api-key <<enter api key>> -telegram-chat-id <<enter chat id>>
        cat alltargets.txtls | anew >> alltargets2.txtls
        rm alltargets.txtls
        mv alltargets2.txtls alltargets.txtls
        echo Below vulnerability $(date +%F-%T) | notify -telegram -telegram-api-key <<enter api key>> -telegram-chat-id <<enter chat id>>
        echo "Starting nuclei"
        cat newurls.txtls | nuclei -t /root/nuclei-templates/ -silent -severity critical,high,medium | notify -telegram -telegram-api-key <<enter api key>> -telegram-chat-id <<enter chat id>>
        echo "nuclei completed"
        rm newurls.txtls domains.txtls newdomains.md
else
        echo No new domains $(date +%F-%T) | notify -telegram -telegram-api-key <<enter api key>> -telegram-chat-id <<enter chat id>>
        rm domains.txtls
        rm newdomains.md
fi
