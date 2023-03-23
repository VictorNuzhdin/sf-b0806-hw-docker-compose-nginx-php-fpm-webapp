# sf-pr08-docker-compose-nginx-php-fpm-webapp
For Skill Factory study project (B8, HW)
<br>

# ИСХОДНАЯ ЗАДАЧА

```bash
01 Возьмите исходники простейшего PHP-приложения как образец;
[https://github.com/SkillfactoryCoding/devops_module10_compose](SkillfactoryCoding/devops_module10_compose)
02 Добавьте "docker-compose.yml" конфигурацию с двумя сервисами: "php" и "nginx";
Nginx должен использовать готовый докер-образ, сервис php должен собираться из текущей директории. 
Для этого в репозитории есть "Dockerfile";
03 Добавьте "healthcheck" для php-сервиса, который ходил бы на http://nginx и проверял содержимое на наличие строки "works" (это можно сделать через curl и grep).
04 Запустить приложение через Docker Compose.

Результатом проверки будет скриншот из браузера по доступному приложению на http://127.0.0.1:80/ 
и содержимое "docker-compose.yml";
```

# КРАТКАЯ ИНСТРУКЦИЯ

### 01 Вносим измения в локальный файл сопоставления ip-адреса и имени хоста

### 01.1 На локальном Docker Linux хосте

```bash
# echo 127.0.0.1 nginx >> /etc/hosts
# tail -n1 /etc/hosts

=OUTPUT:
127.0.0.1 nginx
```

### 01.2 На Windows хосте расположенном в той-же локальной сети что и Docker хост

```bash
> notepad C:\Windows\System32\drivers\etc\hosts

=OUTPUT:
# Custom hosts
# 192.168.230.129 - IP Адрес Docker Linux хоста
192.168.230.129       nginx
```

### 02 Копируем файлы проекта в произвольный каталог на свой Docker-хост (например на Linux Ubuntu Server 22.04)

### 03 Переходим в каталог проекта и проверяем структуру с помощью инструмента "tree"

```bash
# apt install tree
# tree

=OUTPUT:
.
├── configs
│   ├── nginx
│   │   └── default.conf
│   └── php
│       └── php.ini
├── www
│   ├── info
│   │   └── index.php
│   └── index.php
│
├── docker-compose.yml
└── Dockerfile
```

### 04 Проверяем среду выполнения Docker на хосте

```bash
# docker --version

=OUTPUT:
Docker version 23.0.1, build a5ee5b1
```

### 05 Выполняем сборку Образов и запуск Контейнеров из "docker-compose.yml"

```bash
# docker-compose up

=OUTPUT:
[+] Running 7/7
 ⠿ nginx Pulled                                                                                                                                7.9s
   ⠿ 63b65145d645 Pull complete                                                                                                                2.3s
   ⠿ 8c7e1fd96380 Pull complete                                                                                                                3.2s
   ⠿ 86c5246c96db Pull complete                                                                                                                3.4s
   ⠿ b874033c43fb Pull complete                                                                                                                3.5s
   ⠿ dbe1551bd73f Pull complete                                                                                                                3.7s
   ⠿ 0d4f6b3f3de6 Pull complete                                                                                                                3.8s
[+] Building 208.9s (12/12) FINISHED
 => [internal] load build definition from Dockerfile                                                                                           0.1s
 => => transferring dockerfile: 1.39kB                                                                                                         0.0s
 => [internal] load .dockerignore                                                                                                              0.1s
 => => transferring context: 2B                                                                                                                0.0s
 => [internal] load metadata for docker.io/library/php:8-fpm-alpine                                                                            3.5s
 => [auth] library/php:pull token for registry-1.docker.io                                                                                     0.0s
 => [1/6] FROM docker.io/library/php:8-fpm-alpine@sha256:05970a4639efeeeecb5094e7815ef4917f9341b6f4fba5256cdb620aae240605                      6.7s
 => => resolve docker.io/library/php:8-fpm-alpine@sha256:05970a4639efeeeecb5094e7815ef4917f9341b6f4fba5256cdb620aae240605                      0.0s
 => => sha256:f4dbeadc75c19cda75784e259745d42dd938cf860218f8fec2103bf0852be3c7 1.26kB / 1.26kB                                                 0.4s
 => => sha256:05970a4639efeeeecb5094e7815ef4917f9341b6f4fba5256cdb620aae240605 1.65kB / 1.65kB                                                 0.0s
 => => sha256:b5e0829f1838aa47b0189fed2a91d42911ecf714bf61f90194d0f7a5c6fe7094 11.03kB / 11.03kB                                               0.0s
 => => sha256:e80fdb865a69a85ee910e603ec69d253469dd9367105df81057c89ef565ab971 1.87MB / 1.87MB                                                 0.8s
 => => sha256:257b31b3391b9ce8882eab2c50f2cb64279987f785eeba45218d0b14aa3d74cb 268B / 268B                                                     1.1s
 => => sha256:e33a203cc49a38516b3ee9e2252051d0c9e6745a3b57b509dd934de22487c8f2 2.41kB / 2.41kB                                                 0.0s
 => => sha256:15b819c7c781e43403811c73f00c7d3fbcc9e8476dc7da90a4f8539522c02f94 12.01MB / 12.01MB                                               1.9s
 => => extracting sha256:e80fdb865a69a85ee910e603ec69d253469dd9367105df81057c89ef565ab971                                                      0.8s
 => => sha256:3da2f9afa1ef0a2f2910745b04b4659c7f2926f6b9d66111cd9a983483d167ec 498B / 498B                                                     1.2s
 => => sha256:6fc39cb35d8a87761f61fb67f948172da701cb8221abbf78464a5275aa8c44fc 13.04MB / 13.04MB                                               3.3s
 => => sha256:61b19ce321259dc65db1a425f131e57371e1366021ef651ba64ff33d3dd71401 2.45kB / 2.45kB                                                 1.6s
 => => sha256:08f63e0605900140a2d04e96a9f0ad3f37e88aeb256f4e04fea4b2f8f30c8994 19.00kB / 19.00kB                                               2.1s
 => => extracting sha256:f4dbeadc75c19cda75784e259745d42dd938cf860218f8fec2103bf0852be3c7                                                      0.0s
 => => sha256:c0dcbc97474407335bc2686bc94800760bfe9714970d7d92532d4a7d550ecc86 9.18kB / 9.18kB                                                 2.5s
 => => extracting sha256:257b31b3391b9ce8882eab2c50f2cb64279987f785eeba45218d0b14aa3d74cb                                                      0.0s
 => => extracting sha256:15b819c7c781e43403811c73f00c7d3fbcc9e8476dc7da90a4f8539522c02f94                                                      0.7s
 => => extracting sha256:3da2f9afa1ef0a2f2910745b04b4659c7f2926f6b9d66111cd9a983483d167ec                                                      0.0s
 => => extracting sha256:6fc39cb35d8a87761f61fb67f948172da701cb8221abbf78464a5275aa8c44fc                                                      2.1s
 => => extracting sha256:61b19ce321259dc65db1a425f131e57371e1366021ef651ba64ff33d3dd71401                                                      0.0s
 => => extracting sha256:08f63e0605900140a2d04e96a9f0ad3f37e88aeb256f4e04fea4b2f8f30c8994                                                      0.0s
 => => extracting sha256:c0dcbc97474407335bc2686bc94800760bfe9714970d7d92532d4a7d550ecc86                                                      0.0s
 => [internal] load build context                                                                                                              0.0s
 => => transferring context: 489B                                                                                                              0.0s
 => [2/6] RUN apk update     && apk add --no-cache          curl          wget          git  && apk add --update linux-headers     && apk ad  80.8s
 => [3/6] RUN docker-php-ext-install -j$(nproc) mbstring mysqli pdo_mysql zip  && docker-php-ext-configure gd --with-freetype --with-jpeg    107.9s
 => [4/6] RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer                             4.0s
 => [5/6] ADD ./configs/php/php.ini /usr/local/etc/php/conf.d/40-custom.ini                                                                    0.1s
 => [6/6] WORKDIR /var/www/html                                                                                                                0.1s
 => exporting to image                                                                                                                         5.7s
 => => exporting layers                                                                                                                        5.7s
 => => writing image sha256:76d485e84f9f3a03cdf5df042717472557362014dc787362ab4b6316535e9501                                                   0.0s
 => => naming to docker.io/library/webapp-php                                                                                                  0.0s
[+] Running 4/3
 ⠿ Network webapp_backend   Created                                                                                                            0.2s
 ⠿ Network webapp_frontend  Created                                                                                                            0.2s
 ⠿ Container php            Created                                                                                                            0.1s
 ⠿ Container nginx          Created                                                                                                            0.1s
Attaching to nginx, php
php    | [22-Mar-2023 05:10:13] NOTICE: fpm is running, pid 1
php    | [22-Mar-2023 05:10:13] NOTICE: ready to handle connections
nginx  | /docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
nginx  | /docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
nginx  | /docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
nginx  | 10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
nginx  | 10-listen-on-ipv6-by-default.sh: info: /etc/nginx/conf.d/default.conf differs from the packaged version
nginx  | /docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
nginx  | /docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
nginx  | /docker-entrypoint.sh: Configuration complete; ready for start up
nginx  | 2023/03/22 05:10:16 [notice] 1#1: using the "epoll" event method
nginx  | 2023/03/22 05:10:16 [notice] 1#1: nginx/1.23.3
nginx  | 2023/03/22 05:10:16 [notice] 1#1: built by gcc 12.2.1 20220924 (Alpine 12.2.1_git20220924-r4)
nginx  | 2023/03/22 05:10:16 [notice] 1#1: OS: Linux 5.15.0-67-generic
nginx  | 2023/03/22 05:10:16 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
nginx  | 2023/03/22 05:10:16 [notice] 1#1: start worker processes
nginx  | 2023/03/22 05:10:16 [notice] 1#1: start worker process 28
nginx  | 2023/03/22 05:10:16 [notice] 1#1: start worker process 29
```

### 06 В отдельном терминальном сеансе проверяем Созданные ресурсы (т.к текущий будет занят Docker Compose выводом)

### 06.1 Проверяем созданные Docker Образы

```bash
# docker images

=OUTPUT:
REPOSITORY   TAG           IMAGE ID       CREATED        SIZE
webapp-php   latest        66b1930e1fca   16 hours ago   401MB
nginx        alpine-slim   c59097225492   5 weeks ago    11.5MB
```

### 06.2 Проверяем работающие Docker Контейнеры

```bash
# docker ps

=OUTPUT:
b56ed7de1d26   nginx:alpine-slim   "/docker-entrypoint.…"   22 seconds ago   Up 18 seconds                      0.0.0.0:80->80/tcp   nginx
7b622d411512   webapp-php          "docker-php-entrypoi…"   22 seconds ago   Up 20 seconds (health: starting)                        php
```

### 06.3 Проверяем созданные Docker Сети
```bash
# docker network ls

=OUTPUT:
NETWORK ID     NAME              DRIVER    SCOPE
43d96ae1d46b   bridge            bridge    local
f8c2b824176d   host              host      local
ec1c7b0d52a4   none              null      local
3c1d5c24610f   webapp_backend    bridge    local
491dd0c88e82   webapp_frontend   bridge    local

(i) первые 3 сети - стандартные встроенные в Docker - они есть во всех Docker окружениях;
(i) последние 2 сети - созданы с помощью конфигурации "docker-compose.yml";
```

### 07 Проверяем работу веб-приложения на Windows хосте у которого есть GUI веб-браузер (например Google Chrome)

```bash
--Проверка основной index страницы
chrome: http://nginx

=OUTPUT:
It works!
---------------------------------
Server time: 2023-22-03 09:52:22


--Проверка раздела и страницы с информацией о среде выполнения php-приложения
chrome: http://nginx/info/

=OUTPUT:
SERVER_PHP_VERSION: 8.2.4
SERVER_SOFTWARE...: nginx/1.23.3
SERVER_IP_ADDR....: 10.100.10.2
SERVER_PORT.......: 80
SERVER_INTERFACE..: CGI/1.1
---
CLIENT_GW_IP_ADDR: 192.168.230.1
CLIENT_PORT......: 52500
CLIENT_BROWSER_ID: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36


--Проверка страницы с HEALTH статусом веб-приложения (JSON-ответ)
chrome: http://nginx/health

=OUTPUT:
{"status":"HEALTHY"}


(i) см. скриншоты в разделе далее;
```

### 07 Уничтожаем созданные Docker ресурсы и проверяем что все удалено
```bash
# docker stop $(docker ps -a -q)
# docker system prune -a --force
# docker volume rm $(docker volume ls -q)

# echo && docker images && docker ps -a && docker volume ls && docker network ls

=OUTPUT:
(i) в выводе будут только пустые заголовки, а в списке Docker сетей будут отображены только 3 встроенные сети;
```

# СКРИНШОТЫ РЕЗУЛЬТАТА РАБОТЫ ВЕБ-ПРИЛОЖЕННИЯ

08.1 Основная Index страница приложения
![screen](_screens/01_index-page.png?raw=true)

08.2 Страница с информацией о сервере и подключениях
![screen](_screens/02_info-page.png?raw=true)

08.3 Страница HEALTH-статуса приложения (JSON-ответ)
![screen](_screens/03_health-page.png?raw=true)
