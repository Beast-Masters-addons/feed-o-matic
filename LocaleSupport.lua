-----------------------------------------------------
-- LocaleSupport.lua
-- English strings by default, localizations override with their own.
------------------------------------------------------
-- This file contains strings which must be localized in order for Feed-O-Matic features to work in other locales.
-- Note: strings which are the same as in the enUS version needn't be localized; they can be commented out.
------------------------------------------------------

-- Diet names. These should be the seven possible diets returned from GetPetFoodTypes() and shown in the Pet tab of the character window (when mousing over the food icon). 
-- (Want to get them all nice and quick for your localization? Go tame a bear or boar... they eat anything. Except Mechanical Bits.)
-- THESE STRINGS MUST BE LOCALIZED for Feed-O-Matic to work properly in other locales.
FOM_DIET_MEAT					= "Meat"
FOM_DIET_FISH					= "Fish"
FOM_DIET_BREAD					= "Bread"
FOM_DIET_CHEESE					= "Cheese"
FOM_DIET_FRUIT					= "Fruit"
FOM_DIET_FUNGUS					= "Fungus"
FOM_DIET_MECH					= "Mechanical Bits"

-- Beast family names; we use these to provide optional pet-specific feeding emotes (see FeedOMatic_Emotes.lua)
FOM_BASILISK					= "Basilisk"				-- Mists
FOM_BAT							= "Bat"
FOM_BEAR						= "Bear"
FOM_BEETLE						= "Beetle"                  -- Cataclysm
FOM_BIRD_OF_PREY				= "Bird of Prey"        	-- WotLK
FOM_BOAR						= "Boar"                	
FOM_CARRION_BIRD				= "Carrion Bird"        	
FOM_CAT							= "Cat"                 	
FOM_CHIMAERA					= "Chimaera"            	-- WotLK exotic
FOM_CLEFTHOOF					= "Clefthoof"				-- Warlords
FOM_CORE_HOUND					= "Core Hound"          	-- WotLK exotic
FOM_CRAB						= "Crab"                	
FOM_CRANE						= "Crane"					-- Mists
FOM_CROCOLISK					= "Crocolisk"           	
FOM_DEVILSAUR					= "Devilsaur"           	-- WotLK exotic
FOM_DIREHORN					= "Direhorn"				-- Warlords
FOM_DOG							= "Dog"                     -- Cataclysm
FOM_DRAGONHAWK					= "Dragonhawk"          	-- BC
FOM_FOX							= "Fox"                     -- Cataclysm
FOM_GOAT						= "Goat"					-- Mists
FOM_GORILLA						= "Gorilla"             	
FOM_HYENA						= "Hyena"               	
FOM_HYDRA						= "Hydra"					-- Warlords
FOM_MECHANICAL					= "Mechanical"				-- Legion special
FOM_MONKEY						= "Monkey"                  -- Cataclysm
FOM_MOTH						= "Moth"                	-- WotLK
FOM_NETHER_RAY					= "Nether Ray"          	-- BC
FOM_OXEN						= "Oxen"					-- Legion
FOM_PORCUPINE					= "Porcupine"				-- Mists
FOM_QUILEN						= "Quilen"					-- Mists exotic
FOM_RAPTOR						= "Raptor"              	
FOM_RAVAGER						= "Ravager"             	-- BC
FOM_RIVERBEAST					= "Riverbeast"				-- Warlords
FOM_RYLAK						= "Rylak"					-- Warlords
FOM_SCALEHIDE					= "Scalehide"				-- Legion
FOM_SCORPID						= "Scorpid"             	
FOM_SERPENT						= "Serpent"             	-- BC
FOM_SHALE_SPIDER				= "Shale Spider"            -- Cataclysm exotic
FOM_SILITHID					= "Silithid"            	-- WotLK exotic
FOM_SPIDER						= "Spider"              	
FOM_SPIRIT_BEAST				= "Spirit Beast"        	-- WotLK exotic
FOM_SPOREBAT					= "Sporebat"            	-- BC
FOM_STAG						= "Stag"					-- Warlords
FOM_TALLSTRIDER					= "Tallstrider"         	
FOM_TURTLE						= "Turtle"              	
FOM_WARP_STALKER				= "Warp Stalker"			-- BC
FOM_WASP						= "Wasp"                	-- WotLK
FOM_WATER_STRIDER				= "Water Strider"			-- Mists exotic
FOM_WIND_SERPENT				= "Wind Serpent"        	
FOM_WOLF						= "Wolf"                	
FOM_WORM						= "Worm"                	-- WotLK exotic


------------------------------------------------------

if (GetLocale() == "itIT") then

-- Diet names. These should be the seven possible diets returned from GetPetFoodTypes() and shown in the Pet tab of the character window (when mousing over the food icon). 
-- (Want to get them all nice and quick for your localization? Go tame a bear or boar... they eat anything. Except Mechanical Bits.)
-- THESE STRINGS MUST BE LOCALIZED for Feed-O-Matic to work properly in other locales.
FOM_DIET_MEAT					= "Carne"
FOM_DIET_FISH					= "Pesce"
FOM_DIET_BREAD					= "Pane"
FOM_DIET_CHEESE					= "Formaggio"
FOM_DIET_FRUIT					= "Frutta"
FOM_DIET_FUNGUS					= "Funghi"
-- FOM_DIET_MECH					= "Mechanical bits" -- unknown

-- Beast family names; we use these to provide optional pet-specific feeding emotes (see FeedOMatic_Emotes.lua)
FOM_BASILISK					= "Basilisco"				-- Mists
FOM_BAT							= "Pipistrello"
FOM_BEAR						= "Orso"
FOM_BEETLE						= "Scarabeo"                  -- Cataclysm
FOM_BIRD_OF_PREY				= "Rapace"        	-- WotLK
FOM_BOAR						= "Cinghiale"                	
FOM_CARRION_BIRD				= "Mangiacarogne"        	
FOM_CAT							= "Felino"                 	
FOM_CHIMAERA					= "Chimera"            	-- WotLK exotic
FOM_CLEFTHOOF					= "Mammuceronte"				-- Warlords
FOM_CORE_HOUND					= "Segugio del Nucleo"          	-- WotLK exotic
FOM_CRAB						= "Granchio"                	
FOM_CRANE						= "Gru"					-- Mists
FOM_CROCOLISK					= "Crocolisco"           	
FOM_DEVILSAUR					= "Gigantosauro"           	-- WotLK exotic
FOM_DIREHORN					= "Cornofurente"				-- Warlords
FOM_DOG							= "Cane"                     -- Cataclysm
FOM_DRAGONHAWK					= "Dragofalco"          	-- BC
FOM_FOX							= "Volpe"                     -- Cataclysm
FOM_GOAT						= "Caprone"					-- Mists
-- FOM_GORILLA						= "Gorilla"	-- not translated in itIT
FOM_HYENA						= "Iena"               	
FOM_HYDRA						= "Idra"					-- Warlords
FOM_MECHANICAL					= "Unità Meccanica"				-- Legion special
FOM_MONKEY						= "Scimmia"                  -- Cataclysm
FOM_MOTH						= "Falena"                	-- WotLK
FOM_NETHER_RAY					= "Manta Fatua"          	-- BC
FOM_OXEN						= "Yak"					-- Legion
FOM_PORCUPINE					= "Porcospino"				-- Mists
-- FOM_QUILEN						= "Quilen"					-- Mists exotic, not translated in itIT
-- FOM_RAPTOR						= "Raptor" -- not translated in itIT
FOM_RAVAGER						= "Devastatore"             	-- BC
FOM_RIVERBEAST					= "Bestia dei Fiumi"				-- Warlords
-- FOM_RYLAK						= "Rylak"					-- Warlords, not translated in itIT
FOM_SCALEHIDE					= "Scagliamanto"				-- Legion
FOM_SCORPID						= "Scorpide"             	
FOM_SERPENT						= "Serpente"             	-- BC
FOM_SHALE_SPIDER				= "Ragno Roccioso"            -- Cataclysm exotic
FOM_SILITHID					= "Silitide"            	-- WotLK exotic
FOM_SPIDER						= "Ragno"              	
FOM_SPIRIT_BEAST				= "Bestia Eterea"        	-- WotLK exotic
FOM_SPOREBAT					= "Sporofago"            	-- BC
FOM_STAG						= "Cervo"					-- Warlords
FOM_TALLSTRIDER					= "Zampalunga"         	
FOM_TURTLE						= "Tartaruga"              	
FOM_WARP_STALKER				= "Segugio Distorcente"			-- BC
FOM_WASP						= "Vespa"                	-- WotLK
FOM_WATER_STRIDER				= "Gerride"			-- Mists exotic
FOM_WIND_SERPENT				= "Serpente Volante"        	
FOM_WOLF						= "Lupo"                	
FOM_WORM						= "Verme"                	-- WotLK exotic

end

------------------------------------------------------

------------------------------------------------------

if (GetLocale() == "ptBR") then

-- Diet names. These should be the seven possible diets returned from GetPetFoodTypes() and shown in the Pet tab of the character window (when mousing over the food icon). 
-- (Want to get them all nice and quick for your localization? Go tame a bear or boar... they eat anything.)
-- THESE STRINGS MUST BE LOCALIZED for Feed-O-Matic to work properly in other locales.
FOM_DIET_MEAT					= "Carne"
FOM_DIET_FISH					= "Peixe"
FOM_DIET_BREAD					= "Pão"
FOM_DIET_CHEESE					= "Queijo"
FOM_DIET_FRUIT					= "Fruta"
FOM_DIET_FUNGUS					= "Fungo"

-- Beast family names; we use these to provide optional pet-specific feeding emotes (see FeedOMatic_Emotes.lua)
FOM_BAT							= "Morcego"
FOM_BEAR						= "Urso"
FOM_BEETLE						= "Besouro"                  -- Cataclysm
FOM_BIRD_OF_PREY				= "Ave de Rapina"        	-- WotLK
FOM_BOAR						= "Javali"                	
FOM_CARRION_BIRD				= "Ave Carniceira"        	
FOM_CAT							= "Gato"                 	
FOM_CHIMAERA					= "Quimera"            	-- WotLK exotic
FOM_CORE_HOUND					= "Cão-magma"          	-- WotLK exotic
FOM_CRAB						= "Caranguejo"                	
FOM_CROCOLISK					= "Crocolisco"           	
FOM_DEVILSAUR					= "Demossauro"           	-- WotLK exotic
FOM_DOG							= "Cachorro"                     -- Cataclysm
FOM_DRAGONHAWK					= "Falcodrago"          	-- BC
FOM_FOX							= "Raposa"                     -- Cataclysm
FOM_GORILLA						= "Gorila"             	
FOM_HYENA						= "Hiena"               	
FOM_MONKEY						= "Macaco"                  -- Cataclysm
FOM_MOTH						= "Mariposa"                	-- WotLK
FOM_NETHER_RAY					= "Arraia Etérea"          	-- BC
-- FOM_RAPTOR						= "Raptor"              	-- same as enUS
FOM_RAVAGER						= "Assolador"             	-- BC
FOM_SCORPID						= "Escorpídeo"             	
FOM_SERPENT						= "Serpente"             	-- BC
FOM_SHALE_SPIDER				= "Aranha Xistosa"            -- Cataclysm exotic
FOM_SILITHID					= "Silitídeo"            	-- WotLK exotic
FOM_SPIDER						= "Aranha"              	
FOM_SPIRIT_BEAST				= "Fera Espiritual"        	-- WotLK exotic
FOM_SPOREBAT					= "Quirósporo"            	-- BC
FOM_TALLSTRIDER					= "Moa"         	
FOM_TURTLE						= "Tartaruga"              	
-- FOM_WARP_STALKER				= "Warp Stalker"			-- BC, not translated in ptBR
FOM_WASP						= "Vespa"                	-- WotLK
FOM_WIND_SERPENT				= "Serpente Alada"        	
FOM_WOLF						= "Lobo"                	
FOM_WORM						= "Verme"                	-- WotLK exotic

FOM_BASILISK					= "Basilisco"				-- Mists
FOM_CLEFTHOOF					= "Fenoceronte"				-- Warlords
FOM_CRANE						= "Garça"					-- Mists
FOM_DIREHORN					= "Escornante"				-- Warlords
FOM_GOAT						= "Bode"					-- Mists
FOM_HYDRA						= "Hidra"					-- Warlords
FOM_MECHANICAL					= "Mecânico"				-- Legion special
FOM_OXEN						= "Boi"						-- Legion
FOM_PORCUPINE					= "Porco-espinho"			-- Mists
FOM_QUILEN						= "Quílen"					-- Mists exotic
FOM_RIVERBEAST					= "Fera-do-rio"				-- Warlords
-- FOM_RYLAK						= "Rylak"					-- Warlords, not translated in ptBR
FOM_SCALEHIDE					= "Courescama"				-- Legion
FOM_STAG						= "Cervo"					-- Warlords
FOM_WATER_STRIDER				= "Caminhante das Águas"	-- Mists exotic

end

------------------------------------------------------

if (GetLocale() == "frFR") then

-- Diet names. These should be the seven possible diets returned from GetPetFoodTypes() and shown in the Pet tab of the character window (when mousing over the food icon). 
-- (Want to get them all nice and quick for your localization? Go tame a bear or boar... they eat anything.)
-- THESE STRINGS MUST BE LOCALIZED for Feed-O-Matic to work properly in other locales.
FOM_DIET_MEAT					= "Viande"
FOM_DIET_FISH					= "Poisson"
FOM_DIET_BREAD					= "Pain"
FOM_DIET_CHEESE					= "Fromage"
FOM_DIET_FRUIT					= "Fruit"
FOM_DIET_FUNGUS					= "Champignon"

-- Beast family names; we use these to provide optional pet-specific feeding emotes (see FeedOMatic_Emotes.lua)
FOM_BAT							= "Chauve-souris"
FOM_BEAR						= "Ours"
FOM_BOAR						= "Sanglier"
FOM_CARRION_BIRD				= "Charognard"
FOM_CAT							= "Félin"
FOM_CRAB						= "Crabe"
FOM_CROCOLISK					= "Crocilisque"
FOM_GORILLA						= "Gorille"
FOM_HYENA						= "Hyène"
--FOM_RAPTOR						= "Raptor"				-- same as enUS
FOM_SCORPID						= "Scorpide"
FOM_SPIDER						= "Araignée"
FOM_TALLSTRIDER					= "Haut-trotteur"
FOM_TURTLE						= "Tortue"
FOM_WIND_SERPENT				= "Serpent des vents"
FOM_WOLF						= "Loup"
FOM_DRAGONHAWK					= "Faucon-dragon"			-- BC
FOM_NETHER_RAY					= "Raie du Néant"			-- BC
FOM_RAVAGER						= "Ravageur"				-- BC
--FOM_SERPENT						= "Serpent"				-- BC; same as enUS
FOM_SPOREBAT					= "Sporoptère"				-- BC
FOM_WARP_STALKER				= "Traqueur dimensionnel"	-- BC
FOM_BIRD_OF_PREY				= "Oiseau de proie"			-- WotLK
FOM_WASP						= "Guêpe"					-- WotLK
FOM_CHIMAERA					= "Chimère"					-- WotLK exotic
FOM_CORE_HOUND					= "Chien du Magma"			-- WotLK exotic
FOM_DEVILSAUR					= "Diablosaure"				-- WotLK exotic
FOM_MOTH						= "Phalène"					-- WotLK
FOM_SILITHID					= "Silithide"				-- WotLK exotic
FOM_SPIRIT_BEAST				= "Esprit de bête"			-- WotLK exotic
FOM_WORM						= "Ver"						-- WotLK exotic
FOM_DOG							= "Chien"                   -- Cataclysm
FOM_BEETLE						= "Hanneton"                -- Cataclysm
FOM_SHALE_SPIDER				= "Araignée de schiste"     -- Cataclysm exotic
FOM_FOX							= "Renard"                  -- Cataclysm
FOM_MONKEY						= "Singe"                   -- Cataclysm

FOM_BASILISK					= "Basilic"					-- Mists
FOM_CLEFTHOOF					= "Sabot-fourchu"			-- Warlords
FOM_CRANE						= "Grue"					-- Mists
FOM_DIREHORN					= "Navrecorne"				-- Warlords
FOM_GOAT						= "Chèvre"					-- Mists
FOM_HYDRA						= "Hydre"					-- Warlords
FOM_MECHANICAL					= "Mécanique"				-- Legion special
FOM_OXEN						= "Bovin"					-- Legion
FOM_PORCUPINE					= "Porc-épic"				-- Mists
-- FOM_QUILEN						= "Quilen"					-- Mists exotic, not translated in frFR
FOM_RIVERBEAST					= "Potamodonte"				-- Warlords
-- FOM_RYLAK						= "Rylak"					-- Warlords, not translated in frFR
FOM_SCALEHIDE					= "Peau écailleuse"			-- Legion
FOM_STAG						= "Cerf"					-- Warlords
FOM_WATER_STRIDER				= "Trotteur aquatique"			-- Mists exotic

end

------------------------------------------------------

if (GetLocale() == "deDE") then

-- Diet names. These should be the seven possible diets returned from GetPetFoodTypes() and shown in the Pet tab of the character window (when mousing over the food icon). 
-- (Want to get them all nice and quick for your localization? Go tame a bear or boar... they eat anything.)
-- THESE STRINGS MUST BE LOCALIZED for Feed-O-Matic to work properly in other locales.
FOM_DIET_MEAT					= "Fleisch"
FOM_DIET_FISH					= "Fisch"
FOM_DIET_BREAD					= "Brot"
FOM_DIET_CHEESE					= "Käse"
FOM_DIET_FRUIT					= "Obst"
--	FOM_DIET_FUNGUS				= "Fungus"					-- same as enUS

-- Beast family names; we use these to provide optional pet-specific feeding emotes (see FeedOMatic_Emotes.lua)
FOM_BAT							= "Fledermaus"
FOM_BEAR						= "Bär"
FOM_BOAR						= "Eber"
FOM_CARRION_BIRD				= "Aasvogel"
FOM_CAT							= "Katze"
FOM_CRAB						= "Krebs"
FOM_CROCOLISK					= "Krokilisk"
--	FOM_GORILLA					= "Gorilla"					-- same as enUS
FOM_HYENA						= "Hyäne"
--	FOM_RAPTOR					= "Raptor"					-- same as enUS
FOM_SCORPID						= "Skorpid"
FOM_SPIDER						= "Spinne"
FOM_TALLSTRIDER					= "Weitschreiter"
FOM_TURTLE						= "Schildkröte"
FOM_WIND_SERPENT				= "Windnatter"
--	FOM_WOLF					= "Wolf"					-- same as enUS
FOM_DRAGONHAWK					= "Drachenfalke"			-- BC
FOM_NETHER_RAY					= "Netherrochen"			-- BC
FOM_RAVAGER						= "Felshetzer"				-- BC
FOM_SERPENT						= "Schlange"				-- BC
FOM_SPOREBAT					= "Sporensegler"			-- BC
FOM_WARP_STALKER				= "Sphärenjäger"			-- BC
FOM_BIRD_OF_PREY				= "Raubvogel"				-- WotLK
FOM_WASP						= "Wespe"					-- WotLK
FOM_CHIMAERA					= "Schimäre"				-- WotLK exotic
FOM_CORE_HOUND					= "Kernhund"				-- WotLK exotic
FOM_DEVILSAUR					= "Teufelssaurier"			-- WotLK exotic
FOM_MOTH						= "Motte"					-- WotLK
--	FOM_SILITHID				= "Silithid"				-- WotLK exotic; same as enUS
FOM_SPIRIT_BEAST				= "Geisterbestie"			-- WotLK exotic
FOM_WORM						= "Wurm"					-- WotLK exotic
FOM_DOG							= "Hund"                   -- Cataclysm
FOM_BEETLE						= "Käfer"                -- Cataclysm
FOM_SHALE_SPIDER				= "Schieferspinne"     -- Cataclysm exotic
FOM_FOX							= "Fuchs"                  -- Cataclysm
FOM_MONKEY						= "Affe"                   -- Cataclysm

-- FOM_BASILISK					= "Basilisk"				-- Mists, not translated in deDE
FOM_CLEFTHOOF					= "Grollhuf"				-- Warlords
FOM_CRANE						= "Kranich"					-- Mists
FOM_DIREHORN					= "Terrorhorn"				-- Warlords
FOM_GOAT						= "Ziege"					-- Mists
-- FOM_HYDRA						= "Hydra"					-- Warlords, not translated in deDE
FOM_MECHANICAL					= "Mechanisch"				-- Legion special
FOM_OXEN						= "Ochse"					-- Legion
FOM_PORCUPINE					= "Stachelschwein"			-- Mists
FOM_QUILEN						= "Qilen"					-- Mists exotic
FOM_RIVERBEAST					= "Flussbestie"				-- Warlords
-- FOM_RYLAK						= "Rylak"					-- Warlords, not translated in deDE
FOM_SCALEHIDE					= "Schuppenbalg"			-- Legion
FOM_STAG						= "Hirsch"					-- Warlords
FOM_WATER_STRIDER				= "Wasserschreiter"			-- Mists exotic

end

------------------------------------------------------

if (GetLocale() == "esES" or GetLocale() == "esMX") then

-- Diet names. These should be the seven possible diets returned from GetPetFoodTypes() and shown in the Pet tab of the character window (when mousing over the food icon). 
-- (Want to get them all nice and quick for your localization? Go tame a bear or boar... they eat anything.)
-- THESE STRINGS MUST BE LOCALIZED for Feed-O-Matic to work properly in other locales.
FOM_DIET_MEAT					= "Carne"
FOM_DIET_FISH					= "Pescado"
FOM_DIET_BREAD					= "Pan"
FOM_DIET_CHEESE					= "Queso"
FOM_DIET_FRUIT					= "Fruta"
FOM_DIET_FUNGUS					= "Hongo"

-- Beast family names; we use these to provide optional pet-specific feeding emotes (see FeedOMatic_Emotes.lua)
FOM_BAT							= "Murciélago"
FOM_BEAR						= "Oso"
FOM_BOAR						= "Jabalí"
FOM_CARRION_BIRD				= "Carroñero"
FOM_CAT							= "Felino"
FOM_CRAB						= "Cangrejo"
FOM_CROCOLISK					= "Crocolisco"
FOM_GORILLA						= "Gorila"
FOM_HYENA						= "Hiena"
--	FOM_RAPTOR					= "Raptor"					-- same as enUS
FOM_SCORPID						= "Escórpido"
FOM_SPIDER						= "Araña"
FOM_TALLSTRIDER					= "Zancaalta"
FOM_TURTLE						= "Tortuga"
FOM_WIND_SERPENT				= "Serpiente alada"
FOM_WOLF						= "Lobo"
FOM_DRAGONHAWK					= "Dracohalcón"				-- BC
FOM_NETHER_RAY					= "Raya abisal"				-- BC
FOM_RAVAGER						= "Devastador"				-- BC
FOM_SERPENT						= "Serpiente"				-- BC
FOM_SPOREBAT					= "Esporiélago"				-- BC
FOM_WARP_STALKER				= "Acechador deformado"		-- BC
FOM_BIRD_OF_PREY				= "Ave rapaz"				-- WotLK
FOM_WASP						= "Avispa"					-- WotLK
FOM_CHIMAERA					= "Quimera"					-- WotLK exotic
FOM_CORE_HOUND					= "Can del Núcleo"			-- WotLK exotic
FOM_DEVILSAUR					= "Demosaurio"				-- WotLK exotic
FOM_MOTH						= "Palomilla"				-- WotLK
FOM_SILITHID					= "Silítido"				-- WotLK exotic
FOM_SPIRIT_BEAST				= "Bestia espíritu"			-- WotLK exotic
FOM_WORM						= "Gusano"					-- WotLK exotic
FOM_DOG							= "Perro"                   -- Cataclysm
FOM_BEETLE						= "Alfazaque"                -- Cataclysm
FOM_SHALE_SPIDER				= "Araña de esquisto"     -- Cataclysm exotic
FOM_FOX							= "Zorro"                  -- Cataclysm
FOM_MONKEY						= "Mono"                   -- Cataclysm

FOM_BASILISK					= "Basilisco"				-- Mists
FOM_CLEFTHOOF					= "Uñagrieta"				-- Warlords
FOM_CRANE						= "Grulla"					-- Mists
FOM_DIREHORN					= "Cuernoatroz"				-- Warlords
FOM_GOAT						= "Cabra"					-- Mists
FOM_HYDRA						= "Hidra"					-- Warlords
FOM_MECHANICAL					= "Máquina"					-- Legion special
FOM_OXEN						= "Buey"					-- Legion
FOM_PORCUPINE					= "Puercoespín"				-- Mists
-- FOM_QUILEN						= "Quilen"					-- Mists exotic, not translated in es
FOM_RIVERBEAST					= "Bestia fluvial"			-- Warlords
-- FOM_RYLAK						= "Rylak"					-- Warlords, not translated in es
FOM_SCALEHIDE					= "Pielescama"				-- Legion
FOM_STAG						= "Venado"					-- Warlords
FOM_WATER_STRIDER				= "Zancudo acuático"			-- Mists exotic

end

------------------------------------------------------

if (GetLocale() == "ruRU") then

-- Diet names. These should be the seven possible diets returned from GetPetFoodTypes() and shown in the Pet tab of the character window (when mousing over the food icon). 
-- (Want to get them all nice and quick for your localization? Go tame a bear or boar... they eat anything.)
-- THESE STRINGS MUST BE LOCALIZED for Feed-O-Matic to work properly in other locales.
FOM_DIET_MEAT					= "Мясо"
FOM_DIET_FISH					= "Рыба"
FOM_DIET_BREAD					= "Хлеб"
FOM_DIET_CHEESE					= "Сыр"
FOM_DIET_FRUIT					= "Фрукты"
FOM_DIET_FUNGUS					= "Грибы"

-- Beast family names; we use these to provide optional pet-specific feeding emotes (see FeedOMatic_Emotes.lua)
FOM_BAT							= "Летучая мышь"
FOM_BEAR						= "Медведь"
FOM_BOAR						= "Вепрь"
FOM_CARRION_BIRD				= "Падальщик"
FOM_CAT							= "Кошка"
FOM_CRAB						= "Краб"
FOM_CROCOLISK					= "Кроколиск"
FOM_GORILLA						= "Горилла"
FOM_HYENA						= "Гиена"
FOM_RAPTOR						= "Ящер"
FOM_SCORPID						= "Скорпид"
FOM_SPIDER						= "Паук"
FOM_TALLSTRIDER					= "Долгоног"
FOM_TURTLE						= "Черепаха"
FOM_WIND_SERPENT				= "Крылатый змей"
FOM_WOLF						= "Волк"
FOM_DRAGONHAWK					= "Дракондор"				-- BC
FOM_NETHER_RAY					= "Скат Пустоты"			-- BC
FOM_RAVAGER						= "Опустошитель"			-- BC
FOM_SERPENT						= "Змей"					-- BC
FOM_SPOREBAT					= "Спороскат"				-- BC
FOM_WARP_STALKER				= "Прыгуана"				-- BC
FOM_BIRD_OF_PREY				= "Сова"					-- WotLK
FOM_WASP						= "Оса"						-- WotLK
FOM_CHIMAERA					= "Химера"					-- WotLK exotic
FOM_CORE_HOUND					= "Пес недр"				-- WotLK exotic
FOM_DEVILSAUR					= "Девизавр"				-- WotLK exotic
FOM_MOTH						= "Мотылек"					-- WotLK exotic
FOM_SILITHID					= "Силитид"					-- WotLK exotic
FOM_SPIRIT_BEAST				= "Дух зверя"				-- WotLK exotic
FOM_WORM						= "Червь"					-- WotLK exotic
FOM_DOG							= "Собака"                   -- Cataclysm
FOM_BEETLE						= "Жук"                -- Cataclysm
FOM_SHALE_SPIDER				= "Сланцевый паук"     -- Cataclysm exotic
FOM_FOX							= "Лисица"                  -- Cataclysm
FOM_MONKEY						= "Обезьяна"                   -- Cataclysm

FOM_BASILISK					= "Василиск"				-- Mists
FOM_CLEFTHOOF					= "Копытень"				-- Warlords
FOM_CRANE						= "Журавль"					-- Mists
FOM_DIREHORN					= "Дикорог"					-- Warlords
FOM_GOAT						= "Козел"					-- Mists
FOM_HYDRA						= "Гидра"					-- Warlords
FOM_MECHANICAL					= "Механизм"				-- Legion special
FOM_OXEN						= "Быки"					-- Legion
FOM_PORCUPINE					= "Дикобраз"				-- Mists
FOM_QUILEN						= "Цийлинь"					-- Mists exotic
FOM_RIVERBEAST					= "Речное чудище"			-- Warlords
FOM_RYLAK						= "Рилак"					-- Warlords
FOM_SCALEHIDE					= "Чешуйчатая Шкура"		-- Legion
FOM_STAG						= "Олень"					-- Warlords
FOM_WATER_STRIDER				= "Водный долгоног"			-- Mists exotic

end

------------------------------------------------------

if (GetLocale() == "koKR") then

-- Diet names. These should be the seven possible diets returned from GetPetFoodTypes() and shown in the Pet tab of the character window (when mousing over the food icon). 
-- (Want to get them all nice and quick for your localization? Go tame a bear or boar... they eat anything.)
-- THESE STRINGS MUST BE LOCALIZED for Feed-O-Matic to work properly in other locales.
FOM_DIET_MEAT					= "고기"
FOM_DIET_FISH					= "생선"
FOM_DIET_BREAD					= "빵"
FOM_DIET_CHEESE					= "치즈"
FOM_DIET_FRUIT					= "과일"
FOM_DIET_FUNGUS					= "버섯"

-- Beast family names; we use these to provide optional pet-specific feeding emotes (see FeedOMatic_Emotes.lua)
FOM_BAT							= "박쥐"
FOM_BEAR						= "곰"
FOM_BIRD_OF_PREY				= "올빼미"        	-- WotLK
FOM_BOAR						= "멧돼지"                	
FOM_CARRION_BIRD				= "독수리"        	
FOM_CAT							= "살쾡이"                 	
FOM_CHIMAERA					= "키메라"            	-- WotLK exotic
FOM_CORE_HOUND					= "심장부 사냥개"          	-- WotLK exotic
FOM_CRAB						= "게"                	
FOM_CROCOLISK					= "악어"           	
FOM_DEVILSAUR					= "데빌사우르스"           	-- WotLK exotic
FOM_DRAGONHAWK					= "용매"          	-- BC
FOM_GORILLA						= "고릴라"             	
FOM_HYENA						= "하이에나"               	
FOM_MOTH						= "나방"                	-- WotLK exotic
FOM_NETHER_RAY					= "황천의 가오리"          	-- BC
FOM_RAPTOR						= "랩터"              	
FOM_RAVAGER						= "갈퀴발톱"             	-- BC
FOM_SCORPID						= "전갈"             	
FOM_SERPENT						= "살무사"             	-- BC
FOM_SILITHID					= "실리시드"            	-- WotLK exotic
FOM_SPIDER						= "거미"              	
FOM_SPIRIT_BEAST				= "영혼의 야수"        	-- WotLK exotic
FOM_SPOREBAT					= "포자날개"            	-- BC
FOM_TALLSTRIDER					= "타조"         	
FOM_TURTLE						= "거북이"              	
FOM_WARP_STALKER				= "차원의 추적자"			-- BC
FOM_WASP						= "말벌"                	-- WotLK
FOM_WIND_SERPENT				= "천둥매"        	
FOM_WOLF						= "늑대"                	
FOM_WORM						= "벌레"					-- WotLK exotic
FOM_SHALE_SPIDER				= "혈암거미"				-- Cataclysm exotic
FOM_MONKEY						= "원숭이"				-- Cataclysm
FOM_FOX							= "여우"					-- Cataclysm
FOM_DOG							= "개"					-- Cataclysm
FOM_BEETLE						= "딱정벌레"				-- Cataclysm
FOM_BASILISK					= "바실리스크"				-- Mists
FOM_CLEFTHOOF					= "갈래발굽"				-- Warlords
FOM_CRANE						= "학"					-- Mists
FOM_DIREHORN					= "공포뿔"				-- Warlords
FOM_GOAT						= "염소"					-- Mists
FOM_HYDRA						= "히드라"				-- Warlords
FOM_MECHANICAL					= "기계"					-- Legion special
FOM_OXEN						= "소"					-- Legion
FOM_PORCUPINE					= "호저"					-- Mists
FOM_QUILEN						= "기렌"					-- Mists exotic
FOM_RIVERBEAST					= "강물하마"				-- Warlords
FOM_RYLAK						= "라일라크"				-- Warlords
FOM_SCALEHIDE					= "비늘가죽"				-- Legion
FOM_STAG						= "순록"					-- Warlords
FOM_WATER_STRIDER				= "소금쟁이"				-- Mists exotic

end

------------------------------------------------------

if (GetLocale() == "zhTW") then

-- Diet names. These should be the seven possible diets returned from GetPetFoodTypes() and shown in the Pet tab of the character window (when mousing over the food icon). 
-- (Want to get them all nice and quick for your localization? Go tame a bear or boar... they eat anything.)
-- THESE STRINGS MUST BE LOCALIZED for Feed-O-Matic to work properly in other locales.
FOM_DIET_MEAT					= "肉"
FOM_DIET_FISH					= "魚"
FOM_DIET_BREAD					= "麵包"
FOM_DIET_CHEESE					= "乳酪"
FOM_DIET_FRUIT					= "水果"
FOM_DIET_FUNGUS					= "蘑菇"

-- Beast family names; we use these to provide optional pet-specific feeding emotes (see FeedOMatic_Emotes.lua)
FOM_BAT							= "蝙蝠"                       
FOM_BEAR						= "熊"                    
FOM_BOAR						= "野豬"                   
FOM_CARRION_BIRD				= "禿鷹"           
FOM_CAT							= "貓"                        
FOM_CRAB						= "螃蟹"                   
FOM_CROCOLISK					= "鱷魚"               
FOM_GORILLA						= "猩猩"                   
FOM_HYENA						= "土狼"                   
FOM_OWL							= "貓頭鷹"                      
FOM_RAPTOR						= "迅猛龍"                  
FOM_SCORPID						= "蠍子"                   
FOM_SPIDER						= "蜘蛛"                   
FOM_TALLSTRIDER					= "陸行鳥"              
FOM_TURTLE						= "烏龜"                   
FOM_WIND_SERPENT				= "風蛇"           
FOM_WOLF						= "狼"                    
FOM_DRAGONHAWK					= "龍鷹"					-- BC
FOM_NETHER_RAY					= "虛空鰭刺"				-- BC
FOM_RAVAGER						= "破壞者"				-- BC
FOM_SERPENT						= "毒蛇"					-- BC
FOM_SPOREBAT					= "孢子蝙蝠"				-- BC
FOM_WARP_STALKER				= "扭曲行者"				-- BC
FOM_WORM						= "蠕虫"					-- WotLK exotic
FOM_SPIRIT_BEAST				= "灵魂兽"        		-- WotLK exotic
FOM_WASP						= "巨蜂"                	-- WotLK
FOM_SILITHID					= "异种虫"            	-- WotLK exotic
FOM_MOTH						= "蛾子"                	-- WotLK exotic
FOM_DEVILSAUR					= "魔暴龙"           	-- WotLK exotic
FOM_CHIMAERA					= "奇美拉"            	-- WotLK exotic
FOM_CORE_HOUND					= "熔岩犬"        	  	-- WotLK exotic
FOM_BIRD_OF_PREY				= "猛禽"      		  	-- WotLK
FOM_SHALE_SPIDER				= "页岩蛛"				-- Cataclysm exotic
FOM_MONKEY						= "猴子"					-- Cataclysm
FOM_FOX							= "狐狸"					-- Cataclysm
FOM_DOG							= "狗"					-- Cataclysm
FOM_BEETLE						= "甲虫"					-- Cataclysm
FOM_BASILISK					= "石化蜥蜴"				-- Mists
FOM_CLEFTHOOF					= "裂蹄牛"				-- Warlords
FOM_CRANE						= "鹤"					-- Mists
FOM_DIREHORN					= "恐角龙"				-- Warlords
FOM_GOAT						= "山羊"					-- Mists
FOM_HYDRA						= "九头蛇"				-- Warlords
FOM_MECHANICAL					= "机械"					-- Legion special
FOM_OXEN						= "牛"					-- Legion
FOM_PORCUPINE					= "箭猪"					-- Mists
FOM_QUILEN						= "魁麟"					-- Mists exotic
FOM_RIVERBEAST					= "淡水兽"				-- Warlords
FOM_RYLAK						= "双头飞龙"				-- Warlords
FOM_SCALEHIDE					= "鳞甲类"				-- Legion
FOM_STAG						= "雄鹿"					-- Warlords
FOM_WATER_STRIDER				= "水黾"					-- Mists exotic

end

if (GetLocale() == "zhCN") then

-- Diet names. These should be the seven possible diets returned from GetPetFoodTypes() and shown in the Pet tab of the character window (when mousing over the food icon). 
-- (Want to get them all nice and quick for your localization? Go tame a bear or boar... they eat anything.)
-- THESE STRINGS MUST BE LOCALIZED for Feed-O-Matic to work properly in other locales.
FOM_DIET_MEAT					= "肉"
FOM_DIET_FISH					= "鱼"
FOM_DIET_BREAD					= "面包"
FOM_DIET_CHEESE					= "奶酪"
FOM_DIET_FRUIT					= "水果"
FOM_DIET_FUNGUS					= "蘑菇"

-- Beast family names; we use these to provide optional pet-specific feeding emotes (see FeedOMatic_Emotes.lua)
FOM_BAT							= "蝙蝠"                       
FOM_BEAR						= "熊"                    
FOM_BOAR						= "野猪"                   
FOM_CARRION_BIRD				= "秃鹰"           
FOM_CAT							= "猫"                        
FOM_CRAB						= "螃蟹"                   
FOM_CROCOLISK					= "鳄鱼"               
FOM_GORILLA						= "猩猩"                   
FOM_HYENA						= "土狼"                   
FOM_OWL							= "猫头鹰"                      
FOM_RAPTOR						= "迅猛龙"                  
FOM_SCORPID						= "蝎子"                   
FOM_SPIDER						= "蜘蛛"                   
FOM_TALLSTRIDER					= "陆行鸟"              
FOM_TURTLE						= "乌龟"                   
FOM_WIND_SERPENT				= "风蛇"           
FOM_WOLF						= "狼"                    
FOM_DRAGONHAWK					= "龙鹰"					-- BC
FOM_NETHER_RAY					= "虚空鳍刺"				-- BC
FOM_RAVAGER						= "破坏者"				-- BC
FOM_SERPENT						= "毒蛇"					-- BC
FOM_SPOREBAT					= "孢子蝙蝠"				-- BC
FOM_WARP_STALKER				= "扭曲行者"				-- BC
FOM_WORM						= "蠕虫"					-- WotLK exotic
FOM_SPIRIT_BEAST				= "灵魂兽"        		-- WotLK exotic
FOM_WASP						= "巨蜂"                	-- WotLK
FOM_SILITHID					= "异种虫"            	-- WotLK exotic
FOM_MOTH						= "蛾子"                	-- WotLK exotic
FOM_DEVILSAUR					= "魔暴龙"           	-- WotLK exotic
FOM_CHIMAERA					= "奇美拉"            	-- WotLK exotic
FOM_CORE_HOUND					= "熔岩犬"        	  	-- WotLK exotic
FOM_BIRD_OF_PREY				= "猛禽"      		  	-- WotLK
FOM_SHALE_SPIDER				= "页岩蛛"				-- Cataclysm exotic
FOM_MONKEY						= "猴子"					-- Cataclysm
FOM_FOX							= "狐狸"					-- Cataclysm
FOM_DOG							= "狗"					-- Cataclysm
FOM_BEETLE						= "甲虫"					-- Cataclysm
FOM_BASILISK					= "石化蜥蜴"				-- Mists
FOM_CLEFTHOOF					= "裂蹄牛"				-- Warlords
FOM_CRANE						= "鹤"					-- Mists
FOM_DIREHORN					= "恐角龙"				-- Warlords
FOM_GOAT						= "山羊"					-- Mists
FOM_HYDRA						= "九头蛇"				-- Warlords
FOM_MECHANICAL					= "机械"					-- Legion special
FOM_OXEN						= "牛"					-- Legion
FOM_PORCUPINE					= "箭猪"					-- Mists
FOM_QUILEN						= "魁麟"					-- Mists exotic
FOM_RIVERBEAST					= "淡水兽"				-- Warlords
FOM_RYLAK						= "双头飞龙"				-- Warlords
FOM_SCALEHIDE					= "鳞甲类"				-- Legion
FOM_STAG						= "雄鹿"					-- Warlords
FOM_WATER_STRIDER				= "水黾"					-- Mists exotic

end