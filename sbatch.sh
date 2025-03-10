#!/bin/bash
#SBATCH --job-name=0062_bert
#SBATCH --partition=gpu-debug
#SBATCH --nodes=1
#SBATCH --gres=gpu:8
#SBATCH --ntasks-per-node=1
#SBATCH --wait-all-nodes=1
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err

# List of environment variables and module loads for pretrain tasks

export PRETRAIN_CUDA_VERSION_MAJOR=12
export PRETRAIN_CUDA_VERSION_MINOR=1
export PRETRAIN_CUDA_VERSION=${PRETRAIN_CUDA_VERSION_MAJOR}.${PRETRAIN_CUDA_VERSION_MINOR}
export PRETRAIN_CUDA_VERSION_SHORT=${PRETRAIN_CUDA_VERSION_MAJOR}${PRETRAIN_CUDA_VERSION_MINOR}
export PRETRAIN_CUDNN_VERSION=8.9.4
export PRETRAIN_HPCX_VERSION=2.17.1
export PRETRAIN_NCCL_VERSION=2.20.5

export PRETRAIN_PYTHON_VERSION=3.10.14
export PRETRAIN_TORCH_VERSION=2.3.1
export PRETRAIN_TORCHVISION_VERSION=0.18.1
export PRETRAIN_APEX_VERSION=24.04.01
export PRETRAIN_TRANSFORMER_ENGINE_VERSION=1.4
export PRETRAIN_MEGATRON_TAG=nii-geniac
# Ensure the appropriate Huggingface tokenizer is included
# https://github.com/llm-jp/scripts/pull/12#discussion_r1708415209
export PRETRAIN_TOKENIZER_TAG=v3.0b2

module load cuda/${PRETRAIN_CUDA_VERSION}
module load /data/cudnn-tmp-install/modulefiles/${PRETRAIN_CUDNN_VERSION}
module load hpcx/${PRETRAIN_HPCX_VERSION}-gcc-cuda${PRETRAIN_CUDA_VERSION_MAJOR}/hpcx
module load nccl/${PRETRAIN_NCCL_VERSION}

uv add flash-attn

export TORCH_NCCL_ASYNC_ERROR_HANDLING=1


export LAUNCHER="composer -n 8"


export CMD="main.py yamls/main/modernbert-base.yaml run_name=modernbert-base"

srun $LAUNCHER $CMD

