#!/bin/ksh
###############################################################
# DESCRIPTION # Launch of process Java Batch Monitoring #
###############################################################
# HISTORIQUE  #                                               #
# 19/03/2024  # SP  # Creation                                #
###############################################################

# Declaration of local variables
d=$(date +%Y-%m-%d-%H-%M-%S)
LOG="/c/Pamier_Jars/sos00.PAMIR.batch.9.1.32/lib/java/batch/sosBatchMonitoring/sos_dMONITORING.log"
FLAG=$UNXTMP/sos_aMONITORING.flag

echo "========================================="
echo "BEGINNING OF THE START OF THE APPLICATION PROCESS OF BATCH MONITORING"
echo "========================================="

echo "INF: STARTING THE APPLICATION PROCESS JAVA BATCH MONITORING" >> ${LOG}
date '+%Y-%m-%d %H:%M:%S' >> ${LOG}

# Set the language
export LANG=fr_FR.ISO8859-1

# Build the classpath including all JARs in the lib directory
BASE_DIR="/c/Pamier_Jars/sos00.PAMIR.batch.9.1.32/lib/java/batch/sosBatchMonitoring"
CLASSPATH="$BASE_DIR/sosBatchMonitoring.jar"
for jar in "$BASE_DIR/"*.jar; do
    CLASSPATH="$CLASSPATH:$jar"
done

echo "CLASSPATH = $CLASSPATH" >> ${LOG}

# Introscope (if needed)
INTROSCOPE=""

echo "INF: Testing the existence of a process"
echo "INF: Testing the existence of a process"  >> ${LOG}
nom_du_process="C:\Program Files\Eclipse_DEV\Jdks\jdk11\bin\java.exe -DMONITORING"
echo "nom_du_process  ---- $nom_du_process" >> ${LOG}
test_nb_process=`ps -eaf |grep -v grep|grep "${nom_du_process}" | wc -l`
echo "test_nb_process ----- $test_nb_process" >> ${LOG}
if [ $test_nb_process -ne 0 ]; then
  echo "INF: if process exists => stop the process" 
  echo "INF: if process exists => stop the process"   >> ${LOG} 
  sh sos_aMONITORING.sh
  RC=$?
  if [ $RC -ne 0 ]; then
    echo "ERR: Problem when stopping the application"
    echo "ERR: Problem when stopping the application"  >> ${LOG}
    exit $test_nb_process
  fi
fi

# Run the Java application
"C:\Program Files\Eclipse_DEV\Jdks\jdk11\bin\java.exe" $INTROSCOPE -cp "$CLASSPATH" com.inetpsa.sos.batch.monitoring.SosBatchMonitoringApplication >> ${LOG} 2>&1
cr=$?
echo "CR = $cr" >>${LOG}
if [[ $cr -ne 0 ]]; then
  echo "ERR: Process Java Batch MONITORING KO" 
  echo "ERR: Process Java Batch MONITORING KO" >> ${LOG}
  date '+%Y-%m-%d %H:%M:%S'>> ${LOG}
  exit $cr
else
  echo "INF: Launch of the Java Batch MONITORING process OK"
  echo "INF: Launch of the Java Batch MONITORING process OK" >> ${LOG}
  date '+%Y-%m-%d %H:%M:%S'>> ${LOG}
fi
date '+%Y-%m-%d %H:%M:%S'>> ${LOG}

echo "========================================="
echo "END OF THE START OF THE APPLICATION PROCESS OF BATCH MONITORING"
echo "========================================="

exit 0
