# docker-simple-ftp - docker container running pyftpdlib
This is not meant to be full-fledged FTP server, just a simple docker container, you run, when you need to get new firmware to a switch, filer, or any other device.
It should be started when needed and stopped after it has been used. If you need ftp server to run non-stop, use something more serious pls.

## HowTo
Wrapper script 'FTP' is provided to quickly start the service, set the user/pass, provide location for data and stop the container.
Container is run with `--net=host`  and ftp server is running in passive mode when using wrpapper script.  

If you don't want to run 'host based networking' you can play with publishing ports to the container, but unless you want to run in active mode only, it is rather PITA... still possible though.

```
./FTP start 
```
Runs the container with default user/pass on local directory.


...WIP
