mount-scratch:
    mkdir -p ~/Mount/case/scratch
    sshfs case:/mnt/SeagateEnterprise/Data ~/Mount/case/scratch

mount-home:
    mkdir -p ~/Mount/case/home
    sshfs case:/home/mcarbone ~/Mount/case/home

mount-all: mount-home mount-scratch


unmount-scratch:
    umount ~/Mount/case/scratch

unmount-home:
    umount ~/Mount/case/home

unmount-all: unmount-home unmount-scratch

