#! /bin/bash


echo "Running Tests for the following tags::::::::" $CUCUMBER_TAGS

bundle exec cucumber $CUCUMBER_TAGS 
