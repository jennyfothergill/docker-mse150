# What is on this image?

[Docker image](https://hub.docker.com/r/cmelab/docker-mse150/) with python 3.6 and more!

# How can I use it locally?
`docker run --rm -itp 8888:8888 cmelab/mse150:latest jupyter notebook --notebook-dir=/home/jovyan --ip='*' --port=8888 --no-browser --allow-root`

# How can I build it myself?
`docker build . -f Dockerfile -t cmelab/mse150:latest`
