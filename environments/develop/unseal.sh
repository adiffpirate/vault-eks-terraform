#!/bin/bash

replicas=$1
KEY_1=$2
KEY_2=$3
KEY_3=$4

for (( i=0; i<$replicas; i++ )); do
	>&2 printf "\n\n#################################\n"
	>&2 printf "Unsealing vault replica number $i\n"
	>&2 printf "#################################\n\n\n"

	kubectl exec --namespace vault -ti vault-$i -- vault operator unseal "$KEY_1"
	>&2 printf "\n"
	kubectl exec --namespace vault -ti vault-$i -- vault operator unseal "$KEY_2"
	>&2 printf "\n"
	kubectl exec --namespace vault -ti vault-$i -- vault operator unseal "$KEY_3"
	>&2 printf "\n"
done
