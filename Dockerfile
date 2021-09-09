FROM dorowu/ubuntu-desktop-lxde-vnc:focal-lxqt
WORKDIR /home/ubuntu
COPY ./.bashrc /home/ubuntu/.bashrc
VOLUME /home/ubuntu/ros_ws
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt install -y curl 
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
RUN apt update
RUN apt install -y ros-noetic-desktop-full
RUN apt install -y ros-noetic-slam-gmapping
RUN apt install -y ros-noetic-map-server
RUN apt install -y ros-noetic-amcl
RUN apt install -y ros-noetic-move-base
RUN apt install -y ros-noetic-navigation
RUN apt install -y ros-noetic-geometry2
RUN apt install -y cron

ENV USER=ubuntu
ENV PASSWORD=ubuntu

# authorize SSH connection with root account
RUN apt install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN useradd -rm -d /home/test -s /bin/bash -g root -G sudo -u 1000 test
RUN echo 'test:test' | chpasswd
RUN sed -i '/^#/!s/PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN service ssh start
RUN echo 'root:ubuntu' | chpasswd

COPY ./supervisord-user.conf /etc/supervisor/conf.d/supervisord-user.conf

EXPOSE 80 22
