# This script is used for the Open Ondemand portal.
# You can use it as a reference for creating a custom ~/portal/jupyter/my_jupyter_env.sh file

module purge

container=/cephyr/users/chiajung/Alvis/mimer/venvs/llm-quantization.sif

# You can launch jupyter notebook or lab, but you must specify the config file as below:
apptainer exec $container jupyter lab --config="${CONFIG_FILE}"
