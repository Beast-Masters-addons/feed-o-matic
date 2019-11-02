------------------------------------------------------
Fizzwidget Feed-O-Matic
by Gazmik Fizzwidget
http://fizzwidget.com
gazmik@fizzwidget.com
------------------------------------------------------

As my Hunter friends can readily attest, keeping a wild pet can be a full-time job. Why, just feeding the critter when he gets hungry can throw off your routine -- you've got to rummage around in your bags, find a piece of food, make sure it's appropriate for his diet, and check your aim before tossing it to him (lest you accidentally destroy a tasty morsel). So inconvenient! Not to mention potentially dangerous... you don't want to spend so long digging through your bags that you or your pet become someone else's snack.

Never fear, Gazmik Fizzwidget is here with a new gadget to automate all your pet-food-management tasks! My incredible Feed-O-Matic features state-of-the-art nutritional analyzers to make sure your pet's hunger is satisfied with a minimum of fuss, advanced selective logic to make your pet doesn't eat anything you have another use for, and a weight optimizer to make sure the food in your bags stays well organized! Just press the "Feed Now" button and it'll intelligently choose a food and accurately toss it to your pet. This is actually one of the first gizmos I started work on... but because I'm a perfectionist I haven't considered it ready for release until now.

------------------------------------------------------

INSTALLATION: Put the GFW_FeedOmatic folder into your World Of Warcraft/Interface/AddOns folder and launch WoW.

USAGE:
Makes feeding your pet quick, easy, and fun:
	- Bind a key to "Feed Pet", and Feed-O-Matic will automatically choose an appropriate food and give it to the pet whenever you press it. 
	- Alternately, Feed-O-Matic creates a button next to the default UI's pet frame -- click this button to feed the pet.
	- Can use an emote to notify you when it's feeding your pet, with custom randomized messages. See FeedOMatic_Emotes.lua to customize them to your characters!

Helps you manage all the pet food in your inventory:
	- Keeps track of which foods your pet likes more, and prioritizes "better" foods when choosing what to feed the pet. Also makes sure not to use foods your pet has "outgrown" or foods not appropriate to your species of pet.
	- If you're on a quest to collect several of a certain item which also happens to be something your pet likes to eat, Feed-O-Matic can avoid consuming it. (Unless you're carrying more than is needed for the quest or there's nothing else for your pet to eat.)
	- Manages four major categories of foods: Conjured food (free if you befriend a mage), Basic food (just restores health; found at many vendors), "Well Fed" food (has bonus effects when you eat it; often comes from cooking), and Raw food (things that aren't edible for you, but are for your pet; often used as cooking ingredients). Feed-O-Matic looks for food in this order (Conjured, Basic, Well Fed, then Raw), to prioritize the food that's cheapest (both in terms of cost to you and potential usefulness). You can use the Feed-O-Matic Options panel to avoid feeding your pet entire categories of food, or to avoid just specific foods.
	- Feed-O-Matic keeps track of what foods are used by Cooking recipes. The Feed-O-Matic Options panel shows which foods are ingredients for which recipes, so you can choose to avoid feeding things to your pet that you'd rather cook for yourself.
	- All other things being equal, Feed-O-Matic will try to pick foods from smaller stacks, making sure your food supply doesn't take up all your bag space. When your bags get close to full, Feed-O-Matic will start ignoring other criteria and always choosing the smallest stack so that you won't run out of inventory sooner.

CHAT COMMANDS:
	`/feedomatic` (or `/fom` or `/feed`) - Show the Options window.
or:
	`/feedomatic` (or `/fom` or `/feed`) <command>
where <command> can be any of the following:
	`help` - Print this helplist.
	`reset` - Reset to default settings.

CAVEATS, ETC.: 
	- Feed-O-Matic uses a database of many known foods, but it's not guaranteed to be comprehensive. (Please drop me a line if you find a food that should be on there, or discover that something on the list shouldn't be there or is listed as the wrong food type.) 
	- Feed-O-Matic gets its list of Cooking recipes the first time you open your Cooking window. Until then, the Feed-O-Matic Options panel won't show whether foods are used in Cooking. 
	- Feed-O-Matic's feed button is attached to the default UI's pet frame. Other addons can remove its functionality by removing that frame -- however, many such alternate UIs offer the ability to set custom macro actions for their frames. If your UI allows such, setting a button's action to `/click FOM_FeedButton` will allow clicking it to invoke Feed-O-Matic's pet-feeding action.

------------------------------------------------------
VERSION HISTORY

v. 9.0 - 2019/11/02
- Added support for WoW Classic
- Updated TOC to indicate compatibility with WoW Patch 8.2.5
- Show feed button when using Z-perl unit frames
- Open the correct settings page at first attempt

v. 8.0 - 2018/08/08
- Updated to support WoW Patch 8.0. 
- Added Battle for Azeroth foods. (For many new foods, the category/diet is an untested guess. If you encounter issues, please send feedback at https://github.com/fizzwidget/feed-o-matic/issues.)
- No longer treats Gearspring Parts as edible by Mechanical pets.

v. 7.0.2 - 2016/09/20
- Returned the ability to show in Feed-O-Matic's Options panel which foods are used in Cooking recipes (and which recipes each is an ingredient for).
- WoW Patch 7.0 removed the UI for showing your pet's diet. You could cast Beast Lore on your pet to find out, but that's a pain... so now Feed-O-Matic shows you. You'll find a list of the food types your pet can eat both in the tooltip for the feed button and in the tooltip for "show only foods my pet can eat" in the Options panel.
- Tooltips for pet-food items show which pet food type a food belongs to.

v. 7.0.1 - 2016/08/29
- Added support for Mechanical pets in 7.0/Legion. The "mechanical bits" food list is partly guesswork -- please send feedback if you see any issues.
- Updated locale support: You can now add custom emotes in FeedOMatic_Emotes.lua for Mists, Warlords, and Legion beasts, and in all WoW languages including Chinese, Korean, and Italian.

v. 7.0 - 2016/08/27 - Dedicated to Mania of www.wow-petopia.com
- Updated to support WoW Patch 7.0 and Legion. 
- Added Legion foods. Many of these are untested guesses for food category -- please send feedback if you see any issues.
- Added Warlords of Draenor foods. Better late than never?
- Redesigned to no longer use LibPeriodicTable. (Outsourcing list maintenance to a third-party library only meant I had to be the one updating the library... which is more complicated than keeping my own list.)
	- The option to avoid foods used as Cooking ingredients is disabled; it may return in a future version.
- The Feed Pet button now shows the number remaining in your inventory for the selected food.

v. 6.0 - 2014/10/14
- Updated for WoW Patch 6.0.
	- Does not yet include Warlords of Draenor food information. This will be added in a forthcoming release.

v. 5.2 - 2013/03/05
- Updated TOC to indicate compatibility with WoW Patch 5.2.

v. 5.1.1 - 2012/12/28
- *Actually* updated TOC to indicate compatibility with WoW Patch 5.1. Oops.
- Fixed an error that could occur if you had a caged battle critter in your bags.

v. 5.1 - 2012/12/19
- Updated TOC to indicate compatibility with WoW Patch 5.1.
- Includes updated PeriodicTable library -- nearly all Pandaren foods are now supported.
- Fixed errors that could occur when showing the Feed-O-Matic Options UI.

v. 5.0.2 - 2012/09/30
- Includes updated PeriodicTable library with support for the delicious foods of Pandaria.

v. 5.0.1 - 2012/08/30
- Fixed a "blocked action" error when applying glyphs since WoW Patch 5.0.

v. 5.0 - 2012/08/28
- Updated TOC to indicate compatibility with WoW Patch 5.0.
- Note: does not include new Mists of Pandaria foods; as of the current beta, such foods cannot be fed to pets (so there's little point in having Feed-O-Matic attempt to use them).

v. 4.3.1 - 2012/01/04
- Now supports the Brazilian Portuguese localization of the WoW client thanks to data from pt.wowhead.com. (Only the client-specific strings needed for functionality under Portuguese are translated; if you'd like to help provide a translation for Feed-O-Matic's own UI text, see the localization.lua file.)

v. 4.3 - 2011/11/29
- Updated TOC to indicate compatibility with WoW Patch 4.3.

v. 4.2 - 2011/06/28
- Updated TOC to indicate compatibility with WoW Patch 4.2.
- WoW Patch 4.2 makes the Interface Options window much bigger -- now there's room for all of Feed-O-Matic's options (including the food preferences table) on one pane.
- Fixed an issue where the Feed Pet button would show for pets that aren't hunter-tamed beasts -- e.g. quest pets, vehicles, etc.
- The Feed-O-Matic options panel no longer appears if Feed-O-Matic is loaded on a non-hunter character.
- Options now default to being shared across all characters; see the Options Profile panel if you'd prefer per-character, per-server, or per-class settings. (This change may not take effect if you already have saved options; choose the Default options profile if you'd prefer this behavior)

v. 4.1.3 - 2011/05/15
- Added an option to hide the button Feed-O-Matic adds to the default UI's pet frame -- when the button is hidden, the Feed-O-Matic Feed Pet key binding or macro command `/click FOM_FeedButton` still can be used to feed the pet. (You might find this option useful if using a UI that changes/hides the default pet frame.)
- Feed-O-Matic's key binding now shows the name of the Feed Pet spell (or whatever it's called in your WoW localization) instead of "FOM_FEED".

v. 4.1.2 - 2011/05/02
- The Feed Pet button (added by Feed-O-Matic to the default UI's pet frame) now indicates when Feed Pet is unusable or on cooldown.
- Improvements to the tooltip shown when mousing over the Feet Pet button:
 	- Now shows more information about what food Feed-O-Matic will use next.
	- Text in the tooltip is smaller and a bit more terse.
	- Tooltip can be hidden entirely via an advanced user preference: type `/fom notooltip` to disable the tooltip (or enable it again).

v. 4.1.1 - 2011/04/28
- Further changes to support WoW Patch 4.1: Since the Pet Happiness icon in the default UI is no more, Feed-O-Matic puts a new button in its former place next to the pet frame. This button supports all the behaviors we previously added to the pet happiness icon -- click to feed, right-click for options. In addition, the button shows the icon of the food we'll next use for feeding the pet (and as before, can be moused over to identify the food by name).
- When no pet is currently summoned, food quality in the Food Preferences options panel is calculated assuming a pet of level equal to the hunter's (matching a Patch 4.1 change in which pets are always kept at their master's level).
- Adjusted detail and tooltip text in Feed-O-Matic's options panel to reflect the elimination of the happiness mechanic and new behavior of Feed Pet.

v. 4.1 - 2011/04/26
- WoW Patch 4.1 removes the Pet Happiness mechanic; Feed Pet now works only as a large out-of-combat heal. As such, features related to tracking pet happiness and warning when the pet needs feeding have been removed from Feed-O-Matic (which still works great for simplifying the process of feeding a pet).
- New pet families introduced with Patch 4.0 & Cataclysm are now localized for Spanish, German, French, and Russian. (Localized pet family names are used for providing pet-specific feeding emotes; see FeedOMatic_Emotes.lua.)

v. 4.0.4 - 2011/01/07
- Includes an update to the PeriodicTable library fixing an issue where recently added foods were't actually showing up.
- Some of the options in Feed-O-Matic's options panel now provide detailed explanations in tooltips.
- Improvements to the list in Food Preferences (under Feed-O-Matic's options panel):
	- The color of a food's name now reflects its quality (how quickly it restores your pet's happiness).
	- Foods of the same quality are sorted by name.
	- When no pet is currently summoned, food quality is calculated assuming a pet of three levels below yours (previously we assumed five; this matches a change from patch 4.0 in which pets are always kept within three levels of their masters).

v. 4.0.3 - 2011/01/01
- Includes an update to the PeriodicTable library with more foods (Murglesnout, Pygmy Suckerfish, Shimmering Minnow).

v. 4.0.2 - 2010/12/17
- Includes an update to the PeriodicTable library with more Cataclysm foods (including a number of fish and meat items edible by pets but not by players).
- Fixes an issue where FOM wouldn't notice when the pet reached full happiness after feeding (or using Glyph of Mend Pet).

v. 4.0.1 - 2010/12/07
- Includes an update to the PeriodicTable library:
	- now includes most Cataclysm foods.
	- removed some foods pets don't eat.
	- added some pre-Cataclysm foods which weren't included before.
- Fixes an issue where we wouldn't warn that the pet needs feeding immediately after taming.
- Known issue: we don't yet have family-specific hungry sounds for the new pet families introduced with patch 4.0.3a (the Shattering) and Cataclysm. Please send email if there's a sound your new pet makes that you'd like him to make when he's hungry (and know the WoW-internal filename/path for it).

v. 4.0 - 2010/10/11
- Updated for compatibility with WoW Patch 4.0.1 (and Cataclysm Beta).
- NOTE: Cataclysm foods are not yet in the database; they will be provided in a future update.

v. 3.3 - 2009/12/08
- Updated TOC to indicate compatibility with WoW Patch 3.3.
- Reimplemented pet happiness icon "pulse" using new Animation features from recent WoW patches for lower CPU usage.
- Includes an update to the PeriodicTable library and its food lists.

v. 3.2 - 2009/08/04
- Updated TOC to indicate compatibility with WoW Patch 3.2.
- Updated French localization by oXid_FoX.
- Includes an update to the PeriodicTable library and its food lists.

v. 3.1 - 2009/04/18
- Updated TOC to indicate compatibility with WoW Patch 3.1.
- Now uses Ace3 library for saved settings and options UI (any previously saved preferences will be reset to default).
- Includes an update to the PeriodicTable library and its food lists.
- Fixes an issue where a "Can't find Feed Pet spell" message could appear upon login. (The message now only appears if FOM still can't find the spell when you try to feed your pet.)
- Includes possible fix for a blocked/tainted action error I've not been able to reproduce.

v. 3.0.5 - 2009/02/08
- Fixes an error message when attempting to produce a random emote.
- Updated Korean localization by "kelvin Joe".
- Added Russian localization by StingerSoft from WoWInterface.com.
- Updated basic locale support for French, German, and Spanish from Wowhead's databases.
- Includes an update to the PeriodicTable library and its food lists.

v. 3.0.4 - 2008/10/24
- Includes an update to the PeriodicTable library, fixing an issue in which older versions of the library's datasets would override newer versions... which could cause FOM to ignore certain foods.

v. 3.0.3 - 2008/10/18
- Includes an update to the PeriodicTable library and its food lists:
	- Fixes subcategory/supercategory linkage issues that caused FOM to ignore certain foods (such as Conjured Mana Biscuit and Naaru Ration).
	- Includes all (currently known to Wowhead) new foods from Wrath of the Lich King content.
- Reorganized the Food Preferences panel slightly to account for Wrath of the Lich King foods having more possible cooking products. (Don't like mammoth? Try cooking it differently!)
- Fixed an error that could occur when FOM chooses the next food to use.
- Fixed an issue where FOM wouldn't choose a food (and thus feeding would be unavailable) after reloading the UI.
- Fixed an issue where category headers would inconsistently appear grayed out in the Food Preferences list.
- Items that aren't in the PeriodicTable categories corresponding to the six possible pet diets (i.e. not edible by pets) will no longer show in the Food Preferences list.
- Added more random feeding emotes thanks to the commenters at maniasarcania.com. Feeding emotes can now be made specific to categories of foods (specified by PeriodicTable sets).

v. 3.0.2 - 2008/10/15
- Fixed an bug causing us to ignore diets beyond the first for pets with multiple diets.
- Fixed an error when attempting to play pet hungry sounds.
- Added French random emotes by Laumac from WoWInterface.com.

v. 3.0.1 - 2008/10/14
- Fixed a bug where clicking foods in the new Food Preferences panel (see 3.0 release notes below) wouldn't show them as excluded/unchecked.
- When a category is excluded/unchecked in said panel, the foods within it appear grayed out.

v. 3.0 - 2008/10/14
- Updated for compatibility with WoW Patch 3.0 and Wrath of the Lich King.
- Rebuilt FOM's system for choosing foods to feed your pet:
	- Our database of valid pet foods now comes from the PeriodicTable library.
	- Priority order for choosing foods is based (in part) on PeriodicTable sets (conjured, basic, or bonus foods, etc.)
	- There's now a Food Preferences sub-panel under GFW Feed-O-Matic in the Interface Options window.
		- In it, all valid pet foods your WoW client has seen are listed by category.
		- The order of categories and foods in the list reflects the priority order for choosing foods: those nearer the top of the list will be picked before those below.
		- Individual foods can be unchecked in the list to prevent FOM from feeding them to your pet.
		- Entire categories can also be unchecked, which will prevent FOM from using any food of that category (even ones you haven't seen yet). By default, only the "Well Fed" foods are disabled, so be sure to visit the list if you want to exclude other foods.
		- The list can be filtered to show only relevant foods for your pet (or for a pet of about your level, if you don't have a pet summoned at the moment) or only foods you're currently carrying.
		- If a food can be cooked, the list shows information about each of the the Cooking recipe(s) that use it: whether you know the recipe, its difficulty (i.e. orange, yellow, green or gray in the Cooking window), and the food produced.
		- This list replaces the "avoid bonus foods" and "avoid cooking foods" options in previous releases.
- The "keep bag space open" option from previous releases has been removed: given multiple stacks of the same food, FOM will now always consume the smaller stack first so as to free up bag space more quickly.
- Fixed several issues which caused the "Avoid foods needed for quests" option to fail.
- Added numerous random feeding emotes -- thanks to Mania and the creative commenters at http://maniasarcania.com!
- Locale issues:
	- The random text added to feeding emotes (e.g. "Yum!", "Good boy!", etc) is now localizable. See the FeedOMatic_Emotes.lua file for details. (Thanks Virshan for a few Spanish.)
	- Added Korean localization by Boddalhee of Deathwing (KR).
	- Added Spanish localization by Javier Melo. 
	- Added basic locale support for Russian, and updated basic locale support for French and German, based on Wowhead's multilingual database. (That is, enough translations for all features to work the same as in English, but no localized UI text.)
		- Translations are missing for the new and renamed beast families (in WoW 3.0 / WotLK), so the family-specific hungry sounds don't currently work in locales other than English.
	
v. 2.4.1 - 2008/04/11
- Fixed an issue where some checkboxes in the options UI weren't having an effect.
- Fixed an issue with the Save for Cooking setting not being applied properly.
- Added several new foods from recent patches to the default list.

v. 2.4 - 2008/03/24
- Updated for compatibility with WoW Patch 2.4.
- Configuration controls are moved into a pane in the new Interface Options panel provided by the default UI. Key binding moved back into the default UI's Key Bindings panel.
- The option to avoid foods used in Cooking recipes you don't know yet is now independent of that for which level of known recipes to avoid foods from.

v. 2.3.1 - 2007/12/01
- Added new foods introduced in WoW Patch 2.3.
- Fixed an issue with setting key bindings that include modifier keys.
- Added "Unbind Key" buttons to the Options window for removing FOM's key bindings.
- The `diet` argument to the `/fom remove` command is now optional; if omitted, the specified food will be removed from any and all diets it's listed in. (e.g. `/fom remove [Delicious Chocolate Cake]` is now the same as `/fom remove bread [Delicious Chocolate Cake]`.)

v. 2.3 - 2007/11/13
- Updated TOC to indicate compatibility with WoW Patch 2.3.
- Fixed an issue where FOM would report being unable to find your Feed Pet spell upon login; we now wait until the spellbook is more likely to have been loaded by the game before checking.

v. 2.2.1 - 2007/10/12
- Added a workaround for a sound bug in WoW Patch 2.2; "hungry" sounds should be working again.

v. 2.2 - 2007/09/25
- Updated TOC to indicate compatibility with WoW Patch 2.2.
- Fixed an off-by-one error in calculating which foods are edible by the current pet and which provide the most happiness.
- Added a few foods introduced in the Burning Crusade and Patch 2.1 to the default list.

v. 2.1.1 - 2007/07/20
- Fixed an issue where FOM would mistakenly indicate that no food is in your bags upon zoning, logging in, dismounting, etc.
- Typing `/fom debug` will toggle the display of additional info in the tooltip when mousing over the pet happiness icon, showing the list of the next several foods FOM will attempt to use. Check this if FOM is using foods you don't expect it to (or failing to find foods you do).
- Fixed an error when pressing the Feed Pet keybinding while your pet is dead or dismissed.
- We no longer show a chat window message or emote if feeding was unsuccessful (e.g. if the pet is out of range).
- [Underspore Pod] is now treated as an exception to the "foods with bonus effects" rule, since it's easy to summon more. (Yeah, it's kinda hackish. A better UI for customizing food preferences is coming in a future update.)
- Added Traditional Chinese localization.
- Uses a simpler, more reliable means of hooking item tooltips.
- Added support for the Ace [AddonLoader][] -- when that addon is present, Feed-O-Matic will only load for Hunter characters.
[AddonLoader]: http://www.wowace.com/wiki/AddonLoader

v. 2.1 - 2007/05/22
- Updated TOC for WoW Patch 2.1.
- Added family-specific "hungry" sounds for the new pet species introduced in the Burning Crusade.

v. 2.0.6 - 2007/02/17
- Fixed an error that would occur when the keyring is updated. (There's no food there, anyway.)
- Fixed some issues with hooking tooltips when other tooltip-modifying addons are present.
- Added Underspore Pod (fungus) to the food list.

v. 2.0.5 - 2007/01/31
- Fixed several bugs in the food-choosing algorithm which tended to result in Feed-O-Matic choosing items you've told it to avoid.
- Eliminated the "fall back to otherwise-avoided foods if nothing else available" preference. Instead, there's now an error message if you press the feed button when the only foods available are items you've told Feed-O-Matic to avoid. Hold Alt while pressing your Feed Pet keybinding (or Alt-left-click the happiness icon) to feed one of these items anyway.
- Mousing over the pet happiness icon now shows the next food to be used.
- We now keep a list of all foods known to be used in Cooking; the "Save foods used in Cooking recipes" option now has an additional setting for foods used in recipes your character hasn't yet learned.
- You can now set two different key bindings for each action in Feed-O-Matic's Options panel.
- Cut down on CPU usage a bit -- if an inventory update affects only your quiver / ammo pouch, we'll assume that nothing related to pet foods has changed.
- Reorganized the Options panel and reworded some options for better clarity.
- Fixed a bug that kept the `/fom add` and `/fom remove` commands from working properly.
- Removed chat commands for configuation settings which are present in the Options panel.
- Added Conjured Croissant to the built-in foods list.

v. 2.0.4 - 2007/01/14
- Simplified code for adding text to item tooltips thanks to new API in WoW 2.0.3 -- this should fix issues with the same info being added to a tooltip multiple times or sometimes being missing, as well as allow us to work with more third-party addons that show item tooltips.

v. 2.0.3 - 2007/01/11
- Updated for compatibility with WoW Patch 2.0.3 and the Burning Crusade release.
- Added a number of foods to the built-in list (thanks to Griffon Silvertongue).

v. 2.0.2 - 2006/12/08
- Fixed error (introduced in 2.0.1) when mousing over items.

v. 2.0.1 - 2006/12/07
- Fixed posible blocked action errors in tooltip-hooking code.

v. 2.0 - 2006/12/05
- Redesigned to use new secure action functionality in WoW 2.0 (and the Burning Crusade Closed Beta):
 	- Feed-O-Matic now maintains a special action button for feeding your pet a specific item from your bags. Whenever your inventory changes, Feed-O-Matic will (if necessary) choose an appropriate food for your pet's next feeding and set up the button to use it.
	- To use this action button, click the pet happiness icon or bind a key...
	- Due to limitations in WoW 2.0's key binding interface, key bindings for Feed-O-Matic are found in its own Options window instead of the normal Key Bindings window. To show Feed-O-Matic's options window, type `/fom` or right-click the pet happiness icon.
	- It's no longer possible to feed your pet from a custom chat command, so `/fom feed` has been removed. (It is possible to feed your pet in a macro, but this requires a static choice of foods: e.g. `/cast Feed Pet /use Roasted Quail`.)
	- The pet happiness icon will darken if Feed-O-Matic can't find any appropriate food. Mousing over the buttons shows why we can't find food for your pet (either there's nothing in your inventory your pet will eat, or you've configured Feed-O-Matic to avoid certain foods and those are the only ones left).
- We now automatically detect whether a food provides a bonus effect when eaten by players (e.g. a Stamina buff in addition to the health gained), instead of needing to be told which foods fall into this category. If you find that Feed-O-Matic fails to detect such a food, please let us know! 
- Added many foods from Burning Crusade content to the default list. If you find more, please let us know!
- NOTE: The new tameable beast families don't yet have specific sounds for when they're hungry, so they'll just play a bell sound instead. (If you'd like to help pick some, please contact us with the paths of sound files in the WoW MPQs that you think would be appropriate: e.g. "Sound\Creature\OWl\OwlPreAggro.wav".)

v. 12000.2 - 2006/10/27
- Now always prefers conjured foods if available when feeding a pet that can eat them. (This was supposed to have been the case before, but the implementation turned out to be unreliable.)
- Fixed some issues which could result in Feed-O-Matic feeding the pet a food you'd told it to avoid, even if the "fall back" option was turned off. Also, a clearer error message is given if "fall back" is off and we can't find any allowed foods.
- The various reminder options for when your pet needs feeding (flashing the happiness icon, text messages, sounds) are now suppressed while you or your pet is in combat or if your pet is dead.
- Feed-O-Matic posts its own error message if you attempt use it to feed your pet while in combat. (Instead of trying to feed the pet anyway, causing WoW itself to post an error message.)
- Added a number of items to the default foods list (including some holiday treats and the new level 55 mage-conjured bread).

See http://fizzwidget.com/notes/feedomatic/ for older release notes.
