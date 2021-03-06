## IO 500 in Four Easy Steps

```bash
git clone https://github.com/VI4IO/io-500-dev
cd io-500-dev
./utilities/prepare.sh
./io500.sh
```

This is designed to work from an interactive login (e.g. it won't work from a login node) and uses 'mpirun -np 2' to do the simplest possible MPI run.  It runs a trivially sized problem and uses a serial implementation of find.  Hopefully it just works for you; if it doesn't, please let us know.

To improve it, edit i0500.sh one function at a time to grow the problem size and replace the serial find with something much faster (you may want to try the provided python parallel find). You may also need to take whatever steps necessary to run it with a job scheduler. 

[Our documents directory](https://github.com/VI4IO/io-500-dev/tree/master/doc) has more detailed instructions including how to submit once you have successfully run.

Thanks for your participation and good luck!  
