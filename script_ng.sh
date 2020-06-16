#!/bin/bash

g++ -g C01_node_generator_v01.cpp -o B01_ng.out

for n in `seq 1 50`;
do	
	for itr in `seq 1 50`;
	do	
		echo "n=$n,iteration=$itr"
		echo "n=$n,iteration=$itr" >> R01_LoN.txt
		./B01_ng.out $n	
		sleep 1
	done 
done

