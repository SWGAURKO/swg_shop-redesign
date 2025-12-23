Config = {}

-- Function that will return players VIP currency (if you don't plan on using it, just leave it as it is)
Config.GetVipCoinsCallback = function(source, cb)
    cb(0)
end



Config.Markets = {
    ['regular'] = {
        name = "24/7 Market",
        type = "regular",
        logo = "https://i.postimg.cc/YStbvq5L/724.png",
        categories = {
            {
                id = "food",
                name = "Food",
                icon = "fas fa-hamburger",
                items = {
                    {name = "burger", label = "Burger", price = 4, isVip = false},
                    {name = "sandwich", label = "Sandwich", price = 3, isVip = false},
                    {name = "baget", label = "Baguet", price = 3, isVip = false},
                    {name = "donut", label = "Donut", price = 5, isVip = false},
                }
            },
            {
                id = "snacks",
                name = "Snacks",
                icon = "fas fa-cookie-bite",
                items = {
                    {name = "cokoladica", label = "Chocolate bar", price = 7, isVip = false},
                    {name = "protein_bar", label = "Protein chocolate", price = 1, isVip = true, vipPrice = 1}
                }
            },
            {
                id = "drinks",
                name = "Drinks", 
                icon = "fas fa-coffee",
                items = {
                    {name = "ecola", label = "Cola", price = 2, isVip = false},
                    {name = "ejunk", label = "Energy Drink", price = 3, isVip = false, vipPrice = 50},                   
                }
            },
            {
                id = "other",
                name = "Other", 
                icon = "fas fa-phone",
                items = {
                    {name = "radio", label = "Radio", price = 100, isVip = false},
                    {name = "phone", label = "Phone", price = 500, isVip = false},
                    {name = "fixkit", label = "Repair kit", price = 500, isVip = false},   
                }
            }
        }
    },

    ['ltd'] = {
        name = "LTD Gas station",
        type = "ltd",
        logo = "https://i.postimg.cc/qRRwGDMk/ltd.png",
        categories = {
            {
                id = "food",
                name = "Food",
                icon = "fas fa-hamburger",
                items = {
                    {name = "burger", label = "Burger", price = 4, isVip = false},
                    {name = "sandwich", label = "Sandwich", price = 3, isVip = false},
                    {name = "baget", label = "Baguet", price = 3, isVip = false},
                    {name = "donut", label = "Donut", price = 5, isVip = false},
                }
            },
            {
                id = "snacks",
                name = "Snacks",
                icon = "fas fa-cookie-bite",
                items = {
                    {name = "cokoladica", label = "Chocolate bar", price = 7, isVip = false},
                    {name = "protein_bar", label = "Protein chocolate", price = 1, isVip = true, vipPrice = 1}
                }
            },
            {
                id = "drinks",
                name = "Drinks", 
                icon = "fas fa-coffee",
                items = {
                    {name = "ecola", label = "Cola", price = 2, isVip = false},
                    {name = "ejunk", label = "Energy Drink", price = 3, isVip = false, vipPrice = 50},                   
                }
            },
            {
                id = "other",
                name = "Other", 
                icon = "fas fa-phone",
                items = {
                    {name = "radio", label = "Radio", price = 100, isVip = false},
                    {name = "phone", label = "Phone", price = 500, isVip = false},
                    {name = "fixkit", label = "Repair kit", price = 500, isVip = false},   
                    {name = "towingrope", label = "Towing rope", price = 50, isVip = false},
                }
            }
        }
    },

    ['liquor'] = {
        name = "Liquor prodavnica",
        type = "liquor",
        logo = "https://i.postimg.cc/6q4hk7vg/liquor.png",
        categories = {
            {
                id = "food",
                name = "Food",
                icon = "fas fa-hamburger",
                items = {
                    {name = "burger", label = "Burger", price = 4, isVip = false},
                    {name = "sandwich", label = "Sandwich", price = 3, isVip = false},
                    {name = "baget", label = "Baguet", price = 3, isVip = false},
                    {name = "donut", label = "Donut", price = 5, isVip = false},
                }
            },
            {
                id = "snacks",
                name = "Snacks",
                icon = "fas fa-cookie-bite",
                items = {
                    {name = "cokoladica", label = "Chocolate bar", price = 7, isVip = false},
                    {name = "protein_bar", label = "Protein chocolate", price = 1, isVip = true, vipPrice = 1}
                }
            },
            {
                id = "drinks",
                name = "Drinks", 
                icon = "fas fa-coffee",
                items = {
                    {name = "ecola", label = "Cola", price = 2, isVip = false},
                    {name = "ejunk", label = "Energy Drink", price = 3, isVip = false, vipPrice = 50},                   
                }
            },
            {
                id = "other",
                name = "Other", 
                icon = "fas fa-phone",
                items = {
                    {name = "radio", label = "Radio", price = 100, isVip = false},
                    {name = "phone", label = "Phone", price = 500, isVip = false},
                    {name = "fixkit", label = "Repair kit", price = 500, isVip = false},   
                }
            }
        }
    }, 

    ['illegal'] = {
        name = "Black Market",
        type = "illegal",
        logo = "https://i.postimg.cc/RZL2s89f/Special-Carbine-Thumb.webp",
        categories = {
            {
                id = "weapons",
                name = "Weapons",
                icon = "fas fa-gun",
                items = {
                    {name = "WEAPON_PISTOL", label = "Pistol", price = 10000, isVip = false},
                    {name = "WEAPON_HEAVYPISTOL", label = "Heavy pistol", price = 12000, isVip = false},
                    {name = "WEAPON_MACHINEPISTOL", label = "Machine pistol", price = 17500, isVip = false},
                    {name = "WEAPON_ASSAULTRIFLE", label = "Assault rifle", price = 25000, isVip = false},
                    {name = "WEAPON_MINISMG", label = "Mini SMG", price = 20000, isVip = false},
                    {name = "ammo-9", label = "Ammo - 9mm", price = 5, isVip = false},
                    {name = "ammo-45", label = "Ammo - 45mm", price = 5, isVip = false},
                    {name = "ammo-44", label = "Ammo - 44mm", price = 5, isVip = false},
                    {name = "ammo-rifle", label = "Ammo - 5.56", price = 10, isVip = false},
                    {name = "ammo-rifle2", label = "Ammo - 7.62x39", price = 10, isVip = false},
                    {name = "ammo-sniper", label = "Ammo - 7.62x51", price = 15, isVip = false},
                    {name = "WEAPON_SMG", label = "SMG", price = 15000, isVip = true, vipPrice = 50},
                    {name = "WEAPON_HUNTINGRIFLE", label = "Hunting Rifle", price = 15000, isVip = true, vipPrice = 50},
                    {name = "WEAPON_DE", label = "Desert Eagle", price = 15000, isVip = true, vipPrice = 50},
                }
            },
            {
                id = "other",
                name = "Other",
                icon = "fas fa-mask",
                items = {
                    {name = "armour", label = "Armor", price = 3000, isVip = false},
                    {name = "hacking_device", label = "Hacking device", price = 1500, isVip = false},
                    {name = "bag", label = "Bag", price = 5, isVip = false},
                    {name = "selfrevive", label = "Slef revive", price = 1500, isVip = false},
                    {name = "adrenalin", label = "Adrenaline", price = 1200, isVip = false},
                }
            },
            {
                id = "drugs", 
                name = "Drugs",
                icon = "fas fa-pills",
                items = {
                    {name = "joint", label = "Joint", price = 500, isVip = false},
                    {name = "cocaine_bag", label = "50g cocaine", price = 1000, isVip = true, vipPrice = 1},
                }
            }
        }
    }
}

Config.Locations = {
    ['regular'] = {
        vec4(24.4545, -1347.7786, 29.4970, 262.9856),
        vec4(-3038.8708, 584.4542, 7.9089, 17.6253), 
        vec4(-3242.2739, 999.9111, 12.8307, 352.4142),
        vec4(1727.7931, 6415.2441, 35.0372, 238.9138),
        vec4(1697.99, 4924.40, 42.06, 323.19),
        vec4(1959.9824, 3739.9395, 32.3437, 296.5123),
        vec4(549.1434, 2671.3528, 42.1565, 99.3700),
        vec4(2678.0449, 3279.3269, 55.2411, 329.6050),
        vec4(2557.1790, 380.7243, 108.6229, 352.4922),
        vec4(372.4947, 326.4425, 103.5664, 252.7786),
        vec4(239.4763, -897.3555, 29.6232, 164.2585)

    },
    ['ltd'] = {
        vec4(1164.8776, -323.7292, 69.2051, 97.8892),
        vec4(-47.2472, -1758.5483, 29.4210, 50.9088),
        vec4(-706.0665, -914.5461, 19.2156, 83.5935),
        vec4(-1819.5742, 793.6172, 138.0860, 139.8697),
        vec4(1697.3911, 4923.3140, 42.0637, 334.4158)
    },
    ['liquor'] = {
        vec4(1134.2257, -982.5131, 46.4158, 273.7372),
        vec4(-1486.2217, -377.9568, 40.1634, 131.5161),
        vec4(-2966.3975, 390.9071, 15.0433, 84.5735),
        vec4(1166.0286, 2710.8721, 38.1577, 174.6621),
        vec4(-1221.9255, -908.3262, 12.3263, 34.6000)
    },  
    ['illegal'] = {
        vec4(2939.2234, 4624.1548, 48.7204, 221.3809)
    }
}

Config.Blips = {
    ['regular'] = {
        enabled = true, 
        sprite = 59, 
        color = 2,   
        scale = 0.8,
        name = "24/7 Market"
    },
    ['ltd'] = {
        enabled = true,
        sprite = 52,
        color = 5,
        scale = 0.8,
        name = "LTD Market"
    },
    ['liquor'] = {
        enabled = true,
        sprite = 93,
        color = 1,
        scale = 0.8,
        name = "Liquor Market"
    },
    ['illegal'] = {
        enabled = true, 
        sprite = 110,   
        color = 0,
        scale = 0.8,
        name = "Black Market"
    }
}

Config.PedModels = {
    ['regular'] = 'mp_m_shopkeep_01',
    ['ltd'] = 's_m_y_ammucity_01', 
    ['liquor'] = 'a_m_y_bevhills_01',
    ['illegal'] = 's_m_y_dealer_01'
}

Config.Webhooks = {
    ['regular'] = "YOUR_WEBHOOK",
    ['liquor'] = "YOUR_WEBHOOK",
    ['ltd'] = "YOUR_WEBHOOK",
    ['illegal'] = "YOUR_WEBHOOK"
}