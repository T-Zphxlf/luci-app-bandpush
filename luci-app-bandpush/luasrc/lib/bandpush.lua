module("luci.bandpush", package.seeall)

local os = require("os")

function format_bytes(bytes)
    if not bytes then return "0 B" end
    bytes = tonumber(bytes) or 0
    if bytes >= 1073741824 then
        return string.format("%.2f GB", bytes / 1073741824)
    elseif bytes >= 1048576 then
        return string.format("%.2f MB", bytes / 1048576)
    elseif bytes >= 1024 then
        return string.format("%.2f KB", bytes / 1024)
    end
    return string.format("%d B", bytes)
end

function get_stats()
    local stats = { total_sent = 0, total_recv = 0, timestamp = os.time() }
    local f = io.open("/proc/net/dev", "r")
    if f then
        for line in f:lines() do
            local iface, rx, tx = line:match("(%w+):%s+(%d+)%s+%d+.*%s+(%d+)")
            if iface and (iface == "br-lan" or iface == "lan" or iface == "eth0") then
                stats.total_recv = tonumber(rx) or 0
                stats.total_sent = tonumber(tx) or 0
            end
        end
        f:close()
    end
    return stats
end

function generate_report()
    local stats = get_stats()
    local now = os.date("*t")
    return string.format("📊 BandPush 流量报告\n━━━━━━━━━━━━━━━━━\n🕐 时间: %04d-%02d-%02d %02d:%02d\n\n📈 流量统计\n   ⬆️ 发送: %s\n   ⬇️ 接收: %s\n   📦 总计: %s\n━━━━━━━━━━━━━━━━━",
        now.year, now.month, now.day, now.hour, now.min,
        format_bytes(stats.total_sent),
        format_bytes(stats.total_recv),
        format_bytes(stats.total_sent + stats.total_recv))
end

function check_threshold()
    local uci = require("luci.model.uci").cursor()
    uci:load("bandpush")
    if uci:get("bandpush", "bandwidth", "threshold_enabled") ~= "1" then return nil end
    local threshold = tonumber(uci:get("bandpush", "bandwidth", "threshold_daily")) or 10
    local stats = get_stats()
    local daily_gb = (stats.total_sent + stats.total_recv) / 1073741824
    if daily_gb > threshold then
        return string.format("⚠️ 流量告警: %.2f GB > %.2f GB", daily_gb, threshold)
    end
    return nil
end
