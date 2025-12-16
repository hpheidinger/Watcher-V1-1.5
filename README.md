# Watcher 1.5 (Production) - README
The Watcher-V1 series is the rendition for xtables firewalls managed by 'iptables' and 'ipset'.

______________________
# Official Resources:
## Official Watcher repository
- [Repository](https://watcher.comserve-it-services.de/repo/)

## Official Packages
- [Production](https://watcher.comserve-it-services.de/repo/Watcher-1.5-Prod/)
- [Nightly](https://watcher.comserve-it-services.de/repo/Watcher-1.5-nightly/)

## Official Documentation
- [Docs](https://watcher.comserve-it-services.de/repo/Docs/) (Overview)
- [Release notes](https://watcher.comserve-it-services.de/repo/Docs/Release-Notes-1.5.pdf)
- [Master Doc](https://watcher.comserve-it-services.de/repo/Docs/Watcher-Master-V1.5doc.pdf)
- [Modules Doc](https://watcher.comserve-it-services.de/repo/Docs/Watcher-Modules-V1.5doc.pdf)


______________________
# Introduction:
# 🛡️ Watcher – The brain above your firewall.
## ... Driving Attackers Mad

**Watcher is not a simple script.**
Watcher is a **program system** and a **complex framework**.

It is a modular and fully automated IDS/IPS framework designed to block potential attackers in real-time, at the firewall level, before your services even become aware of them.

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
Watcher doesn’t wait for threats — it reads them, classifies them, and acts before they escalate.


## Key Features
- Real-time log monitoring
- Modular detection engine (per-service filters)
- Immediate firewall blocking (DROP via 'ipset')
- No dependencies: no RPM, no APT, no pip – *drop-in, superuser-only*
- Works with syslog/syslog-ng
- Portable, robust – designed for Linux server environments

## Installation Philosophy

Watcher is **drop-anywhere software**. It is intentionally kept minimalistic:
Make a choice for your installation path:
/opt, /usr/local, /root/bin, ... whatever ...
Then go to this installaion path and unpack Watcher.

```sh
# cd <installation path>
# tar xf Watcher.tar
# cd Watcher
# ./Prep
```
'Prep' will analyse your system/platform and then integrates Watcher properly to your server system.
Continue with the individual setup before you start Watcher.
This is explained in the 'Installation' section of the 'Master' documentation

## Watcher efficiency

```text
[root@vmd123606 rules]# Watcher-Report -e | grep 'Summary' -A15
...
***** Summary ************************************
           Total DROPed connections:        118715
           Total passed connections:          8923
         Total passthru connections:         35416
          Total records in firewall:         52963

_____ Efficiency _________________________________
                            Current:         93.00% 
                            ... min:         93.00% 
                            ... max:         94.60% 

····· Legend ·····································

	passthru 	- Count of 'white bots'
	TD/TP 		~ Total dropped/passed 
	Efficiency	= TD / (TD+TP)
```
