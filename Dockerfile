FROM python:3.9-slim

# python output is sent to terminal without being first buffered
ENV PYTHONUNBUFFERED True

# copy local code to container image
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./

RUN pip install Flask gunicorn

# gunicorn webserver, number of workers equals to available cores
# timeout set to 0 for disabling timeouts of workers and allow Cloud Run to handle instance scaling
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 main:app
