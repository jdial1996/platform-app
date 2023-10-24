FROM python:3.9.18-alpine
RUN mkdir /app
WORKDIR /app 
COPY requirements.txt /app
RUN pip3 install -r requirements.txt
COPY . .
CMD ["python3", "app.py"]
