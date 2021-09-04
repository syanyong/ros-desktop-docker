FROM dorowu/ubuntu-desktop-lxde-vnc:focal-lxqt
WORKDIR /root
COPY ./.bashrc /root/.bashrc
VOLUME /root/ros_ws
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt install -y curl 
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
RUN apt update
RUN apt install -y ros-noetic-desktop-full
EXPOSE 80

