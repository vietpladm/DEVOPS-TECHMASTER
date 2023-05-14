Đề bài

LEVEL 3 (ADVANCE): triển khai nginx proxy cho nhiều ứng dụng

từ level 2, triển khai thêm 1 trang web static thứ hai, khác với static web đã triển khai
service cho trang web tĩnh mới được lấy tên là web2
triển khai thêm 1 deployment nginx-proxy đóng vai trò proxy cho cả 2 ứng dụng trên và tạo nodePort service có tên “nginx-proxy”
thiết lập cấu hình config của nginx-proxy sao cho:
khi gọi tới nginx-proxy với path /web1 > nginx-proxy filter path và forward tới service web 1 > service web1
khi gọi tới nginx-proxy với path /web2 > nginx-proxy filter path và forward tới service web 2 > service web2
VD output:
curl web1.test > trả về static web 1
curl web2.test > trả về static web 2


Cách làm:

Triển khai 2 docker image chứa web1 và web2

Dockerfile Web1:
# pull the latest official nginx image
FROM nginx:stable
# run docker service on HTTPS
EXPOSE 443
# copy the additional nginx configuration
COPY maintanence.conf /etc/nginx/conf.d/maintanence.conf
COPY Web1.html /usr/share/nginx/html/index.html
STOPSIGNAL SIGQUIT
CMD ["nginx", "-g", "daemon off;"]

================================

Cấu hình nginx config file cho web1:

 server {
  listen   80;

  root /var/www/yourdomain.com/public;
  index index.html index.htm;

  server_name yourdomain.com;
  
  location / {
   default_type "text/html";
   try_files $uri.html $uri $uri/ /index.html;
  }
}

================================

làm tương tự cho web2

================================

Triển khai k8s deployment và expose service cho web1, chú ý ko cần khai báo type cho service của web1 như lab-2

apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: web1-deployment
  name: web1-deployment
  namespace: static-websites
spec:
  replicas: 2
  selector:
    matchLabels:
      app: web-1
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: web-1
    spec:
      containers:
      - image: vietpl/web1:0.5
        name: web-1
        resources: {}
        ports:
            - containerPort: 80
status: {}
---
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: web1-service
  name: web1-service
  namespace: static-websites
spec:
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  selector:
    app: web-1
status:
  loadBalancer: {}
  
================================

làm tương tự cho web2

================================

Cài đặt HAproxy-Ingress-Controller theo hướng dẫn trên mạng

================================

Cấu hình Ingress cho HAproxy

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: static-websites
  annotations:
    kubernetes.io/ingress.class: haproxy
  namespace: static-websites
spec:
  rules:
  - host: web1.test
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: web1-service
            port:
              number: 80
  - host: web2.test
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: web2-service
            port:
              number: 80
              
================================

Cấu hình IP của minikube/kind node ip được trở tới từ 2 domain web1.test và web2.test

================================

kết quả sau khi triển khai

devops@MAYTINH:~/DEVOPS-TECHMASTER$ curl web1.test
__    __     _                            _        
/ / /\ \ \___| | ___ ___  _ __ ___   ___  | |_ ___  
\ \/  \/ / _ \ |/ __/ _ \| '_ ` _ \ / _ \ | __/ _ \ 
 \  /\  /  __/ | (_| (_) | | | | | |  __/ | || (_) |
  \/  \/ \___|_|\___\___/|_| |_| |_|\___|  \__\___/ 
                                                    
 __    __     _               _                     
/ / /\ \ \___| |__           / |                    
\ \/  \/ / _ \ '_ \   _____  | |                    
 \  /\  /  __/ |_) | |_____| | |                    
  \/  \/ \___|_.__/          |_|                    
                                                    devops@MAYTINH:~/DEVOPS-TECHMASTER$ 
devops@MAYTINH:~/DEVOPS-TECHMASTER$ curl web2.test
__    __     _                            _        
/ / /\ \ \___| | ___ ___  _ __ ___   ___  | |_ ___  
\ \/  \/ / _ \ |/ __/ _ \| '_ ` _ \ / _ \ | __/ _ \ 
 \  /\  /  __/ | (_| (_) | | | | | |  __/ | || (_) |
  \/  \/ \___|_|\___\___/|_| |_| |_|\___|  \__\___/ 
                                                    
 __    __     _               ____                  
/ / /\ \ \___| |__           |___ \                 
\ \/  \/ / _ \ '_ \   _____    __) |                
 \  /\  /  __/ |_) | |_____|  / __/                 
  \/  \/ \___|_.__/          |_____|                
                                                    devops@MAYTINH:~/DEVOPS-TECHMASTER$ 

