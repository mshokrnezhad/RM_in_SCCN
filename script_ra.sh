#!/bin/bash

g++ -g C02_gpcch_cpp_v02_TPC_v02.cpp -o B02_tpc.out
g++ -g C03_gpcch_cpp_v02_OPC_v02.cpp -o B03_opc.out
g++ -g C04_gpcch_cpp_v02_DTPC_v02.cpp -o B04_dtpc.out

for n in `seq 21 50`;
do	
	echo "n=$n" >> R02_TPC_SoP.txt
	echo "n=$n" >> R03_TPC_SoSNR.txt
	echo "n=$n" >> R04_TPC_NoSU.txt
	echo "n=$n" >> R02_OPC_SoP.txt
	echo "n=$n" >> R03_OPC_SoSNR.txt
	echo "n=$n" >> R04_OPC_NoSU.txt
	echo "n=$n" >> R02_DTPC_SoP.txt
	echo "n=$n" >> R03_DTPC_SoSNR.txt
	echo "n=$n" >> R04_DTPC_NoSU.txt

	for itr in `seq 1 50`;
	do	
		echo "n=$n,iteration=$itr"	


		if [ $itr -eq 50 ]
		then
			sed -n "/^n=$n,iteration=50/,/^n=$(($n + 1)),iteration=1/p" R01_LoN.txt | awk '/^x/'|sed 's/x\[0\] = 5000;//g'|sed '/^\s*$/d'|sed 's/;//g'|sed 's/x//g'|sed 's/ = / /g'|sed 's/\[//g'|sed 's/\]//g'>R01_x.txt
			echo "$(($n + 1)) 5000" >> R01_x.txt
			sed -n "/^n=$n,iteration=50/,/^n=$(($n + 1)),iteration=1/p" R01_LoN.txt | awk '/^y/'|sed 's/y\[0\] = 5000;//g'|sed '/^\s*$/d'|sed 's/;//g'|sed 's/y//g'|sed 's/ = / /g'|sed 's/\[//g'|sed 's/\]//g'>R01_y.txt
			echo "$(($n + 1)) 5000" >> R01_y.txt
		else
			sed -n "/^n=$n,iteration=$itr$/,/^n=$n,iteration=$(($itr + 1))$/p" R01_LoN.txt | awk '/^x/'|sed 's/x\[0\] = 5000;//g'|sed '/^\s*$/d'|sed 's/;//g'|sed 's/x//g'|sed 's/ = / /g'|sed 's/\[//g'|sed 's/\]//g'>R01_x.txt
		echo "$(($n + 1)) 5000" >> R01_x.txt
			sed -n "/^n=$n,iteration=$itr$/,/^n=$n,iteration=$(($itr + 1))$/p" R01_LoN.txt | awk '/^y/'|sed 's/y\[0\] = 5000;//g'|sed '/^\s*$/d'|sed 's/;//g'|sed 's/y//g'|sed 's/ = / /g'|sed 's/\[//g'|sed 's/\]//g'>R01_y.txt
		echo "$(($n + 1)) 5000" >> R01_y.txt
		fi
	
		./B02_tpc.out $n
		./B03_opc.out $n
		./B04_dtpc.out $n

		rm R01_x.txt
		rm R01_y.txt
	done 
done    

