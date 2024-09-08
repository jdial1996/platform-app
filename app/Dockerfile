FROM python:3.13.0a1-alpine

WORKDIR ./app

COPY . . 

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

EXPOSE 8000

CMD ["python3", "./app.py"]