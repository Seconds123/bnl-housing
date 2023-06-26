lib.locale()
Properties = {}

function SetupProperties()
    for _, property in pairs(Properties) do
        property.point:remove()
    end

    for _, data in pairs(lib.callback.await("bnl-housing:server:getProperties")) do
        local property = Property.new(data)
        property:createEntrancePoint()
        property:createBlip()

        Properties[property.id] = property
    end
end

---This function is callable from the server.
---@param propertyId number
function SetupInPropertyPoints(propertyId)
    local property = table.findOne(Properties, function(property)
        return property.id == propertyId
    end)
    if not property then return end

    property:createInPropertyPoints()
end

---This function is callable from the server.
---@param propertyId number
function RemoveInPropertyPoints(propertyId)
    local property = table.findOne(Properties, function(property)
        return property.id == propertyId
    end)
    if not property then return end

    property:removeInPropertyPoints()
end

---@param name string
---@param id number
---@return string
function FormatPlayerTag(name, id)
    local options = {
        name = ("#%s"):format(name),
        id = ("#%s"):format(id),
        both = ("[#%s] %s"):format(id, name),
    }
    return options[Config.playerTag]
end

---This function is callable from the server.
---@param text string
function StartBusySpinner(text)
    BeginTextCommandBusyspinnerOn('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandBusyspinnerOn(5)
end

Bridge.onReady(SetupProperties)
