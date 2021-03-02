# docker-simple_ftp - docker container running pyftpdlib
This is not meant to be full-fledged FTP server, just a simple docker container you run, when you need to get a firmware package to a switch/filer/bridge, or any other device.  
It should be started when needed and stopped after it has been used.  
If you need a real ftp server (to run non-stop, be used by multiple users, etc.) **use something that does not provide credentials as environment variables**.

## General info:
Wrapper script 'FTP.sh' is provided to quickly start the service, set the user/pass, provide location for data and stop/remove the container.  
Name of the user that has started the container is added to the container name, so it is possible to run multiple instances by different users, provided they do not share the port.
I'm very sure someone will forget to turn it off, at least you'll know who.  

Container is run with `--net=host`  and ftp server is running in passive mode when using wrpapper script.  
If you don't want to run 'host based networking' you can play with publishing ports to the container, but unless you want to run in active mode only, it is rather PITA... still possible though.

## USAGE
Clone it `git clone https://github.com/marekruzicka/docker-simple_ftp.git`  
build it `./build.sh`  
run it `./FTP.sh start`

### quick run with default settings:
```
user@server:/tmp# FTP.sh start
8d0f2857c45ff97e35e66942dd3cd171b677de224d8cae0bbe6ac70c626fea51

  FTP server is running with following settings:

        User: ftp_user
        Pass: ftp_pass
        Socket: 0.0.0.0:21
        Serving directory: /tmp
```
Runs the container with default user/pass on current directory.

### interactive run to set basic parameters:
```
user@server:/tmp# FTP.sh start -i
Set FTP directory [/tmp]: /srv/ftp
Set FTP user [ftp_user]: feri
Set FTP password [ftp_pass]: heslo
Set FTP port [21]: 2121
3cedc6e65fd48696a490cc7e61d7aef016f771fa4ae29f912e53d752e8868ac5

  FTP server is running with following settings:

        User: feri
        Pass: heslo
        Listening on: 0.0.0.0:2121
        Serving directory: /srv/ftp
```
### manual start:
```
docker run -d --rm --net=host --name simple_ftp \
    -v <directory>:/app/ftp_root \
    -e FTP_USER=<user> \
    -e FTP_PASS=<pass> \
    -e FTP_PORT=<port> \
    simple_ftp:latest
```

# WORK in PROGRESS

## credits:
Idea comes from - https://github.com/mauler/docker-simple-ftp-server  
Most of the really relevant stuff - https://github.com/giampaolo/pyftpdlib

