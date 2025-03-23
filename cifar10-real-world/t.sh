export N_GPU=$(nvidia-smi --list-gpus | wc -l)
echo "There are ${N_GPU} GPUs available."

n_clients=8
for id in $(eval echo "{1..$n_clients}")
do
  client_local_dir=workspaces/secure_workspace/site-${id}/local
  cp ${client_local_dir}/resources.json.default ${client_local_dir}/resources.json
  sed -i "s|\"num_of_gpus\": 0|\"num_of_gpus\": ${N_GPU}|g" ${client_local_dir}/resources.json
  sed -i "s|\"mem_per_gpu_in_GiB\": 0|\"mem_per_gpu_in_GiB\": 1|g" ${client_local_dir}/resources.json
done


sed -i 's/&[[:space:]]*$//' /home/ubuntu/cifar10-real-world/workspaces/secure_workspace/140.110.139.139/startup/start.sh
for i in {1..8}; do
  sed -i 's/&[[:space:]]*$//' /home/ubuntu/cifar10-real-world/workspaces/secure_workspace/site-$i/startup/start.sh
done
