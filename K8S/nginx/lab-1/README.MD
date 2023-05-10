devops@MAYTINH:~/DEVOPS-TECHMASTER/K8S/kubelab/nginx/lab-1$ k create -f template/nginx-deploy.yaml 

deployment.apps/nginx-deployment created

devops@MAYTINH:~/DEVOPS-TECHMASTER/K8S/kubelab/nginx/lab-1$ k create -f template/nginx-svc.yaml

service/nginx-service created

devops@MAYTINH:~/DEVOPS-TECHMASTER/K8S/kubelab/nginx/lab-1$ k get node

NAME                           STATUS   ROLES           AGE     VERSION

k8s-playground-control-plane   Ready    control-plane   4d22h   v1.26.3

k8s-playground-worker          Ready    <none>          4d22h   v1.26.3

k8s-playground-worker2         Ready    <none>          4d22h   v1.26.3

devops@MAYTINH:~/DEVOPS-TECHMASTER/K8S/kubelab/nginx/lab-1$ k get node -o wide

NAME                           STATUS   ROLES           AGE     VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION                      CONTAINER-RUNTIME

k8s-playground-control-plane   Ready    control-plane   4d22h   v1.26.3   172.18.0.5    <none>        Ubuntu 22.04.2 LTS   5.15.90.1-microsoft-standard-WSL2   containerd://1.6.19-46-g941215f49

k8s-playground-worker          Ready    <none>          4d22h   v1.26.3   172.18.0.4    <none>        Ubuntu 22.04.2 LTS   5.15.90.1-microsoft-standard-WSL2   containerd://1.6.19-46-g941215f49

k8s-playground-worker2         Ready    <none>          4d22h   v1.26.3   172.18.0.3    <none>        Ubuntu 22.04.2 LTS   5.15.90.1-microsoft-standard-WSL2   containerd://1.6.19-46-g941215f49

devops@MAYTINH:~/DEVOPS-TECHMASTER/K8S/kubelab/nginx/lab-1$ curl 172.18.0.4:32000

<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>