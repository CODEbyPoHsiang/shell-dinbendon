#!bin/bash
#result獲取驗證碼變數
result=$(curl -s  https://dinbendon.net/do/login  -c cookies | grep -w "6em"|sed 's/<[^<]*>//g'|sed 's/=//g'|bc )
#posturl獲取提交時變動網址串變數
posturl=$(curl -s  https://dinbendon.net/do/login | grep -w 'form action="'|grep -oP '(\/do\/;jsessionid=[0-9A-F]+(.*?)")' |sed 's/"//g')
#準備post資料，要攜帶以存的cookie模擬post，$result跟$posturl兩個變數一併帶入
curl -b cookies -d "signInPanel_signInForm%3Ahf%3A0=&username=guest&password=guest&result=$result&submit=%E7%99%BB%E5%85%A5" -X POST  "https://dinbendon.net$posturl"

echo "爬蟲開始..." 

printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' - #水平線分隔

#獲取登入後頁面資料，要帶上以存的cookies並要加入-L參數，防止網站302轉址，利用grep過濾，再使用awk印出來
curl -b cookies  -L -s  https://dinbendon.net/do/ | grep -w '<td ><a href="'|sed 's/<[^<]*>//g'|awk  -d '{ print $1 }'

printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' - #水平線分隔

now="$(date +'%Y-%m-%d %H:%M:%S')"
echo "爬蟲結束 時間:$now"
