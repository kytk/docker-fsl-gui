# docker-fsl-gui

- Docker image of FSL (6.0.7.12) on Ubuntu 22.04
- You can use FSL GUI via web browser

## How to run the container

- Type the following in the terminal in your host:

    ```
    docker run -d -p 6080:6080 \
      -v /your/host/path:/home/brain/share \
      --name fsl-docker \
      kytk/docker-fsl-gui:latest
    ```

    - `-v /your/path/in/host:/home/brain/share` enables you to use your file in `/your/path/in/host in the container under `/home/brain/share`

    - `--name fsl-docker` names the container as 'fsl-docker' You can choose any name you want.

- Next, launch a browser on your host and enter the following address;

    ```
    localhost:6080/vnc.html
    ```

- Click "Connect"
 
    <img src="https://github.com/kytk/docker-fsl-gui/blob/main/img/novnc1.png">

- Password is "FSLdocker"

    <img src="https://github.com/kytk/docker-fsl-gui/blob/main/img/novnc2.png">

- Then you should be able to see the GUI.

    <img src="https://github.com/kytk/docker-fsl-gui/blob/main/img/novnc3.png">

- In order to run FSL, open terminal and type 'fsl' launches FSL GUI.

    <img src="https://github.com/kytk/docker-fsl-gui/blob/main/img/novnc4.png">

- Files in your host should be found in `/home/brain/share` in the container.

## How to stop the container

- Type the following in the terminal of your host.

    ```
    docker container stop fsl-docker
    ```

## How to re-start the container

- Type the following in the terminal of your host.

    ```
    docker container rm fsl-docker
    ```

## How to remove the container

- Type the following in the terminal of your host.

    ```
    docker container stop fsl-docker
    docker container rm fsl-docker
    ```

