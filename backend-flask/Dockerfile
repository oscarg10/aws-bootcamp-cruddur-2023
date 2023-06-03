FROM 960757103945.dkr.ecr.us-east-1.amazonaws.com/cruddur-python:3.10-slim-buster

#Inside Container
#Make new folder inside container
WORKDIR /backend-flask

#Outside Container -> Inside Container
#This contains the libraries we want to install to run the app
COPY requirements.txt requirements.txt

#Inside Container
#Install the python libraries used for the app 
RUN pip3 install -r requirements.txt

#Outside COntainer -> Inside Container
#. means everything in the current directory
# First . -/backend-flask (Outside Container)
#Second . -/backend-flask (Inside Container)
COPY . .

EXPOSE ${PORT}

ENV PYTHONUNBUFFERED=1

#CMD stands for Command
#
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port=4567", "--debug"]