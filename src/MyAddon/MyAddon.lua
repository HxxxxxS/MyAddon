-- MyAddon
--
-- An example addon written for 1.13
-- 

MyAddon = {}

MyAddon.Name = "MyAddon"
MyAddon.Version = "1.0"
MyAddon.Enabled = 0
MyAddon.Colors = {
    red = "ffff0000",
    green = "ff00ff00",
    yellow = "ffffff00",
    gray = "ff999999",
    orange = "ffe66600"
}

MyAddon.SlashCmd = "myaddon"
MyAddon.Title = MyAddon.Name.." v"..MyAddon.Version

MyAddon.Cmds = {
    {
        cmd = "on",
        desc = "Enables "..MyAddon.Name,
        cb = function() MyAddon:Enable() end

    },
    {
        cmd = "off",
        desc = "Disables "..MyAddon.Name,
        cb = function() MyAddon:Disable() end
    },
    {
        cmd = "help",
        desc = "Displays this message.",
        cb = function() MyAddon:Help() end
    }
}

function MyAddon:OnLoad()

    SLASH_MYADDON1 = "/myaddon"
    SlashCmdList["MYADDON"] = function(msg)
        MyAddon:SlashCommandHandler(msg)
    end

    MyAddon:Print(MyAddon:Color("green")..MyAddon.Title.." Loaded - /"..MyAddon.SlashCmd)
end

function MyAddon:Print(msg)
    DEFAULT_CHAT_FRAME:AddMessage(format(msg))
end

function MyAddon:Color(col)
    return "|c"..MyAddon.Colors[col]
end

function MyAddon:SlashCommandHandler(msg)
    if( msg ) then
        local command = string.lower(msg)

        local i = 0

        for k,o in pairs(MyAddon.Cmds) do
            if command == o["cmd"] then
                --MyAddon:Print(MyAddon:Color("green").."You triggered command '"..MyAddon:Color("yellow")..o["cmd"]..MyAddon:Color("green").."'")
                if o.cb then
                    o.cb()
                end
                i = i+1
                break
            end
        end
        if i==0 then
            MyAddon:Print(MyAddon:Color("yellow").."Unknown command " ..MyAddon:Color("green").."/"..MyAddon.SlashCmd.." "..msg);
            MyAddon:Help()
        end
    else
        MyAddon:Help()
    end
end

function MyAddon:Help()
    MyAddon:Print(MyAddon:Color("green")..MyAddon.Title..MyAddon:Color("yellow").." : Usage - /"..MyAddon.SlashCmd.." option");
    for k,o in pairs(MyAddon.Cmds) do
        MyAddon:Print(MyAddon:Color("green").."/"..MyAddon.SlashCmd.." "..MyAddon:Color("yellow")..o
            ["cmd"]..MyAddon:Color("green")..MyAddon:Color("yellow")..MyAddon:Color("green")..": "..o["desc"])
    end
    MyAddon:Print(MyAddon:Color("green").."Usage - /"..MyAddon.SlashCmd.." option");
end

function MyAddon:Enable()
    MyAddon.Enabled = 1
    MyAddon:Print(MyAddon:Color("green")..MyAddon.Name.." enabled.")
end

function MyAddon:Disable()
    MyAddon.Enabled = 0
    MyAddon:Print(MyAddon:Color("red")..MyAddon.Name.." disabled.")
end
