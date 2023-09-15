### 上网配置

- 拓朴：<client>`3.0.0.201` <-> <server>[`3.0.0.200` --- <SNAT> -- `192.168.20.200`]

1. 接入后Server当前配置
    ```
    [root@localhost net-base]# ip a
    ...
    2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
        link/ether 00:15:5d:02:67:02 brd ff:ff:ff:ff:ff:ff
        inet 192.168.20.200/24 brd 192.168.20.255 scope global noprefixroute eth0
        valid_lft forever preferred_lft forever
        inet6 fe80::f88a:59f:4a56:c2b9/64 scope link noprefixroute 
        valid_lft forever preferred_lft forever
    3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
        link/ether 00:15:5d:02:67:05 brd ff:ff:ff:ff:ff:ff
        inet 3.0.0.200/24 brd 3.0.0.255 scope global eth1
        valid_lft forever preferred_lft forever
    ...
    7: ppp0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1400 qdisc pfifo_fast state UNKNOWN group default qlen 3
        link/ppp 
        inet 192.168.0.1 peer 192.168.0.2/32 scope global ppp0
        valid_lft forever preferred_lft forever
    ```
2. 添加SNAT: `iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -j SNAT --to-source <192.168.20.200>`