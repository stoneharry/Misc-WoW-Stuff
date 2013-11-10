print("Starting...")
local s = ...
if not s then
	print("Parse in the desired file!")
	return
end
local f = io.open(s, "rb")
if not f then
	print("File not found!")
	return
end
local buffer = {}
for line in f:lines() do
	if (#line > 0) then
		local text = string.gsub(line, "(%-%-[^%[%]%>].*)", " ")
		table.insert(buffer, text)
	end
end
f:close()
local code = table.concat(buffer, " ")

--code = string.gsub(code, "(%-%-%[%[.*%]%])", " ")
code = string.gsub(code, "\t", " ")
code = string.gsub(code, "\r", " ")
code = string.gsub(code, "\n", " ")
--code = string.gsub(code, "(%s+)", " ")

--code = string.dump(loadstring(code))
--code = ObfuscateSource(code)
f = io.open(s, "w+b")
f:setvbuf("no")
f:write(code)
f:flush()
f:close()
print("All done!")