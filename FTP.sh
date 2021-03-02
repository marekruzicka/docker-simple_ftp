 #!/bin/bash


help() {
  -
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
\tSocket: 0.0.0.0:$FTP_PORT
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
    docker ps -aq --filter "name=ftp-" | xargs docker stop
  else
    echo -e "\n  Stopping and removing container(s): $@\n" 
    docker stop $@
  fi
}


status() {
  docker ps -a
}


case $1 in
  help | -h | --help)
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

