### 主配置文件

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211124161920465.png" alt="image-20211124161920465" style="zoom:80%;" />

```nginx

user  nginx;
worker_processes  auto; # nginx的开放进程个数

error_log  /var/log/nginx/error.log notice;  # 错误日志格式
pid        /var/run/nginx.pid;  # 进程编号


events {
    worker_connections  1024; # 同时可允许的用户连接
}


http {
    include       /etc/nginx/mime.types;	# 文档及程序关联记录
    default_type  application/octet-stream;	# 默认以字节形式进行信息读取
		# 定义了一个日志格式
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
		# 访问日志
    access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;

    #gzip  on;

    include /etc/nginx/conf.d/*.conf;
}
~  
```

### 虚拟主机（网站监听发布）

文件名以``.conf``结尾都能被Nginx识别

以前的版本server是以``server{}``的形式嵌入到主配置文件中的

```nginx
server {
    listen       80;	#监听端口
    server_name  localhost;	# 域名

    #access_log  /var/log/nginx/host.access.log  main;

    location / {
        root   /usr/share/nginx/html;	# 映射的默认网站
        index  index.html index.htm;	# 网站主页
    }

    #error_page  404              /404.html;

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    # proxy the PHP scripts to Apache listening on 127.0.0.1:80
    #
    #location ~ \.php$ {
    #    proxy_pass   http://127.0.0.1;
    #}

    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #
    #location ~ \.php$ {
    #    root           html;
    #    fastcgi_pass   127.0.0.1:9000;
    #    fastcgi_index  index.php;
    #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
    #    include        fastcgi_params;
    #}

    # deny access to .htaccess files, if Apache's document root
    # concurs with nginx's one
```

### Nginx日志模块

```nginx
 log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
# $remote_addr 用户IP地址
# $remote_user 用户名
# $time_local 当地时间
# $request 请求形式 请求内容 http协议版本 
# $status 请求状态码 
# $body_bytes_sent 请求的文件大小（传输给用户的文件大小）
# $http_referer a标签等跳转标签的链接网站（由后往前）
# $http_user_agent 客户端浏览器相关信息
# $http_x_forwarded_for 代理内容
```

### 404页面

``error_page   500 502 503 504  /50x.html;``

写一个新的404页面，再去配置内更改上述/50x.html

### 日志缓存

<img src="C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211125095254174.png" alt="image-20211125095254174" style="zoom:80%;" />

![image-20211125095715283](C:\Users\ghdyx\AppData\Roaming\Typora\typora-user-images\image-20211125095715283.png)

不推荐使用，内存资源占用较多

