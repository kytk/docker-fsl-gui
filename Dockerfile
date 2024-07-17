FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    novnc \
    websockify \
    net-tools \
    curl \
    supervisor \
    x11vnc \
    xvfb \
    dbus-x11 \
    sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a new user
RUN useradd -m -s /bin/bash brain && \
    echo "brain:UbuntuNoVNC" | chpasswd && \
    adduser brain sudo

# Set up VNC for the new user
RUN mkdir -p /home/brain/.vnc && \
    echo "UbuntuNoVNC" | vncpasswd -f > /home/brain/.vnc/passwd && \
    chmod 600 /home/brain/.vnc/passwd && \
    chown -R brain:brain /home/brain/.vnc

# Create a directory for supervisor logs
RUN mkdir -p /home/brain/logs && \
    chown -R brain:brain /home/brain/logs

# Disable power manager plugin
RUN mkdir -p /home/brain/.config/xfce4/xfconf/xfce-perchannel-xml && \
    echo '<?xml version="1.0" encoding="UTF-8"?>\n\
<channel name="xfce4-panel" version="1.0">\n\
  <property name="plugins" type="empty">\n\
    <property name="plugin-9" type="string" value="power-manager-plugin"/>\n\
  </property>\n\
  <property name="configver" type="int" value="2"/>\n\
</channel>' > /home/brain/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml && \
    chown -R brain:brain /home/brain/.config

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV DISPLAY=:1

EXPOSE 6080

# Switch to the new user
USER brain

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
