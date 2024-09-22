FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-terminal \
    xfce4-indicator-plugin  \
    xfce4-clipman \
    xfce4-clipman-plugin \
    xfce4-statusnotifier-plugin  \
    xfce4-screenshooter \
    lightdm \
    lightdm-gtk-greeter \
    lightdm-gtk-greeter-settings \
    shimmer-themes \
    xinit \
    build-essential  \
    dkms \
    thunar-archive-plugin \
    file-roller \
    gawk \
    xdg-utils \ 
    tightvncserver \
    novnc \
    websockify \
    net-tools \
    curl \
    supervisor \
    x11vnc \
    xvfb \
    dbus-x11 \
    rename \
    sudo \
    wget \
    vim \
    gedit

# make remote resizing the default
#RUN sed -i "s/UI.initSetting('resize', 'off');/UI.initSetting('resize', 'remote');/g" /usr/share/novnc/app/ui.js

# FSL
RUN cd /tmp && \
    wget https://fsl.fmrib.ox.ac.uk/fsldownloads/fslinstaller.py && \
    /usr/bin/python3 fslinstaller.py -d /usr/local/fsl

# Google Chrome
RUN cd /tmp && \
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt install -y ./google-chrome-stable_current_amd64.deb && \
    sleep 3 && \
    rm google-chrome-stable_current_amd64.deb

COPY google-chrome.desktop /usr/share/applications/

# set Google Chrome as default for xdg-mime
RUN xdg-mime default google-chrome.desktop text/html

# tutorial by Chris Rorden
RUN cd /tmp && \
    wget http://www.lin4neuro.net/lin4neuro/neuroimaging_software_packages/tutorial.zip && \
    unzip -d /etc/skel/ tutorial.zip &&\
    find /etc/skel/tutorial -type f -exec chmod 644 {} \; && \
    find /etc/skel/tutorial -type d -exec chmod 755 {} \; 

# Cleanup
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a new user
RUN useradd -m -s /bin/bash brain && \
    echo "brain:FSLdocker" | chpasswd && \
    adduser brain sudo

# Set up VNC for the new user
RUN mkdir -p /home/brain/.vnc && \
    echo "FSLdocker" | vncpasswd -f > /home/brain/.vnc/passwd && \
    chmod 600 /home/brain/.vnc/passwd && \
    chown -R brain:brain /home/brain/.vnc

# Create a directory for supervisor logs
RUN mkdir -p /home/brain/logs && \
    chown -R brain:brain /home/brain/logs

# FSL profile setting
RUN echo '\n\
# FSL Setup\n\
FSLDIR=/usr/local/fsl\n\
PATH=${FSLDIR}/share/fsl/bin:${PATH}\n\
export FSLDIR PATH\n\
. ${FSLDIR}/etc/fslconf/fsl.sh' >> /home/brain/.bashrc

# Disable screensaver
RUN echo '\n\
# Disable screensaver\n\
xset s off' >> /home/brain/.bashrc

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV DISPLAY=:1

EXPOSE 6080

# Switch to the new user
USER brain
ENV USER=brain

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
