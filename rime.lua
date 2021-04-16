function date_translator(input, seg)
    if (input == "date") then
        --- Candidate(type, start, end, text, comment)
        yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), "Date"))
        yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d"), ""))
    end
    if (input == "time") then
        --- Candidate(type, start, end, text, comment)
        yield(Candidate("date", seg.start, seg._end, os.date("%H:%M:%S"), "Time"))
        yield(Candidate("time", seg.start, seg._end, os.date("%H%M%S"), ""))
    end
    if (input == "riqi") then
        --- Candidate(type, start, end, text, comment)
        yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), "日期"))
    end
end

--- 过滤器：单字在先
function single_char_first_filter(input)
    local l = {}
    for cand in input:iter() do
        if (utf8.len(cand.text) == 1) then
            yield(cand)
        else
            table.insert(l, cand)
        end
    end
    for i, cand in ipairs(l) do
        yield(cand)
    end
end

-- select_character_processor: 以词定字
-- 详见 `lua/select_character.lua`
select_character_processor = require("select_character")
