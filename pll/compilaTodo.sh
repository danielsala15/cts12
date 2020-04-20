# Middleware
export MW_HOME=/Oracle/Middleware
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

# Forms Compilation
PATH=$PATH:$HOME/bin
export PATH=$JAVA_HOME/bin:$FR_HOME/bin:$PATH:$ORACLE_HOME/opmn/bin
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
export FORMS_BUILDER_CLASSPATH=$ORACLE_HOME/jlib
export FORMS_PATH=/app/CTS/fmb:/app/CTS/fmx:/app/CTS/pll:/app/CTS/olb
export FORMS_BUILDER_CLASSPATH=/Oracle/Middleware/Oracle_Home/forms/java
#export TWO_TASK=CTS1
export TNS_ADMIN=$DOMAIN_HOME/config/fmwconfig
export WEBUTIL_CONFIG=$FR_INST/server/webutil.cfg
export TERM=vt220
export ORACLE_TERM=$TERM
echo " "
read -s -p "Enter $3 Password: " dbpassword
for i  in `ls  *.pll`
do
echo Compiling Library $i  ...
  $ORACLE_HOME/bin/frmcmp_batch Module=$i Userid=$2/$dbpassword@$3 Module_Type=$1 Logon=YES Compile_All=YES Window_State=Minimized Batch=YES Script=NO Debug=yes
  archivo=$(sed 's/.\{4\}$//' <<< "$i")
  if [ -s $archivo".plx" ]; then
    echo "Archivo "$archivo".plx creado..."
#    scp $archivo".pll" admowner@hph4lp-webl02:/app/CTS/pll
#    scp $archivo".plx" admowner@hph4lp-webl02:/app/CTS/plx
    mv $archivo".plx" ../plx/$archivo".plx"
#    rm $archivo".err"
  else
    echo "Error, verificar el archivo "$archivo".err..."
  fi
done
