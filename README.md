# NorthSeaOil
C64 Simons' Basic / Assembly board game implementation


Introduction
------------
This is a C64 game written by myself and my brother. It is a C64 version of the Board Game "North Sea Oil" - https://boardgamegeek.com/boardgame/5435/north-sea-oil 


About us
--------
I have been coding since the C64 came out - programming in Assembly / Basic and then onto my career programming in C/C++/Python/Fortran 77, but I am severely out of practice at Assembly. My brother has never coded since the C64 came out. 

Why we coded this
-----------------
It was just a fun project we wanted to do together to get back some nostalgia, also renew my interest in coding assembly etc as well as getting my brother back into coding after 40 years.
We were making this up as we went along so there are lots of sections that could be done way better, the assembly code was written in small chunks as and when we needed to do something special.

Requirements
------------
This is designed in Simons' Basic with some additional assembly which it loads at the start of the main game. The game makes heavy use of disk access to load individual graphic elements as needed - so it is recommended to use TheC64 as opposed to a real C64 with a 1541, When loading using TheC64 the disk load times are negligible, when loading on a real c64 they are glacial :)

Contents
--------
nso-game.d64 - this is the main game disk.\
nso-design.d64 - this contains the various graphic creation programs used in the game construction - it is not required to play the game

Playing The Game
----------------
LOAD "NORTH SEA OIL",8\
RUN

The game is played exclusively with the joystick. Menus are presented as a bar in the centre of the screen, moving the joystick up/down left/right chooses between different menu choices and pressing fire selects the choice. Some menus contain only a single item and this is used to convey messages to the user, these are similarly closed using the fire button.

There can be 1 to 6 players. Each player is assigned their own colour. The menu and border changes colour to the currently active user.

There are 3 phases in the game\
Phase 1
-------
Each player takes out a loan / pays back their load. A player may only borrow a maximum of $1,000,000 more than their current loan. A player can pay off any part of their loan if they have enough cash. Initially players start with $0 and therefore must borrow money to play

Phase 2
-------
Phase 2 is where players try to prospect / buy drilling concessions and their associated drills as well as transferring etc\
Here are the following possible actions
* Site Testing
	* Upto 3 site tests are possible per round at a cost of $100,000 each.
	* Each site is either in Deep, Reef or Shallow water as dictated by the card shown in the bottom right.
	* Deep sites require Heavy Drills.
	* Reef sites require Special Drills.
	* Shallow sites require Light Drills.
	* Sites are tested by navigating a magnifying glass cursor to an untested square and pressing the fire button.
	* Sites can contain either Small (20k), Medium (40k), Large (100k) deposits. There are also be some sites that have "No Oil" and earn nothing.
	* Other players should look away when the results of a site test are revealed.
	* A tested site (concession) is still owned by the bank until a concession is bought.
	* A maximum of 3 site tests are available per player per round.
* Buy Concession\
	After a site has been tested it can be bought - this is via a bidding process with any available players.\
	The initial bid (by the instigating player) is $100,000, subsequent players can raise the bid using the joystick or choose "No Bid" until no more bidders are available.\
	Players who do not have enough money to increase the bid are automatically cut out of the bidding process.\
	A player can instigate a maximum of 3 concession bids per round - but they can take part in as many bids as they want, and money allows.

* Sell Concession\
	This lets you choose to sell a concession back to the bank or to another player

* Buy Drills (Light, Special, Heavy)\
	Buy drills so that they can be placed on a players concession.\
	There are limited number of drills available in the game.
	* 5 Heavy
	* 3 Special
 	* 5 Light

	Bought drills are not active until they are placed on a concession.

* Place Drills (Light, Special, Heavy)\
	If you have bought a drill you can then choose to place it on an appropriate concession
	* Light Drill -> Shallow Concession
	* Special Drill -> Reef Concession
	* Heavy Drill -> Deep Concession

	Until a drill is on a concession that concession does not earn money. Use the magnifying glass cursor to select the concession where you want to place the drill.

* Transfer Drills\
	This allows you to transfer a drill from once concession to another. The drill must match the concession (i.e. you cannot transfer a Light Drill in a Shallow Concession to a Deep Concession).\
	Use the magnifying glass cursor to select the initial drill you want to transfer and then the destination concession.\
	Transferring drills costs $10,000.

* Sell Drills\
	Choose to sell drills to the bank or another player.

Menu options will only be shown to a player if they are allowed to perform that action. e.g. if you have no drills you won't see the "Place Drill" option available to you. If you have <$100,000 you won't be able to Site Test

Phase 3
-------
Phase 3 is where the results of the round are calculated including, production, weather, governments etc.
* Weather\
	First the weather for each quadrant is shown in the top right corner.
	* Good weather = 100% production.
	* Rough weather = 50% production.
	* Storm weather = 0% production.
	* Gales = 0% production and any drills in that quadrant are destroyed (sending them to the bank).

	The season affects the likelihood of certain weather types.
	* Spring and Summer are more likely to have good weather.
	* Autumn and Winter are more likely to have bad weather.

	The quadrants are also different for weather.
	* NW/NE are more likely to have bad weather.
	* SW/SE are more likely to have good weather.

* Money\
	This dictates how much money per barrel is to be earned. It can be $4, $10 or $20.

* Government\
	There are 4 governments
	* Conservative
	* Labour
	* Liberal
	* Nationalists

	Governments affect 3 different things
	* Interest rate on your loan.
	* Capital Gains Tax (how much you lose when selling an item to a player or bank).
	* Income Tax (how much tax on your earnings the government will take).

	Conservatives will have low tax but high interest.\
	Labour / Nationalists will have high tax but low interest.\
	Liberals are inbetween.

	**Nationalisation**\
		Labour and Nationalists can instigate "Nationalisation". This is where all player drills and concessions are bought by the government at a fixed rate.

Once all the production / government / weather effects are calculated the players are presented with a summary of their net earnings and we go back to Phase 1

Winning
-------
If a player has more than $5,000,000 in assets / cash and no bank loan they are deemed to have won

Losing
------
If a player cannot afford to pay the interest on their loan and cannot sell enough assets to cover it - they are deemed bankrupt and are permanently out of the game.\
If all players are bankrupt the game is over

Struggles when writing the game
-------------------------------
There were two main struggles with this game.\
* Lack of memory.
* Stack depth errors.

Simons' Basic allows for procedures to be created and used to make structured coding more intuitive, but a maximum stack depth of 5 meant occasionally we ran into stack issues and had to embed a procedures code into another function in order to save a stack call, another technique was to use CGOTO (Calculated Goto) to goto a piece of code then at the end it does another CGOTO LN to go back to its expected location.

As Simons' basic is a cartridge it took up a precious 8k of available basic ram from us leaving us with approx 30k free. This meant nearer the end of the project we were fighting for every byte by shrinking procedure names and variable names to as few characters as possible just to shave 2 or 3 bytes off here and there etc.
We also wasted memory by starting arrays at index 1 instead of 0 - by the time we realised this mistake it was too late and would require too much effort to adjust all the code appropriately.

Code Documentation Basic
------------------
All basic code was written directly on TheC64.

Major Variables
---------------
* Menus
	* MP$ - Menu prompt
	* MC$(MN) - Menu choices
	* MN - number of menu choices

* Board
	* BO(x=6,y=6) - Board Square Owner
		player index who owns this square,
		+ -1 = nobody
  		+ 0 = Bank (square tested, not owned)
		+ 1-6 = Player number

	* BW(x=6,y=6) - Board Square Water Depth
 		+ 1 = Shallow
   		+ 2 = Reef
		+ 3 = Deep

	* BD(x=6,y=6) - Board Square Yield
 		+ 1 = Shallow
   		+ 2 = Reef
		+ 3 = Deep

	* BR(x=6,y=6) - Board Square Rig
 		+ -1 = No rig present
   		+ 1-6 = player number who owns rig

	* Drills
		+ D1(5) = player index who owns the light drills, -1 = Bank owner
		+ D2(3) = player index who owns the special drills, -1 = Bank owner
		+ D3(5) = player index who owns the heavy drills, -1 = Bank owner

* Players
	* PN = Number players
	* PI = current player index
	* PM(PN) = players cash
	* PL(PN) = player loan
	* PP(PN) = player status
		+ 1 = playing
		+ 0 = Bankrupt
		+ 1 = Won

* Bank 
	* P1(concession,yield) how much the bank evaluates a concession is worth with or without a drill
		* Yield
			+ 1 = Drill Only
			+ 2 = Small
			+ 3 = Medium
			+ 4 = Large
 
		* Concession (even numbers=with drill)
			+ 1/2	= Shallow
			+ 3/4	= Reef	
			+ 5/6	= Deep

* Cards
	* Weather
		+ NW,NE,SW,SE = weather codes for that quadrant for the current card
		+ YC = number of years worth of cards (4)
		+ W(season,year,quadrant) = weather code for each season(0-3) year (1-YC), quadrant (1=NW,2=NE,3=SW,4=SE)
		+ SN = Season number (1-4)
		+ YI = Year index (1-YC)
  
	* Money
		+ CN - Number of money cards
		+ CI - current money card
		+ CM = MC(CN) - money card
  
	* Government
		+ GC = Number of government cards
		+ GV(GC,1-4) = Government Cards
		+ GN = GV(GC,1) = Government ID
			+ 1 = Conservative
			+ 2 = Labour
			+ 3 = Liberal
			+ 4 = Nationalist
              
		+ CT = GV(GC,2) = Capital Gains Tax
		+ RT = GV(GC,3) = Income Tax
		+ IT = GV(GC,4) = Interest Rate
		+ GI = Card #
  
	* Prospect
		+ PC = Number of prospect cards
		+ PR(PN,1-2) = Cards
		+ OD = PR(PN,1) = Depth
		+ YL = PR(PN,2) = Yield
		+ PX = Card Number
		
* Drill/Concession Counts for a player
	* Number of player concessions on the board
		* CS = Shallow
		* CR = Reef
		* DH = Deep 

	* Number of player concessions on the board with no drill on it
		* FS = Shallow
  		* FR = Reef
		* FH = Deep 

	* Number of drills owned by the player
		* PS = Shallow
  		* PR = Reef
		* PH = Deep 

	* Last free drill index (0 = none free)
		* IS = Shallow
  		* IR = Reef
		* IH = Deep 

	* Total Free Drills
		* TS = Shallow
  		* TR = Reef
		* TH = Deep 


	* UC = number of tested, but unclaimed concessions
		
* Choosing of Sea Squares\
	AL(6,6)	= This array is used to limit which squares are allowed to be clicked during the CSS procedure. If index set to 0 then square not allowed to be clicked, anything else, you can choose it.

Procedures
----------
 * FAM	= Fix All Money\
	Fixes each players money

 * FM	= Fix Money\
	Rounds the money of an individual player to nearest $500

* INIT ACTION MENU / MAKE ACTION MENU\
	This constructs the values of MC$() / AA() and MN so that the menu can be contextual. It cuts out certain possibilities (by setting AA(I) to 0) based on conditions like lack of funds etc
	* AA(menu possible) = Action Allowed.
		each index of this array represents whether a menu item is allowed. A value of 0 indicates action not allowed - anything else represents allowed.\
		The index of AA represents the menu's meaning
		+ AA(0)	= Site Testing
		+ AA(1)	= Buy Concession
		+ AA(2)	= Sell Concession
		+ AA(3)	= Buy Light Drill
		+ AA(4)	= Buy Special Drill
		+ AA(5)	= Buy Heavy Drill
		+ AA(6)	= Place Light Drill
		+ AA(7)	= Place Special Drill
		+ AA(8)	= Place Heavy Drill
		+ AA(9)	= Transfer Drills
		+ AA(10)	= Sell Drills

	* MM() this array represents the "menu meaning".
		it represents the index into the AA array for a particular menu choice as menus may have missing options.\
		e.g. if you needed to only show 2 menu options - Buy Light Drill and Place Light Drill the MM array would look like\
		MM(1) = 3	MC$(1) = "Buy Light Drill"\
		MM(2) = 6	MC$(2) = "Place Light Drill"\
		MN=2

* COUNT PLAYER DRILLS\
	Counts the various drill/concession counts for a player as specified earlier

* HANDLE PRODUCTION\
	Works out who earned what and adds it to the PM count.\
	Will destroy rigs if weather indicates

* HANDLE INTEREST\
		Works out each players interest and subtracts it from the PM 

* HANDLE BANKRUPT\
		if a player has <0 money it works out their assets and if possible forces the sale of said assets.\
		If a players assets cannot account for the debt the player is deemed bankrupt and out of the game

* BANKRUPT PLAYER\
		returns all the players assets to the bank.

* CALCUATE ASSETS\
		Calculates what a player assets would be worth if sold to the bank.

* FORCE SALE(line 3000)\
		Forces the sale of a players assets until debt repaid.

* CHECK WINNER\
		Check if a player is debt free and has assets of over 5,000,000.

* DATA INIT\
		initialises all the cards / banks etc.

* WEAI\
		Reads weather cards from the disk.

* BANK PRICES INIT\
		Initialises the matrix which dictates what the bank will pay for certain items

* GOVI\
		Reads government cards from the disk.

* PROSPECT INIT\
		Reads prospect cards from the disk.

* DRILL INIT / DRILL GAME INIT\
		Assigns all drills to be owned by the bank.

* PWEAC\
		Pick Weather Card.

* PGOVC\
		Pick Government Card.

* PICK PROSPECT CARD\
		Pick Prospect Card.

* DSA\
		Draw a particular board square on screen including its ownership, yield, drill status.

* CSS\
		Choose Sea Square, move a magnifying glass around the screen allowing the player to select an appropriate square.

* DSTF\
		Draw the tile front on a board square(BX,BY).

* CLEAR SQUARE\
		Blanks a square in the appropriate player colour.

* MOBS OFF\
		Turn off all sprites.

* MENU\
		Initiate and call the machine code sprite menu routine.

* DRAW FINGER / DRAW FINGER GRAB\
		Bank finger sprite animation.

* PICK MONEY CARD\
		Pick money card.

* DWEAF\
		Draws the weather card front tile

* DSFD\
		Draws the prospect card front tile

* DGOVF\
		Draws the government card front tile

* BUY CONCESSIONS\
		Chooses a concession and initiates the bidding process

* BID FOR CONCESSION\
		Performs concession bidding

* SELL CONCESSION\
		Sells a concession to the bank or another player

* BUY LIGHT/SPECIAL/HEAVY DRILL\
		Buys a drill from the bank

* PLACE LIGHT/SPECIAL/HEAVY DRILL\
		Places a drill in your pool onto a concession

* TRANSFER DRILLS\
		Transfers drills from one concession to another

* SELL DRILLS\
		Sells drills to the bank or another player, it asks in turn if you want to sell your light, special or heavy drills (if you have any)

* SELL DRILL TYPE\
		Generic routine for selling a specific drill type - called from SELL DRILLS

* DRAW MAP SPRITES\
		Puts the UK / North sea map sprites in their place
  
* SITE TESTING\
		Lets you choose an empty sea square and perform a site test

* CHOOSE PLAYER COUNT\
		Choose the number of players (1-6)

* CHOOSE PURCHASER\
		Generic chooser of a purchaser, either the bank or another player - players must have at least CB money (current bid) to take part

* SHUFFLE PROSPECT\
		Shuffle prospect cards

* SHUFFLE MONEY\
		Shuffle money cards

* SHUFG\
		Shuffle government cards

* SWEA\
		Shuffle weather cards

* CBID\
		Choose bid amount. Sets up the menu choices based upon the CB (current bid) and BJ array (bid jump).\
		We wanted to avoid using keyboard so made this compromise in the bidding flexibility.

* DRAWT\
		Calls the machine code routine for loading and drawing a 32x32 tile on the game board at BX,BY position.

* BOOTSTRAP\
		Loads the Machine code file loader routine from disk

* DRAW MONEY BACK\
		Draws the money tile in the bottom left

* DRAW GOV BACK\
		Draws the government info tile in the top left

* DWEAB\
		Draws the weather info tile in the top right

* OPMSG\
		Open message box

* CLMSG\
		Close message box

* START MUSIC\
		Plays the opening music (Desert Island Disks)

* ERROR SOUND\
		Plays a brrrr noise when you press an invalid square on the board

* ROUND SUMMARY\
		Displays a summary of how much money each player has earned/lost at the end of a round

* REASSIGN RIG\
		Reassigns a rig at BX,BY to a new owner (NO).

* TILE MATRIX\
		Sets up an array that maps.\
		(Water Type,Depth,Rig Present) -> Tile Number\
		Used when drawing a sea square tile

* CC\
		Change the colour according to the current player (border and menu)

* DESTROY RIGS\
		Animates the destruction of rigs in the AL(BX,BY) squares are not 0. Used during Gale weather

* CWEAB\
		Change the background colour of the weather square back quandrant based upon its weather

* CLICK SOUND\
		Plays a acknowledgement beep

* GAME OVER (50000)\
		Initiate the Game Over screen showing the results of the game

* LOSE SOUND\
		Beethovens 5th

* WIN SOUND\
		A little happy ditty

* DDS\
		Draws the number of drills still left in the pool in the bottom right

Assembly Code
-------------
All assembly language code was written on C64 Studio\
* DrawTile.asm\
		Draws a 32x32 tile loaded at $C700 to the appropriate location on the graphic screen.\
		The BX,BY coordinates are measured in chunks of 32 and are poked to $A800,$A801 prior to calling this routine
  
* fileloader.asm\
		loads a file from disk into memory. This is to get around the annoyance of basic pointers getting messed up if you issue a LOAD"file",8,1 from within basic itself
  
* mclauncher.asm\
		This turns off the kernel / basic roms and executes a machine code routine. It then turns the roms back on before exiting\
		As a lot of my machine code routines were under basic I had to have a small launcher which was called by basic and then called the intended machine code routine
  
* spritemenu2.asm\
		This draws 8 sprites in the middle of the screen and writes text on them to give the appearance of a menu\
		The routine scans Basic variable areas for MP$ and uses that as the first line\
		it scans for array MC$() and uses that for the 2nd line, letting you move between different indexes with the joystick\
		The choice made is written to $3FF
  
* quaddrawtile.asm\
		This draws mini 16x16 tiles for each of the weather types in the weather square in the top right
  
* common.asm\
		common values used across several files

I know all of this could be written more efficiently and neatly but I was often writing this on the fly with my brother on the other end of the phone waiting for me to finish the code so we could progress the game itself.\
I am also 40 years out of practice in 6502 assembly :)

		

		

		
		
