# Proyecto 2

## Steps

### Paso 1

```bash
lab102-192:/aplicacionesCephRook/ceph/ kubectl create -f common.yaml
```

```bash
lab102-192:/aplicacionesCephRook/ceph/ kubectl create -f operator.yaml
```

```bash
lab102-192:/ kubectl -n rook-ceph get pods
NAME                                  READY   STATUS    RESTARTS   AGE
rook-ceph-operator-6d5456dddd-f87t8   1/1     Running   0          5m39s
rook-discover-5vmmn                   1/1     Running   0          3m12s
rook-discover-jf88z                   1/1     Running   0          3m12s
rook-discover-wvz22                   1/1     Running   0          3m12s
```

```bash
lab102-192:/aplicacionesCephRook/ceph/ kubectl create -f cluster.yaml
```

```bash
lab102-192:/ kubectl -n rook-ceph get pods
NAME                                            READY   STATUS      RESTARTS   AGE
rook-ceph-operator-6d5456dddd-f87t8             1/1     Running     0          20m
rook-discover-5vmmn                             1/1     Running     0          17m
rook-discover-jf88z                             1/1     Running     0          17m
rook-discover-wvz22                             1/1     Running     0          17m
csi-rbdplugin-cxgh8                             3/3     Running     0          13m
csi-cephfsplugin-j5zch                          3/3     Running     0          13m
csi-cephfsplugin-g5vqn                          3/3     Running     0          13m
csi-rbdplugin-p2dwm                             3/3     Running     0          13m
csi-cephfsplugin-provisioner-64d4468bbf-ns5gz   5/5     Running     0          13m
csi-cephfsplugin-provisioner-64d4468bbf-hx7l8   5/5     Running     0          13m
csi-rbdplugin-provisioner-76789bdcc7-j84kx      6/6     Running     0          13m
csi-rbdplugin-provisioner-76789bdcc7-m5gqm      6/6     Running     0          13m
csi-rbdplugin-g8dwz                             3/3     Running     0          13m
csi-cephfsplugin-kdnmm                          3/3     Running     0          13m
rook-ceph-mon-a-84c84946ff-f2j8c                1/1     Running     0          9m46s
rook-ceph-mon-b-d8d98dd6b-5vnnv                 1/1     Running     0          9m41s
rook-ceph-mon-d-85bc97c78d-czxlp                1/1     Running     0          6m5s
rook-ceph-mgr-a-5b5b7fd568-hzm7h                1/1     Running     0          3m11s
rook-ceph-osd-prepare-w2-z99rk                  0/1     Completed   0          2m52s
rook-ceph-osd-prepare-w1-nwj77                  0/1     Completed   0          2m52s
rook-ceph-crashcollector-w2-564f7c67b5-b74zg    1/1     Running     0          2m17s
rook-ceph-osd-prepare-w3-fn4sj                  0/1     Completed   0          2m52s
rook-ceph-osd-0-5cfcfcdd7b-7pwwp                1/1     Running     0          2m17s
rook-ceph-osd-1-54ddf94b7c-z7wtn                1/1     Running     0          2m13s
rook-ceph-osd-2-74b648ff6c-khx6w                1/1     Running     0          2m11s
rook-ceph-crashcollector-w3-8659c6997b-cr4xh    1/1     Running     0          6m5s
rook-ceph-crashcollector-w1-6965bf654-sqdjx     1/1     Running     0          9m41s
```

```bash
lab102-192:/aplicacionesCephRook/ceph/ kubectl create -f toolbox.yaml`
```

```bash
lab102-192:/  kubectl -n rook-ceph get pod -l "app=rook-ceph-tools"
NAME                               READY   STATUS    RESTARTS   AGE
rook-ceph-tools-58df894b89-v8dpn   1/1     Running   0          14s
```

```bash
lab102-192:/ kubectl -n rook-ceph exec -it $(kubectl -n rook-ceph get pod -l "app=rook-ceph-tools" -o jsonpath='{.items[0].metadata.name}') bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
bash: warning: setlocale: LC_CTYPE: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_COLLATE: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_MESSAGES: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_NUMERIC: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_TIME: cannot change locale (en_US.UTF-8): No such file or directory
[root@rook-ceph-tools-58df894b89-v8dpn /]#
```

```bash
lab102-192:/ kubectl -n rook-ceph exec -it $(kubectl -n rook-ceph get pod -l "app=rook-ceph-tools" -o jsonpath='{.items[0].metadata.name}') -- bash
bash: warning: setlocale: LC_CTYPE: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_COLLATE: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_MESSAGES: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_NUMERIC: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_TIME: cannot change locale (en_US.UTF-8): No such file or directory
[root@rook-ceph-tools-58df894b89-v8dpn /]#
```

```bash
[root@rook-ceph-tools-58df894b89-v8dpn /]# ceph status
  cluster:
    id:     04bfe2d0-f221-4c28-a88f-89d22c6763c3
    health: HEALTH_WARN
            clock skew detected on mon.b, mon.d

  services:
    mon: 3 daemons, quorum a,b,d (age 11m)
    mgr: a(active, since 10m)
    osd: 3 osds: 3 up (since 9m), 3 in (since 9m)

  data:
    pools:   0 pools, 0 pgs
    objects: 0 objects, 0 B
    usage:   3.0 GiB used, 87 GiB / 90 GiB avail
    pgs:
```

```
lab102-192:/vagrantk3s/ vagrant ssh m -c "timedatectl | grep -q 'System clock synchronized: no' && sudo systemctl restart systemd-timesyncd"
lab102-192:/vagrantk3s/ vagrant ssh w1 -c "timedatectl | grep -q 'System clock synchronized: no' && sudo systemctl restart systemd-timesyncd"
lab102-192:/vagrantk3s/ vagrant ssh w2 -c "timedatectl | grep -q 'System clock synchronized: no' && sudo systemctl restart systemd-timesyncd"
lab102-192:/vagrantk3s/ vagrant ssh w3 -c "timedatectl | grep -q 'System clock synchronized: no' && sudo systemctl restart systemd-timesyncd"
```

```bash
[root@rook-ceph-tools-58df894b89-v8dpn /]# ceph status
  cluster:
    id:     04bfe2d0-f221-4c28-a88f-89d22c6763c3
    health: HEALTH_OK

  services:
    mon: 3 daemons, quorum a,b,d (age 19s)
    mgr: a(active, since 25m)
    osd: 3 osds: 3 up (since 24m), 3 in (since 24m)

  data:
    pools:   0 pools, 0 pgs
    objects: 0 objects, 0 B
    usage:   3.0 GiB used, 87 GiB / 90 GiB avail
    pgs:
```

```bash
[root@rook-ceph-tools-58df894b89-v8dpn /]# ceph df
RAW STORAGE:
    CLASS     SIZE       AVAIL      USED        RAW USED     %RAW USED
    hdd       90 GiB     87 GiB     4.7 MiB      3.0 GiB          3.34
    TOTAL     90 GiB     87 GiB     4.7 MiB      3.0 GiB          3.34

POOLS:
    POOL     ID     STORED     OBJECTS     USED     %USED     MAX AVAIL
```

```bash
[root@rook-ceph-tools-58df894b89-v8dpn /]# rados df
POOL_NAME USED OBJECTS CLONES COPIES MISSING_ON_PRIMARY UNFOUND DEGRADED RD_OPS RD WR_OPS WR USED COMPR UNDER COMPR

total_objects    0
total_used       3.0 GiB
total_avail      87 GiB
total_space      90 GiB
```

### Paso 2

```bash
lab102-192:/aplicacionesCephRook/ceph/ kubectl create -f storageclassRbdBlock.yaml
```

```bash
lab102-192:/aplicacionesCephRook/ceph/ kubectl create -f mysql.yaml
service/wordpress-mysql created
persistentvolumeclaim/mysql-pv-claim created
deployment.apps/wordpress-mysql created
```

```bash
lab102-192:/aplicacionesCephRook/ceph/ kubectl create -f wordpress.yaml
service/wordpress created
persistentvolumeclaim/wp-pv-claim created
deployment.apps/wordpress created
```

```bash
lab102-192:/ kubectl get pods
NAME                               READY   STATUS    RESTARTS   AGE
svclb-wordpress-bg542              1/1     Running   0          7m48s
svclb-wordpress-mthcr              1/1     Running   0          7m48s
svclb-wordpress-k8ssr              1/1     Running   0          7m48s
wordpress-mysql-6965fc8cc8-xq6xv   1/1     Running   0          8m16s
wordpress-7b989dbf57-fvjsc         1/1     Running   0          7m48s
```

```bash
lab102-192:/ kubectl get svc -o wide
NAME              TYPE           CLUSTER-IP    EXTERNAL-IP                              PORT(S)        AGE   SELECTOR
kubernetes        ClusterIP      10.43.0.1     <none>                                   443/TCP        68m   <none>
wordpress-mysql   ClusterIP      None          <none>                                   3306/TCP       11m   app=wordpress,tier=mysql
wordpress         LoadBalancer   10.43.28.62   192.168.1.71,192.168.1.72,192.168.1.73   80:30592/TCP   10m   app=wordpress,tier=frontend
```

```bash
lab102-192:/ curl -i 192.168.1.71
HTTP/1.1 302 Found
Date: Thu, 08 Jun 2023 08:57:25 GMT
Server: Apache/2.4.10 (Debian)
X-Powered-By: PHP/5.6.28
Expires: Wed, 11 Jan 1984 05:00:00 GMT
Cache-Control: no-cache, must-revalidate, max-age=0
Location: http://192.168.1.71/wp-admin/install.php
Content-Length: 0
Content-Type: text/html; charset=UTF-8
```

```bash
lab102-192:/aplicacionesCephRook/ceph/ kubectl create -f direct-mount.yaml
```

```bash
lab102-192:/ kubectl -n rook-ceph get pod -l app=rook-direct-mount
NAME                                 READY   STATUS    RESTARTS   AGE
rook-direct-mount-68ccfbd4f5-vx8rv   1/1     Running   0          19s
```

```bash
lab102-192:/ kubectl -n rook-ceph exec -it $( kubectl -n rook-ceph get pod -l app=rook-direct-mount --no-headers -o custom-columns=":metadata.name" ) -- bash
bash: warning: setlocale: LC_CTYPE: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_COLLATE: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_MESSAGES: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_NUMERIC: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_TIME: cannot change locale (en_US.UTF-8): No such file or directory
[root@w1 /]#
```

<!-- Estos comandos están relacionados con el uso y gestión de dispositivos RBD (Block Device Rados) en Ceph, un sistema de almacenamiento distribuido. Aquí está una explicación de cada comando:

rbd create replicapool/test --size 10: Este comando crea un dispositivo RBD llamado "test" en el pool "replicapool" con un tamaño de --size 10240 (10 GB = 10240 MiB) por lo que realmente son 10MiB Crea un bloque de almacenamiento virtual que se puede utilizar como un disco duro.

rbd info replicapool/test: Este comando muestra información detallada sobre el dispositivo RBD "test" en el pool "replicapool". Proporciona detalles como el tamaño, el nombre del pool, el formato del dispositivo y otras propiedades.

rbd feature disable replicapool/test fast-diff deep-flatten object-map: Este comando deshabilita varias características específicas del dispositivo RBD "test" en el pool "replicapool". Las características deshabilitadas incluyen "fast-diff" (diferencial rápido), "deep-flatten" (aplanamiento profundo) y "object-map" (mapa de objetos). Estas características se utilizan para mejorar el rendimiento o proporcionar funcionalidades adicionales, pero en este caso, se están desactivando.

rbd map replicapool/test: Este comando mapea el dispositivo RBD "test" en el pool "replicapool" a un dispositivo de bloque en el sistema operativo. Una vez mapeado, se puede utilizar el dispositivo RBD como un disco duro normal.

lsblk | grep rbd: Este comando muestra una lista de todos los dispositivos de bloque en el sistema y filtra solo los dispositivos que están relacionados con RBD. Muestra información como los nombres de los dispositivos y su tamaño.

mkfs.ext4 -m0 /dev/rbd0 (o rbd2 ?): Este comando formatea el dispositivo de bloque RBD (/dev/rbd0 o /dev/rbd2) con el sistema de archivos ext4 sin reservar espacio para el superusuario. Esto crea un sistema de archivos ext4 en el dispositivo RBD que se puede utilizar para almacenar y organizar datos. Ten en cuenta que el número del dispositivo puede variar dependiendo del resultado de lsblk.

En resumen, estos comandos permiten crear, gestionar y utilizar dispositivos RBD en Ceph, incluyendo la creación, información, mapeo y formateo de los dispositivos RBD. -->

```bash
[root@w1 /]# lsblk | grep rbd
NAME                                                                                                 MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
rbd0                                                                                                 252:0    0   2G  0 disk
rbd1                                                                                                 252:16   0   1G  0 disk
```

Este comando mostrará una lista de los pools de Ceph existentes en el clúster. Comprueba si el pool "replicapool" ya existe en la lista.
```bash
[root@w1 /]# rados lspools
replicapool
```

Si el pool "replicapool" ya existe, este comando mostrará una lista de los nombres de los dispositivos RBD presentes en ese pool. Comprueba si el dispositivo "test" ya existe en la lista.
```bash
[root@w1 /]# rbd ls -p replicapool
csi-vol-e0a5e57d-05d8-11ee-94c6-ba275707341d
csi-vol-f49b13a8-05d8-11ee-94c6-ba275707341d
```

```bash
[root@w1 /]# rbd create replicapool/test --size 10
```

```bash
[root@w1 /]# rbd ls -p replicapool
csi-vol-e0a5e57d-05d8-11ee-94c6-ba275707341d
csi-vol-f49b13a8-05d8-11ee-94c6-ba275707341d
test
```

```bash
[root@w1 /]# rbd info replicapool/test
rbd image 'test':
        size 10 MiB in 3 objects
        order 22 (4 MiB objects)
        snapshot_count: 0
        id: 675ecb47576
        block_name_prefix: rbd_data.675ecb47576
        format: 2
        features: layering
        op_features:
        flags:
        create_timestamp: Thu Jun  8 09:13:30 2023
        access_timestamp: Thu Jun  8 09:13:30 2023
        modify_timestamp: Thu Jun  8 09:13:30 2023
```

<!-- storageclassRbdBlock es el fichero donde se definirian los parametros de ceph -->
<!-- https://rook.io/docs/rook/v1.11/CRDs/Block-Storage/ceph-block-pool-crd/#spec -->
<!-- https://docs.ceph.com/en/latest/rados/operations/pools/#set-pool-values -->
<!-- https://github.com/rook/rook/issues/8436 -->
```bash 
[root@w1 /]# rbd feature disable replicapool/test fast-diff deep-flatten object-map
rbd: failed to update image features: (22) Invalid argument
2023-06-08 09:25:11.554 7f4ee797eb00 -1 librbd::Operations: one or more requested features are already disabled
```

```bash
[root@w1 /]# rbd showmapped
id pool        namespace image                                        snap device
0  replicapool           csi-vol-e0a5e57d-05d8-11ee-94c6-ba275707341d -    /dev/rbd0
1  replicapool           csi-vol-f49b13a8-05d8-11ee-94c6-ba275707341d -    /dev/rbd1
```

```bash
[root@w1 /]# rbd map replicapool/test
/dev/rbd2
```

```bash
[root@w1 /]# rbd showmapped
id pool        namespace image                                        snap device
0  replicapool           csi-vol-e0a5e57d-05d8-11ee-94c6-ba275707341d -    /dev/rbd0
1  replicapool           csi-vol-f49b13a8-05d8-11ee-94c6-ba275707341d -    /dev/rbd1
2  replicapool           test
```

```bash
[root@w1 /]# lsblk | grep rbd
rbd0                                                                                                 252:0    0   2G  0 disk
rbd1                                                                                                 252:16   0   1G  0 disk
rbd2                                                                                                 252:32   0  10M  0 disk
```

```bash
[root@w1 /]# mkfs.ext4 -m0 /dev/rbd2
mke2fs 1.42.9 (28-Dec-2013)
Discarding device blocks: done
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
Stride=4096 blocks, Stripe width=4096 blocks
2560 inodes, 10240 blocks
0 blocks (0.00%) reserved for the super user
First data block=1
Maximum filesystem blocks=10485760
2 block groups
8192 blocks per group, 8192 fragments per group
1280 inodes per group
Superblock backups stored on blocks:
        8193

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done

```

---

```bash
[root@w1 /]# mkdir /tmp/mountpoint
[root@w1 /]# mount /dev/rbd2 /tmp/mountpoint
[root@w1 mountpoint]# df -h | grep mountpoint
/dev/rbd2       8.6M   14K  8.4M   1% /tmp/mountpoint
[root@w1 mountpoint]# echo 'Hello, World!' >> /tmp/mountpoint/testfile
[root@w1 mountpoint]# cat /tmp/mountpoint/testfile
Hello, World!
```

```bash
lab102-192:/ kubectl get pods --all-namespaces -o wide | sort -k8,8 | grep -E "coredns|metrics-server|rook-ceph-mgr"
kube-system   coredns-854c77959c-hlj4x                        1/1     Running     0          161m   10.42.1.4      w1     <none>           <none>
kube-system   metrics-server-86cbb8457f-dkqsm                 1/1     Running     0          161m   10.42.1.3      w1     <none>           <none>
rook-ceph     rook-ceph-mgr-a-5b5b7fd568-hzm7h                1/1     Running     0          131m   10.42.2.8      w2     <none>           <none>
```

```bash
lab102-192:/vagrantk3s/ vagrant halt w3
==> w3: Attempting graceful shutdown of VM...
==> w3: Forcing shutdown of VM...
lab102-192:/vagrantk3s/ vagrant status
Current machine states:

m                         running (virtualbox)
w1                        running (virtualbox)
w2                        running (virtualbox)
w3                        poweroff (virtualbox)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.
```

```bash
lab102-192:/vagrantk3s/ curl -i 192.168.1.71
HTTP/1.1 302 Found
Date: Thu, 08 Jun 2023 10:40:33 GMT
Server: Apache/2.4.10 (Debian)
X-Powered-By: PHP/5.6.28
Expires: Wed, 11 Jan 1984 05:00:00 GMT
Cache-Control: no-cache, must-revalidate, max-age=0
Location: http://192.168.1.71/wp-admin/install.php
Content-Length: 0
Content-Type: text/html; charset=UTF-8
```

```bash
lab102-192:/vagrantk3s/ kubectl -n rook-ceph exec -it $( kubectl -n rook-ceph get pod -l app=rook-direct-mount --no-headers -o custom-columns=":metadata.name" ) -- bash
bash: warning: setlocale: LC_CTYPE: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_COLLATE: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_MESSAGES: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_NUMERIC: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_TIME: cannot change locale (en_US.UTF-8): No such file or directory
[root@w1 /]# cat /tmp/mountpoint/testfile
Hello, World!
[root@w1 /]# umount /tmp/mountpoint
[root@w1 /]# rbd unmap /dev/rbd2
[root@w1 /]# rbd showmapped
id pool        namespace image                                        snap device
0  replicapool           csi-vol-e0a5e57d-05d8-11ee-94c6-ba275707341d -    /dev/rbd0
1  replicapool           csi-vol-f49b13a8-05d8-11ee-94c6-ba275707341d -    /dev/rbd1
3  replicapool           test                                         -    /dev/rbd3
[root@w1 /]# df -h | grep mountpoint
```

### Paso 3

```bash
lab102-192:/vagrantk3s/ vagrant up w3
lab102-192:/vagrantk3s/ vagrant ssh w3 -c "timedatectl | grep -q 'System clock synchronized: no' && sudo systemctl restart systemd-timesyncd"
```

```bash
lab102-192:/ kubectl create -f filesystem.yaml
```

```bash
lab102-192:/ kubectl -n  rook-ceph get pod -l app=rook-ceph-mds
NAME                                    READY   STATUS    RESTARTS   AGE
rook-ceph-mds-myfs-a-64dddcbbcd-hxnj2   1/1     Running   0          27s
rook-ceph-mds-myfs-b-86f88f5db8-c8mtc   1/1     Running   0          27s
```

```bash
lab102-192:/ kubectl -n rook-ceph exec -it $(kubectl -n rook-ceph get pod -l "app=rook-ceph-tools" -o jsonpath='{.items[0].metadata.name}') -- bash
bash: warning: setlocale: LC_CTYPE: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_COLLATE: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_MESSAGES: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_NUMERIC: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_TIME: cannot change locale (en_US.UTF-8): No such file or directory
[root@rook-ceph-tools-58df894b89-v8dpn /]# ceph status
  cluster:
    id:     04bfe2d0-f221-4c28-a88f-89d22c6763c3
    health: HEALTH_OK

  services:
    mon: 3 daemons, quorum a,b,d (age 10m)
    mgr: a(active, since 104m)
    mds: myfs:1 {0=myfs-a=up:active} 1 up:standby-replay
    osd: 3 osds: 3 up (since 10m), 3 in (since 10m)

  data:
    pools:   3 pools, 96 pgs
    objects: 102 objects, 214 MiB
    usage:   3.5 GiB used, 86 GiB / 90 GiB avail
    pgs:     96 active+clean

  io:
    client:   1.2 KiB/s rd, 2 op/s rd, 0 op/s wr
```

```
mds: myfs:1 {0=myfs-a=up:active} 1 up:standby-replay
```

```bash
kubectl create -f storageclassCephFS.yaml
```

```bash
lab102-192:/aplicacionesCephRook/ kubectl create -f kube-registry.yaml
persistentvolumeclaim/cephfs-pvc created
deployment.apps/kube-registry created
lab102-192:/aplicacionesCephRook/ kubectl create -f kubeRegistryService.yaml
service/kube-registry created
lab102-192:/aplicacionesCephRook/ kubectl create -f kubeRegistryProxy.yaml
daemonset.apps/kube-registry-proxy created
```

```bash
lab102-192:/ POD=$(kubectl get pods --namespace kube-system -l k8s-app=kube-registry -o template --template '{{range .items}}{{.metadata.name}} {{.status.phase}}{{"\n"}}{{end}}' | grep Running | head -1 | cut -f1 -d' ')
lab102-192:/ kubectl port-forward --namespace kube-system $POD 5000:5000 &
[1] 26879
lab102-192:/ Forwarding from 127.0.0.1:5000 -> 5000
Forwarding from [::1]:5000 -> 5000

lab102-192:/ curl http://localhost:5000
Handling connection for 5000
```
 
---

```bash
lab102-192:/ echo "FROM busybox" > Dockerfile
```

```bash
lab102-192:/ docker build -t localhost:5000/my-busybox .
Sending build context to Docker daemon  92.16kB
Step 1/1 : FROM busybox
latest: Pulling from library/busybox
325d69979d33: Pull complete
Digest: sha256:560af6915bfc8d7630e50e212e08242d37b63bd5c1ccf9bd4acccf116e262d5b
Status: Downloaded newer image for busybox:latest
 ---> 8135583d97fe
Successfully built 8135583d97fe
Successfully tagged localhost:5000/my-busybox:latest
lab102-192:/ docker push localhost:5000/my-busybox:latest
The push refers to repository [localhost:5000/my-busybox]
Handling connection for 5000
Handling connection for 5000
9547b4c33213: Preparing
Handling connection for 5000
Handling connection for 5000
9547b4c33213: Pushing [==================================================>]  5.092MB
Handling connection for 5000
9547b4c33213: Pushed
Handling connection for 5000
Handling connection for 5000
Handling connection for 5000
Handling connection for 5000
Handling connection for 5000
Handling connection for 5000
latest: digest: sha256:5cd3db04b8be5773388576a83177aff4f40a03457a63855f4b9cbe30542b9a43 size: 528
```

```bash
lab102-192:/ docker images
REPOSITORY                  TAG       IMAGE ID       CREATED        SIZE
busybox                     latest    8135583d97fe   2 weeks ago    4.86MB
localhost:5000/my-busybox   latest    8135583d97fe   2 weeks ago    4.86MB
```

```bash
lab102-192:/ curl http://localhost:5000/v2/_catalog
Handling connection for 5000
{"repositories":["my-busybox"]}
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
    - name: my-container
      image: localhost:5000/my-busybox
      command: ["sleep", "3600"]
```

```bash
lab102-192:/ kubectl run -i --tty p --image=localhost:5000/my-busybox -- sh
```

```bash
lab102-192:/ kubectl get pods
NAME                               READY   STATUS    RESTARTS   AGE
p                                  1/1     Running   0          11m
lab102-192:/ kubectl exec -it p -- sh
/ # hostname
p
```

```bash
lab102-192:/ kubectl -n rook-ceph exec -it $( kubectl -n rook-ceph get pod -l app=rook-direct-mount --no-headers -o custom-columns=":metadata.name" ) -- bash
bash: warning: setlocale: LC_CTYPE: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_COLLATE: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_MESSAGES: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_NUMERIC: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_TIME: cannot change locale (en_US.UTF-8): No such file or directory
[root@w1 /]# mon_endpoints=$(grep mon_host /etc/ceph/ceph.conf | cut -f3 -d' ')
[root@w1 /]# my_secret=$(grep key /etc/ceph/keyring | cut -f3 -d' ')

[root@w1 /]# mkdir /tmp/registry
[root@w1 /]# mount -t ceph -o mds_namespace=myfs,name=admin,secret=$my_secret $mon_endpoints:/ /tmp/registry
[root@w1 /]# find /tmp/registry -name my-busybox
/tmp/registry/volumes/csi/csi-vol-23e896e8-05ed-11ee-8221-5ede4f76ef32/267a5223-222c-467e-bfbc-e6905ba13b93/docker/registry/v2/repositories/my-busybox
```

```bash
[root@w1 registry]# echo 'Hello Registry!' > file.txt
[root@w1 registry]# ls
file.txt  volumes
[root@w1 registry]# cat file.txt
Hello Registry!
[root@w1 tmp]# umount /tmp/registry
[root@w1 tmp]# ls
mountpoint  registry
[root@w1 tmp]# ls registry
[root@w1 tmp]# mon_endpoints=$(grep mon_host /etc/ceph/ceph.conf | cut -f3 -d' ')
[root@w1 tmp]# my_secret=$(grep key /etc/ceph/keyring | cut -f3 -d' ')
[root@w1 tmp]# mount -t ceph -o mds_namespace=myfs,name=admin,secret=$my_secret $mon_endpoints:/ /tmp/registry
[root@w1 tmp]# ls registry
file.txt  volumes
```

```bash
lab102-192:/ kubectl get pods --all-namespaces -o wide | sort -k8,8 | grep -E "coredns|metrics-server|rook-ceph-mgr"
kube-system   coredns-854c77959c-hlj4x                        1/1     Running     0          6h47m   10.42.1.4      w1     <none>           <none>
kube-system   metrics-server-86cbb8457f-dkqsm                 1/1     Running     0          6h47m   10.42.1.3      w1     <none>           <none>
rook-ceph     rook-ceph-mgr-a-5b5b7fd568-hzm7h                1/1     Running     0          6h17m   10.42.2.8      w2     <none>           <none>
lab102-192:/vagrantk3s/ vagrant halt w3
==> w3: Attempting graceful shutdown of VM...
E0608 16:37:16.033833   26879 portforward.go:234] lost connection to pod
==> w3: Forcing shutdown of VM...
[1]+  Done                    kubectl port-forward --namespace kube-system $POD 5000:5000  (wd: /misc/alumnos/as2/as22022/a798095/proyecto/aplicacionesCephRook)
(wd now: /misc/alumnos/as2/as22022/a798095/proyecto/vagrantk3s)
```

```bash
lab102-192:/ curl -i 192.168.1.71
HTTP/1.1 302 Found
Date: Thu, 08 Jun 2023 14:43:54 GMT
Server: Apache/2.4.10 (Debian)
X-Powered-By: PHP/5.6.28
Expires: Wed, 11 Jan 1984 05:00:00 GMT
Cache-Control: no-cache, must-revalidate, max-age=0
Location: http://192.168.1.71/wp-admin/install.php
Content-Length: 0
Content-Type: text/html; charset=UTF-8
```

```bash
lab102-192:/ kubectl -n rook-ceph exec -it $( kubectl -n rook-ceph get pod -l app=rook-direct-mount --no-headers -o custom-columns=":metadata.name" ) -- bash
bash: warning: setlocale: LC_CTYPE: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_COLLATE: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_MESSAGES: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_NUMERIC: cannot change locale (en_US.UTF-8): No such file or directory
bash: warning: setlocale: LC_TIME: cannot change locale (en_US.UTF-8): No such file or directory
[root@w1 registry]# ls /tmp/registry
file.txt  volumes
[root@w1 registry]# cat /tmp/registry/file.txt
Hello Registry!
```
