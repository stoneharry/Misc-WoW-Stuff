--[[
Functions:
	SpawnMaze(maze (table), x (number), y (number), z (number) [, save (boolean)])
		Spawns a maze using 'maze' as a blueprint. 'x', 'y', 'z' determines the upper-left
		corner of the maze. 'save' determines if the maze is saved to the database (defaults
		to false).
		returns: nothing.
	SpawnMazeLoad(file (string), x (number), y (number), z (number) [, save (boolean)])
		Loads a maze from 'file'.txt and passes it to SpawnMaze().
		returns: nothing.
	GenerateMaze(width, height)
		Generates a maze with dimensions 'width'*2, 'height'*2. It also includes a
		start point (randomly selected at start of generation) and an end point
		(the point farthest from the start point at end of generation).
		Does not generate despawning walls.
		returns: a table representing the generated maze.
		
Please use SpawnMazeLoad() to actually spawn the maze! It gives much more power over
the final output, and allows placement of despawning walls!
Also, the 'save' argument should only be used when the maze is finalized, as it saves
the whole thing to the database.

Please follow these guidelines when editing a maze file:
	# = wall
	S = start point
	E = end point (defaults as the farthest point from start)
	H = despawning wall
	+ = corridor
]]

--[[

local sizeW = 6 --Width of maze box
local sizeH = 5.5125 --Height of maze box
local Box1 = 50000 --Normal maze box (gameobject)
local Box2 = 50001 --Despawning wall (gameobject)
local StartDummy = 60010 --Start dummy (unit)
local EndDummy = 60016 --End dummy (unit)
local firstMaze = true
local Duration = 60 * 60 * 1000 --1 hour

mazeInfo = {
	generating = false,
	players = {},
	completed = {},
	currentMaze = {},
	Start,
	End,
	mazeStart = {0, 0, 0}
}

function SpawnMaze(maze, x, y, z)
	assert (type(maze) == "table", "Bad argument #1 to SpawnMaze (table expected, got "..type(maze)..")")
	for k, v in pairs (maze) do
		assert (type(v) == "string")
	end
	assert (type(x) == "number", "Bad argument #2 to SpawnMaze (number expected, got "..type(x)..")")
	assert (type(y) == "number", "Bad argument #3 to SpawnMaze (number expected, got "..type(y)..")")
	assert (type(z) == "number", "Bad argument #4 to SpawnMaze (number expected, got "..type(z)..")")
	for k, v in pairs (maze) do
		for i = 1, string.len(v) do
			local s = string.sub(v, i, i)
			local nX = x + (i * sizeW)
			local nY = y + (k * sizeW)
			if (s == "#") then --Wall
				local nZ = z
				PerformIngameSpawn(2, Box1, 13, nX, nY, nZ, 0, 400, Duration)
			elseif (s == "+") then --Corridor
				local nZ = z + sizeH
				PerformIngameSpawn(2, Box1, 13, nX, nY, nZ, 0, 400, Duration)
				nZ = z - sizeH
				PerformIngameSpawn(2, Box1, 13, nX, nY, nZ, 0, 400, Duration)
			elseif (s == "S") then --Start point dummy
				local nZ = z + sizeH
				PerformIngameSpawn(2, Box1, 13, nX, nY, nZ, 0, 400, Duration)
				nZ = z - sizeH
				PerformIngameSpawn(2, Box1, 13, nX, nY, nZ, 0, 400, Duration)
				nZ = z + 0.1
				PerformIngameSpawn(1, StartDummy, 13, nX, nY, nZ, 0, 35, Duration)
				mazeInfo.mazeStart[1] = nX
				mazeInfo.mazeStart[2] = nY
				mazeInfo.mazeStart[3] = nZ + 0.9
			elseif (s == "E") then --End point dummy
				local nZ = z + sizeH
				PerformIngameSpawn(2, Box1, 13, nX, nY, nZ, 0, 400, Duration)
				nZ = z - sizeH
				PerformIngameSpawn(2, Box1, 13, nX, nY, nZ, 0, 400, Duration)
				nZ = z + 0.1
				PerformIngameSpawn(1, EndDummy, 13, nX, nY, nZ, 0, 35, Duration)
			elseif (s == "H") then --Despawning wall
				local nZ = z
				PerformIngameSpawn(2, Box2, 13, nX, nY, nZ, 0, 400, Duration)
				nZ = z + sizeH
				PerformIngameSpawn(2, Box1, 13, nX, nY, nZ, 0, 400, Duration)
				nZ = z - sizeH
				PerformIngameSpawn(2, Box1, 13, nX, nY, nZ, 0, 400, Duration)
			else
				print ("Unhandled character \'"..s.."\' in maze spawning code. Replacing with corridor.")
				local nZ = z + sizeH
				PerformIngameSpawn(2, Box1, 13, nX, nY, nZ, 0, 400, Duration)
				nZ = z - sizeH
				PerformIngameSpawn(2, Box1, 13, nX, nY, nZ, 0, 400, Duration)
			end
		end
	end
end
function SpawnMazeLoad(file, x, y, z)
	local f = assert(io.open("scripts/dropbox/kronos/"..file..".txt"), "Bad argument #1 to SpawnMazeLoad (no .txt file with name "..file..")")
	assert (type(x) == "number", "Bad argument #2 to SpawnMazeLoad (number expected, got "..type(x)..")")
	assert (type(y) == "number", "Bad argument #3 to SpawnMazeLoad (number expected, got "..type(y)..")")
	assert (type(z) == "number", "Bad argument #4 to SpawnMazeLoad (number expected, got "..type(z)..")")
	local maze = {}
	for l in f:lines() do
		table.insert(maze, l)
	end
	f:close()
	SpawnMaze(maze, x, y, z)
end

function GenerateMaze(arg1, arg2)
	--Remember, width and height is doubled to make the recursive backtracking work with
	--uneven numbers, so a 10x10 maze actually becomes 20x20.
	--arg1 = width
	--arg2 = height
	assert (type(arg1) == "number", "Bad argument #1 to GenerateMaze (number expected, got "..type(arg1)..")")
	assert (type(arg2) == "number", "Bad argument #2 to GenerateMaze (number expected, got "..type(arg2)..")")
	local maze = {}
	for x = 1, arg1 * 2 do
		maze[x] = {}
		for y = 1, arg2 * 2 do
			maze[x][y] = {"#", 0, 0}
		end
	end
	local hash = (os.time() / os.clock()) + math.random(1, 2^16) - math.random(2^10, 2^16)
	math.randomseed(hash)
	local x = math.random(1, arg1) * 2
	local y = math.random(1, arg2) * 2
	maze[x][y][1] = "S"
	local startX = x
	local startY = y
	local fromStart = 0
	local longestFromStart = 0
	local fromStartX = 0
	local fromStartY = 0
	while (true) do
		local found = false
		local oldX = x
		local oldY = y
		local m = {}
		if (x < ((arg1 * 2) - 2) and maze[x+2][y][1] == "#") then
			table.insert(m, {x+2, y, 1})
		end
		if (x > 2 and maze[x-2][y][1] == "#") then
			table.insert(m, {x-2, y, 2})
		end
		if (y < ((arg2 * 2) - 2) and maze[x][y+2][1] == "#") then
			table.insert(m, {x, y+2, 3})
		end
		if (y > 2 and maze[x][y-2][1] == "#") then
			table.insert(m, {x, y-2, 4})
		end
		if ((#m) > 0) then
			fromStart = fromStart + 1
			local r = math.random(1, (#m))
			x = m[r][1]
			y = m[r][2]
			maze[x][y][1] = "+"
			maze[x][y][2] = oldX
			maze[x][y][3] = oldY
			if (m[r][3] == 1) then
				maze[x-1][y][1] = "+"
			elseif (m[r][3] == 2) then
				maze[x+1][y][1] = "+"
			elseif (m[r][3] == 3) then
				maze[x][y-1][1] = "+"
			else
				maze[x][y+1][1] = "+"
			end
		else
			if (fromStart > longestFromStart) then
				longestFromStart = fromStart
				fromStartX = x
				fromStartY = y
			end
			fromStart = fromStart - 1
			local tmp1 = x
			x = maze[x][y][2]
			y = maze[tmp1][y][3]
		end
		if (x == startX and y == startY) then
			maze[fromStartX][fromStartY][1] = "E"
			break
		end
	end
	local maze2 = {}
	for k1 = 1, ((arg1 * 2) - 1) do
		if (not maze2[k1]) then
			maze2[k1] = {}
		end
		for k2 = 1, ((arg2 * 2) - 1) do
			maze2[k1][k2] = maze[k1][k2][1]
		end
	end
	local Max = 0
	for k1, v1 in pairs (maze2) do
		for k2, v2 in pairs (v1) do
			local r = math.random(1, ((arg1 * arg2) / 5))
			if (Max < 10 and maze2[k1][k2] == "#" and r == 1) then
				local m = {}
				if (maze2[k1+2] and maze2[k1+2][k2] and maze2[k1+2][k2] == "+") then
					table.insert(m, {k1+1, k2})
				end
				if (maze2[k1-2] and maze2[k1-2][k2] and maze2[k1-2][k2] == "+") then
					table.insert(m, {k1-1, k2})
				end
				if (maze2[k1] and maze2[k1][k2+2] and maze2[k1][k2+2] == "+") then
					table.insert(m, {k1, k2+1})
				end
				if (maze2[k1] and maze2[k1][k2-2] and maze2[k1][k2-2] == "+") then
					table.insert(m, {k1, k2-1})
				end
				if ((#m) > 0) then
					Max = Max + 1
					maze2[k1][k2] = "+"
				end
			end
		end
	end
	local maze3 = {}
	for k1, v1 in pairs (maze2) do
		maze3[k1] = table.concat(v1)
	end
	return maze3
end

function GenerateNewMaze()
	mazeInfo.generating = true
	if (firstMaze) then
		firstMaze = false
	else
		for k, v in pairs (mazeInfo.players) do
			if (v) then
				v:Teleport(0, -7477.58, -1254.11, 477.4)
			end
			table.remove(k)
		end
	end
	CreateLuaEvent(DelayGeneration, 2000, 1)
end
function DelayGeneration()
	local maze = GenerateMaze(20, 20) --40x40
	SpawnMaze(maze, -100, -100, 250)
	mazeInfo.generating = false
end

function MazeCheckPlayers()
	if (not mazeInfo.generating) then
		for k, v in pairs (mazeInfo.players) do
			if (not v or (v:IsInWorld() and v:GetMapId() ~= 13)) then
				table.remove(mazeInfo.players, k)
			end
		end
	end
end

CreateLuaEvent(MazeCheckPlayers, 2000, 0)

function MazeDummyGossip(pUnit, event, player, id, intid)
	if (event == 1) then
		local tmp = true
		for k, v in pairs (mazeInfo.completed) do
			if (v:GetName() == player:GetName()) then
				tmp = false
			end
		end
		if (tmp) then
			table.insert(mazeInfo.completed, player)
			pUnit:SendChatMessageToPlayer(42, 0, "You have received 5 \124cffa335ee\124Hitem:29434:0:0:0:0:0:0:0:0\124h[Badge of Justice]\124h\124r for completing this course!", player)
			player:AddItem(29434, 5)
			player:CastSpell(47292)
		end
		pUnit:GossipCreateMenu(1, player, 0)
		pUnit:GossipMenuAddItem(2, "Return me to Blackrock Mountain.", 1, 0)
		pUnit:GossipMenuAddItem(0, "Nevermind.", 2, 0)
		pUnit:GossipSendMenu(player)
	elseif (event == 2) then
		if (intid == 1) then
			for k, v in pairs (mazeInfo.players) do
				if (v:GetName() == player:GetName()) then
					table.remove(mazeInfo.players, k)
				end
			end
			player:GossipComplete()
			player:Teleport(0, -7555, -1200, 477)
		elseif (intid == 2) then
			player:GossipComplete()
		end
	end
end

RegisterUnitGossipEvent(EndDummy, 1, MazeDummyGossip)
RegisterUnitGossipEvent(EndDummy, 2, MazeDummyGossip)

CreateLuaEvent(GenerateNewMaze, 10000, 1)
CreateLuaEvent(GenerateNewMaze, Duration + 1000, 0)

]]