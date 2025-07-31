helm install keycloak ./bitnami/keycloak \
  --kube-insecure-skip-tls-verify \
  --namespace dev-local \
  --kubeconfig ./kubeconf/local.yaml \
  --set metrics.enabled=false \
  --set metrics.serviceMonitor.enabled=true \
  --set metrics.serviceMonitor.namespace="cattle-monitoring-system" \
  --set auth.adminUser=admin \
  --set auth.adminPassword="123456aA@" \
  --set service.nodePorts.http=30012 \
  --set service.type=NodePort \
  --set resources.requests.memory="1000Mi" \
  --set resources.requests.cpu="400m" \
  --set resources.limits.memory="1000Mi" \
  --set resources.limits.cpu="400m" \
  --set extraEnvVars[0].name="KC_DB" \
  --set extraEnvVars[0].value="postgres" \
  --set extraEnvVars[1].name="KC_DB_URL" \
  --set extraEnvVars[1].value="jdbc:postgresql://172.23.0.127:9999/kcdemocoreapp" \
  --set extraEnvVars[2].name="KC_DB_USERNAME" \
  --set extraEnvVars[2].value="postgres" \
  --set extraEnvVars[3].name="KC_DB_PASSWORD" \
  --set extraEnvVars[3].value="123456aA@" \
  --set extraEnvVars[4].name="KC_HOSTNAME" \
  --set extraEnvVars[4].value="keycloak.com.vn" \
  --set extraEnvVars[5].name="KC_PROXY" \
  --set extraEnvVars[5].value="edge" \
  --set extraEnvVars[6].name="KC_HTTP_ENABLED" \
  --set-string extraEnvVars[6].value="true" \
  --set extraEnvVars[7].name="KC_HOSTNAME_STRICT" \
  --set-string extraEnvVars[7].value="false" \
  --set extraEnvVars[8].name="KC_ADMIN" \
  --set extraEnvVars[8].value="admin" \
  --set extraEnvVars[9].name="KC_ADMIN_PASSWORD" \
  --set extraEnvVars[9].value="123456aA@" \
  --set extraEnvVars[10].name="KC_ENABLE_PRODUCTION" \
  --set-string extraEnvVars[10].value="true" \
  --set command[0]="/opt/bitnami/keycloak/bin/kc.sh" \
  --set command[1]="start" \
  --set tls.enabled=true \
  --set tls.existingSecret="keycloak-cert" \
  --set tls.usePem=true \
  --set extraEnvVars[11].name="KC_HTTPS_CERTIFICATE_FILE" \
  --set extraEnvVars[11].value="/opt/bitnami/keycloak/certs/tls.crt" \
  --set extraEnvVars[12].name="KC_HTTPS_CERTIFICATE_KEY_FILE" \
  --set extraEnvVars[12].value="/opt/bitnami/keycloak/certs/tls.key"


0	KC_DB=postgres	Sử dụng PostgreSQL làm backend DB
1	KC_DB_URL=jdbc:postgresql://...	JDBC connection string
2–3	KC_DB_USERNAME, KC_DB_PASSWORD	Thông tin xác thực đến DB
4	KC_HOSTNAME=keycloak.com.vn	Tên miền mà Keycloak phản hồi
5	KC_PROXY=edge	Bật chế độ proxy edge để xử lý SSL từ outside, sau đó sẽ call http nội bộ
6	KC_HTTP_ENABLED=true	Cho phép cổng HTTP 8080 (cho probe hoạt động)
7	KC_HOSTNAME_STRICT=false	Không bắt strict match hostname
8–9	KC_ADMIN, KC_ADMIN_PASSWORD	Tương tự phần auth.*, nhưng set thêm để đảm bảo
10	KC_ENABLE_PRODUCTION=true	Chạy ở chế độ production (bắt buộc nếu dùng TLS)
11–12	KC_HTTPS_CERTIFICATE_FILE, KC_HTTPS_CERTIFICATE_KEY_FILE	Đường dẫn đến .crt và .key đã mount vào container từ secret
