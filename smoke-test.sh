#!/bin/bash
set -x

NODE_IP=$(kubectl get service/calculator-service -o jsonpath='{.spec.clusterIP}')
NODE_PORT=$(kubectl get svc calculator-service -o=jsonpath='{.spec.ports[0].port}')
curl http://${NODE_IP}:${NODE_PORT}/sum?a=1\&b=2
