# Watcher-1.5 - Release notes
Watcher 1.5 is a consolidation release of Watcher 1.4/Prod

## Major changes
Watcher 1.4 established all IPSETs in the iptables 'filter' table (~OSI level 5; application layer).
With the introduction of Geo-Blocking (dynloader 'geo') and Geo-Tracking (Pseudo-module 'GeoTrack')
This showed some flaws under certain circumstances where attackers unleashed requests to service ports that Watcher does not manage, or foreign protocols like ICMP in flood-pings, attacking the network adapter.
Such packets fell through to the 'filter' table and erratically pushed the packet counters.

Watcher 1.5 now blocks packets that are 'not_service_related' at 'raw/mangle; PREROUTING' stage which is ~OSI level 3; i.e., simply by their IP address without taking care of protocol and/or service port. This means illegal protocols and or service ports are strictly getting a DROP before reaching the 'filter' stage.
This strictly separates attacks on the NIC (e.g. flood-pings and illegal ports) from attacks on services and avoids that the counters in 'filter' are not pushed-up erratically an reflect the legal access to the services at the 'application layer (~OSI 5)

(Watcher-Report -e; Efficiency-Report)
```sh
IPset comment                        Packets           Bytes
––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
» filter/INPUT (~ OSI level: 5)
Untreated,WBanalyse,404                   91            5444
WatchLG-DB,Login,FAKEHOST                 11             660
WatchLG-DB,Login,KICKOFF                  35            1992
WatchLG-DB,Login,NXDOMAIN                 37            2220
...

» raw/PREROUTING (~ OSI level: 3)
blacklisted                               67           15286
custody-low,GeoTrack,IN                   99            6124
custody-low,GeoTrack,RU                  180           10800
geo-ae                                     2             120
geo-ar                                     9             508
geo-br                                   493           33367
geo-cn                                    57            3188
...
```

Unusually high packet rates now get you a clue whether berserks are messing with access to your NIC.
