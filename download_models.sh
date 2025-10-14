#!/bin/bash
mkdir -p backend/model/ConstructionSafetyQA-1.2B-V1
aws s3 cp s3://finetuning-demo-models/ConstructionSafetyQA-1.2B-V1/ backend/model/ConstructionSafetyQA-1.2B-V1/ --recursive