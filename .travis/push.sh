#!/bin/sh

#adapted from https://gist.github.com/willprice/e07efd73fb7f13f917ea thank you @willprice

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

convert_pdf_png() {
  convert -density 300 cv.pdf -quality 100 -flatten cv.png
}

commit() {
  git checkout master
  git add *.pdf *.png
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER [ci skip]"
}

upload_files() {
  git remote add token_origin https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git
  git push --quiet --set-upstream token_origin master
}

setup_git
convert_pdf_png
commit
upload_files
