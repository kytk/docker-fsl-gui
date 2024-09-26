# docker-fsl-gui

- Docker image of FSL (6.0.7.13) on Ubuntu 22.04
- You can use FSL GUI via web browser

## Features

- FSL version 6.0.7.13
- Ubuntu 22.04 base image
- GUI accessible through a web browser

## Quick Start

1. Run the container:
   ```bash
   docker run -d -p 6080:6080 \
     --platform linux/amd64 \
     -v /your/host/path:/home/brain/share \
     --name fsl-docker \
     kytk/docker-fsl-gui:6.0.7.13
   ```
   - `-v /your/host/path:/home/brain/share`: Mounts a volume to share files between host and container
   - `--name fsl-docker`: Names the container (customizable)

2. Access the GUI:
   - Open a web browser and navigate to: `http://localhost:6080/vnc.html`

   - Click "Connect"
    <img src="https://github.com/kytk/docker-fsl-gui/blob/main/img/novnc1.png">

   - Enter the password: `FSLdocker`
    <img src="https://github.com/kytk/docker-fsl-gui/blob/main/img/novnc2.png">

3. Using FSL:
   - Open a terminal in the GUI
   - Type `fsl` to launch the FSL GUI
    <img src="https://github.com/kytk/docker-fsl-gui/blob/main/img/novnc4.png">


## File Sharing

Files from your host machine are accessible in the container at `/home/brain/share`.

## Container Management

### Stop the container
```bash
docker container stop fsl-docker
```

### Restart the container
```bash
docker container start fsl-docker
```

### Remove the container
```bash
docker container stop fsl-docker
docker container rm fsl-docker
```

## Troubleshooting

If you encounter any issues, please check the following:
- Ensure Docker is running on your host machine
- Verify that port 6080 is not in use by another application
- Check your firewall settings if you're unable to connect to the VNC interface

## Support

For issues, questions, or contributions, please open an issue on the GitHub repository.


