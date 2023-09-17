#!/bin/bash
echo "Пожалуйста, введите url:"
read url
echo "Адресс сканирования: $url"
docker stop dast
docker rm dast
docker run -it --restart=always -v $(pwd):/zap/wrk -e URL=$url -u $(id -u ${USER}):$(id -g ${USER}) --name dast my_security_tools
docker cp dast:/zap/wrk/nuclei_result.html .
docker cp dast:/zap/wrk/resultZAP.html .
docker cp dast:/zap/wrk/nikto_result.html .
docker cp dast:/zap/wrk/wapiti_result .
output_file="Final-report.html"
pages=("nuclei_result.html" "resultZAP.html" "nikto_result.html")

echo "" > $output_file

for page in "${pages[@]}"
do
if [ -f "$page" ]; then
content=$(cat "$page")
echo "" >> $output_file
echo "$content" >> $output_file
else
echo "Файл $page не найден"
fi
done

echo "" >> $output_file

echo "Объединенный файл сохранен в $output_file"
