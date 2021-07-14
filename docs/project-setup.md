### Setup GCP

- create GCP project `weatherwebcam`
  - enable billing account
  
- Enable Cloud Build API and create service account
  - `sa-weather-webcam@weatherwebcam.iam.gserviceaccount.com`

- create Cloud Run Service
  - named `weather-webcam`


#### Setup Google Cloud SDK

- install Google Cloud SDK and set:
  - `gcloud auth list` 
  - `gcloud config set project $GOOGLE_CLOUD_PROJECT`
  - `gcloud config set compute/zone europe-west3-c`
  
- set environment variable with GCP Project ID
  - `export GOOGLE_CLOUD_PROJECT=weatherwebcam`


#### Deploy app

- Submit the build using Google Cloud Build
  - `gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/weather-webcam`

- Deploy to Cloud Run
  - `gcloud run deploy --image gcr.io/$GOOGLE_CLOUD_PROJECT/weather-webcam --platform managed --project=$GOOGLE_CLOUD_PROJECT --allow-unauthenticated --region europe-west3`

  
#### Deploy with Github Actions
  - create GC Service Account for github-actions. Roles:
    - `Cloud Run Admin`
    - `Cloud Run Service Agent`
    - `Cloud Build Service Agent`
    - `Viewer`
  - Check if new SA has been created `gcloud iam service-accounts list --project $GOOGLE_CLOUD_PROJECT`
  - Generate SA key `gcloud iam service-accounts keys create ./keys.json --iam-account github-actions@weatherwebcam.iam.gserviceaccount.com`
  - Test SA authentication works `gcloud auth activate-service-account --key-file=keys.json`
  - Add in Github Actions secrets `GCP_PROJECT_ID` and `GCP_SA_KEY_JSON`
  
### Test Docker container locally
  - `docker build -t weather-webcam:latest .`
  - `docker run --rm -p 9090:8080 -e PORT=8080 weather-webcam`
  - go to http://0.0.0.0:9090/



##### Next

- create weatherwebcamstorage GCP storage bucket
- change domain name in Cloud Run