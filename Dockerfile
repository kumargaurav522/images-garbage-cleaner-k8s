FROM ubuntu:18.04

MAINTAINER Gaurav <kumar.gaurav522@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -yq --no-install-recommends \
    apt-utils \
    docker.io \
    cron \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
# Copy dockerimages-cron file to the cron.d directory
COPY dockerimages-cron /etc/cron.d/dockerimages-cron
# Copy Script on root Directory
COPY script.sh /root/
# Give execution rights on the cron job
RUN chmod 0744 /etc/cron.d/dockerimages-cron
# Apply cron job
RUN crontab /etc/cron.d/dockerimages-cron
# Create the log file to be able to run tail
RUN touch /var/log/cron.log
# Run the command on container startup
#CMD cron && tail -f /var/log/cron.log
WORKDIR /root
CMD ["cron", "-f"]
#CMD cron && tail -f /var/log/cron.log
