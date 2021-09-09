FROM dorowu/ubuntu-desktop-lxde-vnc:focal-lxqt
WORKDIR /root
COPY ./.bashrc /root/.bashrc
VOLUME /root/ros_ws
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
RUN apt install -y openssh-server
RUN apt install -y cron
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 ubuntu
RUN echo 'ubuntu:ubuntu' | chpasswd
RUN service ssh start
COPY ./supervisord-user.conf /etc/supervisor/conf.d/supervisord-user.conf

EXPOSE 80 22
