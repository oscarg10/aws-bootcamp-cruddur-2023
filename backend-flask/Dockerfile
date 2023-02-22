FROM python:3.10-slim-buster

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

#Set environment variables (Env Vars)
#Inside Container and will remain set when container is running
ENV FLASK_ENV=development

EXPOSE ${PORT}

#CMD stands for Command
#
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port=4567"]