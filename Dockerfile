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


