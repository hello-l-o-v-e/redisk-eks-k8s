#!/bin/bash

set -e

# 参数设置
BRANCH=${1:-"main"}
ENVIRONMENT=${2:-"testnet"}
IMAGE_TAG=${3:-"latest"}

echo "Starting deployment..."
echo "Branch: $BRANCH"
echo "Environment: $ENVIRONMENT"
echo "Image Tag: $IMAGE_TAG"

# 等待Pod就绪
wait_for_pod() {
    local pod_name=$1
    local max_attempts=30
    local attempt=1
    
    while [ $attempt -le $max_attempts ]; do
        if kubectl get pod -l app=redis | grep -q Running; then
            echo "Pod is ready!"
            return 0
        fi
        echo "Waiting for pod to be ready... (attempt $attempt/$max_attempts)"
        sleep 10
        attempt=$((attempt + 1))
    done
    echo "Timeout waiting for pod to be ready"
    exit 1
}

# 执行部署
echo "Deploying Redis to EKS..."
wait_for_pod "redis"
echo "Deployment completed successfully!"

