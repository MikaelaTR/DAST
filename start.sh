#!/bin/bash
echo "===============NIKTO starting======================" && perl nikto.pl -h $URL -o /zap/wrk/nikto_result.html -Format html
echo "===============WAPITI starting=====================" && wapiti -u $URL -f html -o /zap/wrk/wapiti_result
echo "===============NUCLEI starting=====================" && nuclei -u $URL -o /zap/wrk/nuclei_result.html
echo "===============ZAP starting========================" && zap-full-scan.py -t $URL -r /zap/wrk/resultZAP.html
