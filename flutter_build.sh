#!/bin/bash

# Localiza a linha com a versão atual no pubspec.yaml e lê ela em variáveis.
current_version=$(grep 'version:' pubspec.yaml | sed 's/version: //')
IFS='+' read -ra ADDR <<< "$current_version"
version=${ADDR[0]}
build_number=${ADDR[1]}

# Incrementa o número de build.
new_build_number=$((build_number + 1))

# Atualiza a versão no pubspec.yaml.
sed -i '' "s/version: $current_version/version: $version+$new_build_number/" pubspec.yaml

# Faz o build do appbundle.
flutter build appbundle --target=lib/main/main.dart

