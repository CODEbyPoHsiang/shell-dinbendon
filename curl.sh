#!bin/bash

result=$(curl -s https://dinbendon.net/do/login -c cookies | tee content.html | grep -w "6em"|sed 's/<[^<]*>//g'|sed 's/=//g'|bc )

posturl=$(grep -w 'form action="' content.html | grep -oP '(\/do\/;jsessionid=[0-9A-F]+(.*?)")' |sed 's/"//g')

curl -b cookies -d "signInPanel_signInForm%3Ahf%3A0=&username=guest&password=guest&result=$result&submit=%E7%99%BB%E5%85%A5" -X POST  "https://dinbendon.net$posturl"

echo "爬蟲開始..." 
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' - #水平線分隔

curl -b cookies  -L -s  https://dinbendon.net/do/ | grep -w '<td ><a href="'|sed 's/<[^<]*>//g'|awk  -d '{ print $1 }'

printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' - #水平線分隔
now="$(date +'%Y-%m-%d %H:%M:%S')"
echo "爬蟲結束 時間:$now"
