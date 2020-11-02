# install base image and version
FROM ubuntu:18.04

# copy all existing files in a directory called app
COPY . /app

# set app as working dir
WORKDIR /app

# set entrypoint or command that cannot be overwritten
ENTRYPOINT [ "bash" ]

# the cmd we want to run
CMD [ "test.sh" ]
