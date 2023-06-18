# Docker

## Check out how I brought my Docker image size down

> docker image ls redhat/ubi8
![](https://raw.github.com/SubrahmanyamRaparti/Docker/main/images/redhat\ubi8.png)

#### Dockerfile
```
FROM redhat/ubi8:latest

MAINTAINER SubrahmanyamRaparti rv.subrahmanyam1@gmail.com

RUN yum install -y unzip --setopt=install_weak_deps=False

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \ 
    unzip awscliv2.zip && \
    ./aws/install && \
    echo "AWS CLI VERSION - " $(/usr/local/bin/aws --version)
    
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256" && \
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum -c && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    echo "KUBECTL VERSION - " $(/usr/local/bin/kubectl version --client --output=yaml)
```
> docker image ls
![](https://raw.github.com/SubrahmanyamRaparti/Docker/main/images/k8s-ecr-cred-updater-ubi8-1.png)

```
FROM redhat/ubi8:latest

MAINTAINER SubrahmanyamRaparti rv.subrahmanyam1@gmail.com

RUN yum install -y unzip --setopt=install_weak_deps=False

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \ 
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -fr aws awscliv2.zip && \
    echo "AWS CLI VERSION - " $(/usr/local/bin/aws --version)
    
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256" && \
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum -c && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm -fr kubectl kubectl.sha256 && \
    echo "KUBECTL VERSION - " $(/usr/local/bin/kubectl version --client --output=yaml)
```
> docker image ls
![](https://raw.github.com/SubrahmanyamRaparti/Docker/main/images/k8s-ecr-cred-updater-ubi8-2.png)

> docker image ls alpine
![](https://raw.github.com/SubrahmanyamRaparti/Docker/main/images/alpine.png)

```
FROM alpine:latest

MAINTAINER SubrahmanyamRaparti rv.subrahmanyam1@gmail.com

RUN apk --no-cache add python3 py3-pip curl

RUN pip3 install --upgrade pip && \
    pip3 install --no-cache-dir awscli
    
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256" && \
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum -c && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm -fr kubectl kubectl.sha256 && \
    echo "KUBECTL VERSION - " $(/usr/local/bin/kubectl version --client --output=yaml)
    
RUN apk del python3 py3-pip curl && apk cache clean
```
> docker image ls
![](https://raw.github.com/SubrahmanyamRaparti/Docker/main/images/k8s-ecr-cred-updater-alpine-1.png)


```
FROM alpine:latest

MAINTAINER SubrahmanyamRaparti rv.subrahmanyam1@gmail.com

RUN apk --no-cache add python3 py3-pip curl && \ 
    pip3 install --upgrade pip && \
    pip3 install --no-cache-dir awscli
    
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256" && \
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum -c && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm -fr kubectl kubectl.sha256 && \
    echo "KUBECTL VERSION - " $(/usr/local/bin/kubectl version --client --output=yaml)
    
RUN apk del python3 py3-pip curl && apk cache clean
```
> docker image ls
![](https://raw.github.com/SubrahmanyamRaparti/Docker/main/images/k8s-ecr-cred-updater-alpine-2.png)

```
FROM alpine:latest

MAINTAINER SubrahmanyamRaparti rv.subrahmanyam1@gmail.com

RUN apk --update --no-cache add \
    python3 \
    py-pip \
    curl \
    && python3 -m pip install --no-cache-dir awscli \
    && rm -rf /var/cache/apk/* /root/.cache/pip/*
    
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256" && \
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum -c && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm -fr kubectl kubectl.sha256 && \
    echo "KUBECTL VERSION - " $(/usr/local/bin/kubectl version --client --output=yaml)
    
RUN apk del python3 py3-pip curl && apk cache clean
```
> docker image ls
![](https://raw.github.com/SubrahmanyamRaparti/Docker/main/images/k8s-ecr-cred-updater-alpine-3.png)