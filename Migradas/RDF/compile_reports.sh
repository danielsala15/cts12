#!/bin/bash

#UNIX Forms Compile
#Compila file

#source /Oracle/config/domains/HPHOFM_FR/bin/setDomainEnv.sh

echo " "

for i in ????????.rdf; do
echo Compiling Report $i  ...
   /Oracle/config/domains/HPHOFM_FR/reports/bin/rwconverter.sh userid=<username>/<password>@<sid> batch=yes source=$i stype=rdffile dtype=repfile overwrite=yes compile_all=yes
done
