#include <Array.au3>
#include <GUIConstants.au3>
Global $About = "Build on AutoIt v3.3.12.0"&@CRLF&"Tested on Windows 7 SP1"&@CRLF&"By musahi0128 (musahi0128@gmail.com)"
Global $Help = "How to use :"&@CRLF&"1. Select cheats you want to activate"&@CRLF&'2. Save change by clicking "Add cheat(s)" button or preview it first'&@CRLF&"4. Open emulator, check Game Settings > Enable Cheats"&@CRLF&"5. Play the game."
Global $CfgFile = @ScriptDir&"\hm-holv.cfg"
Global $Msg, $Form, $Form0, $Form1, $Form2, $Form3, $Form4, $Form5, $DummyForm0, $DummyForm1, $DummyForm2, $DummyForm3, $DummyForm4, $DummyForm5
Global $StaticCheats[11][2]
$StaticCheats[0][0] = "Max money"
$StaticCheats[0][1] = "_L 0x204F3978 0x000F423F"
$StaticCheats[1][0] = "Max stamina"
$StaticCheats[1][1] = "_L 0x104F3252 0x0000007B"
$StaticCheats[2][0] = "Max water in watering can"
$StaticCheats[2][1] = "_L 0x104D3870 0x00000063"
$StaticCheats[3][0] = "Max fodder"
$StaticCheats[3][1] = "_L 0x104D386E 0x00000063"
$StaticCheats[4][0] = "Fed dog with milk"
$StaticCheats[4][1] = "_L 0x104C674D 0x0000007B"
$StaticCheats[5][0] = "Fed all chicken with mineral alfalfa sprouts"
$StaticCheats[5][1] = "_L 0x004F86E6 0x00000002"&@CRLF&"_L 0x004F874E 0x00000002"&@CRLF&"_L 0x004F87B6 0x00000002"&@CRLF&"_L 0x004F881E 0x00000002"&@CRLF&"_L 0x004F8886 0x00000002"&@CRLF&"_L 0x004F88EE 0x00000002"&@CRLF&"_L 0x004F8956 0x00000002"
$StaticCheats[6][0] = "Fed horse and all cow with mineral alfalfa sprouts"
$StaticCheats[6][1] = "_L 0x204F92D0 0x00000200"&@CRLF&"_L 0x204F8D90 0x00000200"&@CRLF&"_L 0x204F8E00 0x00000200"&@CRLF&"_L 0x204F8E70 0x00000200"&@CRLF&"_L 0x204F8EE0 0x00000200"&@CRLF&"_L 0x204F8F50 0x00000200"
$StaticCheats[7][0] = "Easy win horse race"
$StaticCheats[7][1] = "_L 0x204D2D23 0x030D4000"&@CRLF&"_L 0x204D2E03 0x00000000"&@CRLF&"_L 0x204D2EE3 0x00000000"&@CRLF&"_L 0x204D2FC3 0x00000000"
$StaticCheats[8][0] = "Max Horse Race Medal"
$StaticCheats[8][1] = "_M 0x08D0D4F2 0x0000270F"
$StaticCheats[9][0] = "Max affection [Dog]"
$StaticCheats[9][1] = "_L 0x104C674E 0x000000FF"
$StaticCheats[10][0] = "Max affection [Horse]"
$StaticCheats[10][1] = "_L 0x104F92CD 0x000000FF"
Global $Clock = [["27906","06:00 AM"],["2E287","07:00 AM"],["34C08","08:00 AM"],["3B589","09:00 AM"],["41F0A","10:00 AM"],["4888B","11:00 AM"],["4F20C","12:00 PM"],["55B8D","01:00 PM"],["5C50E","02:00 PM"],["62E8F","03:00 PM"],["69810","04:00 PM"],["70191","05:00 PM"],["76B12","06:00 PM"],["7D493","07:00 PM"],["83E14","08:00 PM"],["8A795","09:00 PM"],["91116","10:00 PM"],["97A97","11:00 PM"],["00000","12:00 AM"],["06981","01:00 AM"],["0D302","02:00 AM"],["13C83","03:00 AM"],["1A604","04:00 AM"],["20F85","05:00 AM"]]
Global $Years = [["01","1 st"],["02","2 nd"],["03","3 rd"],["04","4 th"],["05","5 th"],["06","6 st"]]
Global $Seasons = [["1","Spring"],["2","Summer"],["3","Fall"],["4","Winter"]]
Global $Days = [["1","Monday"],["2","Tuesday"],["3","Wednesday"],["4","Thursday"],["5","Friday"],["6","Saturday"],["7","Sunday"]]
Global $Dates = [["01","1"],["02","2"],["03","3"],["04","4"],["05","5"],["06","6"],["07","7"],["08","8"],["09","9"],["0A","10"],["0B","11"],["0C","12"],["0D","13"],["0E","14"],["0F","15"],["10","16"],["11","17"],["12","18"],["13","19"],["14","20"],["15","21"],["16","22"],["17","23"],["18","24"],["19","25"],["1A","26"],["1B","27"],["1C","28"],["1D","29"],["1E","30"],["1F","31"]]
Global $Forecasts = [["0","Sunny"],["1","Cloudy"],["2","Rainy"],["3","Very Rainy"],["4","Snowy"],["5","Stormy"]]
Global $TimeCheats[7][3]
$TimeCheats[0][0] = "Pause time"
$TimeCheats[0][1] = "_L 0xE1010002 0x004B94C1"&@CRLF&"_L 0x30100006 0x004B94C1"&@CRLF&"_L 0xE1010000 0x004B94C1"&@CRLF&"_L 0x30100008 0x004B94C1"&@CRLF
$TimeCheats[0][2] = ""
$TimeCheats[1][0] = "Set clock"
$TimeCheats[1][1] = "_M 0x98D6FA20 0xEFFF1000"&@CRLF&"_M 0x28CB94C8 0x000000FF"&@CRLF&"_L 0x204B94C8 0x000"
$TimeCheats[1][2] = $Clock
$TimeCheats[2][0] = "Change year"
$TimeCheats[2][1] = "_L 0x104B94CC 0x000000"
$TimeCheats[2][2] = $Years
$TimeCheats[3][0] = "Change season"
$TimeCheats[3][1] = "_L 0x104B94D0 0x0000000"
$TimeCheats[3][2] = $Seasons
$TimeCheats[4][0] = "Change day"
$TimeCheats[4][1] = "_L 0x104B94D4 0x0000000"
$TimeCheats[4][2] = $Days
$TimeCheats[5][0] = "Change date"
$TimeCheats[5][1] = "_L 0x104B94D8 0x000000"
$TimeCheats[5][2] = $Dates
$TimeCheats[6][0] = "Change forecast"
$TimeCheats[6][1] = "_M 0xCF000000 0x00000006"&@CRLF&"_M 0x104B94E4 0x0000000"
$TimeCheats[6][2] = $Forecasts
Global $Animals = [["C674E","Dog"],["F92CD","Horse"]]
Global $Girls = [["A48","15E","Katie"],["A5E","15E","Gina"],["A74","15E","Gwen"],["A8A","15E","Dia"],["AA0","15E","Lyla"],["BBE","15E","Aurelia"],["BEA","16E","Alice"],["C6E","16E","Harvest Goddess"]]
Global $Villagers = [["AB6","15E","Louis"],["ACC","15E","Parsely"],["AE2","15E","Bob"],["AF8","15E","Tim"],["B0E","15E","Joe"],["B24","15E","Kurt"],["B3A","15E","Woody"],["B50","15E","Wallace"],["B66","15E","Ronald"],["B7C","15E","Martha"],["B92","15E","Rudolph"],["BA8","15E","Nac"],["BD4","15E","Flak"],["C00","15E","Charles"],["C16","15E","Renton"],["C2C","15E","Nic"],["C42","15E","Chester"],["C58","15E","Zann"]]
Global $Tools = [["000","Brush"],["001","Milker"],["002","Sickle"],["003","Light Sickle"],["004","Super Sickle"],["005","Ultra Sickle"],["006","Hoe"],["007","Light Hoe"],["008","Super Hoe"],["009","Ultra Hoe"],["00A","Axe"],["00B","Light Axe"],["00C","Super Axe"],["00D","Ultra Axe"],["00E","Hammer"],["00F","Light Hammer"],["010","Super Hammer"],["011","Ultra Hammer"],["012","Fishing Rod"],["013","Super Fishing Rod"],["014","Hyper DX Fishing Rod"],["015","Kurt's Fishing Rod"],["016","Watering Can"],["018","Chicken Feed"],["019","Cow Miracle Potion"],["01A","Animal Medicine"],["01B","Ocarina"],["01C","Bug Net"],["01D","Bath Towel"],["01E","Bell"],["01F","Blue Feather"],["020","Potato Seeds"],["021","Tomato Seeds"],["022","Corn Seeds"],["023","Breadfruit Seeds"],["024","Spinach Seeds"],["025","Onion Seeds"],["026","Carrot Seeds"],["027","Pumpkin Seeds"],["028","Rice Seeds"],["029","Alfalfa Seeds"],["02A","Watermelon Seeds"],["02B","Strawberry Seeds"],["02C","Wild Mint Seeds"],["02D","Frost Pansy Seeds"],["02E","Stardust Seeds"],["02F","Mistbloom Seeds"],["030","Fairy Dress Seeds"],["031","Silverbell Seeds"],["032","Golden Potato Seeds"],["033","Blue Mist Seeds"],["034","Prized Breadfruit Seeds"],["035","Pomato Seeds"],["036","??? Seeds"],["037","Pobread Seeds"],["038","Potanich Seeds"],["039","Potanion Seeds"],["03A","Tater Tater Seeds"],["03B","Tomorn Seeds"],["03C","Oniato Seeds"],["03D","Corrot Seeds"],["03E","Rice Corn Seeds"],["03F","Straw Corn Seeds"],["040","Cornich Seeds"],["041","Waterniche Seeds"],["042","Spinkin Seeds"],["043","Rice Carrot Seeds"],["044","Waterkin Seeds"],["045","Water Rice Seeds"],["046","Strawter Mellon Seeds"],["20E","Experimental Seeds Bag 1"],["20F","Experimental Seeds Bag 2"],["210","Experimental Seeds Bag 3"]]
Global $Peoples[0][3]
Global $Items[0][2]
Global $Fridge[0][2]
Global $ItemsPart1 = [["047","Potato"],["048","Tomato"],["049","Corn"],["04A","Breadfruit"],["04B","Spinach"],["04C","Onion"],["04D","Carrot"],["04E","Pumpkin"],["04F","Rice"],["051","Watermelon"],["052","Strawberry"],["059","Golden Potato"],["05A","Mineral Potato"],["05B","Mineral Tomato"],["05C","Mineral Corn"],["05D","Gold Breadfruit"],["05E","Mineral Spinach"],["05F","Mineral Onion"],["060","Mineral Carrot"],["061","Red Pumpkin"],["062","Platinium Rice"],["064","Black Watermelon"],["065","Golden Strawberry"],["078","Gold Mushroom"],["079","Super Mushroom"],["07A","Big Mushroom"],["07B","Milk S"],["07C","Milk M"],["07D","Milk L"],["07E","Gold Milk"],["07F","Egg"],["080","Golden Egg"],["086","Very Berry"],["087","Cranberry"],["088","Blueberry"],["089","Walnut"],["08A","Mushroom"],["08B","Black Truffle"],["08C","White Truffle"],["08D","Star Truffle"],["08E","Baby Truffle"],["08F","Chestnut"],["090","Apple"],["091","Orange"],["092","Grapes"],["093","Full Moon Berry"],["094","Clam"],["09D","Rice Ball"],["09E","Sandwich"],["09F","Fluffy Bread"],["0A0","Honey"],["0A1","Cheese"],["0A2","Yogurt"],["0A3","Miso"],["0A4","Tea"],["0A5","Herb Tea"],["0A6","Milk Tea"],["0A7","Cookie"],["0A8","Muffin"],["0A9","Cake"],["0AA","Cheesecake"],["0AB","Pancake"],["0AC","Nut Wine"],["0AD","Wheat Wine"],["0AE","Water"],["0AF","Milk"],["0B0","Herb Wine"],["0B1","Fish Meal"],["0B2","Sauteed Mushroom"],["0B3","Tomato Salad"],["0B4","A. Cheese"],["0B5","French Fries"],["0B6","Butter"],["0B7","Olive Oil"],["0C3","Power Berry"],["0C7","Char"],["0C8","White-Spotted Char"],["0C9","Masu Salmon"],["0CA","Sakura Salmon"],["0CB","Pale Chub"],["0CC","Dark Chub"],["0CD","Smelt"],["0CE","Surfsmelt"],["0CF","Loach"],["0D0","Rainbow Trout"],["0D1","Cobalt Rainbow Trout"],["0D2","Sardine"],["0D3","Anchovy"],["0D4","Horse Mackerel"],["0D5","White Trevally"],["0D6","Mackerel"],["0D7","Blue Mackerel"],["0D8","Black Rockfish"],["0D9","Red Rockfish"],["0DA","Sweetfish"],["0DB","Dace"],["0DC","Eel"],["0DD","Garden Eel"],["0DE","Dark Sleeper"],["0DF","Catfish"],["0E0","Black Bass"],["0E1","Blotched Snakehead"],["0E2","Tiger Globefish"],["0E3","Raven Globefish"],["0E4","Porgy"],["0E5","Black Porgy"],["0E6","Pike"],["0E7","Cod"],["0E8","Alaska Pollock"],["0E9","Greenling"],["0EA","Amberjack"],["0EB","Young Amberjack"],["0EC","Chicken Grunt"],["0ED","Mountain Grunt"],["0EE","Leatherfish"],["0EF","Black Scraper Fish"],["0F0","Pacific Herring"],["0F1","Flounder"],["0F2","Right-eye Flounder"],["0F3","Salmon"],["0F4","Huchen"],["0F5","Dolphinfish"],["0F6","Monkfish"],["0F7","Tuna"],["0F8","Albacore"],["0F9","Longtooth Grouper"],["0FA","Spanish Mackerel"],["0FB","Nagi"],["0FC","Swordfish"],["0FD","Squid"],["0FE","Pacific Flying Squid"],["0FF","Octopus"],["100","Ocellated Octopus"],["101","Shrimp"],["102","Sweet Shrimp"],["103","Lobster"],["104","Blue Homard"],["144","Failed Dish"],["145","Strawberry Jam"],["146","Orange Cookie"],["147","Orange Juice"],["148","Orange Marmalade"],["149","Carrot Cake"],["14A","Cranberry Jam"],["14B","Grape Juice"],["14C","Jam Sandwich"],["14D","Shortcake"],["14E","Herb Cookie"],["14F","Honey Cake"],["150","Blueberry Jam"],["151","Very Berry Jam"],["152","Mix Berry Jam"],["153","Chestnut Cake"],["154","Apple Jam"],["155","Stewed Apples"],["156","Fine Cheesecake"],["157","Strawberry Milk"],["158","Cheese Potato"],["159","Assorted Cheese"],["15A","Cheese Risotto"],["15B","Hot Milk"],["15C","Fine Cheese"],["15D","Miso Greenling"],["15E","Broiled Horse Mackerel"],["15F","Monkfish Stew"],["160","Broiled Squid"],["161","Fried Squid"],["162","Squid Rice"],["163","Chicken Grunt Vinegar"],["164","Fried Huchen"],["165","Marinated Sardines"],["166","Pickled Char"],["167","Dace Dumplings"],["168","Broiled Eel"],["169","Shrimp Pilaf"],["16A","Fried Shrimp"],["16B","Broiled Chub"],["16C","Canh Chua"],["16D","Teriyaki Swordfish"],["16E","Fried Leatherfish"],["16F","Grouper Stew"],["170","Clam Chowder"],["171","Marinated Salmon"],["172","Salmon Cream Stew"],["173","Butter-Fried Salmon"],["174","Miso Mackerel"],["175","Spanish Mackerel Stew"]]
Global $ItemsPart2 = [["176","Pike Rice"],["177","Seafood Gratin"],["178","Seafood Stew"],["179","Seafood Pilaf"],["17A","Seafood Risotto"],["17B","Fried Dolphinfish"],["17C","Fish Cream Sautee"],["17D","Porgy Carpaccio"],["17E","Marinated Octopus"],["17F","Cod Soup"],["180","Broiled Loach"],["181","Dark Sleeper Stew"],["182","Broiled Catfish"],["183","Rainbow Trout Kebab"],["184","Marinated Herring"],["185","Sauteed Clam"],["186","Flounder Meuniere"],["187","Bouillabaisse"],["188","Tiger Globefish Stew"],["189","Teriyaki Amberjack"],["18A","Tuna Carpaccio"],["18B","Tuna Steak"],["18C","Stewed Rockfish"],["18D","Stewed Masu Salmon"],["18E","Boiled Octopus"],["18F","Boiled Egg"],["190","Boiled Lobster"],["191","Lobster Roast"],["192","Marinated Smelt"],["193","Fried Smelt"],["194","Fish and Mushrooms"],["195","Fish and Tomatoes"],["196","Fried Fish"],["197","Baked Fish"],["198","Fish Meuniere"],["1F5","Golden Potato Treats"]]
Global $ItemsPart3 = [["050","Alfalfa Sprouts"],["053","Wild Mint"],["054","Frost Pansy"],["055","Stardust"],["056","Mistbloom"],["057","Fairy Dress"],["058","Silverbell Herb"],["063","Mineral Alfalfa Sprouts"],["081","Grass"],["082","Red Herb"],["083","Green Herb"],["084","Moondrop Herb"],["085","Pink Cat Mint"],["095","Common Seashell"],["096","Coral"],["097","Wonderful Seashell"],["098","Lumber"],["09B","Pontata Root"],["0B8","Diamond Earrings"],["0B9","Opal Earrings"],["0BA","Garnet Earrings"],["0BB","Emerald Earrings"],["0BC","Sapphire Earrings"],["0BD","Aquamarine Earrings"],["0BE","Ruby Earrings"],["0BF","Amethyst Earrings"],["0C0","Moonlight Earrings"],["0C1","Fodder"],["0C4","Sunken Treasure"],["0C5","Pirate Treasure"],["0C6","Treasure Chest"],["105","Small White"],["106","Grass Yellow"],["107","Swallowtail Butterfly"],["108","Green Japonicus"],["109","Monarch Butterfly"],["10A","Golden-ringed Dragonfly"],["10B","Red Dragonfly"],["10C","Lesser Emperor Dragonfly"],["10D","Common Skimmer"],["10E","Blue Damselfly"],["10F","Rhinoceros Beetle"],["110","Pincer Beetle"],["111","Drone Beetle"],["112","Caterpillar"],["113","Coal"],["114","Moonlight Stone"],["115","Blue Rock"],["116","Rare Metal"],["117","Iron Ore"],["118","Copper Ore"],["119","Gold Ore"],["11A","Silver Ore"],["11C","Orichalcum"],["120","Diamond"],["123","Emerald"],["127","Sapphire"],["128","Aquamarine"],["12B","Ruby"],["12C","Garnet"],["12D","Amethyst"],["136","Opal"],["137","Scrap Metal"],["138","Mineral Crystal"],["139","Special Fishing Bait"],["13A","AP Medicine"],["13B","Super AP Medicine"],["13C","Ammonite Fossil"],["13D","Trilobite Fossil"],["13E","Plant Fossil"],["13F","Ancient Fish Fossil"],["140","Earthenware"],["141","Unknown Object"],["142","Unusual Pot"],["143","Mysterious Clay Doll"],["1DA","Treasure Map"],["1DC","Grandma's Recipe"],["1DF","Silk Thread"],["1E0","Seven-Color Cloth"],["1E3","Gift Bread"],["1E5","Prized Breadfruit"],["1E7","Sugar Lace"],["1E8","Heal Grass"],["1E9","Cherry Tree Seeds"],["1EC","Moonlight Key"],["1ED","Goddess Statue Fragment"],["1F3","Woody's Gift"],["1F4","Harvesr Goddess Goods"],["1F7","Silver Fish Charm"],["1F9","Shady H. Goddess Goods"],["213","Martha's Gift"],["215","Deep-forest Lumber"]]
Global $ItemVal = [$ItemsPart1, $ItemsPart2, $ItemsPart3]
Global $FridgeVal = [$ItemsPart1, $ItemsPart2]
_ArrayConcatenate($Peoples, $Girls)
_ArrayConcatenate($Peoples, $Villagers)
For $i In $ItemVal
	_ArrayConcatenate($Items, $i)
Next
For $i In $FridgeVal
	_ArrayConcatenate($Fridge, $i)
Next
