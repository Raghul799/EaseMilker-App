#!/usr/bin/env bash
set -euo pipefail

# Simple deploy script for Cloud Run
# Requires: gcloud, Firebase project configured, service account with permissions

if [[ -z "${GOOGLE_CLOUD_PROJECT:-}" ]]; then
  echo "Set GOOGLE_CLOUD_PROJECT env var" >&2
  exit 1
fi

SERVICE_NAME="easemilker-ingestion"
REGION="us-central1"

pushd "$(dirname "$0")/../functions" >/dev/null

echo "Building container..."
gcloud builds submit --tag "gcr.io/${GOOGLE_CLOUD_PROJECT}/${SERVICE_NAME}:latest"

echo "Deploying to Cloud Run..."
gcloud run deploy "$SERVICE_NAME" \
  --image "gcr.io/${GOOGLE_CLOUD_PROJECT}/${SERVICE_NAME}:latest" \
  --platform managed \
  --region "$REGION" \
  --allow-unauthenticated \
  --set-env-vars "FIREBASE_PROJECT_ID=${GOOGLE_CLOUD_PROJECT}" \
  --set-env-vars "MQTT_BROKER_URL=${MQTT_BROKER_URL}" \
  --set-env-vars "MQTT_USERNAME=${MQTT_USERNAME}" \
  --set-env-vars "MQTT_PASSWORD=${MQTT_PASSWORD}" \
  --set-env-vars "MQTT_CLIENT_ID=${MQTT_CLIENT_ID:-easemilker-ingestor}" \
  --set-env-vars "MQTT_TLS=${MQTT_TLS:-true}" \
  --set-env-vars "LOG_LEVEL=${LOG_LEVEL:-info}"

echo "Done."
popd >/dev/null
