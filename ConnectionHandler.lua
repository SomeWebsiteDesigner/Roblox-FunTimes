local function Connector()
local ConnectionGroup = {}

ConnectionGroup.Groups = {}

ConnectionGroup.__index = ConnectionGroup

function ConnectionGroup.Create(Name, ExisitingConnections)
	local Proxy = {}
	Proxy.Connections = {}

	if Name == nil then
		warn("pls put a name")
		return
	end

	if ConnectionGroup.Groups[Name] then
		warn("put a unique name..........")
		return
	end

	Proxy.Name = Name
	ConnectionGroup.Groups[Name] = Proxy

	if ExisitingConnections then
		for i = 1, #ExisitingConnections do
			Proxy.Connections[i] = ExisitingConnections[i]
		end
	end

	setmetatable(Proxy, ConnectionGroup)

	return Proxy
end

function ConnectionGroup.Delete(Name)
	if Name == nil then
		warn("pls put a name")
		return
	end

	if ConnectionGroup.Groups[Name] then
		warn("put a unique name..........")
		return
	end

	Proxy.Name = Name
	ConnectionGroup.Groups[Name] = Proxy

	if ExisitingConnections then
		for i = 1, #ExisitingConnections do
			Proxy.Connections[i] = ExisitingConnections[i]
		end
	end
end


function ConnectionGroup:AddConnection(Connection)
	for i = 1, #self.Connections do
		if self.Connections[i] == Connection then
			warn("CANNOT ADD DUPLICATE CONNECTION CAUSE WHATS THE POINT OF THAT LOL")
			return
		end
	end

	table.insert(self.Connections, Connection)
end

function ConnectionGroup:RemoveConnection(Connection)
	for i = 1, #self.Connections do
		if self.Connections[i] == Connection then
			self.Connections[i]:Disconnect()
			table.remove(self.Connections, i)
			return
		end
	end
end

function ConnectionGroup:Disconnect()
	for i = 1, #self.Connections do
		self.Connections[i]:Disconnect()
		table.remove(self.Connections, i)
	end
end

function ConnectionGroup:Destroy()
	ConnectionGroup.Groups[self.Name] = nil
	self:Disconnect()
end

function ConnectionGroup.GetGroupByName(name)
	return ConnectionGroup.Groups[name]
end
	end
return Connector
