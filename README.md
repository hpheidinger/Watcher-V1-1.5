# Watcher 1.5 (Production) - README
The Watcher-V1 series is the rendition for xtables firewalls managed by 'iptables' and 'ipset'.
____________________
# Official Resources:
## Official Watcher repository
- [Repository](https://watcher.comserve-it-services.de/repo/)

## Official Packages
- [Production](https://watcher.comserve-it-services.de/repo/Watcher-1.5-Prod/)
- [Nightly](https://watcher.comserve-it-services.de/repo/Watcher-1.5-nightly/)

## Official Documentation
- [Docs](https://watcher.comserve-it-services.de/repo/Docs/)
- [Release notes 1.5](https://watcher.comserve-it-services.de/repo/Docs/Release-Notes-1.5.pdf)
- [Master Doc](https://watcher.comserve-it-services.de/repo/Docs/Watcher-Master-V1.5doc.pdf)
- [Modules Doc](https://watcher.comserve-it-services.de/repo/Docs/Watcher-Modules-V1.5doc.pdf)


______________________
# Introduction:
# 🛡️ Watcher – The brain above your firewall.
## ... Driving Attackers Mad

**Watcher is not a simple script.**
Watcher is a **program system** and a **complex framework** to proteect Linux server at the service level.

It is a modular, fully automated IDS/IPS framework designed to block potential attackers in real-time, at the firewall level, before your services even become aware of them.

## What It Does

Watcher modules continuously monitor service logs (e.g., SSH, web, and mail) in real-time.  
When suspicious behavior is detected, it immediately blocks the source IP via `ipset' – protecting the services from wasting CPU on known offenders.

**Its purpose is simple:**  
Let your services do their job — not log endless abuse from IP `aa.bb.cc.dd`.

## Watcher characteristics
Watcher is a reactive event-classification framework and superordinated firewall manager, designed to act as a semantic control layer above conventional filtering systems. It dynamically interprets service events via modular rule sets, assigning behavioral context to each incident, and triggering targeted actions—be it injection, escalation, suppression, or request termination.

Unlike traditional tools, Watcher operates with situational awareness:

    - Recognizes patterns in real-time across service layers
    - Applies curated response logic based on threat semantics
    ⚡ Updates rulesets dynamically without service interruption

It’s not just a filter. It’s a strategy engine. 
Watcher doesn’t wait for threats—it reads them, classifies them, and acts before they escalate.


## Key Features
- Real-time log monitoring
- Modular detection engine (per-service filters)
- Immediate firewall blocking (DROP via 'ipset')
- No dependencies: no RPM, no APT, no pip – *drop-in, superuser-only*
- Works with syslog/syslog-ng
- Portable, robust – designed for Linux server environments

## Installation Philosophy

Watcher is **drop-anywhere software**. It is intentionally kept minimalistic:

```sh
# tar xf <path to your downloaded Watcher.tar archive>
# cd Watcher
# ./Prep
```

## Watcher efficiency
Excerpt from Watcher's Efficiency-Report ...

```text
[root@comserve-it-services bin]# Watcher-Report -e
WatcherV1 1.5 - Watcher-Report3 on comserve-it-services.de
Time stamp    : 2026-01-02 15:28:52
Up since      : 2025-12-30 01:53:16
Watcher uptime: 3 d, 13:35:36

===== Connection attempts of DROPed bandits ====================================
IPset comment                                           Packets           Bytes
––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
–––– filter/INPUT (~ OSI level: 5) –––––––
WatchLG-DB,Login,FAKEHOST                                   643           37384
WatchLG-DB,Login,KICKOFF                                   1314           87539
WatchLG-DB,Login,NXDOMAIN                                 16794         1005632
WatchMX-DB,Mail,FAKEHOST                                    512           30548
WatchMX-DB,Mail,NXDOMAIN                                   1255           69848
WatchMX-DB,Mail,TRUEHOST                                   1279           74879
... 
–––– raw/PREROUTING (~ OSI level: 3) –––––––
GeoTrack-DB,GeoTrack,RU                                       1              40
blacklisted                                                1510           90600
custody-low,GeoTrack,CN                                      43            3148
custody-low,GeoTrack,RU                                     108            6888
custody-low,GeoTrack,ZA                                      87            5220
geo-ae                                                      424           36622
geo-ar                                                      633           36666
geo-br                                                   105771         5763995
geo-by                                                       40            2112
geo-cn                                                     8383         1006173
...
spamhaus,drop                                             16291          704915

                          Total DROPed connections:      252269        15104772
––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

***** Summary *************************************************
                          Total DROPed connections:      252269
                          Total passed connections:       11245
                        Total passthru connections:       70252
                         Total records in firewall:       56309

_____ Efficiency ______________________________________________
                                           Current:       95.70% 
                                           ... min:       89.90% 
                                           ... max:      100.00% 

····· Legend ··················································

	passthru 	- Count of 'white bots'
	TD/TP 		~ Total dropped/passed 
	Efficiency	= TD / (TD+TP)
	
[report_efficiency] took 3085 ms

```
