# docker-fsl-gui

- Docker image of FSL (6.0.7.12) on Ubuntu 22.04
- You can use FSL GUI via web browser

## Usage

- Type the following in the terminal:

    - `-v /your/path/in/host:/home/brain/share` enables you to use your file in `/your/path/in/host in the container under `/home/brain/share`

    ```
    docker run -d -p 6080:6080 \
      -v /your/host/path:/home/brain/share \
      kytk/docker-fsl-gui:latest
    ```

- Next, launch a browser on your host and enter the following address;

    ```
    localhost:6080/vnc.html
    ```

- Click "Connect"
 
- Password is "FSLdocker"

- Open terminal and type 'fsl' launches FSL GUI.



