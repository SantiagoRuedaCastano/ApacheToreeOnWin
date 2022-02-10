# Apache Toree on Windows with support for Delta Format
Apache Toree installed on Windows



Requiriments
-------------------------
* Microsoft Visual C++ build tools
* Docker
* GNU Make



Install toree from source
-------------------------

```
git clone https://github.com/apache/incubator-toree
cd incubator-toree/
make dist
```

Then do

```
make release
```

You'll get this error which you can ignore:

```
/bin/sh: 1: docker: not found
Makefile:212: recipe for target 'dist/toree-pip/toree-0.2.0.dev1.tar.gz' failed
make: *** [dist/toree-pip/toree-0.2.0.dev1.tar.gz] Error 127
```

Now we can install the built package ::

```
cd dist/toree-pip/
python setup.py install
```

Install the jupyter kernel. I've called  `toree_spark`.
Be sure to change the value of `--spark-home` to yours.

```
jupyter toree install --kernel_name=toree_spark --spark_home=c:/spark/   --user
```


Configuration
-------------------------

Getting path from jupyter

```
jupyter kernelspec list
```

Adjusting file `run.cmd` with the path 

Copy `run.cmd` to path\bin


In the path, editing `kernel.json` file

change `run.sh` for `run.cmd`

Now launch Jupyter with

```
jupyter notebook
```

Add Delta Format support to Apache Toree
-------------------------

Inside `kernel.json` file option `"__TOREE_SPARK_OPTS__": ""` it must be changed by 

```
"__TOREE_SPARK_OPTS__": "--packages io.delta:delta-core_2.12:0.8.0 --conf spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension --conf spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog"
```

Aditional copy delta JARs to `%SPARK_HOME%\jar`

Other useful command
-------------------------
Unistall kernel from Jupyter

```
jupyter kernelspec uninstall unwanted-kernel
```




