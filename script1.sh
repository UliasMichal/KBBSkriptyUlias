#!/bin/bash

POZDRAV_A="Ahoj, jak se vede?"
POZDRAV_B="Čau, máš se?"
POZDRAV_C="Nazdar kámo!"

PRILEZITOST=1

if (( $PRILEZITOST < 0 )) 
then echo $POZDRAV_A
else
    	if (( $PRILEZITOST > 10 ))
        then
		echo $POZDRAV_B
        else
		echo $POZDRAV_C
        fi
fi
