local config = require("server.config")

local SHELL = "/opt/quick_server/openresty/web_interface/tool/deploy.sh"

local function PullCode(commit)
    local repo = config.userDefinedCodes.localRepo
    local dest = config.userDefinedCodes.localDest
    if repo == nil or dest == nil then
        ngx.say("config 'localRepo' or 'localDest' missed")
    end

    local cmd = string.format("%s %s %s %s", SHELL, repo, dest, commit)
    local ok = os.execute(cmd)
    if ok == 0 then
        ngx.say("ok")
    else
        ngx.say("error: " .. ok)
    end
end

local args = ngx.req.get_uri_args()

if args["commit"] then
    local commit = args["commit"] 
    PullCode(commit)
else
    ngx.say("param 'commit' missed")
end
