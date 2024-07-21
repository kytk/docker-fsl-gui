# docker-fsl-gui

- Docker image of FSL (6.0.7.12) on Ubuntu 22.04
- You can use FSL GUI via web browser

## How to run the container

- Type the following in the terminal in your host:

    - `-v /your/path/in/host:/home/brain/share` enables you to use your file in `/your/path/in/host in the container under `/home/brain/share`

    - `--name fsl-docker` names the container as 'fsl-docker' You can choose any name you want.

    ```
    docker run -d -p 6080:6080 \
      -v /your/host/path:/home/brain/share \
      --name fsl-docker \
      kytk/docker-fsl-gui:latest
    ```

- Next, launch a browser on your host and enter the following address;

    ```
    localhost:6080/vnc.html
    ```

- Click "Connect"
 
- Password is "FSLdocker"

- Open terminal and type 'fsl' launches FSL GUI.

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

