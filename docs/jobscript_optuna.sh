#!/usr/bin/env bash
#SBATCH -A C3SE-STAFF
#SBATCH --gpus-per-node=A40:1

ml purge
container="/mimer/NOBACKUP/groups/llm-workshop/containers/optuna.sif"

export TRANSFORMERS_VERBOSITY="error"

ipy_flags=(
 "--TerminalInteractiveShell.colors=NoColor"
 "--TerminalInteractiveShell.xmode=Verbose"
)
apptainer exec $container ipython "${ipy_flags[@]}" -c "%run optuna_randomsearch.ipynb"
