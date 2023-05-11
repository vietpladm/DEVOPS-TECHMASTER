LEVEL 2: triển khai deployment một ứng dụng web tĩnh lên kubernetes cho phép truy cập từ bên ngoài thông qua nodePort

output:

đóng gói thành công container chứa web tĩnh
download 1 template tại https://www.free-css.com/free-css-templates)
sử dụng base image nginx
lưu ý cấu hình nginx trỏ tới web tĩnh (tham khảo file cấu hình mẫu đơn giản tại https://gist.github.com/mockra/9062657)
1 deployment chạy ứng dụng web tĩnh (replicas=2)
1 nodePort service trỏ tới deployment (service web 1)
thực hiên curl tới nodePort và cho ra kết quả trang web tĩnh theo template

devops@MAYTINH:~/DEVOPS-TECHMASTER/K8S/nginx/lab-2/template$ k get pod

NAME                                  READY   STATUS    RESTARTS        AGE

nginx-deployment-2-58dc5f78dc-4c9qz   1/1     Running   0               10s

nginx-deployment-2-58dc5f78dc-bz8rk   1/1     Running   0               10s

ubuntu                                1/1     Running   182 (11m ago)   2d2h

whoami-85dd4d7ccb-crk95               1/1     Running   0               2d3h

devops@MAYTINH:~/DEVOPS-TECHMASTER/K8S/nginx/lab-2/template$ k create -f nginx-service.yaml 

service/maintenance-nginx created

devops@MAYTINH:~/DEVOPS-TECHMASTER/K8S/nginx/lab-2/template$ k get svc

NAME                TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE

kubernetes          ClusterIP   10.96.0.1       <none>        443/TCP        2d3h

  maintenance-nginx   NodePort    10.96.246.144   <none>        80:31000/TCP   12s

  whoami              ClusterIP   10.96.245.89    <none>        80/TCP         2d3h

  whoami-headless     ClusterIP   None            <none>        80/TCP         2d2h

  devops@MAYTINH:~/DEVOPS-TECHMASTER/K8S/nginx/lab-2/template$ k describe svc/maintenance-nginx 
  

  Name:                     maintenance-nginx
  
Namespace:                default
  
Labels:                   app=maintenance-nginx
  
Annotations:              <none>
  
Selector:                 app=nginx
  
Type:                     NodePort
  
IP Family Policy:         SingleStack
  
IP Families:              IPv4
  
IP:                       10.96.246.144
  
IPs:                      10.96.246.144
  
Port:                     80-80  80/TCP
  
TargetPort:               443/TCP
  
NodePort:                 80-80  31000/TCP
Endpoints:                10.244.1.19:443,10.244.2.20:443
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>
devops@MAYTINH:~/DEVOPS-TECHMASTER/K8S/nginx/lab-2/template$ k get pod -o wide
NAME                                  READY   STATUS    RESTARTS        AGE    IP            NODE                     NOMINATED NODE   READINESS GATES
nginx-deployment-2-58dc5f78dc-4c9qz   1/1     Running   0               62s    10.244.2.20   k8s-playground-worker    <none>           <none>
nginx-deployment-2-58dc5f78dc-bz8rk   1/1     Running   0               62s    10.244.1.19   k8s-playground-worker2   <none>           <none>
ubuntu                                1/1     Running   182 (12m ago)   2d2h   10.244.1.7    k8s-playground-worker2   <none>           <none>
whoami-85dd4d7ccb-crk95               1/1     Running   0               2d3h   10.244.2.8    k8s-playground-worker    <none>           <none>
devops@MAYTINH:~/DEVOPS-TECHMASTER/K8S/nginx/lab-2/template$ k get node -o wide
NAME                           STATUS   ROLES           AGE    VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION                      CONTAINER-RUNTIME
k8s-playground-control-plane   Ready    control-plane   5d2h   v1.26.3   172.18.0.5    <none>        Ubuntu 22.04.2 LTS   5.15.90.1-microsoft-standard-WSL2   containerd://1.6.19-46-g941215f49
k8s-playground-worker          Ready    <none>          5d2h   v1.26.3   172.18.0.4    <none>        Ubuntu 22.04.2 LTS   5.15.90.1-microsoft-standard-WSL2   containerd://1.6.19-46-g941215f49
k8s-playground-worker2         Ready    <none>          5d2h   v1.26.3   172.18.0.3    <none>        Ubuntu 22.04.2 LTS   5.15.90.1-microsoft-standard-WSL2   containerd://1.6.19-46-g941215f49
devops@MAYTINH:~/DEVOPS-TECHMASTER/K8S/nginx/lab-2/template$ k describe svc/maintenance-nginx 
Name:                     maintenance-nginx
Namespace:                default
Labels:                   app=maintenance-nginx
Annotations:              <none>
Selector:                 app=nginx
Type:                     NodePort
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.96.148.224
IPs:                      10.96.148.224
Port:                     80-80  80/TCP
TargetPort:               80/TCP
NodePort:                 80-80  31000/TCP
Endpoints:                10.244.1.19:80,10.244.2.20:80
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>
devops@MAYTINH:~/DEVOPS-TECHMASTER/K8S/nginx/lab-2/template$ curl 172.18.0.3:31000
<!doctype html>
<html>
<head>
<title>Maintainance Page</title>
<meta charset="utf-8"/>
<meta name="robots" content="noindex"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
  body { text-align: center; padding: 150px; background: black;}
  h1 { font-size: 50px; color:white; }
  body { font: 20px Helvetica, sans-serif; color: white; }
  article { display: block; text-align: left; width: 650px; margin: 0 auto; }
  a { color: #dc8100; text-decoration: none; }
  a:hover { color: #333; text-decoration: none; }
</style>
</head>
<body>
<article>
    <h1>Welcome to DEVOPS11 - TECH MASTER!</h1>
    <div>
        <p>THE WEBPAGE BUILDING IS STILL IN PROGRESS V_V</p>
        <p>THANK YOU FOR YOUR PATIENCE.</p>
        <p>PHAN LAC VIET.</p>
    </div>
</article>
</body>
