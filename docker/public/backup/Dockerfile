# Copyright 2020 Cisco Systems, Inc
FROM alpine:3.6
RUN mkdir /code
ADD run_cron.sh /code
ADD run_backup.sh /code
RUN chmod +x /code/run_backup.sh
RUN chmod +x /code/run_cron.sh
