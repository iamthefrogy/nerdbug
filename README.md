# nerdbug - Hunt while you are sleeping
<h4 align="left"> Made with ❤️ ❤️ ❤️ from <img src="https://user-images.githubusercontent.com/8291014/145205748-5530f102-9102-4659-a141-21872f237c57.png" alt="frogy" height=20px> </h4>

![](https://visitor-badge.glitch.me/badge?page_id=iamthefrogy.nerdbug)<a href="https://twitter.com/iamthefrogy"> </a>

An automation tool that downloads CHAOS project discovery data every hour compares it with the master domain list, identifies new domains, runs Nuclei on it and automatically provides you with the final result via [notify](https://github.com/projectdiscovery/notify) and publish it to a variety of supported platforms like Telegram, Discord, Slack, etc. Cron job automation is already implemented. <br/>

![Automation](https://user-images.githubusercontent.com/8291014/123051721-f6734900-d3f9-11eb-846d-9721790b8951.png)

+ **Requirements:** Go Language 1.17.+, Python 3.+, jq
+ **Tools used - You must need to install these tools to use this script**<br/>

  + [httpx](https://github.com/projectdiscovery/httpx)
  + [anew](https://github.com/tomnomnom/anew)
  + [nuclei](https://github.com/projectdiscovery/nuclei)
  + [chaospy](https://github.com/PhotonBolt/chaospy)
  + [notify](https://github.com/projectdiscovery/notify)
  
  Make sure these tools are downloaded and binaries are copied in the /usr/bin folder.
  
+ **Installation**

    ```sh
    apt install jq
    git clone https://github.com/iamthefrogy/nerdbug.git && cd nerdbug/ 
    chmod +x cron.sh
    chmod +x nerdbug.sh
    
    When you install the chaospy tool, place the binary in the nerdbug folder.
    ```
    
+ **Usage**

    ```sh
    1. First time users - Download the chaos data into text file and save it as alltargets.txtls. Plenty of methods out there for this.
    
    2. Set the integer value within the cron.sh file. It is a number of hours you want to automate this script in the background. Currently set to 3600 seconds means an hour. (SCREEN).    
    
    3. Set up and edit Notify Provider Config (default provider config file can be created at $HOME/.config/notify/provider-config.yaml) to suit your needs (support single / multiple providers where do you want to send the notification to)
    4. Open nerdbug.sh and set the provider in which is currently set as notify -provider <<provider to send the notification to (eg. telegram,discord,slack)>>
   
   screen -S nerdbug
   
   ./cron.sh
   
   exit screen
    ```
#### Thanks to the authors of the tools used in this script.

**Warning:** This is just a research project. Kindly use it with caution and at your own risk.
