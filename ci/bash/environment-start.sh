#!/bin/bash -e
CI_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

rbenv local 2.0.0-p648
gem install bundle
echo `rbenv version`
bundle install

mkdir -p ../../test-reports
mkdir -p ../../test-reports/screenshots
mkdir -p ../../test-reports/screenshots/scenario
