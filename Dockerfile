FROM python:latest
WORKDIR /django_app
COPY ./django_app .
RUN pip install -r requirements.txt
CMD ["./run.sh"]