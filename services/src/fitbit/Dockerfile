FROM python:3.6-stretch

# MAINTAINER Raju Bandari <raju.bandari1910@gmail.com>

RUN apt-get update && apt-get install -y gcc make apt-transport-https ca-certificates build-essential

RUN python3 --version
RUN pip3 --version

WORKDIR  /usr/src/

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . /src/
RUN ls -la /src/*

CMD ["python3", "/src/main.py"]