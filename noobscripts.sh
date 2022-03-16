#!/bin/bash


threads=80
dirsearchWordlist=~/payloads/myFuzzList.txt 

red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput sgr0`

domain=
domainCount=0
totalDomains=0


while getopts ":d:e:r:" o; do
    case "${o}" in
        d)
            domain=${OPTARG}
            ;;

        *)
            usage
            ;;
    esac
done
shift $((OPTIND - 1))







main(){

  source ~/.bashrc
  source ~/.profile
 
  clear
  logo
  if [ -d "$HOME/recon/targets/$domain" ]
  then
    echo "This is a known target."
  else
    mkdir $HOME/recon/targets/$domain
  fi
  


mkdir $HOME/recon/targets/$domain/$foldername
mkdir $HOME/recon/targets/$domain/$foldername/screenshots
mkdir $HOME/recon/targets/$domain/$foldername/subdomains
mkdir $HOME/recon/targets/$domain/$foldername/screenshots/aquatone;

#mkdir $HOME/recon/targets/$domain/$foldername/waybackurls
#touch $HOME/recon/targets/$domain/$foldername/waybackurls/waybackurls.txt
#touch $HOME/recon/targets/$domain/$foldername/waybackurls/parameters.txt
#touch $HOME/recon/targets/$domain/$foldername/waybackurls/js.txt
#touch $HOME/recon/targets/$domain/$foldername/waybackurls/php.txt
#touch $HOME/recon/targets/$domain/$foldername/waybackurls/aspx.txt
#touch $HOME/recon/targets/$domain/$foldername/waybackurls/jsp.txt
#touch $HOME/recon/targets/$domain/$foldername/waybackurls/json.txt

touch $HOME/recon/targets/$domain/$foldername/subdomains/assetfinder.txt
touch $HOME/recon/targets/$domain/$foldername/subdomains/crtsh.txt
touch $HOME/recon/targets/$domain/$foldername/subdomains/certspotter.txt
touch $HOME/recon/targets/$domain/$foldername/subdomains/all.txt
touch $HOME/recon/targets/$domain/$foldername/subdomains/alive.txt
touch $HOME/recon/targets/$domain/$foldername/subdomains/uniqueAlive.txt



recon $domain




}


usage() {

 echo -e "Usage: $0 -d domain \n " 1>&2; exit 1; 


}




logo(){

echo "${red}

    ▐ ▄             ▄▄▄▄·     .▄▄ ·  ▄▄· ▄▄▄  ▪   ▄▄▄·▄▄▄▄▄.▄▄ · 
   •█▌▐█▪     ▪     ▐█ ▀█▪    ▐█ ▀. ▐█ ▌▪▀▄ █·██ ▐█ ▄█•██  ▐█ ▀. 
   ▐█▐▐▌ ▄█▀▄  ▄█▀▄ ▐█▀▀█▄    ▄▀▀▀█▄██ ▄▄▐▀▀▄ ▐█· ██▀· ▐█.▪▄▀▀▀█▄
   ██▐█▌▐█▌.▐▌▐█▌.▐▌██▄▪▐█    ▐█▄▪▐█▐███▌▐█•█▌▐█▌▐█▪·• ▐█▌·▐█▄▪▐█
   ▀▀ █▪ ▀█▄▀▪ ▀█▄▀▪·▀▀▀▀      ▀▀▀▀ ·▀▀▀ .▀  ▀▀▀▀.▀    ▀▀▀  ▀▀▀▀ 

   
${reset}
                                                          "
}


recon(){

enumeration

livehost

#wayback

#webscreenshot

aquatone

}


enumeration(){

echo "${green} Recon started on $domain ${reset}"


echo "

 Listing subdomains using subfinder...
"

subfinder -d $domain -t $threads -o $HOME/recon/targets/$domain/$foldername/subfinder.txt > /dev/null

domainCount="$(cat $HOME/recon/targets/$domain/$foldername/subfinder.txt | wc -l)"

totalDomains=$((totalDomains+domainCount))

echo " ${yellow}Domains found using subfinder: ${domainCount}, Total Subdomains: ${totalDomains} ${reset}"

domainCount=0




echo "

 Listing subdomains using sublister...
"

python3 ~/recon/tools/Sublist3r/sublist3r.py -d $domain -t $threads -o $HOME/recon/targets/$domain/$foldername/sublister.txt > /dev/null

domainCount="$(cat $HOME/recon/targets/$domain/$foldername/sublister.txt | wc -l)"

totalDomains=$((totalDomains+domainCount))

echo " ${yellow}Domains found using sublister: ${domainCount}, Total Subdomains: ${totalDomains} ${reset}"

domainCount=0




echo "

 Listing subdomains using Assetfinder...
"

assetfinder --subs-only $domain >> $HOME/recon/targets/$domain/$foldername/assetfinder.txt

domainCount="$(cat $HOME/recon/targets/$domain/$foldername/assetfinder.txt | wc -l)"

totalDomains=$((totalDomains+domainCount))

echo " ${yellow}Domains found using Assetfinder: ${domainCount}, Total Subdomains: ${totalDomains} ${reset}"

domainCount=0




echo "

 Listing subdomains using crtsh...
"

curl -s https://crt.sh/\?q\=%.$domain\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u >> $HOME/recon/targets/$domain/$foldername/crtsh.txt 

domainCount="$(cat $HOME/recon/targets/$domain/$foldername/crtsh.txt | wc -l)"

totalDomains=$((totalDomains+domainCount))

echo " ${yellow}Domains found using crtsh: ${domainCount}, Total Subdomains: ${totalDomains} ${reset}"

domainCount=0




echo "

 Listing subdomains using certspotter...
"

curl -s https://certspotter.com/api/v0/certs\?domain\=$domain | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u | grep $domain >> $HOME/recon/targets/$domain/$foldername/certspotter.txt 

domainCount="$(cat $HOME/recon/targets/$domain/$foldername/certspotter.txt | wc -l)"

totalDomains=$((totalDomains+domainCount))

echo " ${yellow}Domains found using certspotter: ${domainCount}, Total Subdomains: ${totalDomains} ${reset}"

domainCount=0




#echo "

 #Listing subdomains using Amass...
#"

#amass enum -d $domain -max-dns-queries 300 -o $HOME/recon/targets/$domain/$foldername/amass.txt > /dev/null

#domainCount="$(cat $HOME/recon/targets/$domain/$foldername/amass.txt | wc -l)"

#totalDomains=$((totalDomains+domainCount))

#echo " ${yellow}Domains found using Amass: ${domainCount}, Total Subdomains: ${totalDomains} ${reset}"

#domainCount=0




echo "

 Listing subdomains using findomain...
"

cd $HOME/recon/targets/$domain/$foldername

findomain --target $domain --threads $threads -u findomain.txt > /dev/null

cd $HOME/recon

domainCount="$(cat $HOME/recon/targets/$domain/$foldername/findomain.txt | wc -l)"

totalDomains=$((totalDomains+domainCount))

echo " ${yellow}Domains found using findomain: ${domainCount}, Total Subdomains: ${totalDomains} ${reset}"



}

livehost(){

echo "

 Adding all the subdomains to all.txt
"

cat $HOME/recon/targets/$domain/$foldername/subfinder.txt $HOME/recon/targets/$domain/$foldername/sublister.txt $HOME/recon/targets/$domain/$foldername/findomain.txt $HOME/recon/targets/$domain/$foldername/assetfinder.txt $HOME/recon/targets/$domain/$foldername/crtsh.txt $HOME/recon/targets/$domain/$foldername/certspotter.txt >> $HOME/recon/targets/$domain/$foldername/all.txt
#$HOME/recon/targets/$domain/$foldername/amass.txt 
echo " ${yellow}Added ${totalDomains} subdomains to ../targets/$domain/$foldername/all.txt ${reset}"

echo "

 Listing unique live subdomains
"

cat $HOME/recon/targets/$domain/$foldername/all.txt | httprobe >> $HOME/recon/targets/$domain/$foldername/alive.txt

cat $HOME/recon/targets/$domain/$foldername/alive.txt | sort -u >> $HOME/recon/targets/$domain/$foldername/uniqueAlive.txt

uniquecount="$(cat $HOME/recon/targets/$domain/$foldername/uniqueAlive.txt | wc -l)"

echo " ${yellow}Found ${uniquecount} unique subdomains. Adding it to $HOME/recon/targets/$domain/$foldername/uniqueAlive.txt ${reset}"

}


wayback(){

echo "

 Scraping wayback for data...

"

cat $HOME/recon/targets/$domain/$foldername/uniqueAlive.txt | waybackurls > $HOME/recon/targets/$domain/$foldername/waybackurls/waybackurls.txt 

cat $HOME/recon/targets/$domain/$foldername/waybackurls/waybackurls.txt  | sort -u | unfurl --unique keys > $HOME/recon/targets/$domain/$foldername/waybackurls/parameters.txt
[ -s $HOME/recon/targets/$domain/$foldername/waybackurls/parameters.txt  ] && echo " ${yellow}Wordlist saved to /$domain/$foldername/waybackurls/parameters.txt${reset}
" 

cat $HOME/recon/targets/$domain/$foldername/waybackurls/waybackurls.txt  | sort -u | grep -P "\w+\.js(\?|$)" | sort -u > $HOME/recon/targets/$domain/$foldername/waybackurls/js.txt
[ -s $HOME/recon/targets/$domain/$foldername/waybackurls/js.txt ] && echo " ${yellow}JS Urls saved to /$domain/$foldername/waybackurls/js.txt${reset}
" 

cat $HOME/recon/targets/$domain/$foldername/waybackurls/waybackurls.txt  | sort -u | grep -P "\w+\.php(\?|$) | sort -u " > $HOME/recon/targets/$domain/$foldername/waybackurls/php.txt
[ -s $HOME/recon/targets/$domain/$foldername/waybackurls/php.txt ] && echo " ${yellow}PHP Urls saved to /$domain/$foldername/waybackurls/php.txt${reset}
" 

cat $HOME/recon/targets/$domain/$foldername/waybackurls/waybackurls.txt  | sort -u | grep -P "\w+\.aspx(\?|$) | sort -u " > $HOME/recon/targets/$domain/$foldername/waybackurls/aspx.txt
[ -s $HOME/recon/targets/$domain/$foldername/waybackurls/aspx.txt ] && echo " ${yellow}ASP Urls saved to /$domain/$foldername/wayback-data/aspx.txt${reset}
" 

cat $HOME/recon/targets/$domain/$foldername/waybackurls/waybackurls.txt  | sort -u | grep -P "\w+\.jsp(\?|$) | sort -u " > $HOME/recon/targets/$domain/$foldername/waybackurls/jsp.txt
[ -s $HOME/recon/targets/$domain/$foldername/waybackurls/jsp.txt ] && echo " ${yellow}JSP Urls saved to /$domain/$foldername/waybackurls/jsp.txt${reset}
" 

cat $HOME/recon/targets/$domain/$foldername/waybackurls/waybackurls.txt  | sort -u | grep -P "\w+\.json(\?|$) | sort -u " > $HOME/recon/targets/$domain/$foldername/waybackurls/json.txt
[ -s $HOME/recon/targets/$domain/$foldername/waybackurls/json.txt ] && echo " ${yellow}JSON Urls saved to /$domain/$foldername/waybackurls/json.txt${reset}

" 

echo " ${yellow}Waybackurls has finished the scraping process${reset}"

}


webscreenshot(){

echo "

 Taking screenshots of live subdomains...
"

python3 ~/karna/recon/webscreenshot/webscreenshot.py -i $HOME/recon/targets/$domain/$foldername/uniqueAlive.txt -o $HOME/recon/targets/$domain/$foldername/webscreenshot/ -t 50 > /dev/null

echo " ${yellow}Finished taking sceenshots${reset}"

echo "

	HOPE YOU FIND LOTS OF BUGS WITH THIS DATA :)

	HAPPY HACKING! 

"


}


aquatone(){

echo "

 Taking screenshots of live subdomains...
"

cd $HOME/recon/targets/$domain/$foldername/screenshots/aquatone;

cat $HOME/recon/targets/$domain/$foldername/uniqueAlive.txt | aquatone -threads $threads -out $HOME/recon/targets/$domain/$foldername/screenshots/aquatone -scan-timeout 300 -http-timeout 7000

echo " ${yellow}Finished taking sceenshots${reset}"

echo "

	HOPE YOU FIND LOTS OF BUGS WITH THIS DATA :)

	HAPPY HACKING! 

"


}




todate=$(date +"%Y-%m-%d")
foldername=recon-$todate
main $domain


