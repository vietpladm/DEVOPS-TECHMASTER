# DEVOPS-TECHMASTER
NỘP BÀI TẬP DEVOPS-11
Default docker bridge network
Ko có DNS, các containers trong cùng mạng chỉ giao tiếp đc với nhau qua IP address
Ko có sự riêng tư

Các containers dùng default docker bridge network sẽ có chung cấu hình như MTU, Iptables… Nếu muốn thay đổi cấu hình của default bridge network, cần phải khởi động lại docker 
Các containers dùng default docker bridge network sẽ mặc định dùng chung các biến môi trường


Docker bridge network do user tạo
Giao tiếp được với nhau qua containers name do có DNS 
Có sự riêng tư hơn
Các containers có thể được join hoặc rời khỏi bridge network do user tạo trong vòng đời của chúng bằng cách stop chúng rồi tạo lại
Bridge network do user tạo ra có thể được cấu hình với các thông số khác nhau cho các containers như MTU, IPTables…
Các containers trong cùng mạng bridge network do user tạo ra sẽ ko mặc định dùng chung các biến môi trường

