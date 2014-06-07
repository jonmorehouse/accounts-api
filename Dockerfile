FROM jonmorehouse/node
MAINTAINER Jon Morehouse <morehousej09@gmail.com>

# set up further dependencies as needed for application
RUN apt-get -y install libzmq-dev libhiredis0.10 libpq-dev

# add src / bin to machine
RUN mkdir /app
ADD bin /app 
ADD lib /app

# install and setup server
RUN cd /app && npm install 
# force symliks for the the global multi-config package. This is an npm package for now ...
RUN cd /app && force-dedupe-git-modules





