#UNIX Forms Compile
#compilaRdf.sh
#Compila file

# Middleware
export MW_HOME=/Oracle/product/Middleware
export ORACLE_HOME=$MW_HOME/Oracle_Home
export WLS_HOME=$ORACLE_HOME/wlserver
export WL_HOME=$WLS_HOME
export ORACLE_INSTANCE=/Oracle/config/domains/HPHOFM_FR/config/fmwconfig/components/FORMS/instances/forms1
export FR_HOME=$ORACLE_HOME
export FR_INST=$ORACLE_INSTANCE
export DOMAIN_HOME=/Oracle/config/domains/HPHOFM_FR
export JAVA_HOME=/Oracle/java/JAVA_HOME
export NLS_LANG="AMERICAN_AMERICA.WE8MSWIN1252"
export FORMS_ALLOW_JAVASCRIPT_EVENTS=TRUE

# Forms compilation
PATH=$PATH:$HOME/bin
export PATH=$JAVA_HOME/bin:$FR_HOME/bin:$PATH:$ORACLE_HOME/opmn/bin
export LD_LIBRARY_PATH=/Oracle/product/Middleware/Oracle_Home/lib
export FORMS_BUILDER_CLASSPATH=/Oracle/product/Middleware/Oracle_Home/jlib
export FORMS_PATH=/app/CTS/fmb:/app/CTS/fmx:/app/CTS/pll:/app/CTS/olb
export REPORTS_PATH=/app/CTS/rep:/app/CTS/rdf

#export TWO_TASK=CTS1
export TNS_ADMIN=$DOMAIN_HOME/config/fmwconfig
export WEBUTIL_CONFIG=$FR_INST/server/webutil.cfg
export TERM=vt220
export ORACLE_TERM=$TERM

echo " "
echo "**************************************************************************"
echo "*** Use: >./compilaRdf.sh [filename without extension] [CTSTEST UserID]***"
echo "**************************************************************************"
echo " "
read -s -p "Enter CTSTEST  Password: " dbpassword
echo " "
echo "Compilando Archivo: " $1".rdf"
$ORACLE_HOME/bin/rwconverter.sh userid=$2/$dbpassword@$3 batch=yes source=$1 stype=rdffile dtype=repfile overwrite=yes compile_all=yes
read -p "Enter [admowner] UserID: " scpUserID
scp $1".rdf" $scpUserID@hph4lp-webl02:/app/CTS/rdf
scp $1".rep" $scpUserID@hph4lp-webl02:/app/CTS/rep
mv $1".rep" ../rep/$1".rep"
