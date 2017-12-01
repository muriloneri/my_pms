#!/bin/bash


checkping()
	{
       	ping -c2 -W2 "$HOST" > /dev/null;
	}

checkssh()
	{ 
	sshpass -p ${PASS} ssh -o StrictHostKeyChecking=no $USER@$HOST hostname >> ips_ok.txt;
	}	

for i in `cat planilha2.csv`; do

	USER=`echo $i | awk -F"," '{print $1}'`
	HOST=`echo $i | awk -F"," '{print $2}'`
	PASS=`echo $i | awk -F"," '{print $3}'`

	if checkping; then
		echo "IP "$HOST" VÁLIDO"

		if checkssh; then
			echo "SENHA AUTENTICADA"
			echo
			echo "$HOST, $USER, $PASS" >> ips_ok.txt
		else
			echo "SENHA INVÁLIDA"
			echo
			echo "$HOST, $USER, $PASS" >> ips_nok.txt

		fi
	else
		echo "IP "$HOST" INVÁLIDO"
		echo
		echo "$HOST" >> ips_off.txt
	fi
	done
exit 0
