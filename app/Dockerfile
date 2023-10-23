FROM python:3.9.18-alpine
RUN mkdir /app
WORKDIR /app 
COPY requirements.txt /app
RUN pip3 install -r requirements.txt
COPY . .
CMD ["python3", "app.py"]
# CMD tail -f /dev/null



# WORKDIR /app
# ENV PYTHONPATH=${PYTHONPATH}:${PWD}
# RUN apk add --update py3-pip
# RUN pip3 install -r requirements.txt


# CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]