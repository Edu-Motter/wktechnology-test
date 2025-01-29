# WK technology Test

## Setup docker

### Running MySQL container:
```bash
  docker run -p 3306:3306 --name wk-database \
-e MYSQL_ROOT_PASSWORD=root \
-e MYSQL_DATABASE=wktechnology \
-d mysql
```

### Running Spring Boot container:
```bash
  docker run -p 8080:8080 wk-backend --net wk-network --name wk-backend 
```

---

### Network for the containers to communicate:

```bash
  docker network connect wk-network wk-database
``` 
```bash
  docker network connect wk-network wk-database
```



### Blood Types: 
| Blood type | Blood types you can receive | Blood types you can donate to |
|------------|----------------------------|------------------------------|
| A+         | A+, A-, O+, O-             | A+, AB+                      |
| A-         | A-, O-                     | A-, A+, AB-, AB+             |
| B+         | B+, B-, O+, O-             | B+, AB+                      |
| B-         | B-, O-                     | B-, B+, AB+, AB-             |
| AB+        | All blood types (universal recipient) | AB+             |
| AB-        | AB-, A-, B-, O-             | AB-, AB+                      |
| O+         | O+, O-                     | O+, A+, B+, AB+               |
| O-         | O-                         | All blood types (universal donor) |
