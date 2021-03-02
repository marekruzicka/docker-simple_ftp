FROM python:slim

# default config
ENV FTP_USER ftp_user
ENV FTP_PASS ftp_pass
ENV FTP_PORT 21

COPY app/ /app

RUN pip install pyftpdlib
RUN mkdir -pv /app/ftp_root

VOLUME /app/ftp_root

EXPOSE $FTP_PORT
WORKDIR /app

CMD python simple-ftp-server

