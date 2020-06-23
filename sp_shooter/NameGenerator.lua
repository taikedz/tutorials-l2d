--[[
A name generator, for keeping track of stuff

Do

    nglib = require "NameGenerator"
    ng = nglib:init(names_list, adjectives_list) -- arguments optional

and then just call `ng:generate()` repeatedly to receive quirky names.

--]]

local basic_adjectives = {
    "Anxious",
    "Brazen",
    "Coercive",
    "Dastardly",
    "Finnicky",
    "Ghastly",
    "Harrowing",
    "Insidious",
    "Jeering",
    "Knavish",
    "Lurid",
    "Menacing",
    "Nasty",
    "Ostentatious",
    "Primordial",
    "Quenchless",
    "Remorseless",
    "Snide"
}

local basic_names = {
    "Alice",
    "Bob",
    "Carol",
    "Dave",
    "Eve",
    "Frank",
    "Gene",
    "Harry",
    "Isabelle",
    "Jake",
    "Kate",
    "Luke",
    "Mary",
    "Nick",
    "Ollie",
    "Peter",
    "Queenie",
    "Roger",
    "Sue"
}

-- +++++++++++++++++++++++++++++++

local NameGenerator = {}

local function generate_handler(self)
    local a = self.adjectives
    local n = self.names
    return a[math.random(1,#a)] .. " " .. n[math.random(1,#n)]
end

function NameGenerator:init(adj, nam)
    local ng = {}
    math.randomseed(os.time())

    if adj then ng.adjectives = adj
    else ng.adjectives = basic_adjectives
    end

    if nam then ng.names = nam
    else ng.names = basic_names
    end

    ng.generate = generate_handler

    return ng
end

return NameGenerator
