#!/bin/sh
bazel build //proto/cel/expr:all

rm -vrf ./expr
mkdir ./expr

files=($(bazel aquery 'kind(proto, //proto/cel/expr:all)' | grep Outputs | grep "[.]pb[.]go" | grep "expr_go_proto" | sed 's/Outputs: \[//' | sed 's/\]//' | tr "," "\n"))
for src in ${files[@]};
do
  dst=$(echo $src | sed 's/\(.*\%\/github.com\/google\/cel-spec\/\(.*\)\)/\2/')
  $(cp $src ./expr)
done