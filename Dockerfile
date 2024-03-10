FROM alpine:latest

LABEL "naintainer"="SubrahmanyamRaparti" "email"="rv.subrahmanyam1@gmail.com"

# RUN groupadd -r subbu && useradd -r -g subbu subbu
RUN addgroup -S subbu && adduser -S subbu -G subbu -h /home/subbu

# RUN chsh -s /usr/sbin/nologin root

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

USER subbu