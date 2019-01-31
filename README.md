nginx_ssl
========

> 包含了ssl证书的nginx镜像

使用说明
-----
> 配置文件、静态文件、证书文件都从外部挂在进去
	
> 镜像中已包含了一个初始的证书，如需修改，请在外部修改ca或者server的配置json文件，然后用cfssl重新生成证书，重启nginx


修改证书
-----
> 证书是使用cfssl+配置文件生成的,直接删除生成的证书文件，修改配置json文件，重新用cfssl生成。

> cfssl具体的用法请百度，下载的命令参考Dockerfile 

> 生成CA的命令 cfssl gencert -initca /etc/nginx/cert/ca-csr.json | cfssljson -bare ca -

> 生成server端的证书 cfssl gencert -ca=/etc/nginx/cert/ca.pem -ca-key=/etc/nginx/cert/ca-key.pem -config=/etc/nginx/cert/ca-config.json -profile=server /etc/nginx/cert/server-csr.json | cfssljson -bare server

测试镜像
-----
>sudo docker run -d --name nginxssl \
>    --net=host --restart=always \
>    --privileged=true \
>    -v $PWD/nginx/cert:/etc/nginx/cert \
>    -v $PWD/home:/home \
>    -v $PWD/nginx/conf.d/default.conf:/etc/nginx/conf.d/default.conf  \
>    nginx:ssl 

>输入https://ip 访问nginx