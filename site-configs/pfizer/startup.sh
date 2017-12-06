#!/bin/bash



workdir=/lustre/scratch/io500-tests
datadir=$workdir/data # directory where the data will be stored
resultdir=$workdir/result # the directory where the output will be kept
ROOT=/lustre/scratch/siddis14/io-500-dev

# These are listed in the order that they run.
io500_run_ior_easy="True" # does the write phase and enables the subsequent read
io500_run_md_easy="True"  # does the creat phase and enables the subsequent stat
io500_run_ior_hard="True" # does the write phase and enables the subsequent read
io500_run_md_hard="True"  # does the creat phase and enables the subsequent read
io500_run_find="True"
io500_run_ior_easy_read="True"
io500_run_md_easy_stat="True"
io500_run_ior_hard_read="True"
io500_run_md_hard_stat="True"
io500_run_md_easy_delete="True" # turn this off if you want to just run find by itself
io500_run_md_hard_delete="True" # turn this off if you want to just run find by itself
io500_run_mdreal="False"  # this one is optional
io500_cleanup_workdir="False"  # this flag is currently ignored. You'll need to clean up your data files manually if you want to.


function setup_directories {
  # set directories for where the benchmark files are created and where the results will go.
  # If you want to set up stripe tuning on your output directories or anything similar, then this is good place to do it.
  timestamp=`date +%Y.%m.%d-%H.%M.%S`           # create a uniquifier
  io500_workdir=$datadir # directory where the data will be store
  io500_result_dir=$resultdir      # the directory where the output results will be kept
  mkdir -p $io500_workdir $io500_result_dir
}

function setup_paths {
# Set the paths to the binaries.  If you ran ./utilities/prepare.sh successfully, then binaries are in ./bin/
  io500_ior_cmd=$ROOT/bin/ior
  io500_mdtest_cmd=$ROOT/bin/mdtest
  io500_mdreal_cmd=$ROOT/bin/md-real-io
  io500_mpirun="mpirun -np 8"
  io500_mpiargs=""
}

function setup_ior_easy {
  io500_ior_easy_params="-t 2048k -b 500M -F" # 2M writes, 500 MB per proc, file per proc
  }


function setup_mdt_easy {
  io500_mdtest_easy_params="-u -L" # unique dir per thread, files only at leaves
  io500_mdtest_easy_files_per_proc=600
}

function setup_ior_hard {
  io500_ior_hard_writes_per_proc=500
}

function setup_mdt_hard {
  io500_mdtest_hard_files_per_proc=600
}

function setup_find {
   #
   # setup the find command. This is an area where innovation is allowed.
   #    There are two default options provided. One is a serial find and the other
   #    is a parallel version.
   #    If a custom approach is used, please provide enough info so others can reproduce.

   # the serial version that should run (SLOWLY) without modification
   io500_find_mpi="False"
   io500_find_cmd=$ROOT/bin/sfind.sh

}

function setup_mdreal {
  io500_mdreal_params="-P=5000 -I=1000"
  }

function run_benchmarks {
# Important: source the io500_core.sh script.  Do not change it. If you discover
# a need to change it, please email the mailing list to discuss
  source $ROOT/bin/io500_fixed.sh 2>&1 | tee $io500_result_dir/io-500-summary.txt
}

function extra_description {
	echo "System_name='Pfizer-Durham'"
}

rm -rf $datadir

setup_directories
setup_paths
setup_ior_easy # required if you want a complete score
setup_ior_hard # required if you want a complete score
setup_mdt_easy # required if you want a complete score
setup_mdt_hard # required if you want a complete score
setup_find # required if you want a complete score
setup_mdreal # optional
run_benchmarks


