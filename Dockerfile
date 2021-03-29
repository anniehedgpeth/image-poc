FROM ubuntu:18.04
COPY ./base_config_setup.sh /tmp/base_config_setup.sh
RUN chmod +x /tmp/base_config_setup.sh
RUN sh /tmp/base_config_setup.sh

CMD ["/bin/bash"]