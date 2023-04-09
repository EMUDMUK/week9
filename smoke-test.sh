#!/bin/bash
set -x

NODE_IP=$(kubectl get service/calculator-service -o jsonpath='{.spec.clusterIP}' -n staging)
NODE_PORT=$(kubectl get svc calculator-service -o=jsonpath='{.spec.ports[0].port}' -n staging)
curl http://${NODE_IP}:${NODE_PORT}/sum?a=6\&b=2 -eq 3
