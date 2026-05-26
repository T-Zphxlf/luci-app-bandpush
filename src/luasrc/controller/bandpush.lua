module("luci.controller.bandpush", package.seeall)

function index()
    entry({"admin", "services", "bandpush"}, firstchild(), _("BandPush 流量推送"), 50)
    entry({"admin", "services", "bandpush", "status"}, call("act_status"))
    entry({"admin", "services", "bandpush", "main"}, cbi("bandpush/main"), _("基本设置"), 10)
    entry({"admin", "services", "bandpush", "bandwidth"}, cbi("bandpush/bandwidth"), _("流量统计"), 20)
end

function act_status()
    local bandpush = require("luci.bandpush")
    luci.http.prepare_content("application/json")
    luci.http.write_json(bandpush.get_stats())
end
