# This script is used for the Open Ondemand portal.
# You can use it as a reference for creating a custom ~/portal/jupyter/*.sh file

ml purge  # Ensure we don't have any conflicting modules loaded

# The container must contain jupyter
container=/mimer/NOBACKUP/groups/llm-workshop/containers/prompt_eng/prompt_eng.sif

# You can launch jupyter notebook or lab, but you must specify the config file as below:
apptainer exec --nv $container jupyter notebook --config="${CONFIG_FILE}"