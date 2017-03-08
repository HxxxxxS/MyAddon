-- MyAddon
--
-- An example addon written for 1.12
-- 

MyAddon = {}

MyAddon = "MyAddon"
MyAddon_Version = "0"
MyAddon_Title = MyAddon_Name.." v"..MyAddon_Version

MyAddon_Enabled = 0;

MyAddon_Colors = {
    red = "ffff0000",
    green = "ff00ff00",
    yellow = "ffffff00",
    gray = "ff999999",
    orange = "ffe66600"
}

MyAddon_Cmds = {
    {
        cmd = "on",
        desc = "Enables "..MyAddon_Name,
        cb = function() MyAddon:Enable() end

    },
    {
        cmd = "off",
        desc = "Disables "..MyAddon_Name,
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
    SLASH_MYADDON2 = "/ma"
    SlashCmdList["MYADDON"] = function(msg)
        MyAddon:SlashCommandHandler(msg)
    end

    MyAddon:Print(MyAddon:Color("green")..MyAddon_Title.." Loaded - /ma")
end

function MyAddon:Print(msg)
    DEFAULT_CHAT_FRAME:AddMessage(format(msg))
end

function MyAddon:Color(col)
    return "|c"..MyAddon_Colors[col]
end

function MyAddon:SlashCommandHandler(msg)
    if( msg ) then
        local command = string.lower(msg)

        local i = 0

        for k,o in pairs(MyAddon_Cmds) do
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
            MyAddon:Print(MyAddon:Color("yellow").."Unknown command " ..MyAddon:Color("green").."/ma "..msg);
            MyAddon:Help()
        end
    else
        MyAddon:Help()
    end
end

function MyAddon:Help()
    MyAddon:Print(MyAddon:Color("green")..MyAddon_Title..MyAddon:Color("yellow").." : Usage - /ma option");
    for k,o in pairs(MyAddon_Cmds) do
        MyAddon:Print(MyAddon:Color("green").."/ma "..MyAddon:Color("yellow")..o
            ["cmd"]..MyAddon:Color("green")..MyAddon:Color("yellow")..MyAddon:Color("green")..": "..o["desc"])
    end
    MyAddon:Print(MyAddon:Color("green").."Usage - /ma option");
end

function MyAddon:Enable()
    MyAddon_Enabled = 1
    MyAddon:Print(MyAddon:Color("green")..MyAddon_Name.." enabled.")
end

function MyAddon:Disable()
    MyAddon_Enabled = 0
    MyAddon:Print(MyAddon:Color("red")..MyAddon_Name.." disabled.")
end