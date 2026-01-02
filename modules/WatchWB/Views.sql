Create view  if not exists affairs_by_instance 
AS
select	a.ip_addr, a.affair_num, a.date_event,
	b.id, b.instname
from	affairs_by_ip a, instances b
where	a.instance=b.id
;
