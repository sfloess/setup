virt-install \
--connect xen:/// \
--paravirt \
--name centos-atomic-xen \
--ram 2048 \
--disk size=20 \
--vcpus 2 \
--os-type linux \
--os-variant virtio26 \
--network bridge=bridge0 \
--graphics vga \
--location 'http://192.168.168.31/cblr/links/CentOS-7-Atomic-x86_64/' \
--extra-args 'ks=http://192.168.168.31/cblr/svc/op/ks/system/centos-atomic-xen text console=ttyS0 utf8 console=hvc0' 

#--extra-args 'ks=http://192.168.168.31/kickstart/centos-7-atomic.ks text console=ttyS0 utf8 console=hvc0' 


