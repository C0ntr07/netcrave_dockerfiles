# Exporting applications/services and their runtime dependencies 
```
  342  echo $(which apache2) > deps
  343  echo $(which nginx) >> deps
  344  find /usr/lib64/apache2/modules/* -type f >> deps
  345  last_count=0; while true; do cat deps | sort | uniq | xargs ldd | awk '{print $3}' | grep "." | sort | uniq | tee >> deps; count=$(cat deps | sort | uniq | wc -l); if [ $count -eq $last_count ]; then break; fi; last_count=$count; done;
  346  history
```
```
sh-4.4$ LD_LIBRARY_PATH=lib64/:usr/lib:usr/lib64 usr/sbin/nginx 
usr/sbin/nginx: relocation error: lib64/libc.so.6: symbol _dl_exception_create, version GLIBC_PRIVATE not defined in file 
ld-linux-x86-64.so.2 with link time reference
sh-4.4$ LD_LIBRARY_PATH=lib64/:usr/lib:usr/lib64 usr/sbin/apache2 
usr/sbin/apache2: relocation error: lib64/libc.so.6: symbol _dl_exception_create, version GLIBC_PRIVATE not defined in file 
ld-linux-x86-64.so.2 with link time reference
sh-4.4$ LD_LIBRARY_PATH=/lib64/:lib64/:usr/lib:usr/lib64 usr/sbin/nginx
usr/sbin/nginx: /lib64/libc.so.6: version `GLIBC_2.27' not found (required by usr/sbin/nginx)
sh-4.4$ LD_LIBRARY_PATH=/lib64/:lib64/:usr/lib:usr/lib64 usr/sbin/apache2 
apache2: Syntax error on line 210 of /etc/apache2/httpd.conf: Syntax error on line 119 of /etc/apache2/default-server.conf: Could not open 
configuration file /etc/apache2/conf.d/matomo.conf: Permission denied
sh-4.4$ 
```
https://stackoverflow.com/questions/847179/multiple-glibc-libraries-on-a-single-host

```
touch .dockerenv
find /lib64 -name "ld-*" -maxdepth1 >> deps
echo ".dockerenv" >> deps
tar -cvpf webservers.tar -T cat deps
< detach >
docker cp <image>:/root/webservers.tar .
docker import webservers.tar
sha256:e76c1afaf16990905ddb3b77edb08ce161e45930018e8205ef81a1b700792004
docker run it e76c1afaf16990905ddb3b77edb08ce161e45930018e8205ef81a1b700792004 /usr/sbin/nginx 
nginx: [alert] could not open error log file: open() "/var/log/nginx/error_log" failed (2: No such file or directory)
2019/02/28 07:55:52 [emerg] 1#1: open() "/etc/nginx/nginx.conf" failed (2: No such file or directory)
```

lol after that it really did need the perl module i found earlier looking for libs

```
docker run -v /mnt/export/erratic/netcrave_dockerfiles/test/nginx.conf:/etc/nginx/nginx.conf -it 
e76c1afaf16990905ddb3b77edb08ce161e45930018e8205ef81a1b700792004 /usr/sbin/nginx
nginx: [alert] could not open error log file: open() "/var/log/nginx/error_log" failed (2: No such file or directory)
Can't locate nginx.pm in @INC (you may need to install the nginx module) (@INC contains: /etc/perl 
/usr/local/lib64/perl5/5.26.2/x86_64-linux /usr/local/lib64/perl5/5.26.2 /usr/lib64/perl5/vendor_perl/5.26.2/x86_64-linux 
/usr/lib64/perl5/vendor_perl/5.26.2 /usr/lib64/perl5/5.26.2/x86_64-linux /usr/lib64/perl5/5.26.2).
BEGIN failed--compilation aborted.
2019/02/28 08:02:57 [alert] 1#1: perl_parse() failed: 2

```
