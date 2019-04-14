"VOGON for
		  THE HITCHHIKER'S GUIDE TO THE GALAXY
	(c) Copyright 1984 Infocom, Inc.  All Rights Reserved."

<OBJECT MINERAL-WATER
	(IN SATCHEL)
	(DESC "Santraginean Mineral Water")
	(LDESC "There is a bottle of mineral water here.")
	(SYNONYM BOTTLE WATER)
	(ADJECTIVE SANTRA MINERA)
	(FLAGS NARTICLEBIT DRINKBIT TAKEBIT)
	(GENERIC MINERAL-WATER)
	(ACTION MINERAL-WATER-F)>

<ROUTINE MINERAL-WATER-F ()
	 <COND (<VERB? DRINK DRINK-FROM>
		<TELL
"Bad idea. Even Santraginus Five seawater is illegal on most planets. (You can
imagine what kind of beach communities they have.)" CR>)
	       (<VERB? LOOK-INSIDE>
		<PERFORM ,V?EXAMINE ,PRSO>
		<RTRUE>)
	       (<VERB? OPEN CLOSE>
		<TELL
"This is one of those clever new always-open always-closed bottles." CR>)
	       (<VERB? POUR THROW>
		<LIQUID-SPILL>)>>

<ROOM HOLD
      (IN ROOMS)
      (SYNONYM PROTEI)
      (DESC "Vogon Hold")
      (WEST "The door to the corridor is locked (from the outside).")
      (EAST TO AIRLOCK IF VOGON-INNER-DOOR IS OPEN) ;"shouldn't happen"
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL VOGON-INNER-DOOR AIRLOCK-OBJECT FLEET HOLD-FURNISHINGS)
      (PSEUDO "WEAPON" WEAPON-PSEUDO)
      (ACTION HOLD-F)>

<ROUTINE HOLD-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <NOT <FSET? ,HOLD ,NDESCBIT>>>
		<FSET ,HOLD ,NDESCBIT>
		<FSET ,PEANUTS ,TAKEBIT>
		<FCLEAR ,PEANUTS ,NDESCBIT>
		<FCLEAR ,PEANUTS ,TRYTAKEBIT>
		<FCLEAR ,TOWEL ,TRYTAKEBIT>
		<MOVE ,PEANUTS ,PROTAGONIST>
		<MOVE ,FORD ,HERE>
		<MOVE ,MINERAL-WATER ,FORD>
		<SETG GROGGY T>
		<ENABLE <QUEUE I-GROGGY 3>>
		<ENABLE <QUEUE I-FORD 6>>
		<ENABLE <QUEUE I-ANNOUNCEMENT 18>>
		<ENABLE <QUEUE I-GUARDS 36>>
		<SETG LINE-NUMBER <RANDOM 6>>
		<SETG WORD-NUMBER <RANDOM 3>>
		<SETG SCORE <+ ,SCORE 8>>
		<SETG P-IT-OBJECT ,PEANUTS>
		<CRLF>
		<TELL
"Ford removes the bottle of " D ,MINERAL-WATER " which he's been waving under
your nose. He tells you that you are aboard a Vogon spaceship, and gives you
some peanuts." CR>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <FSET? ,HOLD ,REVISITBIT>>
		<SETG DREAMING T>
		<JIGS-UP
"A pair of Vogon guards stand nearby, waving acrid-smelling stun guns an inch
away from your face. Simultaneously, they fire.">
		<RTRUE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a squalid room filled with grubby mattresses, unwashed cups, and
unidentifiable bits of smelly alien underwear. A door lies to port, and an
airlock lies to starboard.">
		<COND (,GOWN-HUNG
		       <TELL " Your gown is hanging from a hook">
		       <COND (<NOT <FSET? ,TOWEL ,SURFACEBIT>>
			      <TELL ".">)>)>
		<COND (<FSET? ,TOWEL ,SURFACEBIT>
		       <COND (,GOWN-HUNG
			      <TELL " and a ">)
			     (T
			      <TELL " A ">)>
		       <TELL "towel is draped over a drain on the floor.">)>
		<COND (<AND ,PANEL-BLOCKER
			    <NOT <EQUAL? ,PANEL-BLOCKER ,SATCHEL>>>
		       <TELL
" Resting in front of a " D ,ROBOT-PANEL " at the base of one wall is">
		       <ARTICLE ,PANEL-BLOCKER>
		       <TELL ".">)>
		<CRLF>)>>

<OBJECT HOLD-FURNISHINGS
	(IN LOCAL-GLOBALS)
	(DESC "it")
	(SYNONYM MATTRE CUPS CUP UNDERW)
	(ADJECTIVE GRUBBY UNWASH UNIDEN SMELLY ALIEN)
	(FLAGS NDESCBIT NARTICLEBIT)
	(ACTION UNIMPORTANT-THING-F)>

<ROUTINE I-GROGGY ()
	 <ENABLE <QUEUE I-GROGGY -1>>
	 <SETG GROGGY-COUNTER <+ ,GROGGY-COUNTER 1>>
	 <COND (<NOT ,GROGGY>
		<DISABLE <INT I-GROGGY>>
		<SETG GROGGY-COUNTER 0>
		<RFALSE>)>
	 <CRLF>
	 <COND (<EQUAL? ,GROGGY-COUNTER 1 2>
		<TELL "You begin to feel ">
		<COND (<EQUAL? ,GROGGY-COUNTER 2>
		       <TELL "in">)>
		<TELL "distinctly groggy." CR>)
	       (<EQUAL? ,GROGGY-COUNTER 3>
		<TELL "You begin to feel very indistinct." CR>)
	       (T
		<TELL
"Your serious allergic reaction to protein loss from" ,BEAM "s becomes a cause
celebre amongst various holistic pressure groups in the Galaxy and leads to a
total ban on dematerialisation. Within fifty years, space travel is replaced by
a keen interest in old furniture restoration and market gardening. In this new,
quieter Galaxy, the art of telepathy flourishes as never before, creating a new
universal harmony which brings all life together, converts all matter into
thought and brings about the rebirth of the entire Universe on a higher and
better plane of existence.|
|
However, none of this affects you, because you are dead." CR>
		<FINISH>)>>

<GLOBAL GROGGY-COUNTER 0>

<GLOBAL GOWN-HUNG <>>

<GLOBAL PANEL-BLOCKER <>>

<GLOBAL ITEM-ON-SATCHEL <>>

<GLOBAL FISH-COUNTER 5>

<OBJECT DISPENSER
	(IN HOLD)
	(DESC "babel fish dispenser")
	(LDESC "Along one wall is a tall dispensing machine.")
	(SYNONYM DISPEN MACHIN SLOT)
	(ADJECTIVE DISPEN BABEL FISH TALL VENDIN)
	(ACTION DISPENSER-F)>

<ROUTINE DISPENSER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The dispenser is tall, has a button at around eye-level, and says \"Babel
Fish\" in large letters. Anything dispensed would probably come out the slot
at around knee-level.">
		<FINE-PRODUCT>
		<CRLF>)
	       (<AND <VERB? PUT-IN-FRONT>
		     <PRSO? ,HEAD ,EARS>>
		<SETG LYING-DOWN T>
		<TELL
"You are now lying down with your ear near the " D ,DISPENSER " slot." CR>)
	       (<AND <VERB? LIE-DOWN>
		     ,IN-FRONT-FLAG>
		<PERFORM ,V?PUT-IN-FRONT ,HEAD ,DISPENSER>
		<RTRUE>)>>

<OBJECT DISPENSER-BUTTON
	(IN HOLD)
	(DESC "dispenser button")
	(SYNONYM BUTTON)
	(ADJECTIVE DISPEN SINGLE BABEL FISH)
	(FLAGS NDESCBIT)
	(ACTION DISPENSER-BUTTON-F)>

<ROUTINE DISPENSER-BUTTON-F ()
 <COND (<VERB? PUSH>
	<COND (,LYING-DOWN
	       <TELL "You can't reach it from down here." CR>
	       <RTRUE>)
	      (<EQUAL? ,FISH-COUNTER 0>
	       <TELL "Click." CR>
	       <RTRUE>)>
	<SETG FISH-COUNTER <- ,FISH-COUNTER 1>>
	<TELL
"A single " D ,BABEL-FISH " shoots out of the slot. It sails across the
room and ">
	<COND (<NOT ,GOWN-HUNG>
	       <TELL
"through a " D ,FISH-HOLE " in the wall, just under a " D ,HOOK "." CR>)
	      (T
	       <TELL "hits the dressing gown. The fish slides down the ">
	       <COND (,SLEEVE-TIED
		      <TELL "inside (nice try, though)">)
		     (T
		      <TELL "sleeve">)>
	       <TELL " of the gown and falls to the floor, ">
	       <COND (<NOT <FSET? ,TOWEL ,SURFACEBIT>>
		      <TELL
"vanishing through the grating of a hitherto unnoticed drain." CR>)
		     (T
		      <TELL
"landing on the towel. A split-second later, a tiny cleaning robot whizzes
across the floor, grabs the fish, and continues its breakneck pace toward
a " D ,ROBOT-PANEL " at the base of the wall. ">
		      <COND (<NOT ,PANEL-BLOCKER>
			     <TELL
"The robot zips through the panel, and is gone." CR>)
			    (<NOT <EQUAL? ,PANEL-BLOCKER ,SATCHEL>>
			     <TELL "The robot zips around">
			     <ARTICLE ,PANEL-BLOCKER>
			     <TELL ", through the panel, and is gone." CR>)
			    (T
			     <TELL
"The robot plows into the satchel, sending the " D ,BABEL-FISH>
			     <COND
			      (<AND <NOT <EQUAL? ,ITEM-ON-SATCHEL ,MAIL>>
				    ,ITEM-ON-SATCHEL>
			       <TELL " and">
			       <ARTICLE ,ITEM-ON-SATCHEL T>)>
			     <TELL
" flying through the air in a graceful arc">
			     <COND
			      (<NOT <EQUAL? ,ITEM-ON-SATCHEL ,MAIL>>
			       <TELL
". " ,ROBOT-FLIES-IN "catches the " D ,BABEL-FISH " ">
			       <COND (,ITEM-ON-SATCHEL
				      <MOVE ,ITEM-ON-SATCHEL ,LOCAL-GLOBALS>
				      <TELL "and also manages to catch">
				      <ARTICLE ,ITEM-ON-SATCHEL T>
				      <SETG ITEM-ON-SATCHEL <>>)
				     (T
				      <TELL
"(which is all the flying junk it can find)">)>
			       <TELL ", and exits." CR>)
			      (<EQUAL? ,ITEM-ON-SATCHEL ,MAIL>
			       <MOVE ,MAIL ,LOCAL-GLOBALS>
			       <SETG SCORE <+ ,SCORE 12>>
			       <MOVE ,BABEL-FISH ,PROTAGONIST>
			       <COND (<RUNNING? ,I-ANNOUNCEMENT>
				      <ENABLE <QUEUE I-GUARDS 4>>)
				     (<NOT
				       <FSET? ,CAPTAINS-QUARTERS ,TOUCHBIT>>
				      <ENABLE <QUEUE I-ANNOUNCEMENT 4>>
				      <ENABLE <QUEUE I-GUARDS 7>>)>
			       <SETG FISH-COUNTER 0>
			       <SETG ITEM-ON-SATCHEL <>>
			       <TELL
" surrounded by a cloud of junk mail. Another robot flies in and begins madly
collecting the cluttered plume of mail. The " D ,BABEL-FISH " continues its
flight, landing with a loud \"squish\" in your ear." CR>)>)>)>)>)>>

<OBJECT FISH-HOLE
	(IN HOLD)
	(DESC "small hole")
	(SYNONYM HOLE)
	(ADJECTIVE SMALL)
	(FLAGS NDESCBIT)
	(ACTION FISH-HOLE-F)>

<ROUTINE FISH-HOLE-F ()
	 <COND (<VERB? LOOK-INSIDE>
		<TELL "You see only " D ,DARK-OBJECT "." CR>)
	       (<AND <VERB? PUT>
		     <PRSI? ,FISH-HOLE>>
		<COND (<FSET? ,PRSO ,INTEGRALBIT>
		       <PART-OF>)
		      (<L? <GETP ,PRSO ,P?SIZE> 5>
		       <MOVE ,PRSO ,LOCAL-GLOBALS>
		       <TELL "It falls through the hole and vanishes." CR>)
		      (T
		       <TELL "It doesn't fit through the hole." CR>)>)
	       (<AND <VERB? PUT-ON PUT-IN-FRONT>
		     <PRSI? ,FISH-HOLE>>
		<COND (<PRSO? ,HANDS ,EARS ,ME ,HEAD>
		       <PERFORM ,V?STAND-BEFORE ,FISH-HOLE>
		       <RTRUE>)>
		<PERFORM ,V?HANG ,PRSO ,HOOK>
		<RTRUE>)
	       (<AND <VERB? BLOCK-WITH SPUT-ON>
		     <PRSO? ,FISH-HOLE>>
		<PERFORM ,V?HANG ,PRSI ,HOOK>
		<RTRUE>)
	       (<VERB? BLOCK>
		<PERFORM ,V?STAND-BEFORE ,FISH-HOLE>
		<RTRUE>)
	       (<AND <VERB? LIE-DOWN>
		     ,IN-FRONT-FLAG>
		<PERFORM ,V?STAND-BEFORE ,FISH-HOLE>
		<RTRUE>)>>

<OBJECT HOOK
	(IN HOLD)
	(DESC "metal hook")
	(SYNONYM HOOK)
	(ADJECTIVE METAL)
	(FLAGS NDESCBIT)
	(ACTION HOOK-F)>

<ROUTINE HOOK-F ()
	 <COND (<VERB? EXAMINE>
		<COND (,GOWN-HUNG
		       <TELL "Your gown is hanging from it." CR>)
		      (T
		       <TELL
"The hook is attached to the wall, inches above a tiny hole." CR>)>)
	       (<VERB? HANG PUT-ON>
		<COND (,LYING-DOWN
		       <TELL ,WHILE-LYING CR>)
		      (<PRSO?,GOWN>
		       <COND (<FSET? ,GOWN ,WORNBIT>
			      <IDROP>
			      <RTRUE>)>
		       <SETG GOWN-HUNG T>
		       <MOVE ,GOWN ,HERE>
		       <FSET ,GOWN ,NDESCBIT>
		       <FSET ,GOWN ,TRYTAKEBIT>
		       <FCLEAR ,GOWN ,OPENBIT>
		       <TELL
"The gown is now hanging from the hook, covering a tiny hole." CR>)
		      (<PRSO? ,HANDS ,EARS ,HEAD>
		       <PERFORM ,V?STAND-BEFORE ,HOOK>
		       <RTRUE>)
		      (<FSET? ,PRSO ,TAKEBIT>
		       <COND (<FSET? ,PRSO ,TRYTAKEBIT>
			      <TELL ,NOT-HOLDING>
			      <ARTICLE ,PRSO T>
			      <TELL "." CR>)
			     (T
		       	      <MOVE ,PRSO ,HERE>
		       	      <TELL "It slips off the hook." CR>)>)
		      (T
		       <V-COUNT>)>)>>

<OBJECT DRAIN
	(IN HOLD)
	(DESC "drain")
	(SYNONYM DRAIN GRATING GRATE)
	(FLAGS NDESCBIT)
	(ACTION DRAIN-F)>

<ROUTINE DRAIN-F ()
	 <COND (<VERB? PUT-ON>
		<COND (<FSET? ,TOWEL ,SURFACEBIT>
		       <TELL "The drain is already covered by the towel." CR>)
		      (,LYING-DOWN
		       <TELL ,WHILE-LYING CR>)
		      (<PRSO?,TOWEL>
		       <FSET ,TOWEL ,CONTBIT>
		       <FSET ,TOWEL ,SURFACEBIT>
		       <FSET ,TOWEL ,OPENBIT>
		       <FSET ,TOWEL ,NDESCBIT>
		       <FSET ,TOWEL ,TRYTAKEBIT>
		       <MOVE ,TOWEL ,HERE>
		       <PERFORM ,V?EXAMINE ,DRAIN>
		       <RTRUE>)
		      (T
		       <TELL "The drain is too large to be covered by">
		       <ARTICLE ,PRSO T>
		       <TELL "." CR>)>)
	       (<VERB? LOOK-INSIDE>
		<PERFORM ,V?LOOK-INSIDE ,FISH-HOLE>
		<RTRUE>)
	       (<AND <VERB? EXAMINE>
		     <FSET? ,TOWEL ,SURFACEBIT>>
		<TELL "The towel completely covers the drain." CR>)>> 

<OBJECT ROBOT-PANEL
	(IN HOLD)
	(DESC "tiny robot panel")
	(SYNONYM PANEL)
	(ADJECTIVE ROBOT TINY)
	(FLAGS NDESCBIT)
	(ACTION ROBOT-PANEL-F)>

<ROUTINE ROBOT-PANEL-F ()
	 <COND (<VERB? EXAMINE CLOSE>
		<TELL
"The panel, only a few inches high, is currently closed." CR>)
	       (<VERB? OPEN>
		<TELL ,BUDGE CR>)
	       (<VERB? BLOCK>
		<SETG AWAITING-REPLY 6>
		<ENABLE <QUEUE I-REPLY 2>>
		<TELL "With " D ,HANDS "s? By force of will?" CR>)
	       (<AND <VERB? LIE-DOWN>
		     ,IN-FRONT-FLAG>
		<PERFORM ,V?STAND-BEFORE ,ROBOT-PANEL>
		<RTRUE>)
	       (<AND <VERB? PUT-IN-FRONT PUT-IN-FRONT PUT-ON>
		     <PRSI? ,ROBOT-PANEL>>
		<PERFORM ,V?BLOCK-WITH ,ROBOT-PANEL ,PRSO>
		<RTRUE>)
	       (<AND <VERB? BLOCK-WITH SPUT-ON>
			 <PRSO? ,ROBOT-PANEL>>
		<COND (<PRSI? ,HEAD ,HANDS ,EARS ,EYES>
		       <V-COUNT>)
		      (<NOT <HELD? ,PRSI>>
		       <TELL ,NOT-HOLDING>
		       <ARTICLE ,PRSI T>
		       <TELL "." CR>)
		      (,PANEL-BLOCKER
		       <TELL "But">
		       <ARTICLE ,PANEL-BLOCKER T>
		       <TELL
" is already in front of the " D ,ROBOT-PANEL "." CR>)
		      (,LYING-DOWN
		       <TELL ,WHILE-LYING CR>)
		      (T
		       <MOVE ,PRSI ,HERE>
		       <SETG PANEL-BLOCKER ,PRSI>
		       <FSET ,PRSI ,TRYTAKEBIT>
		       <TELL "Okay,">
		       <COND (<PRSI? ,SATCHEL>
			      <TELL " the satchel is lying on its side">)
			     (T
			      <FSET ,PRSI ,NDESCBIT>
			      <ARTICLE ,PRSI T>
			      <TELL " is sitting">)>
		       <TELL " in front of the " D ,ROBOT-PANEL "." CR>)>)>>

<OBJECT BABEL-FISH
	(IN LOCAL-GLOBALS) ;"just for the purpose of MOBY-FIND"
	(DESC "babel fish")
	(SYNONYM FISH)
	(ADJECTIVE BABEL)
	(FLAGS TAKEBIT)
	(ACTION BABEL-FISH-F)>

<ROUTINE BABEL-FISH-F ()
	 <COND (<VERB? TAKE REMOVE>
		<TELL
"That would be foolish. Having a " D ,BABEL-FISH " in your ear is terribly
useful." CR>)>>

<OBJECT GLASS-CASE
	(IN HOLD)
	(DESC "glass case")
	(LDESC "In the corner is a glass case with a switch and a keyboard.")
	(SYNONYM CASE LID GLASS)
	(ADJECTIVE GLASS)
	(SIZE 40)
	(FLAGS CONTBIT TRANSBIT SEARCHBIT)
	(ACTION GLASS-CASE-F)>

<GLOBAL GLASS-CASE-SCORE <>>

<ROUTINE GLASS-CASE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "The " D ,GLASS-CASE " is ">
		<COND (<FSET? ,GLASS-CASE ,OPENBIT>
		       <TELL "open">)
		      (T
		       <TELL "closed">)>
		<TELL
". Attached to it are a " D ,KEYBOARD " and a switch." CR>)
	       (<AND <VERB? OPEN>
		     <NOT <FSET? ,GLASS-CASE ,OPENBIT>>>
		<TELL ,BUDGE CR>)
	       (<VERB? MUNG>
		<TELL
"The hold of the Vogon ship is virtually undamaged by the explosion
of the " D ,GLASS-CASE>
		<JIGS-UP
". You, however, are blasted into tiny bits and smeared all over the room.
Several cleaning robots fly in and wipe you neatly off the walls.">
		<RTRUE>)>>

<ROUTINE GLASS-CASE-OPENS () ;"see V-TYPE"
	 <COND (<FSET? ,GLASS-CASE ,OPENBIT>
		<TELL "Nothing happens." CR>
		<FUCKING-CLEAR>)
	       (T
		<FSET ,GLASS-CASE ,OPENBIT>
		<TELL "The " D ,GLASS-CASE " opens." CR>
		<FCLEAR ,PLOTTER ,TRYTAKEBIT>
		<COND (<NOT ,GLASS-CASE-SCORE>
		       <SETG GLASS-CASE-SCORE T>
		       <SETG SCORE <+ ,SCORE 25>>)>
		<FUCKING-CLEAR>)>>

<OBJECT KEYBOARD
	(IN HOLD)
	(DESC "keyboard")
	(SYNONYM KEYBOA)
	(FLAGS NDESCBIT TRYTAKEBIT)>

<OBJECT CASE-SWITCH
	(IN HOLD)
	(DESC "switch")
	(SYNONYM SWITCH)
	(FLAGS NDESCBIT SWITCHBIT)
	(ACTION CASE-SWITCH-F)>

<ROUTINE CASE-SWITCH-F ()
	 <COND (<VERB? LAMP-ON TURN PUSH MOVE THROW>
		<COND (<HELD? ,BABEL-FISH>
		       <TELL
"A recording plays: \"To open the case, type in the ">
		       <COND (<EQUAL? ,WORD-NUMBER 1>
			      <TELL "first">)
			     (<EQUAL? ,WORD-NUMBER 2>
			      <TELL "second">)
			     (<EQUAL? ,WORD-NUMBER 3>
			      <TELL "third">)>
		       <TELL
" word from the second verse of the Captain's current favourite poem.
WARNING: An incorrect input will cause the case to explode.\"" CR>)
		      (T
		       <TELL "A recording plays: \"A">
		       <PRODUCE-GIBBERISH 5>
		       <CRLF>)>)>>

<ROUTINE PRODUCE-GIBBERISH (N "AUX" GIBBERISH-COUNTER SUPER-COUNTER)
	 <SET SUPER-COUNTER 0>
	 <REPEAT ()
		 <SET SUPER-COUNTER <+ .SUPER-COUNTER 1>>
		 <SET GIBBERISH-COUNTER 0>
		 <REPEAT ()
			 <SET GIBBERISH-COUNTER <+ .GIBBERISH-COUNTER 1>>
			 <TELL <PICK-ONE ,GIBBERISH>>
			 <COND (<EQUAL? .GIBBERISH-COUNTER 10>
				<COND (<NOT <EQUAL? .SUPER-COUNTER .N>>
				       <TELL " o">)>
				<RETURN>)>>
		 <COND (<EQUAL? .SUPER-COUNTER .N>
			<TELL ".\"">
			<RETURN>)>>>

<ROUTINE I-ANNOUNCEMENT ()
	 <ENABLE <QUEUE I-ANNOUNCEMENT -1>>
	 <TELL CR "An announcement is coming over the ship's intercom. \"">
	 <COND (<HELD? ,BABEL-FISH ,PROTAGONIST>
		<TELL
"This is the Captain. My instruments show that we've picked up a couple of
hitchhikers. I hate freeloaders, and when my guards find you I'll have you
thrown into space. On second thought, maybe I'll read you some of my poetry
first. Repeating...\"" CR>)
	       (T
		<TELL "E">
		<PRODUCE-GIBBERISH 10>
		<CRLF>)>>

<GLOBAL GIBBERISH
	<PLTABLE
"toy" "r g" "irb" "kwa" "o s"
"fim" "p w" "osh" "flu" "a r"
"vup" "d t" "imb" "tha" "i l"
"cav" "s g" "ulp" "cho" "u n"
"zit" "z z" "eft" "qui" "e h"
"kon" "l m" "ork" "gry" "o t"
"huv" "x j" "erl" "tru" "a b"
"fud" "w c" "oll" "wro" "i s">>

<ROUTINE I-GUARDS ()
	 <COND (<EQUAL? ,HERE ,HOLD>
		<DISABLE <INT I-ANNOUNCEMENT>>
		<TELL CR
"Guards burst in and grab you and Ford, who comes slowly awake. They drag you
down the corridor to a large cabin, where they strap you into large, menacing
chairs..." CR CR>
		<SETG HERE ,CAPTAINS-QUARTERS>
		<MOVE ,NAME ,HERE>
		<SETG LYING-DOWN <>>
		<ENABLE <QUEUE I-CAPTAIN 2>>
		<SETG FORD-SLEEPING <>>
		<FSET ,FORD ,NDESCBIT>
		<MOVE ,PROTAGONIST ,POETRY-APPRECIATION-CHAIR>
		<V-LOOK>
		<MOVE ,FORD ,HERE>
		<MOVE ,GUARDS ,HERE>)
	       (<NOT <IN? ,RIFLES ,LOCAL-GLOBALS>>
		<TELL CR ,GUARDS-REALIZE "They">
		<GUARD-DEATH>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROOM CAPTAINS-QUARTERS
      (IN ROOMS)
      (DESC "Captain's Quarters")
      (FLAGS RLANDBIT ONBIT)
      (PSEUDO "WEAPON" WEAPON-PSEUDO "STRAPS" UNIMPORTANT-THING-F)
      (GLOBAL FLEET)
      (ACTION CAPTAINS-QUARTERS-F)>

<ROUTINE CAPTAINS-QUARTERS-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is the cabin of the " D ,VOGON-CAPTAIN ". You and Ford are strapped
into " D ,POETRY-APPRECIATION-CHAIR "s." CR>)>>

<OBJECT POETRY-APPRECIATION-CHAIR
	(IN CAPTAINS-QUARTERS)
	(DESC "poetry appreciation chair")
	(SYNONYM CHAIR CHAIRS SEAT)
	(ADJECTIVE POETRY APPREC FORMID LARGE MENACI)
	(FLAGS VEHBIT OPENBIT SEARCHBIT SURFACEBIT CONTBIT)
	(ACTION POETRY-APPRECIATION-CHAIR-F)>

<ROUTINE POETRY-APPRECIATION-CHAIR-F ("OPTIONAL" (RARG <>))
	 <COND (.RARG
		<RFALSE>)
	       (<VERB? DISEMBARK WALK LEAP WALK-AROUND>
		<SETG AWAITING-REPLY 7>
		<ENABLE <QUEUE I-REPLY 2>>
		<TELL "You're strapped in, remember?" CR>)
	       (<AND <VERB? OPEN CLOSE>
		     <PRSO? ,POETRY-APPRECIATION-CHAIR>>
		<TELL-ME-HOW>)>> 

<OBJECT VOGON-CAPTAIN
	(IN CAPTAINS-QUARTERS)
	(DESC "Vogon Captain")
	(LDESC
"The Captain is indescribably hideous, indescribably blubbery,
and indescribably mid-to-dark green. He is holding samples of his
favourite poetry.")
	(SYNONYM CAPTAIN VOGONS)
	(ADJECTIVE VOGON)
	(FLAGS ACTORBIT)
	(ACTION VOGON-CAPTAIN-F)>

<ROUTINE VOGON-CAPTAIN-F ()
	 <COND (<OR <VERB? TELL HELLO THANK>
		    <AND <VERB? ASK-ABOUT ASK-FOR>
			 <EQUAL? ,VOGON-CAPTAIN ,PRSO>>>
		<TELL
"One of the guards lightly bashes your skull with the butt of his weapon">
		<COND (<HELD? ,BABEL-FISH>
		       <TELL
". \"This is a poetry appreciation session, prisoner. No talking!\"" CR>)
		      (T
		       <TELL " and says, \"A">
		       <PRODUCE-GIBBERISH 2>
		       <CRLF>)>
		<FUCKING-CLEAR>)
	       (<AND <IN? ,POETRY ,HERE>
		     <VERB? BLOCK>>
		<PERFORM ,V?LISTEN ,POETRY>
		<RTRUE>)>> 

<GLOBAL CAPTAIN-COUNTER 0>

<ROUTINE I-CAPTAIN ()
	 <ENABLE <QUEUE I-CAPTAIN -1>>
	 <SETG CAPTAIN-COUNTER <+ ,CAPTAIN-COUNTER 1>>
         <CRLF>
	 <COND (<EQUAL? ,CAPTAIN-COUNTER 1>
		<TELL
"\"If he's going to read us his poetry,\" mutters Ford, sweating profusely,
\"just pray he softens us up with some cudgels first...\"" CR CR>)>
	 <COND (<NOT <HELD? ,BABEL-FISH ,PROTAGONIST>>
		<TELL "The " D ,VOGON-CAPTAIN " says, \"O">
		<PRODUCE-GIBBERISH 2>
		<COND (<EQUAL? ,CAPTAIN-COUNTER 6>
		       <GUARDS-TO-AIRLOCK>)
		      (T
		       <CRLF>)>)
	       (<EQUAL? ,CAPTAIN-COUNTER 1>
		<TELL
"\"Hello, hitchhikers!\" begins the " D ,VOGON-CAPTAIN ". \"I've decided to
read you a verse of my poetry!\"" CR>)
	       (<EQUAL? ,CAPTAIN-COUNTER 2>
		<TELL
"\"Oh freddled gruntbuggly, thy nacturations are to me!\"" CR>)
	       (<EQUAL? ,CAPTAIN-COUNTER 3>
		<TELL
"\"As plurdled gabbleblotchits on a lurgid bee.\"" CR>)
	       (<EQUAL? ,CAPTAIN-COUNTER 4>
		<TELL
"\"Groop I implore thee, my foonting turlingdromes.\"" CR>)
	       (<EQUAL? ,CAPTAIN-COUNTER 5>
		<TELL
"\"And hooptiously drangle me with crinkly bindlewurdles, or I will rend
thee in the gobberwarts with my blurglecruncheon, see if I don't!\"" CR>)
	       (<EQUAL? ,CAPTAIN-COUNTER 6>
		<COND (,POEM-ENJOYED
		       <TELL
"\"You looked like you enjoyed my poem. I think...yes, I think I'll read
the NEXT verse, also!\"" CR>)
		      (T
		       <TELL
"\"You didn't seem to enjoy my poem at all! Guards, toss
them out the airlock!\"">
		       <GUARDS-TO-AIRLOCK>)>)
	       (<EQUAL? ,CAPTAIN-COUNTER 7>
		<COND (<EQUAL? ,LINE-NUMBER 1 2>
		       <TELL ,LINE-A CR>)
		      (<EQUAL? ,LINE-NUMBER 3 4>
		       <TELL ,LINE-B CR>)
		      (T
		       <TELL ,LINE-C CR>)>)
	       (<EQUAL? ,CAPTAIN-COUNTER 8>
		<COND (<EQUAL? ,LINE-NUMBER 3 5>
		       <TELL ,LINE-A CR>)
		      (<EQUAL? ,LINE-NUMBER 1 6>
		       <TELL ,LINE-B CR>)
		      (T
		       <TELL ,LINE-C CR>)>)
	       (<EQUAL? ,CAPTAIN-COUNTER 9>
		<COND (<EQUAL? ,LINE-NUMBER 4 6>
		       <TELL ,LINE-A CR>)
		      (<EQUAL? ,LINE-NUMBER 2 5>
		       <TELL ,LINE-B CR>)
		      (T
		       <TELL ,LINE-C CR>)>)
	       (<EQUAL? ,CAPTAIN-COUNTER 10>
		<TELL
"\"Gerond withoutitude form into formless bloit, why not then? Moose.\"" CR>)
	       (<EQUAL? ,CAPTAIN-COUNTER 11>
		<TELL
"\"Since you have somehow managed to survive two verses of my poetry, I have
no choice but to space you. Guards!\"">
		<GUARDS-TO-AIRLOCK>)>>

<GLOBAL LINE-A "\"Fripping lyshus wimbgunts, awhilst moongrovenly kormzibs.\"">

<GLOBAL LINE-B "\"Gashee morphousite, thou expungiest quoopisk!\"">

<GLOBAL LINE-C
"\"Bleem miserable venchit! Bleem forever mestinglish asunder frapt.\"">

<GLOBAL LINE-NUMBER 0>

;"The line order is set randomly from 1 to 6, with the following result:
	1	Line A, Line B, Line C
	2	Line A, Line C, Line B
	3	Line B, Line A, Line C
	4	Line B, Line C, Line A
	5	Line C, Line A, Line B
	6	Line C, Line B, Line A"

<GLOBAL WORD-NUMBER 0> ;"randomly set between one and three"

<ROUTINE GUARDS-TO-AIRLOCK ()
	 <DISABLE <INT I-CAPTAIN>>
	 <TELL
" A guard grabs you and Ford, and drags you toward the hold. Ford whispers,
\"Don't worry, I'll think of something!\"" CR CR>
	 <FCLEAR ,HOLD ,TOUCHBIT>
	 <GOTO ,HOLD>
	 <FCLEAR ,FORD ,NDESCBIT>
	 <MOVE ,GUARDS ,HERE>
	 <MOVE ,FORD ,HERE>
	 <ENABLE <QUEUE I-FORD 1>>>

<OBJECT POETRY
	(IN CAPTAINS-QUARTERS)
	(DESC "Vogon poetry")
	(SYNONYM POETRY POEM SAMPLE VERSE)
	(ADJECTIVE VOGON FIRST SECOND)
	(FLAGS NDESCBIT NARTICLEBIT DARKBIT)
	(ACTION POETRY-F)>

<GLOBAL POEM-ENJOYED <>>

<GLOBAL AIRLOCK-COUNTER 0>

<ROUTINE POETRY-F ()
	 <COND (<AND <VERB? ENJOY LISTEN>
		     <L? ,CAPTAIN-COUNTER 2>>
		<TELL "The " D ,VOGON-CAPTAIN " hasn't begun yet!" CR>)
	       (<VERB? ENJOY>
		<COND (<NOT <HELD? ,BABEL-FISH>>
		       <TELL
"You can't even understand it, let alone enjoy it!" CR>)
		      (,POEM-ENJOYED
		       <SETG AWAITING-REPLY 8>
		       <ENABLE <QUEUE I-REPLY 2>>
		       <TELL "Hey, let's not overdo it, okay?" CR>)
		      (T
		       <SETG POEM-ENJOYED T>
		       <SETG SCORE <+ ,SCORE 15>>
		       <TELL
"You realise that, although the " D ,POETRY " is indeed astoundingly bad,
worse things happen at sea, and in fact, at school. With an effort for which
Hercules himself would have patted you on the back, you grit your teeth and
enjoy the stuff." CR>)>)
	       (<VERB? LISTEN>
		<TELL "You have no choice. Why not relax and enjoy it?" CR>)
	       (<AND <IN? ,POETRY ,HERE>
		     <VERB? BLOCK>>
		<PERFORM ,V?LISTEN ,POETRY>
		<RTRUE>)
	       (<VERB? READ EXAMINE>
		<TELL "You can't see it from here." CR>)>>

<OBJECT VOGON-CORRIDOR-DOOR
	(IN HOLD)
	(DESC "corridor door")
	(SYNONYM DOOR)
	(ADJECTIVE CORRID)
	(FLAGS DOORBIT NDESCBIT)
	(ACTION VOGON-CORRIDOR-DOOR-F)>

<ROUTINE VOGON-CORRIDOR-DOOR-F ()
	 <COND (<VERB? OPEN UNLOCK THROUGH>
		<DO-WALK ,P?WEST>)>>

<OBJECT VOGON-INNER-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "inner door")
	(SYNONYM DOOR)
	(ADJECTIVE INNER AIRLOC MASSIV)
	(FLAGS VOWELBIT NDESCBIT DOORBIT)
	(ACTION VOGON-AIRLOCK-DOOR-F)>

<OBJECT VOGON-OUTER-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "outer door")
	(SYNONYM DOOR)
	(ADJECTIVE OUTER AIRLOC MASSIV)
	(FLAGS VOWELBIT NDESCBIT DOORBIT)
	(ACTION VOGON-AIRLOCK-DOOR-F)>

<ROUTINE VOGON-AIRLOCK-DOOR-F ()
	 <COND (<VERB? OPEN THROUGH>
		<TELL ,BUDGE CR>)>>

<OBJECT AIRLOCK-OBJECT
	(IN LOCAL-GLOBALS)
	(DESC "airlock")
	(SYNONYM AIRLOC)
	(FLAGS VOWELBIT)
	(ACTION AIRLOCK-OBJECT-F)>

<ROUTINE AIRLOCK-OBJECT-F ()
	 <COND (<VERB? THROUGH WALK-TO>
		<COND (<EQUAL? ,HERE ,AIRLOCK>
		       <TELL ,LOOK-AROUND CR>)
		      (<EQUAL? ,HERE ,HOLD>
		       <DO-WALK ,P?WEST>)>)
	       (<VERB? LEAVE EXIT DISEMBARK>
		<COND (<EQUAL? ,HERE ,AIRLOCK>
		       <DO-WALK ,P?EAST>)
		      (T
		       <TELL ,LOOK-AROUND CR>)>)>>

<OBJECT EQUATIONS
	(IN LOCAL-GLOBALS)
	(DESC "it")
	(SYNONYM EQUATI NUMBER PENCIL)
	(FLAGS NDESCBIT NARTICLEBIT)
	(ACTION UNIMPORTANT-THING-F)>

<ROOM AIRLOCK
      (IN ROOMS)
      (SYNONYM BETELG)
      (DESC "Airlock")
      (LDESC "This airlock has massive doors to port and starboard.")
      (WEST TO HOLD IF VOGON-INNER-DOOR IS OPEN) ;"this should never happen"
      (EAST TO HOLD IF VOGON-OUTER-DOOR IS OPEN) ;"ditto"
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL VOGON-INNER-DOOR VOGON-OUTER-DOOR AIRLOCK-OBJECT FLEET EQUATIONS)
      (ACTION AIRLOCK-F)>

<ROUTINE AIRLOCK-F (RARG)
	 <COND (<EQUAL? .RARG ,M-END>
		<SETG AIRLOCK-COUNTER <+ ,AIRLOCK-COUNTER 1>>
		<CRLF>
		<COND (<EQUAL? ,AIRLOCK-COUNTER 1>
		       <TELL
"Ford points at the " D ,VOGON-OUTER-DOOR ". \"In about two minutes, it will
open and we'll be ejected into the vacuum of space. But don't panic, I'll
think of something.\"" CR>)
		      (<EQUAL? ,AIRLOCK-COUNTER 2>
		       <TELL "Ford is mumbling to himself." CR>)
		      (<EQUAL? ,AIRLOCK-COUNTER 3>
		       <TELL
"Ford produces a pencil and begins scribbling equations on the wall." CR>)
		      (<EQUAL? ,AIRLOCK-COUNTER 4>
		       <TELL
"Ford's eyes light up. \"Do you still have the Electronic Sub-Etha Auto
Hitching Thu...\" At that moment, the airlock door opens, and you and Ford
are blown out into space.||">
		       <COND (<HELD? ,GUIDE>
			      <TELL
"Your elbow must have struck some key on " D ,GUIDE " because it begins
droning out an entry, coincidentally enough the entry on SPACE. \""
,SPACE-TEXT "\" (Footnote 9)" CR CR>)>
		       <TELL
"Precisely twenty-nine seconds later, you and Ford are scooped up by a passing
ship. Gasping for air, you pass out..." CR CR>
		       <SETG HEART-PROB 100>
		       <GOTO ,DARK>)>)>>