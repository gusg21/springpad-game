-- Convert from CSV string to table (converts a single line of a CSV file)
local function parseCsvLine(line, sep)
    local res = {}
    local pos = 1
    sep = sep or ","
    while true do
        local c = string.sub(line, pos, pos)
        if (c == "") then
            break
        end
        if (c == '"') then
            -- quoted value (ignore separator within)
            local txt = ""
            repeat
                local startp, endp = string.find(line, '^%b""', pos)
                txt = txt .. string.sub(line, startp + 1, endp - 1)
                pos = endp + 1
                c = string.sub(line, pos, pos)
                if (c == '"') then
                    txt = txt .. '"'
                end
            until -- check first char AFTER quoted string, if it is another
            -- quoted string without separator, then append it
            -- this is the way to "escape" the quote char in a quote. example:
            --   value1,"blub""blip""boing",value3  will result in blub"blip"boing  for the middle
            (c ~= '"')
            table.insert(res, txt)
            assert(c == sep or c == "")
            pos = pos + 1
        else
            -- no quotes used, just look for the first separator
            local startp, endp = string.find(line, sep, pos)
            if (startp) then
                table.insert(res, string.sub(line, pos, startp - 1))
                pos = endp + 1
            else
                -- no separator found -> use rest of string and terminate
                table.insert(res, string.sub(line, pos))
                break
            end
        end
    end
    return res
end

local function parseCsv(file)
    local index = 1
    local t = {}
    for line in love.filesystem.lines(file) do
        t[index] = parseCsvLine(line)
        index = index + 1
    end
    return t
end

return parseCsv
