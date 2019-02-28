# Unprivileged; Yes it works:
- `docker build -t netcrave/qemu_in_a_container .`
- `docker run -it netcrave/qemu_in_a_container`

## Reasons why 
- because I am a pro qemu power-user
- I'm disabling vmx: 
```
/usr/bin/qemu-system-x86_64 \
-display none \
-cpu qemu64,-vmx \
-m 512M \
-nodefaults \
-nodefconfig \
-device virtio-serial-pci \
-serial 'mon:stdio' \
-bios OVMF.fd -pflash ovmf.var`

