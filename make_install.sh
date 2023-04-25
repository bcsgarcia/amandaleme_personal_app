#!/bin/bash

# Loop through all subdirectories that contain a pubspec.yaml file
for package in $(find . -type f -name pubspec.yaml -exec dirname {} \;); do
  echo "Running 'flutter pub get' in $package"
  cd "$package"
  flutter pub get
  cd -
done