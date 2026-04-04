apiVersion: apps/V1
kind: Deployment
metadata:
  --name : prod-deployment
  ---ns : prod
spec:
  --cpu: 2
  --memory: 2

 ---

 apiVersion: v1
 kind: Service
 metadata: 
   --name : appsvc
   --namespace: prod
 spec:
  --type: NodePort
  --port: 9000

---

adding a new feature: v10

---
