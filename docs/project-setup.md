### Setup GCP

- create GCP project `weatherwebcam`
  - enable billing account
  
- Enable Cloud Build API and create service account
  - `sa-weather-webcam@weatherwebcam.iam.gserviceaccount.com`

- create Cloud Run Service
  - named `weather-webcam`

#### Setup Google Cloud SDK

- install Google Cloud SDK
  - and `gcloud auth list`
  
- set environment variable with GCP Project ID
  - `export GOOGLE_CLOUD_PROJECT=weatherwebcam`
  - `gcloud config set project $GOOGLE_CLOUD_PROJECT`

#### Deploy app

- Submit the build using Google Cloud Build
  - `gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/weather-webcam`

- Deploy to Cloud Run
  - `gcloud run deploy --image gcr.io/$GOOGLE_CLOUD_PROJECT/weather-webcam --project=$GOOGLE_CLOUD_PROJECT`



### Test Docker container locally
  - `docker build -t weather-webcam:latest .`
  - `docker run --rm -p 9090:8080 -e PORT=8080 weather-webcam`
  - go to http://0.0.0.0:9090/




##### Next

- create weatherwebcamstorage GCP storage bucket
- change domain name in Cloud Run