#!/bin/bash

cluster_type=$1;
time_limit=$2;
script_name=$3;
script_path=`readlink -f $script_name`
shift;
shift;
shift;

echo "### Submitting" $# "jobs to" $cluster_type;

cpu_job_limit=16;
gpu_job_limit=2;

if [ $cluster_type == "cpu" ]; then
	job_limit=$cpu_job_limit;
	sbatch_arguments="-p sandybridge -A COMPUTERLAB-SL2";
elif [ $cluster_type == "gpu" ]; then
	job_limit=$gpu_job_limit;
	sbatch_arguments="-p tesla -A COMPUTERLAB-SL2-GPU"; # --gpu_compute_mode=3";
else
	echo "Need to choose cluster type";
	exit;
fi;

for i in $(seq 1 $job_limit $#); do
	config_list="";
	config_count=0
	for j in $(seq 0 1 $(($job_limit - 1))); do
		k=$(($i+$j));
		if [ $k -le $# ]; then
			config_list="$config_list ${!k}";
			config_count=$(($config_count + 1));
		fi;
	done;

	echo "sbatch $sbatch_arguments --time=$time_limit --ntasks=$config_count /home/dk503/proj/slurm_submit $cluster_type $script_path $config_list";
	sbatch $sbatch_arguments --time=$time_limit --ntasks=$config_count /home/dk503/proj/slurm_submit $cluster_type $script_path $config_list;
done;
