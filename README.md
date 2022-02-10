# ApacheToreeOnWin
Apache Toree installed on windows



Requiriments
-------------------------
Microsoft Visual C++ build tools
Docker
GNU Make



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

Install the jupyter kernel. I call this one `toree_spark` to differentiate from any others you may have.
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

Adjusting file run.cmd with the path 

Copy run.cmd to path\bin


In the path, editing kernel.json file

change run.sh for run.cmd

Now launch Jupyter with

```
jupyter notebook
```



Other useful command
-------------------------
Unistall kernel from Jupyter

```
jupyter kernelspec uninstall unwanted-kernel
```




