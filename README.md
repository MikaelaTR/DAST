# DAST
##To run the script, follow these steps:
##sudo apt update
##sudo apt install apt-transport-https ca-certificates curl software-properties-common
##curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
##echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
##sudo apt update
##sudo apt install docker-ce docker-ce-cli containerd.io
##sudo docker build -t my_security_tools .
##sudo chmod +x run_command.sh
##./run_command.sh
