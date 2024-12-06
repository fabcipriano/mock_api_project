#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define file contents
DB_JSON_CONTENT='[
  {
    "id": 28210,
    "typeId": "4bd2f2c5-2a1d-4977-b50d-c858f9019a83",
    "typeName": "Telefonia móvel",
    "attributes": {
      "ddd": "11",
      "imei": "3987e457b44b179c",
      "msisdn": "5511914810095",
      "storeFlow": "FALSE",
      "isEmployee": false,
      "appsflyerId": "1733251645899-1046529223769090535",
      "migrationType": "PRE_PAGO",
      "activationType": "MIGRATION",
      "chipSimDelivery": "FALSE",
      "activationChannel": "Android"
    },
    "externalId": "JOIN-a8f0f883-5e9c-40d6-98e3-7b7800586159",
    "foreignLabel": "5511914810095",
    "foreignId": "2140519",
    "activationDate": "2024-12-03T20:12:46.109",
    "status": "ACTIVE",
    "createdAt": "2024-12-03T20:05:03.972",
    "updatedAt": "2024-12-03T20:12:46.148",
    "inactivationDate": null,
    "inactivationReason": null,
    "inactivatedBy": null,
    "inactivatingDate": null,
    "inactivatingReason": null,
    "inactivatingBy": null
  },
  {
    "id": 28202,
    "typeId": "4bd2f2c5-2a1d-4977-b50d-c858f9019a83",
    "typeName": "Telefonia móvel",
    "attributes": {
      "ddd": "11",
      "imei": "3987e457b44b179c",
      "msisdn": "5511914810095",
      "storeFlow": "FALSE",
      "isEmployee": false,
      "appsflyerId": "1733143296872-2378089023862476048",
      "migrationType": "PRE_PAGO",
      "activationType": "MIGRATION",
      "chipSimDelivery": "FALSE",
      "activationChannel": "Android"
    },
    "externalId": "JOIN-6eedaa82-3757-4adb-b66d-a65a46c5f622",
    "foreignLabel": null,
    "foreignId": "2140216",
    "activationDate": "2024-12-02T20:33:23.045",
    "status": "INACTIVE",
    "createdAt": "2024-12-02T20:32:30.576",
    "updatedAt": "2024-12-03T19:30:19.747",
    "inactivationDate": "2024-12-03T19:30:19.711",
    "inactivationReason": "PREPAID",
    "inactivatedBy": "EXT-Inativar produto RW-0811889c-b1ad-11ef-8a5b-3280dabf9318",
    "inactivatingDate": "2024-12-03T17:42:37.780",
    "inactivatingReason": "Digital Attendance",
    "inactivatingBy": "CSP"
  }
]'

DOCKERFILE_CONTENT='FROM node:14
# Install json-server
RUN npm install -g json-server
# Set working directory
WORKDIR /app
# Copy db.json to the container
COPY db.json /app/db.json
# Expose the port
EXPOSE 3000
# Start json-server
CMD ["json-server", "--watch", "db.json", "--port", "3000"]
'

DOCKER_COMPOSE_CONTENT='version: "3.8"
services:
  mock-api:
    build:
      context: .
    ports:
      - "3000:3000"
'

# Create project directory
PROJECT_DIR="mock_api_project"
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

# Create db.json
echo "$DB_JSON_CONTENT" > db.json
echo "Created db.json"

# Create Dockerfile
echo "$DOCKERFILE_CONTENT" > Dockerfile
echo "Created Dockerfile"

# Create docker-compose.yml
echo "$DOCKER_COMPOSE_CONTENT" > docker-compose.yml
echo "Created docker-compose.yml"

# Build and run the Docker container
echo "Building Docker image..."
docker-compose build

echo "Starting the mock API..."
docker-compose up -d

echo "Mock API is running at http://localhost:3000"