#!/usr/bin/env bash

# su -m $DOCKER_USER -c "jupyter notebook --allow-root --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir=/workdir"

cd /root
jupyterhub -f /etc/jupyterhub/jupyterhub_config.py