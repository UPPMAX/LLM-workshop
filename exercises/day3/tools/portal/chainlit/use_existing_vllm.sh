#!/usr/bin/bash

# N.B. this trick works because we've prepared a temporary vLLM endpoint on
# alvis2, contact support https://supr.naiss.se/support if you want to do
# something similar

# Do port-forwarding for existing vLLM port
alvis2_vllm_port=$(</mimer/NOBACKUP/groups/llm-workshop/exercises/day3/tools/_instructor/.vllm_alvis2_port)
VLLM_API_PORT="$(find_ports)"
ssh -L ${VLLM_API_PORT}:localhost:${alvis2_vllm_port} -S none -T -f -N alvis2

# Using exisiting vLLM connection instead of launching
unset VLLM_SIF
VLLM_BASE_URL="http://localhost:${VLLM_API_PORT}/v1"

# Chainlit set-up
CHAINLIT_SIF=/apps/containers/Chainlit/Chainlit-2.5.5.sif


echo JOBDIR=$JOBDIR
echo CHAINLIT_PORT=$CHAINLIT_PORT
echo VLLM_API_PORT=$VLLM_API_PORT
