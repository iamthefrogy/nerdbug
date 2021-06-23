# nerdbug - Hunt while you are sleeping
An automation tool that downloads CHAOS project discovery data every hour compares it with the master domain list, identifies new domains, runs Nuclei on it and automatically provides you with the final result via Telegram push notifications. Cron job automation is already implemented. <br/>

![Automation](https://user-images.githubusercontent.com/8291014/123051721-f6734900-d3f9-11eb-846d-9721790b8951.png)

+ **Requirements:** Go Language, Python 3.+, jq
+ **Tools used - You must need to install these tools to use this script**<br/>

  + [httpx](https://github.com/projectdiscovery/httpx)
  + [anew](https://github.com/tomnomnom/anew)
  + [nuclei](https://github.com/projectdiscovery/nuclei)
  + [chaospy](https://github.com/ep1n3phr1n3/chaospy)
  
  Make sure these tools are downloaded and binaries are copied in the /usr/bin folder.
  
+ **Installation**

    ```sh
    apt install jq
    git clone https://github.com/iamthefrogy/nerdbug.git && cd nerdbug/ 
    chmod +x nerdbug.sh cronjob.sh && wget https://github.com/ep1n3phr1n3/chaospy/blob/master/chaospy.py
    ```
    
+ **Usage**

    ```sh
    1. First time users - Download the chaos data and rename the file to alltargets.txtls.
    
    wget -q "https://chaos-data.projectdiscovery.io/index.json" && cat index.json | grep "URL" | sed 's/"URL": "//;s/",//' | while read host do;do wget -q "$host";done && for i in `ls -1 | grep .zip$`;  do unzip -o -qq $i; done && rm *.zip
    cat *.txt >> alltargets.txtls
    
    2. Set the integer value within the cron.sh file. It is a number of hours you want to automate this script in the backgroun. Currently set to 3600 seconds means an hour. (SCREEN).    
    
    3. Open nerdbug.sh and insert your telegram bot token and chat id value within the 'token' and 'chat_id' variable which is currently set as << enter API key >> and << enter chat id >>
   
   screen -S nerdbug
   
   ./cronjob.sh
   
   exit screen
    ```
#### Thanks to the authors of the tools used in this script.

**Warning:** This is just a research project. Kindly use it with caution and at your own risk.
