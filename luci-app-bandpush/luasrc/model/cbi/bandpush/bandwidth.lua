local m, s, o

m = SimpleForm("bandpush_bandwidth", translate("BandPush 流量统计"))
m:dirty()

s = m:section(SimpleSection)

o = s:option(Flag, "bandwidth_enabled", translate("启用流量统计"))
o.default = 1

o = s:option(Value, "subnet", translate("子网"))
o.default = "192.168.1.0/24"

s = m:section(SimpleSection, "", translate("告警设置"))

o = s:option(Flag, "threshold_enabled", translate("启用阈值告警"))
o.default = 0

o = s:option(Value, "threshold_daily", translate("日流量阈值 (GB)"))
o.datatype = "ufloat"
o.default = "10"
o:depends("threshold_enabled", "1")

return m
