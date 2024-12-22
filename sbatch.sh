#!/bin/bash
#SBATCH --job-name=0062_bert
#SBATCH --partition=gpu-debug
#SBATCH --nodes=1
#SBATCH --gpus-per-node=1
#SBATCH --ntasks-per-node=1
#SBATCH --wait-all-nodes=1
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err



python main.py  yamls/main/mosaic-bert-base-uncased.yaml