module("luci.push", package.seeall)
require("luci.model.uci")

local function get_config(opt, default)
    local uci = require("luci.model.uci").cursor()
    uci:load("bandpush")
    return uci:get("bandpush", "config", opt) or default
end

local function http_post(url, data)
    local cmd = string.format("curl -s -X POST '%s' -H 'Content-Type: application/json' -d '%s'", url, data)
    local f = io.popen(cmd)
    if f then
        local r = f:read("*a")
        f:close()
        return r
    end
end

function send_bark(msg)
    local url = get_config("bark_url", "")
    if url == "" then return nil, "未配置" end
    url = url .. luci.sys.urlencode(msg) .. "/BandPush"
    local code = io.popen("curl -s -o /dev/null -w '%{http_code}' '" .. url .. "'"):read("*a")
    return code == "200"
end

function send_pushplus(msg)
    local token = get_config("pushplus_token", "")
    if token == "" then return nil end
    local d = string.format('{"token":"%s","content":"%s","template":"txt"}', token, msg)
    return http_post("http://www.pushplus.plus/send", d) and true
end

function send_serverchan(msg)
    local sckey = get_config("serverchan_sckey", "")
    if sckey == "" then return nil end
    local d = string.format('{"title":"BandPush","desp":"%s"}', msg)
    return http_post("https://sctapi.ftqq.com/" .. sckey .. ".send", d) and true
end

function send_telegram(msg)
    local token = get_config("telegram_bot_token", "")
    local chat_id = get_config("telegram_chat_id", "")
    if token == "" or chat_id == "" then return nil end
    local d = string.format('{"chat_id":"%s","text":"%s"}', chat_id, msg)
    return http_post("https://api.telegram.org/bot" .. token .. "/sendMessage", d) and true
end

function send(msg)
    local t = get_config("push_type", "bark")
    if t == "bark" then return send_bark(msg) end
    if t == "pushplus" then return send_pushplus(msg) end
    if t == "serverchan" then return send_serverchan(msg) end
    if t == "telegram" then return send_telegram(msg) end
    return nil, "未知类型"
end
