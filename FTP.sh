 #!/bin/bash


help() {
        echo -e "
  `basename $0` is used to manage FTP server (running in docker container).
  You can start the container directly using docker CLI, but why would you?\n
\tUSAGE:\n\033[1m\t\t`basename $0` [ option ] [ <parameter> ] \033[0m\n
\t<options>
\t\t-h | --help | help\tDisplay this help
\t\tstart [-i]\t\tStart simple_ftp.
\t\tstop [<name>]\t\tStop all or particular instance.
\t\tstatus\t\t\tList current simple_ftp instances. (running and stopped).\n

\tEXAMPLES:
\033[1m\t\t`basename $0` start\033[0m
\t\t  Start FTP server with default user/pass/port serving current directory\n
\033[1m\t\t`basename $0` start -i\033[0m
\t\t  Start FTP server in interactive mode
\t\t  It will ask you to set user/pass/port/dirctory\n
\033[1m\t\t`basename $0` status\033[0m
\t\t  Show running simple_ftp instances (filtered docker ps)\n
\033[1m\t\t`basename $0` stop\033[0m
\t\t  Stop and remove all simple_ftp instances\n
\033[1m\t\t`basename $0` stop <name>\033[0m
\t\t  Stop only provided simple_ftp instance
\t\t  Use `basename $0` status to get names\n

Use https://github.com/marekruzicka/docker-simple_ftp to report bugs, or check for updates.
"
}


settings() {
  read -p "Set FTP directory [$PWD]: " FTP_DIR
  read -p "Set FTP user [ftp_user]: " FTP_USER
  read -p "Set FTP password [ftp_pass]: " FTP_PASS
  read -p "Set FTP port [21]: " FTP_PORT
}

show_settings() {
  echo -e "
  FTP server is running with following settings:\n
\tUser: $FTP_USER
\tPass: $FTP_PASS
\tListening on: 0.0.0.0:$FTP_PORT
\tServing directory: $FTP_DIR
"
}

start() {
  if [[ $1 == '-i' ]]; then
    shift
    settings
  fi

  # defaults
  FTP_USER=${FTP_USER:-ftp_user}
  FTP_PASS=${FTP_PASS:-ftp_pass}
  FTP_PORT=${FTP_PORT:-21}
  FTP_DIR=${FTP_DIR:-$PWD}


  if [[ $# -eq 0 ]]; then
    docker run -d --rm --net=host -v $FTP_DIR:/app/ftp_root --name simple_ftp-$USER \
        -e FTP_USER=$FTP_USER \
        -e FTP_PASS=$FTP_PASS \
        -e FTP_PORT=$FTP_PORT \
        simple_ftp:latest \
        && show_settings
  else
    echo -e "\n\tERROR: $@ unsupported parameters\n"
  fi
}

stop() {
  if [[ $# -eq 0 ]]; then
    echo -e "\n  Stopping and removing all simple_ftp instances\n"
    docker ps -aq --filter "name=simple_ftp-" | xargs docker stop
  else
    echo -e "\n  Stopping and removing container(s): $@\n" 
    docker stop $@
  fi
}


status() {
  docker ps -a
}


case $1 in
  help | -h | --help | "")
    help
    exit 0;;
  start)
    shift
    start $@;;
  stop)
    shift
    stop $@;;
  status)
    status;;
esac

