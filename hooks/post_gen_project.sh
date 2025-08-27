#!/bin/bash

echo "$(pwd)"
cd Demo

cat > "project.yml"<<EOF
name: {{cookiecutter.module_name}}Demo
options:
  minimumXcodeGenVersion: 2.0.0
  deploymentTarget:
    iOS: "15.0"

packages:
  {{cookiecutter.module_name}}:
    path: ../{{cookiecutter.module_name}}

targets:
  {{cookiecutter.module_name}}Demo:
    type: application
    platform: iOS
    bundleId: {{cookiecutter.bundle_identifier}}
    info:
      path: {{cookiecutter.module_name}}Demo/Info.plist
    settings:
      base:
        PRODUCT_BUNDLE_IDENTIFIER: {{cookiecutter.bundle_identifier}}
        INFOPLIST_FILE: {{cookiecutter.module_name}}Demo/Info.plist
    sources:
      - path: ./{{cookiecutter.module_name}}Demo
    dependencies:
      - package: {{cookiecutter.module_name}}

  {{cookiecutter.module_name}}DemoTests:
    type: bundle.unit-test
    platform: iOS
    sources:
      - path: ./{{cookiecutter.module_name}}DemoTests
    dependencies:
      - target: {{cookiecutter.module_name}}Demo

  {{cookiecutter.module_name}}DemoUITests:
    type: bundle.ui-testing
    platform: iOS
    sources:
      - path: ./{{cookiecutter.module_name}}DemoUITests
    dependencies:
      - target: {{cookiecutter.module_name}}Demo
EOF

if command -v xcodegen >/dev/null 2>&1; then
  xcodegen generate
  rm project.yml
else
  echo "⚠️ XcodeGen no está instalado. Instalalo con: brew install xcodegen"
  exit 1
fi

cd ../..
ORIGEN="{{cookiecutter.module_name}}Template"

(
  shopt -s dotglob nullglob
  mv -f "$ORIGEN"/* ./
)

# Eliminar origen si quedó vacío
if [ -z "$(ls -A ./ 2>/dev/null)" ]; then
  rmdir "$ORIGEN"
fi
