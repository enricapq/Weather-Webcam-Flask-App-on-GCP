FROM python:3.9-slim

# python output is sent to terminal without being first buffered
ENV PYTHONUNBUFFERED True
ENV APP_HOME /app

# copy just the requirements.txt first to leverage Docker cache
COPY ./requirements.txt $APP_HOME/requirements.txt

WORKDIR $APP_HOME

RUN pip install -r requirements.txt

COPY . ./
# install gunicorn to run on Cloud Run, not needed locally
RUN pip install gunicorn

# gunicorn webserver, number of workers equals to available cores
# timeout set to 0 for disabling timeouts of workers and allow Cloud Run to handle instance scaling
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 main:app
