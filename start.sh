#!/bin/sh
#shellcheck disable=SC2016

set -e

INPUT_TARGET_BRANCH=${INPUT_TARGET_BRANCH:-master}
INPUT_UPSTREAM_BRANCH=${INPUT_UPSTREAM_BRANCH:-master}
TARGET_REPOSITORY=${INPUT_TARGET_REPOSITORY:-$GITHUB_REPOSITORY}

[ -z "${INPUT_GITHUB_TOKEN}" ] && {
    echo 'Missing input "github_token: ${{ secrets.GITHUB_TOKEN }}".' 1>&2;
    exit 1;
};

[ -z "${INPUT_UPSTREAM_REPOSITORY}" ] && {
    echo 'Missing input "upstream_repository' 1>&2;
    echo '  e.g. "upstream_repository: TobKed/github-forks-sync-action".' 1>&2;
    exit 1;
};

echo "Rebase ${TARGET_REPOSITORY}:${INPUT_TARGET_BRANCH} on ${INPUT_UPSTREAM_REPOSITORY}:${INPUT_UPSTREAM_BRANCH}";

target_dir=${TARGET_REPOSITORY##*/}
target_repo="https://${GITHUB_ACTOR}:${INPUT_GITHUB_TOKEN}@github.com/${TARGET_REPOSITORY}.git"
upstream_repo="https://${GITHUB_ACTOR}:${INPUT_GITHUB_TOKEN}@github.com/${INPUT_UPSTREAM_REPOSITORY}.git"

git config --global user.email $GITHUB_ACTOR

git config --global user.name $GITHUB_ACTOR

git clone ${target_repo} ${target_dir}
cd ${target_dir}

git checkout $INPUT_TARGET_BRANCH

git remote add upstream $upstream_repo

git pull --rebase upstream $INPUT_UPSTREAM_BRANCH

git push --force