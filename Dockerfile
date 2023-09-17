# Используем официальный образ OWASP ZAP
FROM owasp/zap2docker-stable:latest

# Обновляем индексы пакетов и устанавливаем пакеты для установки Go
USER root
RUN apt-get update && apt-get install --allow-unauthenticated -y wget && apt install perl

RUN wget https://golang.org/dl/go1.20.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.20.linux-amd64.tar.gz && \
    rm go1.20.linux-amd64.tar.gz
ENV PATH="/usr/local/go/bin:${PATH}"
# Устанавливаем переменные окружения для Go
ENV GOPATH=/go
ENV PATH=$PATH:/go/bin

#Клонируем репозиторий Nikto и устанавливаем зависимости
RUN git clone https://github.com/sullo/nikto.git
WORKDIR nikto/program
RUN git checkout nikto-2.5.0

# Создаем директорию для Go-проектов
RUN mkdir -p $GOPATH/src

RUN pip install wapiti3

# Установим Nuclei
ENV GO111MODULE=on
RUN go clean -modcache
RUN go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
# Укажем рабочий каталог
#CMD [ "echo "nikto starting....." && "perl nikto.pl -h $URL -o /zap/wrk/nikto_result.html -Format html", 
#"echo "wapiti started......." && "wapiti -v2 -u $URL -o /zap/wrk/wapiti_result.html -f html" ,
#"echo "NUCLEI stared" && nuclei -u $URL -o /home/zap/result" ,"echo "ZAP started" && zap-full-scan.py -t $URL -r /zap/wrk/resultZAP.html" ]
COPY start.sh /home/app/run_commands.sh
RUN chmod +x /home/app/run_commands.sh
ENTRYPOINT ["/home/app/run_commands.sh"]
