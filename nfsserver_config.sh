sudo yum install lvm2 -y
sudo pvcreate /dev/xvdf1
sudo pvcreate /dev/xvdg1
sudo pvcreate /dev/xvdh1
sudo vgcreate webdata-vg /dev/xvdh1 /dev/xvdg1 /dev/xvdf1

sudo lvcreate -n apps-lv -L 9G webdata-vg
sudo lvcreate -n logs-lv -L 9G webdata-vg
sudo lvcreate -n opt-lv -L 9G webdata-vg

sudo mkfs -t xfs /dev/webdata-vg/apps-lv
sudo mkfs -t xfs /dev/webdata-vg/logs-lv
sudo mkfs -t xfs /dev/webdata-vg/opt-lv

sudo mkdir -p /mnt/apps
sudo mkdir -p /mnt/logs
sudo mkdir -p /mnt/opt

sudo mount /dev/webdata-vg/apps-lv /mnt/apps
sudo mount /dev/webdata-vg/logs-lv /mnt/logs
sudo mount /dev/webdata-vg/opt-lv /mnt/opt
