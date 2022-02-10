@echo off

REM PATH can be gotten from jupyter kernelspec list command
set PROG_HOME= path

if not defined SPARK_HOME (
  echo SPARK_HOME must be set to the location of a Spark distribution!
  exit 1
)

REM disable randomized hash for string in Python 3.3+
set PYTHONHASHSEED=0

REM The SPARK_OPTS values during installation are stored in __TOREE_SPARK_OPTS__. This allows values to be specified during
REM install, but also during runtime. The runtime options take precedence over the install options.

if not defined SPARK_OPTS (
  set SPARK_OPTS=%__TOREE_SPARK_OPTS__%
) else (
  if "%SPARK_OPTS%" == "" (
    set SPARK_OPTS=%__TOREE_SPARK_OPTS__%
  )
)

if not defined TOREE_OPTS (
  set TOREE_OPTS=%__TOREE_OPTS__%
) else (
  if "%TOREE_OPTS%" == "" (
    set TOREE_OPTS=%__TOREE_OPTS__%
  )
)


echo Starting Spark Kernel with SPARK_HOME=%SPARK_HOME%

REM This doesn't work because the classpath doesn't get set properly, unless you hardcode it in SPARK_SUBMIT_OPTS using forward slashes or double backslashes, but then you can't use the SPARK_HOME and PROG_HOME variables.
REM set SPARK_SUBMIT_OPTS=-cp "%SPARK_HOME%\conf\;%SPARK_HOME%\jars\*;%PROG_HOME%\lib\toree-assembly-0.2.0.dev1-incubating-SNAPSHOT.jar" -Dscala.usejavacp=true
REM set TOREE_COMMAND="%SPARK_HOME%\bin\spark-submit.cmd" %SPARK_OPTS% --class org.apache.toree.Main %PROG_HOME%\lib\toree-assembly-0.2.0.dev1-incubating-SNAPSHOT.jar %TOREE_OPTS% %*

REM The two important things that we must do differently on Windows are that we must add toree-assembly-0.2.0.dev1-incubating-SNAPSHOT.jar to the classpath, and we must define the java property scala.usejavacp=true.
set TOREE_COMMAND="%JAVA_HOME%\bin\java" -cp "%SPARK_HOME%conf/;%SPARK_HOME%jars/*;%PROG_HOME%\lib\toree-assembly-0.6.0.dev0-incubating-SNAPSHOT.jar" -Dscala.usejavacp=true -Xmx1g org.apache.spark.deploy.SparkSubmit %SPARK_OPTS% --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" --conf "spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog" --class org.apache.toree.Main %PROG_HOME%\lib\toree-assembly-0.6.0.dev0-incubating-SNAPSHOT.jar %TOREE_OPTS% %*

echo.
echo %TOREE_COMMAND%
echo.

%TOREE_COMMAND%