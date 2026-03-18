**Metabase Custom Image -> Kubernetes (Helm)**

Bu proje ile amacimiz:
- Dockerfile ile `metabase-custom` imaji olusturmak
- Helm chart ile Kubernetes uzerinde calistirmak
- Helm yapisinin calistigini dogrulamak

**Hizli Komutlar (Amaca Giden Net Adimlar)**
- 1 **Custom image build**
    ```docker build -t metabase-custom:latest .```

- 2 **(Opsiyonel) local calistir ve dogrula**
    ```docker run -d -p 3000:3000 metabase-custom:latest```

- 3 **Helm ile local kontrol**
    ```helm lint helm/metabase```
    ```helm template metabase-custom helm/metabase```

- 4 **Cluster uzerine kurulum**
    ```helm install metabase-custom helm/metabase --set image.repository=metabase-custom --set image.tag=latest```

- 5 **Pod ve servis dogrulama**
    ```kubectl get pods```
    ```kubectl get svc```

- 6 **UI erisimi**
    ```kubectl port-forward svc/metabase-custom-metabase 3000:3000```
    Tarayici: `http://localhost:3000`

**Yapilandirma Ozeti**
- DB tipi: `MB_DB_TYPE=h2`
- DB dosyasi: `/metabase.db/metabase.db`
- DB kaliciligi: PVC uzerinde saklanir
- PVC adi: `<release>-db` (ornek: `metabase-custom-db`)
- Servis adi: `<release>-metabase` (ornek: `metabase-custom-metabase`)
- Port: `3000`

**Detayli Yol Haritasi**
- 1 **Image olustur**
    ```docker build -t metabase-custom:latest .```
- 2 **Chart'i dogrula**
    ```helm lint helm/metabase```
    ```helm template metabase-custom helm/metabase```
- 3 **Kubernetes kurulum**
    ```helm install metabase-custom helm/metabase --set image.repository=metabase-custom --set image.tag=latest```
- 4 **Calisma kontrolu**
    ```kubectl get pods```
    ```kubectl describe pod <pod-name>```
- 5 **Erisim testi**
    ```kubectl port-forward svc/metabase-custom-metabase 3000:3000```
- 6 **Helm dogrulama**
    ```helm status metabase-custom```
    ```helm get manifest metabase-custom```

**Docker Bolumu (Silme + Bilgi)**
- Image bilgisi:
    ```docker images```
    ```docker image inspect metabase-custom:latest```
- Container bilgisi:
    ```docker ps -a```
    ```docker inspect <container-id>```
- Container silme:
    ```docker rm -f <container-id>```
- Image silme:
    ```docker rmi metabase-custom:latest```
- image to .tar 
    ```docker save -o image.tar image:latest```
**Helm Bolumu (Manifest Silme + Bilgi)**
- Manifest bilgisi:
    ```helm list -A```
    ```helm status metabase-custom```
    ```helm get manifest metabase-custom```
- Manifest silme (release kaldirma):
    ```helm uninstall metabase-custom```

**Kubectl Bolumu (Manifest Silme + Bilgi)**
- Manifest bilgisi:
    ```kubectl get all```
    ```kubectl describe deployment <deployment-name>```
    ```kubectl get pvc```
- Manifest silme:
    ```kubectl delete pod <pod-name>```
    ```kubectl delete -f <manifest.yaml>```
    ```kubectl delete deployment <deployment-name>```
    ```kubectl delete service <service-name>```
    ```kubectl delete pvc <pvc-name>```

**Ekstra Yardimci Komutlar (Docker/K8s/Helm)**
- Docker image list:
    ```docker images```
- Docker container list:
    ```docker ps```
- Docker image info:
    ```docker image inspect metabase-custom:latest```
- Docker container silme:
    ```docker rm -f <container-id>```
- Helm release list:
    ```helm list -A```
- Helm manifest info:
    ```helm get manifest metabase-custom```
- Helm upgrade (yeniden deploy):
    ```helm upgrade metabase-custom helm/metabase --set image.repository=metabase-custom --set image.tag=latest```
- Helm uninstall (kaldirma):
    ```helm uninstall metabase-custom```
- Kubectl manifest info:
    ```kubectl get all```
- Pod loglari:
    ```kubectl logs -f <pod-name>```
- Tum kaynaklari gor:
    ```kubectl get all```
- PVC kontrol:
    ```kubectl get pvc```
