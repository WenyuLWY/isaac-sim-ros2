FROM osrf/ros:humble-desktop-full

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /root
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
RUN apt-get update && apt-get install -y python-is-python3 python3-pip unzip xterm
RUN pip install gdown
RUN apt-get update && apt-get install -y ros-humble-rqt-tf-tree

RUN mkdir -p /root/ros2_ws/src && \
    cd ~/ros2_ws && \
    bash -c "source /opt/ros/humble/setup.bash && colcon build" && \
    echo "source /root/ros2_ws/install/setup.bash" >> ~/.bashrc

RUN echo "#!/bin/bash" > /root/start.sh && \
    echo "cd /root/ros2_ws" >> /root/start.sh && \
    echo "source /opt/ros/humble/setup.bash" >> /root/start.sh && \
    echo "colcon build" >> /root/start.sh && \
    echo "source /root/ros2_ws/install/setup.bash" >> /root/start.sh && \
    echo "exec \"\$@\"" >> /root/start.sh && \
    chmod +x /root/start.sh

ENTRYPOINT ["/root/start.sh"]

CMD ["/bin/bash"]