#UNIX Forms Compile
#compile_forms.sh
export FORMS_PATH=/app/CTS/fmb:/app/CTS/fmx:/app/CTS/pll:/app/CTS/olb
export FORMS_BUILDER_CLASSPATH=/Oracle/Middleware/Oracle_Home/forms/java
#Compila file

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

# Forms compilation
PATH=$PATH:$HOME/bin
export PATH=$JAVA_HOME/bin:$FR_HOME/bin:$PATH:$ORACLE_HOME/opmn/bin
export LD_LIBRARY_PATH=/Oracle/Middleware/Oracle_Home/lib
export FORMS_BUILDER_CLASSPATH=/Oracle/Middleware/Oracle_Home/jlib
export FORMS_PATH=/app/CTS/fmb:/app/CTS/fmx:/app/CTS/pll:/app/CTS/olb
export REPORTS_PATH=/app/CTS/rep:/app/CTS/rdf
#export TWO_TASK=CTS1
export TNS_ADMIN=$DOMAIN_HOME/config/fmwconfig
export WEBUTIL_CONFIG=$FR_INST/server/webutil.cfg
export TERM=vt220
export ORACLE_TERM=$TERM
echo " "
echo "****************************************************************************************"
echo "*** Use: >./compilaFrm.sh [filename without extension] [module type] [UserID] [SID]  ***"
echo "*** were module_type: MENU, LIBRARY, FORM or REPORT                                  ***"
echo "****************************************************************************************"
echo " "
if [ $# -ne 4 ]; then
    echo "NUEVO: Usa SID despues del UserID"
    exit 1
fi
read -s -p "Enter $4 Password: " dbpassword
echo " "
if [ "$2" == "FORM" ]; then
  echo "Compilando Archivo: " $1".fmb"
  $ORACLE_HOME/bin/frmcmp_batch Module=$1".fmb" Userid=$3/$dbpassword@$4 Module_Type=$2 Logon=YES Compile_All=YES Window_State=Minimized Batch=YES Script=NO Output_File=$1".fmx" Debug=yes
  if [ -s $1".fmx" ]; then
    echo "Archivo "$1".fmx creado..."
    read -p "Enter [admowner] UserID: " scpUserID
    scp $1".fmb" $scpUserID@hph4lp-webl02:/app/CTS/fmb
    scp $1".fmx" $scpUserID@hph4lp-webl02:/app/CTS/fmx
    mv $1".fmx" ../fmx/$1".fmx"
  else
    echo "Error, verificar el archivo "$1".err..."
  fi
elif [ "$2" == "MENU" ]; then
  echo "Compilando Archivo: " $1".mmb"
  frmcmp_batch Module=$1".mmb" Userid=$3/$dbpassword@$4 Module_Type=$2 Logon=YES Compile_All=YES Window_State=Minimized Batch=YES Script=NO Output_File=$1".mmx"
  if [ -s $1".mmx" ]; then
    echo "Archivo "$1".mmx creado..."
    read -p "Enter [admowner] UserID: " scpUserID
    scp $1".mmb" $scpUserID@hph4lp-webl02:/app/CTS/fmb
    scp $1".mmx" $scpUserID@hph4lp-webl02:/app/CTS/fmx
    mv $1".mmx" ../fmx/$1".mmx"
   else
    echo "Error, verificar el archivo "$1".err..."
  fi
elif [ "$2" == "LIBRARY" ]; then
  echo "Compilando Archivo: " $1".pll"
  frmcmp_batch Module=$1".pll" Userid=$3/$dbpassword@$4 Module_Type=$2 Logon=YES Compile_All=YES Window_State=Minimized Batch=YES Script=NO Output_File=$1".plx"
  if [ -s $1".plx" ]; then
    echo "Archivo "$1".plx creado..."
    read -p "Enter [admowner] UserID: " scpUserID
    scp $1".pll" $scpUserID@hph4lp-webl02:/app/CTS/pll
    scp $1".plx" $scpUserID@hph4lp-webl02:/app/CTS/pll
    mv $1".plx" ../pll/$1".plx"
   else
    echo "Error, verificar el archivo "$1".err..."
  fi
fi
