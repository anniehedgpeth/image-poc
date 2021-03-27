FROM ubuntu:18.04
COPY ./base_config_setup.sh /tmp/base_config_setup.sh
CMD sh /tmp/base_config_setup.sh