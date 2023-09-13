#!/bin/sh

set -o pipefail

if [[ -z "$BUILD_PATH" ]]; then
  echo "BUILD_PATH environment variable is missing. Cannot proceed."
  exit 1
fi

if [[ -e $BUILD_PATH ]]; then
  echo "$BUILD_PATH is correct"
else
  echo "$BUILD_PATH not found. You should run build (e.g.:npm run build) or change the build path name."
  exit 1
fi

if [[ -z "$AUTHOR" ]]; then
  echo "AUTHOR environment variable is missing. Cannot proceed."
  exit 1
fi

if [[ -z "$GITHUB_PAGE_NAME" ]]; then
  echo "$GITHUB_PAGE_NAME environment variable is missing. Cannot proceed."
  exit 1
fi

BASE_PATH=$(pwd)

USERNAME="${USERNAME:-${GITHUB_ACTOR}}"
EMAIL="${EMAIL:-${GITHUB_ACTOR}@users.noreply.github.com}"

BRANCH="master"
REPOSITORY="${AUTHOR}/${GITHUB_PAGE_NAME}"
GITHUB_PAGE_NAME="${GITHUB_PAGE_NAME}"

git config --global user.name "${USERNAME}"
git config --global user.email "${EMAIL}"

git clone --branch ${BRANCH} --single-branch --depth 1 https://${PA_TOKEN}@github.com/${REPOSITORY}.git
if [ "$?" -ne 0 ]; then
    echo >&2 "Cloning '$REPOSITORY' failed"
    exit 1
fi

mkdir -p ${GITHUB_PAGE_NAME} || exit "$?"
cp -rf ${BASE_PATH}/${BUILD_PATH}/. ${GITHUB_PAGE_NAME} || exit "$?"
cd ${GITHUB_PAGE_NAME} || exit "$?"

COMMIT_MESSAGE="${GITHUB_WORKFLOW}. Commit ${GITHUB_SHA} from \"${GITHUB_REPOSITORY}\""

if [ -z "$(git status --porcelain)" ]; then
    echo "No changes detected"
else
    git add -A
    git commit --message "${COMMIT_MESSAGE}"
    git push origin ${BRANCH}
fi

echo "Deploy complete 👌"
