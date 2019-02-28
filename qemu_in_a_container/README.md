# Unprivileged; Yes it works:
- `docker build -t netcrave/qemu_in_a_container .`
- `docker run -it netcrave/qemu_in_a_container`
- Press Control-a<release>press c to switch between serial and qemu monitor. Helpful because you can switch over to the monitor to run `system_reset` then switch back, and hit F2 to drop into the BIOS. If it got stuck switch back to the monitor and type `cont` then switch back and try F2 again.
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
```
## Notes

### nested vmx capabilities
It's possible that you might be able to run it with vmx if you have kvm nested enabled: https://docs.fedoraproject.org/en-US/quick-docs/using-nested-virtualization-in-kvm/
I don't think I'm gonna go that far though because this is good enough, after all I just want to get a segregated docker server up for 
jenkins. 


### Bonus 

- I'll try to get qemu-system-sparc up for those who want to grab SunOS and run Solaris (easy)
- I need a job does anybody need a solaris admin? 
- added ipxe option rom and userspace networking (networking not finished but its there, boots to ipxe) `-net nic,model=virtio -net 
tap,fd=3 3<>/dev/tap11`
