#!/bin/bash

# The travis_retry function  is not available is subshells/commands. See this tweet for details https://twitter.com/travisci/status/499195739353153539?s=20
travis_retry() {
  local result=0
  local count=1
  while [[ "${count}" -le 3 ]]; do
    [[ "${result}" -ne 0 ]] && {
      echo -e "\\n${ANSI_RED}The command \"${*}\" failed. Retrying, ${count} of 3.${ANSI_RESET}\\n" >&2
    }
    # run the command in a way that doesn't disable setting `errexit`
    "${@}"
    result="${?}"
    if [[ $result -eq 0 ]]; then break; fi
    count="$((count + 1))"
    sleep 1
  done

  [[ "${count}" -gt 3 ]] && {
    echo -e "\\n${ANSI_RED}The command \"${*}\" failed 3 times.${ANSI_RESET}\\n" >&2
  }

  return "${result}"
}

# The -e flag makes the build fail if there are any errors
# The -v flag makes the shell print all lines before executing them
set -ev

# Set environment variables
export ALGOLIA_API_KEY=e0824d7d48a118c054a077bc087bc976
export ALGOLIA_APP_ID=EWKZLLNQ9L
# A comma-separated list of branches and versions for which we build the deployment image, update the Algolia index and push the image to GCP
export BRANCH_VERSION_CONFIG=1.1=1.1,1.0=1.0
export GCP_CLUSTER_ID=production-app-cluster
export GCP_PROJECT_ID=production-apps-210001
export GCP_ZONE=us-west1-b
# The latest version. We use this variable in the `export-product-url.sh` script to determine whether the version should be added or not to the URLs that we upload to Algolia.
export LATEST_VERSION=1.1
# The name of the product.
export PRODUCT_NAME=PX-Backup
# We use this environment variable to determine the name of the Algolia index
export PRODUCT_INDEX_NAME=PX-Backup
# The base URL
export VERSIONS_BASE_URL=backup.docs.portworx.com
# Docker builds cannot use uppercase characters in the image name
export LOWER_CASE_BRANCH=$(echo -n $TRAVIS_BRANCH | awk '{print tolower($0)}')
export BUILDER_IMAGE="pxbackup:$TRAVIS_COMMIT"
export SEARCH_INDEX_IMAGE="pxbackup-indexer:$TRAVIS_COMMIT"
export DEPLOYMENT_IMAGE="gcr.io/$GCP_PROJECT_ID/pxbackup-$LOWER_CASE_BRANCH:$TRAVIS_COMMIT"
# The current version
export VERSIONS_CURRENT=$(bash themes/pxdocs-tooling/deploy/scripts/versions.sh get-current-branch-version)
# A comma-separated list of all versions. We use this variable to build the version selector.
export VERSIONS_ALL=$(bash themes/pxdocs-tooling/deploy/scripts/versions.sh get-all-versions)
export VERSIONS_TAG=$(echo -n "$VERSIONS_CURRENT" | sed 's/\./-/g')
export ALGOLIA_INDEX_NAME="${PRODUCT_INDEX_NAME}-${VERSIONS_TAG}"
# A comma-separated list of other product names and indices, in the form of`<product-name>=<product-index>`.
export OTHER_PRODUCT_NAMES_AND_INDICES="Portworx Enterprise=PX-Enterprise-2-6"
# A comma-separated list of all product names and indices, in the form of `<product-name>=<product-index>`.
export PRODUCT_NAMES_AND_INDICES="${PRODUCT_INDEX_NAME}=${PRODUCT_NAME}-${TRAVIS_BRANCH/./-},${OTHER_PRODUCT_NAMES_AND_INDICES}"
# Each product has its own list of redirects. For each product, we use the `VERSIONS_BASE_URL` environment variable to determine the name of the file where the redirects are stored, and then we save that name in the `NGINX_REDIRECTS_FILE` environment variable
if [ "${VERSIONS_BASE_URL}" '==' "docs.portworx.com" ]; then export NGINX_REDIRECTS_FILE=px-enterprise-redirects.conf ; fi
if [ "${VERSIONS_BASE_URL}" '==' "backup.docs.portworx.com" ]; then export NGINX_REDIRECTS_FILE=px-backup-redirects.conf ; fi
# Build images
travis_retry make image
# Publish site -> public
make publish-docker
# Build the deployment image
travis_retry make deployment-image
travis_retry make check-links
# If this is a pull request then we don't want to update algolia or deploy
if [ "${TRAVIS_PULL_REQUEST}" != "false" ]; then exit 0; fi
# This checks if the current branch is present in the BRANCH_VERSION_CONFIG variable if exists if not
if [ "${TRAVIS_PULL_REQUEST}" == "false" ] && [ "$(bash themes/pxdocs-tooling/deploy/scripts/versions.sh should-build-current-branch)" != "yes" ]; then exit 0; fi
# Update the Algolia index
travis_retry make search-index-image
travis_retry make search-index-docker
# Connect the GCLOUD_SERVICE_ACCOUNT_TOKEN, GCP_PROJECT_ID, GCP_ZONE and GCP_CLUSTER_ID vars -> gcloud and kubectl
bash themes/pxdocs-tooling/deploy/scripts/ci_connect.sh
# Push the image to gcr
echo "Pushing image $DEPLOYMENT_IMAGE"
gcloud docker -- push $DEPLOYMENT_IMAGE
echo "Deploying image $DEPLOYMENT_IMAGE"
cat themes/pxdocs-tooling/deploy/manifests/pxbackup/deployment.yaml | envsubst
cat themes/pxdocs-tooling/deploy/manifests/pxbackup/deployment.yaml | envsubst | kubectl apply -f -
cat themes/pxdocs-tooling/deploy/manifests/pxbackup/service-template.yaml | envsubst
cat themes/pxdocs-tooling/deploy/manifests/pxbackup/service-template.yaml | envsubst | kubectl apply -f -


