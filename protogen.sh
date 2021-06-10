#!/bin/bash

set -eo pipefail


PROTO_DIRS=$(find ./proto -path -prune -o -name '*.proto' -print0 | xargs -0 -n1 dirname | sort | uniq)

rm -r ./ts/_proto
mkdir -p ./ts/_proto

echo "Compiling protobuf definitions"
for dir in $PROTO_DIRS; do
echo $dir
protoc \
  --plugin=protoc-gen-ts=./node_modules/.bin/protoc-gen-ts \
  --plugin=protoc-gen-go=${GOBIN}/protoc-gen-go \
  -I ./proto \
  -I third_party/proto \
  --js_out=import_style=commonjs,binary:./ts/_proto \
  --ts_out=service=true:./ts/_proto \
  $(find "${dir}" -name '*.proto')
done


PROTO_DIRS=$(find ./third_party -path -prune -o -name '*.proto' -print0 | xargs -0 -n1 dirname | sort | uniq)


echo "Compiling protobuf definitions"
for dir in $PROTO_DIRS; do
echo $dir
protoc \
  --plugin=protoc-gen-ts=./node_modules/.bin/protoc-gen-ts \
  --plugin=protoc-gen-go=${GOBIN}/protoc-gen-go \
  -I ./proto \
  -I third_party/proto \
  --js_out=import_style=commonjs,binary:./ts/_proto \
  --ts_out=service=true:./ts/_proto \
  $(find "${dir}" -name '*.proto')
done
