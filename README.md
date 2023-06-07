# Proyecto 2

## Steps

### Paso 1

```bash
lab102-191:/aplicacionesCephRook/ceph/ kubectl create -f common.yaml
```

```bash
lab102-191:/aplicacionesCephRook/ceph/ kubectl create -f operator.yaml
```

```bash
lab102-191:/aplicacionesCephRook/ceph/ kubectl -n rook-ceph get pods
NAME                                  READY   STATUS    RESTARTS   AGE
rook-ceph-operator-6d5456dddd-6k6r6   1/1     Running   0          5m49s
rook-discover-c8qjj                   1/1     Running   0          3m18s
rook-discover-dlxz7                   1/1     Running   0          3m18s
rook-discover-hxstp                   1/1     Running   0          3m18s
```

```bash
lab102-191:/aplicacionesCephRook/ceph/ kubectl create -f cluster.yaml
```

```bash
lab102-191:/aplicacionesCephRook/ceph/ kubectl -n rook-ceph get pods
NAME                                            READY   STATUS      RESTARTS   AGE
rook-ceph-operator-6d5456dddd-6k6r6             1/1     Running     0          17m
rook-discover-c8qjj                             1/1     Running     0          15m
rook-discover-dlxz7                             1/1     Running     0          15m
rook-discover-hxstp                             1/1     Running     0          15m
csi-cephfsplugin-2n7hm                          3/3     Running     0          10m
csi-rbdplugin-hlvzb                             3/3     Running     0          10m
csi-cephfsplugin-provisioner-64d4468bbf-vlhmf   5/5     Running     0          10m
csi-rbdplugin-bncfx                             3/3     Running     0          10m
csi-cephfsplugin-tjl97                          3/3     Running     0          10m
csi-rbdplugin-provisioner-76789bdcc7-xz4k5      6/6     Running     0          10m
csi-rbdplugin-provisioner-76789bdcc7-5gz89      6/6     Running     0          10m
csi-rbdplugin-8rdl9                             3/3     Running     0          10m
csi-cephfsplugin-xd54g                          3/3     Running     0          10m
csi-cephfsplugin-provisioner-64d4468bbf-cxmqm   5/5     Running     0          10m
rook-ceph-mon-a-558f7ddd74-rxfbq                1/1     Running     0          6m58s
rook-ceph-mon-b-7b4869c96f-9z89l                1/1     Running     0          4m58s
rook-ceph-mon-c-6d746f55dd-2xdwb                1/1     Running     0          2m50s
rook-ceph-mgr-a-8449d56c94-hzjcr                1/1     Running     0          2m39s
rook-ceph-crashcollector-w1-6965bf654-pdh7l     1/1     Running     0          2m50s
rook-ceph-osd-prepare-w3-k7th7                  0/1     Completed   0          2m20s
rook-ceph-osd-prepare-w1-454q2                  0/1     Completed   0          2m20s
rook-ceph-osd-prepare-w2-vb5pm                  0/1     Completed   0          2m20s
rook-ceph-crashcollector-w3-8659c6997b-vjfl5    1/1     Running     0          96s
rook-ceph-osd-0-6dc7fbcb76-dzp8j                1/1     Running     0          96s
rook-ceph-osd-2-86dcb85947-9nssw                1/1     Running     0          95s
rook-ceph-osd-1-69b578ddf4-8hz4j                1/1     Running     0          96s
rook-ceph-crashcollector-w2-564f7c67b5-446mg    1/1     Running     0          4m58s
```

```bash
lab102-191:/aplicacionesCephRook/ceph/ kubectl create -f toolbox.yaml`
```

```bash
lab102-191:/aplicacionesCephRook/ceph/ kubectl -n rook-ceph get pod -l "app=rook-ceph-tools"
NAME                               READY   STATUS    RESTARTS   AGE
rook-ceph-tools-58df894b89-pb5xk   1/1     Running   0          6m11s
```

```bash
lab102-191:/aplicacionesCephRook/ceph/ kubectl -n rook-ceph exec -it $(kubectl -n rook-ceph get pod -l "app=rook-ceph-tools" -o jsonpath='{.items[0].metadata.name}') -- bash
bash: warning: setlocale: LC_CTYPE: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_COLLATE: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_MESSAGES: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_NUMERIC: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_TIME: cannot change locale (en_US.UTF-8): No such file or directory
[root@rook-ceph-tools-58df894b89-pb5xk /]#
```

```bash
lab102-191:/aplicacionesCephRook/ceph/ kubectl -n rook-ceph exec -it $(kubectl -n rook-ceph get pod -l "app=rook-ceph-tools" -o jsonpath='{.items[0].metadata.name}') -- bash
bash: warning: setlocale: LC_CTYPE: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_COLLATE: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_MESSAGES: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_NUMERIC: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_TIME: cannot change locale (en_US.UTF-8): No such file or directory
[root@rook-ceph-tools-58df894b89-pb5xk /]#
```

```bash
[root@rook-ceph-tools-58df894b89-pb5xk /]# ceph status
  cluster:
    id:     963ff71e-1f71-455a-9902-2c8aa1210501
    health: HEALTH_WARN
            clock skew detected on mon.c

  services:
    mon: 3 daemons, quorum a,b,c (age 12m)
    mgr: a(active, since 12m)
    osd: 3 osds: 3 up (since 11m), 3 in (since 11m)

  data:
    pools:   0 pools, 0 pgs
    objects: 0 objects, 0 B
    usage:   3.0 GiB used, 87 GiB / 90 GiB avail
    pgs:
```

```bash
[root@rook-ceph-tools-58df894b89-pb5xk /]# ceph df
RAW STORAGE:
    CLASS     SIZE       AVAIL      USED        RAW USED     %RAW USED
    hdd       90 GiB     87 GiB     3.9 MiB      3.0 GiB          3.34
    TOTAL     90 GiB     87 GiB     3.9 MiB      3.0 GiB          3.34

POOLS:
    POOL     ID     STORED     OBJECTS     USED     %USED     MAX AVAIL
```

```bash
[root@rook-ceph-tools-58df894b89-pb5xk /]# rados df
POOL_NAME USED OBJECTS CLONES COPIES MISSING_ON_PRIMARY UNFOUND DEGRADED RD_OPS RD WR_OPS WR USED COMPR UNDER COMPR

total_objects    0
total_used       3.0 GiB
total_avail      87 GiB
total_space      90 GiB
```

```bash
lab102-191:/aplicacionesCephRook/ceph/ kubectl create -f storageclassRbdBlock.yaml
```

```bash
lab102-191:/aplicacionesCephRook/ceph/ kubectl create -f mysql.yaml
lab102-191:/aplicacionesCephRook/ceph/ kubectl create -f wordpress.yaml
```

```bash
lab102-191:/aplicacionesCephRook/ kubectl get pods
NAME                               READY   STATUS    RESTARTS   AGE
svclb-wordpress-smz4d              1/1     Running   0          3m16s
svclb-wordpress-2wzqm              1/1     Running   0          3m16s
svclb-wordpress-zq2vt              1/1     Running   0          3m16s
wordpress-mysql-6965fc8cc8-5tm79   1/1     Running   0          3m30s
wordpress-7b989dbf57-d45j2         1/1     Running   0          3m16s
```

```bash
lab102-191:/aplicacionesCephRook/ceph/ kubectl create -f direct-mount.yaml
```

```bash
lab102-191:/aplicacionesCephRook/ceph/ kubectl -n rook-ceph get pod -l app=rook-direct-mount
NAME                                 READY   STATUS    RESTARTS   AGE
rook-direct-mount-68ccfbd4f5-tpmnh   1/1     Running   0          16s
```

```bash
lab102-191:/aplicacionesCephRook/ceph/ kubectl -n rook-ceph exec -it $( kubectl -n rook-ceph get pod -l app=rook-direct-mount --no-headers -o custom-columns=":metadata.name" ) -- bash
bash: warning: setlocale: LC_CTYPE: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_COLLATE: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_MESSAGES: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_NUMERIC: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_TIME: cannot change locale (en_US.UTF-8): No such file or directory
[root@w1 /]#
```

```bash
lab102-191:/misc/alumnos/as2/as22022/a798095/proyecto/ kubectl get svc -o wide
NAME              TYPE           CLUSTER-IP     EXTERNAL-IP                              PORT(S)        AGE    SELECTOR
kubernetes        ClusterIP      10.43.0.1      <none>                                   443/TCP        105m   <none>
wordpress-mysql   ClusterIP      None           <none>                                   3306/TCP       27m    app=wordpress,tier=mysql
wordpress         LoadBalancer   10.43.71.138   192.168.1.71,192.168.1.72,192.168.1.73   80:32655/TCP   27m    app=wordpress,tier=frontend
```

```bash
lab102-191:/misc/alumnos/as2/as22022/a798095/proyecto/ curl -i 192.168.1.71
HTTP/1.1 302 Found
Date: Wed, 07 Jun 2023 10:09:25 GMT
Server: Apache/2.4.10 (Debian)
X-Powered-By: PHP/5.6.28
Expires: Wed, 11 Jan 1984 05:00:00 GMT
Cache-Control: no-cache, must-revalidate, max-age=0
Location: http://192.168.1.71/wp-admin/install.php
Content-Length: 0
Content-Type: text/html; charset=UTF-8
```

### Paso 2

### Paso 3
