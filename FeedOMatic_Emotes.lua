FOM_Emotes = {};

FOM_Emotes.enUS = {

	["any"] = {	-- emotes for any pet (don't localize this line!)
		"Yum!",
		"Mmm, good stuff.",
		"Hey! Watch the fingers!",
		"Om nom nom nom...",
		"One gulp and it's gone!",
		"Mmm, delicious.",
		"Burp!",
		"Yay, bag space!",
	},

	["male"] = { -- emotes for any male pet (don't localize this line!)
		"Good boy!",
		"Atta boy!",
		"No more Mister Grumpy!",
	},
	["female"] = { -- emotes for any female pet (don't localize this line!)
		"Good girl!",
		"Atta girl!",
		"No more Miss Grumpy!",
	},

	-- emotes for when eating specific foods
	-- number on first line is itemID (use an addon or Wowhead to find it)
	[7974] = {	-- Zesty Clam Meat
		"Mmm, zesty!",
	},
	[12037] = {	-- Mystery Meat
		"Tastes like chicken.",
		"Tastes like tallstrider!",
		"Tastes like well-aged gnome.",
		"Tastes like... spider?",
	},
	[44072] = {	-- Roasted Mystery Beast
		"Tastes like chicken.",
		"Tastes like tallstrider!",
		"Tastes like well-aged gnome.",
		"Tastes like... spider?",
	},
	[59232] = {	-- Unidentifiable Meat Dish
		"Tastes like chicken.",
		"Tastes like tallstrider!",
		"Tastes like well-aged gnome.",
		"Tastes like... spider?",
	},
	[12217] = { -- Dragonbreath Chili
		"Yow, spicy!",
	},
	[4538] = { -- Snapvine Watermelon
		"What a big mouth!",
	},
	[8950] = { -- Homemade Cherry Pie
		"Tastes so good, makes a grown man cry.",
	},
	[27659] = { -- Warp Burger
		"Now how about some Nether Ray Fries?",
	},
	[41808] = { -- Bonescale Snapper
		"Crunchy!",
	},
	[41814] = { -- Glassfin Minnnow
		"Can has bigger fish?",
	},
	[43647] = { -- Shimmering Minnow
		"Can has bigger fish?",
	},

	-- emotes for categories of items
	-- use keys from LibPeriodicTable's Consumable.Food section
	-- TODO: need a PT-less way to key on both food diet and what we now call food type
	-- ["Consumable.Food.Edible.Bread.Conjured"] = {
	-- 	"Tastes great, less filling!",
	-- },
	-- ["Consumable.Food.Edible.Bread.Combo.Conjured"] = {
	-- 	"Tastes great, less filling!",
	-- },
	-- ["Consumable.Food.Inedible.Fish"] = {
	-- 	"Mmm, sashimi!",
	-- },

	-- emotes for entire diets
	[FOM_DIET_FUNGUS] = {
		"Trippy...",
	},

	-- emotes for specific pet families
	-- use keys from localization.lua
	[FOM_BOAR] = {
		"Good piggy!"
	},
	[FOM_CAT] = {
		"Nice kitty!",
	},
	[FOM_HYENA] = {
		"Good dog!",
	},
	[FOM_WOLF] = {
		"Good dog!",
	},
	[FOM_SPIDER] = {
		"Do you really have to wrap it up before eating it?",
	},
	[FOM_RAPTOR] = {
		"Down, dino!",
	},
	[FOM_DEVILSAUR] = {
		"Down, dino!",
	},
	[FOM_CROCOLISK] = {
		"Crikey, it snapped that up fast!",
	},
	[FOM_CORE_HOUND] = {
		"What a good little puppy!",
		"Aww, they're sharing.",
		"Hey, don't fight over it!",
	},
	[FOM_CHIMAERA] = {
		"Hey, don't fight over it!",
	},



};

FOM_Emotes.esES = {

	["any"] = {	-- emotes for any pet (don't localize this line!)
		"¡Ñam!",
		"Mmm, está rico.",
		"¡Ehh! ¡Cuidado con mis dedos!",
		"Om nom nom nom...",
		"¡Un mordisco y listo!",
		"Mmm, delicioso.",
		"¡Gurps!",
	},

	["male"] = { -- emotes for any male pet (don't localize this line!)
		"¡Buen chico!",
	},
	["female"] = { -- emotes for any female pet (don't localize this line!)
		"¡Buena chica!",
	},

	-- emotes for when eating specific foods
	-- number on first line is itemID (use an addon or Wowhead to find it)
	[7974] = {	-- Zesty Clam Meat
		"¡Mmm, sabrosa!",
	},
	[12037] = {	-- Mystery Meat
		"Sabe a pollo.",
		"¡Sabe a zancudo!",
		"Sabe a gnomo viejo.",
		"Sabe a... ¿araña?",
	},
	[12217] = { -- Dragonbreath Chili
		"¡Guau, picante!",
	},
	[4538] = { -- Snapvine Watermelon
		"¡Vaya bocaza!",
	},


	-- emotes for specific pet families
	-- use keys from localization.lua
	[FOM_BOAR] = {
		"¡Buen cerdito!"
	},
	[FOM_CAT] = {
		"¡Buen gatito!",
	},
	[FOM_HYENA] = {
		"¡Buen perro!",
	},
	[FOM_WOLF] = {
		"¡Buen perro!",
	},
	[FOM_RAPTOR] = {
		"¡Abajo, dino!",
	},
	[FOM_DEVILSAUR] = {
		"¡Abajo, dino!",
	},
	[FOM_CORE_HOUND] = {
		"¡Qué chiquitín más bueno!",
	},

};
FOM_Emotes.esMX = FOM_Emotes.esES;

FOM_Emotes.frFR = {

	["any"] = {	-- emotes for any pet (don't localize this line!)
		"Miam!",
		"Mmm, bonne bouffe.",
		"Hey! attention \195\160 mes doigts!",
		"Hum gloup gloup gloup gloup...",
		"Encore une bouchée et ca ira!",
		"Mmm, d\195\169licieux.",
		"Burp!",
		"Oui, un peu plus de place dans le sac!",
	},

	["male"] = { -- emotes for any male pet (don't localize this line!)
		"Bon gar\195\167on!",
		"Attrape gar\195\167on!",
		"Pas plus monsieur le goinfre!",
	},
	["female"] = { -- emotes for any female pet (don't localize this line!)
		"Bonne fille!",
		"Attrape ma fille!",
		"Pas plus madame la goinfre!",
	},

	-- emotes for when eating specific foods
	-- number on first line is itemID (use an addon or Wowhead to find it)
	[7974] = {	-- Zesty Clam Meat
		"Mmm, du crabe!",
	},
	[12037] = {	-- Mystery Meat
		"Ca a un gout de poulet.",
		"Ca a un gout bouillie pour b\195\169b\195\169!",
		"Ca a un gout de vieux gnome!",
		"Ca a un gout d'... araign\195\169e?",
	},
	[12217] = { -- Dragonbreath Chili
		"La vache, c'est \195\169pic\195\169!",
	},
	[4538] = { -- Snapvine Watermelon
		"Quelle grande bouche!",
	},
	[8950] = { -- Homemade Cherry Pie
		"C'est si bon, ca en ferait hurler un muet.",
	},
	[41808] = { -- Bonescale Snapper
		"Crrrrrr!",
	},
	[41814] = { -- Glassfin Minnnow
		"On dirait de la friture, T'as pas un plus gros poisson?",
	},
	[43647] = { -- Shimmering Minnow
		"On dirait de la friture, T'as pas un plus gros poisson?",
	},


	-- emotes for specific pet families
	-- use keys from localization.lua
	[FOM_BOAR] = {
		"Bon cochon!"
	},
	[FOM_CAT] = {
		"Bon minou!",
	},
	[FOM_HYENA] = {
		"Bon chien!",
	},
	[FOM_WOLF] = {
		"Bon chien!",
	},
	[FOM_SPIDER] = {
		"Tu veux vraiment le recouvrir de bave avant de manger \195\167a ?",
	},
	[FOM_RAPTOR] = {
		"Baisse toi, dino!",
	},
	[FOM_DEVILSAUR] = {
		"Baisse toi, dino!",
	},
	[FOM_CROCOLISK] = {
		"Mange pas si vite satan\195\169 croco!",
	},
	[FOM_CORE_HOUND] = {
		"C'est une bonne petite b\195\170te \195\167a !",
		"Ho, faut savoir partager.",
		"Hey, combats pas sans \195\167a!",
	},
	[FOM_CHIMAERA] = {
		"Hey, combats pas sans \195\167a!",
	},

};

FOM_Emotes.koKR = {

	["any"] = {	-- emotes for any pet (don't localize this line!)
		"얌얌!",
		"음~, 맛나네요.",
		"손가락 핥지마!",
		"이 보잘 것 없는 먹이로 얼마나 버틸성 싶으냐!",
		"내것도 좀 남겨놔라!",
		"먹어봐라, 이 집은 이게 죽여준다.",
		"꺼억~!",
		"어예~, 가방 한칸 빈다!",
	},

	["male"] = { -- emotes for any male pet (don't localize this line!)
		"잘했어!",
		"남기지마 시키야!",
		"이 보잘 것 없는 먹이로 얼마나 버틸성 싶으냐!",
	},
	["female"] = { -- emotes for any female pet (don't localize this line!)
		"잘했어!",
		"착하네!",
		"이 보잘 것 없는 먹이로 얼마나 버틸성 싶으냐!",
	},

	-- emotes for when eating specific foods
	-- number on first line is itemID (use an addon or Wowhead to find it)
	[7974] = {	-- Zesty Clam Meat
		"톡 쏘는군요!",
	},
	[12037] = {	-- Mystery Meat
		"닭고기 같기도 하고...",
		"타조 맛이지?!",
		"늙은 노움 맛 날거야.",
		"음..맛이...거미같나?",
	},
	[44072] = {	-- Roasted Mystery Beast
		"닭고기 같기도 하고...",
		"타조 맛이지?!",
		"늙은 노움 맛 날거야.",
		"음..맛이...거미같나?",
	},
	[12217] = { -- Dragonbreath Chili
		"와우! 화끈하구나!",
	},
	[4538] = { -- Snapvine Watermelon
		"입 크게 벌려!",
	},
	[8950] = { -- Homemade Cherry Pie
		"사나이 울리는 체리파이.",
	},
	[27659] = { -- Warp Burger
		"다음엔 가오리 튀김으로?",
	},
	[41808] = { -- Bonescale Snapper
		"아삭아삭하네!",
	},
	[41814] = { -- Glassfin Minnnow
		"좀 더 큰걸로 줘?",
	},
	[43647] = { -- Shimmering Minnow
		"좀 더 큰걸로 줘?",
	},

	-- emotes for categories of items
	-- use keys from LibPeriodicTable's Consumable.Food section
	["Consumable.Food.Edible.Bread.Conjured"] = {
		"맛은 좋은데 양이 좀 부족하네!",
	},
	["Consumable.Food.Edible.Bread.Combo.Conjured"] = {
		"맛있지? 좀 더줘?",
	},
	["Consumable.Food.Inedible.Fish"] = {
		"크~, 생수엔 역시 회가 최고!",
	},
	["Consumable.Food.Fungus"] = {
		"몽롱하네요...",
	},

	-- emotes for specific pet families
	-- use keys from localization.lua
	[FOM_BOAR] = {
		"잘했어 뚱띠!"
	},
	[FOM_CAT] = {
		"착하다 야옹이!",
	},
	[FOM_HYENA] = {
		"잘먹네, 우리 메리해피도꾸워리쫑!",
	},
	[FOM_WOLF] = {
		"잘먹네, 우리 메리해피도꾸워리쫑!",
	},
	[FOM_SPIDER] = {
		"먹기전에 꼭 거미줄로 감아야 되?",
	},
	[FOM_RAPTOR] = {
		"맛있냐!",
	},
	[FOM_DEVILSAUR] = {
		"맛있냐!",
	},
	[FOM_CROCOLISK] = {
		"깨물어! 깨물어!",
	},
	[FOM_CORE_HOUND] = {
		"착하네, 우리 메리해피도꾸워리쫑!",
		"머리가 둘이라고 반씩 노나 먹냐.",
		"먹이 갖고 싸우지 마라!",
	},
	[FOM_CHIMAERA] = {
		"그만 날고 얼른 먹어!",
	},



};

FOM_Emotes.ruRU = {

	["any"] = {	-- emotes for any pet (don't localize this line!)
		"О да!",
		"Ммм, хороша з....а.",
		"Эээ! Осторожно, пальцы!",
		"Ам ням ням ням...",
		"Прогладил всё, сразу, не разжевывая!",
		"Ммм, восхитительно.",
		"Отрыгивает!",
		"Чумааа!",
	},

	["male"] = { -- emotes for any male pet (don't localize this line!)
		"Хороший мальчик!",
		"Ах ты май малыш!",
		"Молодчина!",
	},
	["female"] = { -- emotes for any female pet (don't localize this line!)
		"Хорошая девочка!",
		"Ух ты мая малышка!",
		"Умница!",
	},

	-- emotes for when eating specific foods
	-- number on first line is itemID (use an addon or Wowhead to find it)
	[7974] = {	-- Zesty Clam Meat
		"Ммм, Острое!",
	},
	[12037] = {	-- Mystery Meat
		"На вкус как курица.",
		"На вкус как долгоног!",
		"На вкус как гном переросток.",
		"На вкус как... паук?",
	},
	[44072] = {	-- Roasted Mystery Beast
		"На вкус как курица.",
		"На вкус как долгоног!",
		"На вкус как гном переросток.",
		"На вкус как... паук?",
	},
	[12217] = { -- Dragonbreath Chili
		"Уф, и в правду Дыхание дракона!",
	},
	[4538] = { -- Snapvine Watermelon
		"Какой большой рот!",
	},
	[8950] = { -- Homemade Cherry Pie
		"На вкус не плохо, вот бы начинки побольше.",
	},
	[27659] = { -- Warp Burger
		"А что насчет запеченых Скатов Пустоты?",
	},
	[41808] = { -- Bonescale Snapper
		"Хрущащий!",
	},
	[41814] = { -- Glassfin Minnnow
		"Может есть рыбешка побольше?",
	},
	[43647] = { -- Shimmering Minnow
		"Может есть рыбешка побольше?",
	},

	-- emotes for categories of items
	-- use keys from LibPeriodicTable's Consumable.Food section
	["Consumable.Food.Edible.Bread.Conjured"] = {
		"Вкус так се, могло быть и по лучше!",
	},
	["Consumable.Food.Edible.Bread.Combo.Conjured"] = {
		"Вкус так се,могло быть и по лучше!",
	},
	["Consumable.Food.Inedible.Fish"] = {
		"Ммм, сашими! А роллов с рыбкой нету?",
	},
	["Consumable.Food.Fungus"] = {
		"Странный вкус...",
	},

	-- emotes for specific pet families
	-- use keys from localization.lua
	[FOM_BOAR] = {
		"Хорошая свинка!",
	},
	[FOM_CAT] = {
		"Славная киска!",
	},
	[FOM_HYENA] = {
		"Хороший пёсик!",
	},
	[FOM_WOLF] = {
		"Хороший пёсик!",
	},
	[FOM_SPIDER] = {
		"Ты серьёзна бедешь окутывать это перед едой?",
	},
	[FOM_RAPTOR] = {
		"Пригнись, дино!",
	},
	[FOM_DEVILSAUR] = {
		"Пригнись, дино!",
	},
	[FOM_CROCOLISK] = {
		"Ну надо же, как быстро слопал!",
	},
	[FOM_CORE_HOUND] = {
		"Хороший маленький щеночек!",
		"Да, вот значит как они делятся.",
		"Эй вы оба, не деритесь!",
	},
	[FOM_CHIMAERA] = {
		"Эй вы оба, не деритесь!",
	},

};