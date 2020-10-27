#!/bin/bash

read -p "Zadejte číslo: " INPUT

pripustneChary='^[0-9]+$'
if ! [[ $INPUT =~ $pripustneChary ]]; then
   exit 1
fi

read -p "Zadejte název adresáře: " ADRESAR

if [[ ! -d $ADRESAR ]]; then
   mkdir $ADRESAR
   else
	if [[ ! -z "$(ls -A $ADRESAR)" ]]; then
	if [[ -d "$ADRESAR.bak" ]]; then
	rm -rf "$ADRESAR.bak"
	fi
	mv $(pwd)/$ADRESAR $(pwd)/"$ADRESAR.bak"
	mkdir $ADRESAR
	fi
fi

i=$(( $INPUT ))
iterace=0

while read line ; do
	i=$(( i-1 ))
	if (( i < $(( 0 )) )); then
	break
	fi
	iterace=$(( iterace + 1 ))
	koncovka=$( echo $line | rev  | cut -d '.' -f 1 | rev)
	zbytek=$( echo $line | rev | cut -c$(( ${#koncovka} + 2 ))- | rev )
	if [[ ! -d $(pwd)/$ADRESAR/$koncovka ]]; then
	mkdir $(pwd)/$ADRESAR/$koncovka
	fi
	touch $(pwd)/$ADRESAR/$koncovka/$zbytek
	echo "$koncovka/$zbytek"
	curl -m 60 -L http://$line > $ADRESAR/$koncovka/$zbytek 2>/dev/null
done < <( curl https://raw.githubusercontent.com/opendns/public-domain-lists/master/opendns-top-domains.txt 2>/dev/null)
echo "Počet iterací byl:" $iterace

exit 0
