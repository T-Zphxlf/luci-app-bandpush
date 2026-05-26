local m, s, o

m = SimpleForm("bandpush", translate("BandPush 基本设置"))
m:dirty()

s = m:section(SimpleSection)

o = s:option(Flag, "enabled", translate("启用插件"))
o.default = 0

o = s:option(Value, "push_interval", translate("推送间隔（分钟）"))
o.datatype = "uinteger"
o.default = "60"

s = m:section(SimpleSection, "", translate("推送设置"))

o = s:option(ListValue, "push_type", translate("推送方式"))
o:value("bark", "Bark")
o:value("pushplus", "PushPlus")
o:value("serverchan", "Server酱")
o:value("telegram", "Telegram")
o.default = "bark"

o = s:option(Value, "bark_url", translate("Bark 地址"))
o:depends("push_type", "bark")

o = s:option(Value, "pushplus_token", translate("PushPlus Token"))
o:depends("push_type", "pushplus")

o = s:option(Value, "serverchan_sckey", translate("Server酱 SCKEY"))
o:depends("push_type", "serverchan")

o = s:option(Value, "telegram_bot_token", translate("Telegram Bot Token"))
o:depends("push_type", "telegram")

o = s:option(Value, "telegram_chat_id", translate("Telegram Chat ID"))
o:depends("push_type", "telegram")

return m
