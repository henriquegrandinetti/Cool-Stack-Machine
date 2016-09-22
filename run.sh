#! /bin/bash

echo "" > linked.cl

for i in "$@"
do
    echo $i
    echo "$(<$i)" >> linked.cl
done

./cool linked.cl

# rm linked.cl
