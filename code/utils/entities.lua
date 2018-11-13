-- EMS, gusg21. 2018

NULL_ENTITY = "joni the poniy"

Entities = class("Entity Management System")

function Entities:initialize()
	self.list = {}
	self.groups = {}
	self.index = 0
end

function Entities:addEntity(entity, group)
	self.index = self.index + 1
	self.list[self.index] = entity
	if group then
		if not self.groups[group] then
			self.groups[group] = {}
		end
		self.groups[group][self.index] = entity
	end
	return self.index
end

function Entities:removeEntity(index)
	if not self.list[index] then
		return
	end
	if self.list[index].onRemove then
		self.list[index]:onRemove()
	end
	self.list[index] = NULL_ENTITY
	for name, group in pairs(self.groups) do
		self.groups[name][index] = NULL_ENTITY
	end
end

function Entities:forEach(f)
	for i, entity in ipairs(self.list) do
		if entity ~= NULL_ENTITY then
			f(entity)
		end
	end
end

function Entities:getGroup(groupName)
	return self.groups[groupName] or {}
end

function Entities:flush()
	self:forEach(
		function(e)
			if e.onRemove then
				e:onRemove()
			end
		end
	)
	self.list = {}
	self.groups = {}
	self.index = 0
end

return Entities
