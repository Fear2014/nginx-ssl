FROM nginx:1.15.8

MAINTAINER fear
# add cfssl   --add by fear
COPY cert /etc/nginx/cert

RUN  apt-get update \
      && apt-get install -y curl \
      && curl -s -L -o /bin/cfssl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 \
      && curl -s -L -o /bin/cfssljson https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64 \
      && curl -s -L -o /bin/cfssl-certinfo https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64 \
      && chmod +x /bin/cfssl* \
      && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
      &&  echo 'Asia/Shanghai' >/etc/timezone


CMD ["nginx", "-g", "daemon off;"]
