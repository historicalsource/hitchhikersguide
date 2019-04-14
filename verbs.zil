"VERBS for
		  THE HITCHHIKER'S GUIDE TO THE GALAXY
	(c) Copyright 1984 Infocom, Inc.  All Rights Reserved."

;"subtitle game commands"

<GLOBAL VERBOSITY 1> ;"0 = superbrief, 1 = brief, 2 = verbose"

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSITY 2>
	 <TELL "Maximum verbosity." CR CR>
	 <V-LOOK>>

<ROUTINE V-BRIEF ()
	 <SETG VERBOSITY 1>
	 <TELL "Brief descriptions." CR>>

<ROUTINE V-SUPER-BRIEF ()
	 <SETG VERBOSITY 0>
	 <TELL "Super-brief descriptions." CR>>

<ROUTINE V-DIAGNOSE ()
	 <COND (,HEADACHE
		<TELL "You have a big blinding throbber." CR>)
	       (,GROGGY
		<TELL "You feel weak." CR>)
	       (<EQUAL? ,IDENTITY-FLAG ,ZAPHOD>
		<TELL "You have two " D ,HANGOVER "s." CR>)
	       (T
		<TELL "You are in good health." CR>)>>

<ROUTINE V-INVENTORY ("AUX" SPARE-KLUDGE)
	 <COND (<FSET? ,SPARE-DRIVE ,NDESCBIT>
		<SET SPARE-KLUDGE T>
		<FCLEAR ,SPARE-DRIVE ,NDESCBIT>)
	       (T
		<SET SPARE-KLUDGE <>>)>
	 <COND (<AND <NOT <EQUAL? ,IDENTITY-FLAG ,ARTHUR>>
		     <NOT <FIRST? ,PROTAGONIST>>>
		<TELL "You are empty-handed." CR>)
	       (T
		<TELL "You have:" CR>
		<COND (,HEADACHE
		       <TELL "  a " D ,HANGOVER CR>)>
		<COND (<AND <EQUAL? ,IDENTITY-FLAG ,ARTHUR>
			    <OR ,HOLDING-NO-TEA
				<NOT <HELD? ,TEA>>>>
		       <SETG HOLDING-NO-TEA T>
		       <TELL "  no tea" CR>)>
		<PRINT-CONT ,PROTAGONIST>)>
	 <COND (.SPARE-KLUDGE
		<FSET ,SPARE-DRIVE ,NDESCBIT>)>>

<ROUTINE V-QUIT ()
	 <V-SCORE>
	 <TELL
"Do you wish to leave the game? (Y is affirmative): ">
	 <COND (<YES?>
		<QUIT>)
	       (T
		<TELL "Ok." CR>)>>

<ROUTINE V-RESTART ()
	 <V-SCORE T>
	 <TELL "Do you wish to restart? (Y is affirmative): ">
	 <COND (<YES?>
		<TELL "Restarting." CR>
		<RESTART>
		<TELL "Failed." CR>)>>

<ROUTINE FINISH ("OPTIONAL" (REPEATING <>))
	 <CRLF>
	 <COND (<NOT .REPEATING>
		<V-SCORE>
		<CRLF>)>
	 <TELL
"Would you like to start over, restore a saved position, or end this session
of the game?|
(Type RESTART, RESTORE, or QUIT): >">
	 <READ ,P-INBUF ,P-LEXV>
	 <COND (<EQUAL? <GET ,P-LEXV 1> ,W?RESTAR>
	        <RESTART>
		<TELL "Failed." CR>
		<FINISH T>)
	       (<EQUAL? <GET ,P-LEXV 1> ,W?RESTOR>
		<COND (<RESTORE>
		       <TELL "Ok." CR>)
		      (T
		       <TELL "Failed." CR>
		       <FINISH T>)>)
	       (<EQUAL? <GET ,P-LEXV 1> ,W?QUIT ,W?Q>
		<QUIT>)
	       (T
		<FINISH T>)>>

<ROUTINE YES? ()
	 <PRINTI ">">
	 <READ ,P-INBUF ,P-LEXV>
	 <COND (<EQUAL? <GET ,P-LEXV 1> ,W?YES ,W?Y>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-RESTORE ()
	 <COND (<RESTORE>
		<TELL "Ok." CR>)
	       (T
		<TELL "Failed." CR>)>>

<ROUTINE V-SAVE ()
	 <COND (<SAVE>
	        <TELL "Ok." CR>)
	       (T
		<TELL "Failed." CR>)>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
	 <COND (<L? ,SCORE 400>
		<TELL
"We are about to give you your score. Put on your peril-sensitive sunglasses
now. (Hit RETURN or ENTER when ready.) ">
		<PRINTI ">">
		<READ ,P-INBUF ,P-LEXV>
		<SETG P-CONT <>>
		<CRLF>)>
	 <TELL "Your score is " N ,SCORE " of a possible 400, in " N ,MOVES>
	 <COND (<1? ,MOVES>
		<TELL " turn.">)
	       (T
		<TELL " turns.">)>
	 <CRLF>
	 ,SCORE>

<ROUTINE V-SCRIPT ()
	<PUT 0 8 <BOR <GET 0 8> 1>>
	<COPR-NOTICE "begins">
	<V-VERSION>>

<ROUTINE V-UNSCRIPT ()
	<COPR-NOTICE "ends">
	<V-VERSION>
	<PUT 0 8 <BAND <GET 0 8> -2>>
	<RTRUE>>

<ROUTINE COPR-NOTICE (STRING)
	 <TELL
"Here " .STRING " a transcript of interaction with " ,GUIDE-NAME "." CR>>

<ROUTINE V-VERSION ("AUX" (CNT 17) V)
	 <SET V <BAND <GET 0 1> *3777*>>
	 <TELL
"THE HITCHHIKER'S GUIDE TO THE GALAXY|
Infocom interactive fiction - a science fiction story|
Copyright (c) 1984 by Infocom, Inc. All rights reserved.|">
	 ;<COND (<NOT <EQUAL? <BAND <GETB 0 1> 8> 0>>
		<TELL
"Licensed to Tandy Corporation. Version 00.00." N .V CR>)>
	 <TELL "Release " N .V " / Serial number ">
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> 23>
			<RETURN>)
		       (T
			<PRINTC <GETB 0 .CNT>>)>>
	 <CRLF>>

<ROUTINE V-$VERIFY ()
	 <COND (<AND <PRSO? ,INTNUM>
		     <EQUAL? ,P-NUMBER 469>>
		<TELL N ,SERIAL CR>)
	       (T
		<TELL "Verifying..." CR>
	 	<COND (<VERIFY>
		       <TELL "Good." CR>)
	       	      (T
		       <TELL CR "** Bad **" CR>)>)>>

<CONSTANT SERIAL 0>

;<GLOBAL DEBUG <>>

;<ROUTINE V-$DEBUG ()
	 <COND (,DEBUG
		<SETG DEBUG <>>
		<TELL "Debugging off." CR>)
	       (T
		<SETG DEBUG T>
		<TELL "Debugging on." CR>)>>

;<ROUTINE V-$CHEAT ()
	 <COND (<NOT <PRSO? ,INTNUM>>
		<GOTO ,RAMP>)
	       (<EQUAL? ,P-NUMBER 1>
		<LEAVE-EARTH>
		<SETG DOG-FED T>
	        <FCLEAR ,GOWN ,NDESCBIT>
		<FCLEAR ,TOOTHBRUSH ,TRYTAKEBIT>
		<GOTO ,DARK>
		<SETG DARK-FLAG ,HOLD>
		<FSET ,DARK-OBJECT ,DARKBIT>
		<MOVE ,MAIL ,DARK-OBJECT>
		<MOVE ,TOWEL ,DARK-OBJECT>
		<MOVE ,THUMB ,DARK-OBJECT>
		<MOVE ,TOOTHBRUSH ,DARK-OBJECT>
		<MOVE ,SCREWDRIVER ,DARK-OBJECT>
		<MOVE ,GOWN ,DARK-OBJECT>
		<FSET ,GOWN ,WORNBIT>)
	       (<EQUAL? ,P-NUMBER 2>
		<LEAVE-EARTH>
		<FSET ,HOLD ,TOUCHBIT>
		<SETG DOG-FED T>
	        <FCLEAR ,GOWN ,NDESCBIT>
		<FCLEAR ,TOOTHBRUSH ,TRYTAKEBIT>
		<GOTO ,DARK>
		<SETG DARK-FLAG ,ENTRY-BAY>
		<FSET ,DARK-OBJECT ,DARKBIT>
		<MOVE ,PLOTTER ,PROTAGONIST>
		<MOVE ,BABEL-FISH ,PROTAGONIST>
		<MOVE ,TOWEL ,PROTAGONIST>
		<MOVE ,GUIDE ,PROTAGONIST>
		<MOVE ,THUMB ,PROTAGONIST>)
	       (<EQUAL? ,P-NUMBER 3>
		<LEAVE-EARTH>
		<FSET ,HOLD ,TOUCHBIT>
		<SETG DOG-FED T>
	        <FCLEAR ,GOWN ,NDESCBIT>
		<FCLEAR ,TOOTHBRUSH ,TRYTAKEBIT>
		<SETG LYING-DOWN <>>
		<FSET ,DARK-OBJECT ,DARKBIT>
		<MOVE ,PLOTTER ,BRIDGE>
		<MOVE ,SPARE-DRIVE ,BRIDGE>
		<MOVE ,HATCH ,GLOBAL-OBJECTS>
		<MOVE ,TEA ,BRIDGE>
		<MOVE ,BOARD ,LOCAL-GLOBALS>
		<MOVE ,NUT-COM-INTERFACE ,NUTRIMAT>
		<FSET ,BEAST ,MUNGEDBIT>
		<SETG DRIVE-TO-PLOTTER T>
		<SETG BROWNIAN-SOURCE ,TEA>
		<MOVE ,FORD ,LOCAL-GLOBALS>
		<MOVE ,TRILLIAN ,LOCAL-GLOBALS>
		<MOVE ,ZAPHOD ,LOCAL-GLOBALS>
		<GOTO ,BRIDGE>)
	       (<EQUAL? ,P-NUMBER 4>
		<LEAVE-EARTH>
		<FSET ,HOLD ,TOUCHBIT>
		<SETG DOG-FED T>
	        <FCLEAR ,GOWN ,NDESCBIT>
		<FCLEAR ,TOOTHBRUSH ,TRYTAKEBIT>
		<FCLEAR ,JACKET-FLUFF ,TRYTAKEBIT>
		<FCLEAR ,JACKET-FLUFF ,NDESCBIT>
		<FSET ,DARK-OBJECT ,DARKBIT>
		<SETG LYING-DOWN <>>
		<SETG SCORE 200>
		<MOVE ,SATCHEL-FLUFF ,PROTAGONIST>
		<MOVE ,POCKET-FLUFF ,PROTAGONIST>
		<MOVE ,JACKET-FLUFF ,PROTAGONIST>
		<MOVE ,CUSHION-FLUFF ,PROTAGONIST>
		<MOVE ,FLOWERPOT ,PROTAGONIST>
		<MOVE ,TEA ,PROTAGONIST>
		<MOVE ,HATCH ,GLOBAL-OBJECTS>
		<MOVE ,FORD ,LOCAL-GLOBALS>
		<MOVE ,TRILLIAN ,LOCAL-GLOBALS>
		<MOVE ,ZAPHOD ,LOCAL-GLOBALS>
		<FSET ,PARTICLE ,MUNGEDBIT>
		<COND (<EQUAL? ,BROWNIAN-SOURCE ,TEA>
		       <SETG BROWNIAN-SOURCE <>>)>
		<MOVE ,SCREWDRIVER ,HATCHWAY>
		<MOVE ,TOOTHBRUSH ,HATCHWAY>
		<MOVE ,TWEEZERS ,HATCHWAY>
		<MOVE ,RASP ,HATCHWAY>
		<MOVE ,AWL ,HATCHWAY>
		<MOVE ,CHISEL ,HATCHWAY>
		<MOVE ,WRENCH ,HATCHWAY>
		<MOVE ,PLIERS ,HATCHWAY>
		<MOVE ,PINCER ,HATCHWAY>
		<MOVE ,CHIPPER ,HATCHWAY>
		<GOTO ,AFT-CORRIDOR>)
	       (T
		<GOTO ,RAMP>)>>

;<ROUTINE V-$PROB ()
	 <TELL "Heart: " N ,HEART-PROB CR>
	 <TELL "Vogon: " N ,VOGON-PROB CR>
	 <TELL "Traal: " N ,TRAAL-PROB CR>
	 <TELL "Fleet: " N ,FLEET-PROB CR>
	 <TELL "Whale: " N ,WHALE-PROB CR>
	 <TELL "Trillian: " N ,TRILLIAN-PROB CR>
	 <TELL "Ford: " N ,FORD-PROB CR>
	 <TELL "Zaphod: " N ,ZAPHOD-PROB CR>>


;"subtitle real verbs"

<ROUTINE V-AGAIN ("AUX" OBJ (N <>))
	 <COND (,L-DONT-FLAG
		<SETG DONT-FLAG T>
		<SETG PRSA ,L-PRSA>
		<DONT-F>
		<RTRUE>)>
	 <COND (<NOT ,L-PRSA>
		<TELL "Not until you do something." CR>)
	       (<OR <EQUAL? ,L-PRSA ,V?FIND ,V?FOLLOW ,V?CALL>
		    <EQUAL? ,L-PRSA ,V?WHAT ,V?WHERE ,V?WHO>
		    <EQUAL? ,L-PRSA ,V?WAIT-FOR ,V?WALK-TO ,V?WHAT-ABOUT>
		    <EQUAL? ,L-PRSA ,V?ASK-ABOUT ,V?ASK-FOR ,V?I-AM>
		    <EQUAL? ,L-PRSA ,V?MY-NAME ,V?TELL-ABOUT ,V?CALL-WITH>
		    <EQUAL? ,L-PRSA ,V?CARVE>>
		<TELL
"Sorry, the Galactic Compendium on Interactive Fiction prohibits the use of
AGAIN after your previous action." CR>
		<SETG PRSA ,V?VERBOSE>) ;"so this won't run the clock"
	       (<EQUAL? ,NOT-HERE-OBJECT ,L-PRSO ,L-PRSI>
		<TELL "You can't see that here." CR>)
	       (<EQUAL? ,L-PRSA ,V?WALK>
		<DO-WALK ,L-PRSO>)
	       (T
		<SET OBJ
		     <COND (<AND ,L-PRSO <NOT <VISIBLE? ,L-PRSO>>>
			    ,L-PRSO)
			   (<AND ,L-PRSI <NOT <VISIBLE? ,L-PRSI>>>
			    ,L-PRSI)>>
		<COND (<AND .OBJ 
			    <NOT <EQUAL? .OBJ ,ROOMS>>>
		       <TELL "You can't see">
		       <COND (.N
			      <TELL " any " D .OBJ " here." CR>)
			     (T
		       	      <ARTICLE .OBJ T>
		       	      <TELL " anymore." CR>)>
		       <RFATAL>)
		      (T
		       <COND (,L-FRONT-FLAG
			      <SETG IN-FRONT-FLAG T>)>
	 	       <PERFORM ,L-PRSA ,L-PRSO ,L-PRSI>)>)>>

<ROUTINE V-ALARM ()
	 <COND (<PRSO? ,ROOMS>
		<PERFORM ,V?ALARM ,ME>
		<RTRUE>)
	       (T
		<TELL "I don't think">
	        <ARTICLE ,PRSO T>
	        <TELL " is sleeping." CR>)>>

<ROUTINE V-ANSWER ()
	 <COND (<AND ,AWAITING-REPLY
		     <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?YES>>
		<V-YES>
		<FUCKING-CLEAR>)
	       (<AND ,AWAITING-REPLY
		     <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?NO>>
		<V-NO>
		<FUCKING-CLEAR>)
	       (<IN? ,BEAST ,HERE>
		<V-SAY>
		<FUCKING-CLEAR>)
	       (T
		<TELL "Nobody is awaiting your answer." CR>
	        <FUCKING-CLEAR>)>>

<ROUTINE V-APPLAUD ()
	 <COND (<RUNNING? ,I-CAPTAIN>
		<TELL "If you want to enjoy the poetry, just type that." CR>)
	       (T
		<TELL "Thank you, thank you." CR>)>>

<ROUTINE V-APPRECIATE ()
	 <COND (<RUNNING? ,I-CAPTAIN>
		<V-APPLAUD>)
	       (T
		<TELL
"Hey, I never get any appreciation! There's absolutely no job satisfaction
in being a computer." CR>)>>

<ROUTINE V-ASK-ABOUT ()
	 <COND (<PRSO? ,ME>
		<PERFORM ,V?TELL ,ME>
		<RTRUE>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<TELL "A long silence tells you that">
		<ARTICLE ,PRSO T>
		<TELL " isn't interested in talking about">
		<COND (<IN? ,PRSI ,ROOMS>
		       <TELL " that">)
		      (T
		       <ARTICLE ,PRSI T>)>
		<TELL "." CR>)
	       (T
		<PERFORM ,V?TELL ,PRSO>
		<RTRUE>)>>

<ROUTINE V-ASK-FOR ()
	 <TELL "Unsurprisingly,">
	 <ARTICLE ,PRSO T>
	 <TELL " doesn't oblige." CR>>

<ROUTINE V-BITE ()
	 <HACK-HACK "Biting">>

<ROUTINE V-BLOCK ()
	 <V-DIG>>

<ROUTINE V-BLOCK-WITH ()
	 <V-DIG>>

<ROUTINE PRE-BOARD ()
	 <COND (,IN-FRONT-FLAG
		<PERFORM ,V?STAND-BEFORE ,PRSO>
		<RTRUE>)
	       (<PRSO? <LOC ,PROTAGONIST>>
		<TELL ,LOOK-AROUND CR>)>>

<ROUTINE V-BOARD ("AUX" AV)
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<TELL "You are now in">
		<ARTICLE ,PRSO T>
		<TELL "." CR>
		<MOVE ,WINNER ,PRSO>
		<COND (<NOT <EQUAL? ,HERE ,SPEEDBOAT>>
		       <SETG LYING-DOWN T>)>
		<APPLY <GETP ,PRSO ,P?ACTION> ,M-ENTER>
		<RTRUE>)
	       (T
		<TELL "You can't get into">
		<ARTICLE ,PRSO T>
		<TELL "!" CR>)>>

<ROUTINE V-BRUSH ()
	 <COND (<NOT ,PRSI>
		<COND (<HELD? ,TOOTHBRUSH>
		       <TELL "(with the " D ,TOOTHBRUSH ")" CR>
		       <PERFORM ,V?BRUSH ,PRSO ,TOOTHBRUSH>
		       <RTRUE>)
		      (T
		       <TELL "You have nothing to brush">
		       <ARTICLE ,PRSO T>
		       <TELL " with." CR>)>)
	       (<NOT <PRSI? ,TOOTHBRUSH>>
		<TELL "With">
		<ARTICLE ,PRSI>
		<TELL "!" CR>)
	       (<NOT <PRSO? ,TEETH>>
		<TELL
"In general, " D ,TOOTHBRUSH "es are meant for teeth." CR>)
	       (T
		<TELL "Congratulations on your fine dental hygiene." CR>)>>

<ROUTINE V-BUY ()
	 <TELL "Sorry,">
	 <ARTICLE ,PRSO T>
	 <TELL " isn't for sale." CR>>

<ROUTINE V-CALL ()
	 <COND (<NOT <EQUAL? ,HERE ,BEDROOM>>
		<TELL "There's no phone here!" CR>)
	       (,HEADACHE
		<TELL "You reach for the receiver. " <PICK-ONE ,LURCHES> CR>)
	       (<FSET? ,PHONE ,TOUCHBIT>
		<TELL "The cable is down, remember?" CR>)
	       (<PRSO? ,DAIS>
		<FSET ,PHONE ,TOUCHBIT>
		<TELL
"You explain your situation. The desk sergeant promises to send someone
over soon, and says not to try anything crazy in the meantime, like lying
down in front of the " D ,BULLDOZER "." ,DIALLING-TONE CR>)
	       (<PRSO? ,HOME>
		<TELL "Who do you think you are, E.T.?" CR>)
	       (<PRSO? ,MAZE>
		<V-HELP>)
	       (T
		<TELL "You don't know the number." CR>)>>

<ROUTINE V-CALL-WITH ()
	 <COND (<NOT <PRSI? ,PHONE>>
		<TELL "You can't use">
		<ARTICLE ,PRSI>
		<TELL " as a " D ,PHONE "." CR>)
	       (T
		<PERFORM ,V?CALL ,PRSO>
		<RTRUE>)>>

<ROUTINE PRE-CARVE ()
	 <COND (<NOT <HELD? ,STONE>>
		<TELL "You have no carving instrument." CR>)>>

<ROUTINE V-CARVE ()
	 <TELL <PICK-ONE ,YUKS> CR>>

<ROUTINE V-CARVE-WITH ()
	 <COND (<EQUAL? ,HERE ,OUTER-LAIR>
		<COND (<PRSI? ,STONE>
		       <PERFORM ,V?CARVE ,PRSO ,MEMORIAL>
		       <RTRUE>)
		      (T
		       <TELL "No luck;">
		       <ARTICLE ,PRSI T>
		       <TELL
" doesn't even scratch the " D ,MEMORIAL "." CR>)>)
	       (T
		<TELL "Huh?" CR>)>>

<ROUTINE V-CHASTISE ()
	 <TELL
"Use prepositions to indicate precisely what you want to do: LOOK AT the
object, LOOK INSIDE it, LOOK UNDER it, etc." CR>>

<ROUTINE V-CLEAN ()
	 <COND (<AND <PRSO? ,ROOMS ,GLOBAL-ROOM>
		     <EQUAL? ,HERE ,BEDROOM>>
		<TELL "Just as you've got it all spick and span">
		<BETTER-LUCK>)
	       (<PRSO? ,TEETH>
		<PERFORM ,V?BRUSH ,TEETH>
		<RTRUE>)
	       (T
		<COND (<PRSO? ,TOWEL>
		       <SETG TOWEL-MUDDY <>>)>
		<TELL "It is now much cleaner." CR>)>>

<ROUTINE V-CLIMB-DOWN ()
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?DOWN>)
	       (T
		<V-CARVE>)>>

<ROUTINE V-CLIMB-FOO ()
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?UP>)
	       (T
		<V-CARVE>)>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (T
		<TELL "You can't climb onto">
		<ARTICLE ,PRSO T>
		<TELL "." CR>)>>

<ROUTINE V-CLIMB-OVER ()
	 <V-CARVE>>

<ROUTINE V-CLIMB-UP ()
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?UP>)
	       (T
		<V-CARVE>)>>

<ROUTINE V-CLOSE ()
	 <COND (<FSET? ,PRSO ,SURFACEBIT>
		<V-COUNT>)
	       (<AND <FSET? ,PRSO ,ACTORBIT>
		     <NOT <PRSO? ,NUTRIMAT ,SCREENING-DOOR>>>
		<V-COUNT>)
	       (<OR <FSET? ,PRSO ,DOORBIT>
		    <FSET? ,PRSO ,CONTBIT>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "Okay,">
		       <ARTICLE ,PRSO T>
		       <TELL " is now closed." CR>
		       <FCLEAR ,PRSO ,OPENBIT>)
		      (T
		       <TELL ,ALREADY-CLOSED CR>)>)
	       (T
		<TELL-ME-HOW>)>>

<ROUTINE V-COUNT ()
	 <TELL <PICK-ONE ,IMPOSSIBLES> CR>>

<ROUTINE V-CUT ()
	 <COND (<NOT ,PRSI>
		<V-CARVE>)
	       (T
		<TELL "I doubt that the \"cutting edge\" of">
		<ARTICLE ,PRSI>
		<TELL " is adequate." CR>)>>

<ROUTINE V-DIG ()
	 <TELL <PICK-ONE ,WASTES> CR>>

<ROUTINE V-DISEMBARK ()
	 <COND (<AND <FSET? ,PRSO ,TAKEBIT> ;"since GET OUT is also TAKE OUT"
		     <EQUAL? <META-LOC ,PRSO> ,HERE>
		     <NOT <IN? ,PRSO ,HERE>>
		     <NOT <IN? ,PRSO ,PROTAGONIST>>>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (<NOT <EQUAL? <LOC ,WINNER> ,PRSO>>
		<TELL ,LOOK-AROUND CR>
		<RFATAL>)
	       (T
		<OWN-FEET>
		<SETG LYING-DOWN <>>
		<MOVE ,WINNER ,HERE>)>>

<ROUTINE V-DOZE ()
	 <TELL "You doze for several minutes. ">
	 <V-WAIT>>

<ROUTINE V-DRINK ("AUX" S)
	 <TELL "You can't drink that!" CR>>

<ROUTINE V-DRINK-FROM ()
	 <V-COUNT>>

<ROUTINE PRE-DROP ()
	 <COND (<IDROP>
		<RTRUE>)>>

<ROUTINE V-DROP ()
	 <COND (<EQUAL? ,HERE ,MAZE>
		<COND (<NOT <PRSO? ,THING>>
		       <SETG BRAIN-DAMAGED ,PRSO>)>
		<MOVE ,PRSO ,LOCAL-GLOBALS>
		<TELL "As you release">
		<ARTICLE ,PRSO T>
		<TELL ", it vanishes into the maze of synapses." CR>)
	       (<EQUAL? ,HERE ,ACCESS-SPACE>
		<MOVE ,PRSO ,LOCAL-GLOBALS>
		<TELL "If you recall, the floor is just an open mesh, and">
		<ARTICLE ,PRSO T>
		<TELL " drops through and disappears." CR>)
	       (T
		<MOVE ,PRSO ,HERE>
		<TELL "Dropped." CR>)>>

<ROUTINE V-EAT ()
	 <TELL "Stuffing">
	 <ARTICLE ,PRSO T>
	 <TELL " in your mouth would do little to help at this point." CR>>

<ROUTINE V-ENJOY ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<V-KISS>)
	       (T
		<TELL "Not difficult at all, considering how enjoyable">
	        <ARTICLE ,PRSO T>
	        <TELL " is." CR>)>>

<ROUTINE V-ENTER ("AUX" VEHICLE)
	 <COND (<SET VEHICLE <FIND-IN ,HERE ,VEHBIT>>
		<PERFORM ,V?BOARD .VEHICLE>
		<RTRUE>)
	       (T
		<DO-WALK ,P?IN>)>>

<ROUTINE V-ESCAPE ()
	 <SETG DREAMING <>>
	 <TELL
"You are so keen on escape that you literally leap through the fabric of the
space-time continuum. You wake up in a shack on tenth-century Earth. A dressing
gown, a " D ,TOOTHBRUSH>
	 <JIGS-UP
", and a flathead axe lie by your bed. Before you have a chance to move, Mongol
hordes sweep magnificently across the plains of central Asia. They knock down
your shack and burn the remains with you inside. You lose interest in the rest
of the game.">
	 <RTRUE>>

<ROUTINE V-EXAMINE ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<V-LOOK-INSIDE>)
	       (<AND <FSET? ,PRSO ,CONTBIT>
		     <NOT <FSET? ,PRSO ,ACTORBIT>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <V-LOOK-INSIDE>)
		      (T
		       <TELL "It's closed." CR>)>)
	       (<GETP ,PRSO ,P?TEXT>
		<PERFORM ,V?READ ,PRSO>
		<RTRUE>)
	       (<PRSO? ,BROWNIAN-SOURCE>
		<PERFORM ,V?EXAMINE ,DANGLY-BIT>
		<RTRUE>)
	       (<FSET? ,PRSO ,TOOLBIT>
		<TELL
,IT-LOOKS-LIKE " every other " D ,PRSO " you've ever seen." CR>)
	       (<PRSO? ,EYES ,TEETH ,HEAD ,EARS>
		<TELL "That would involve quite a contortion." CR>)
	       (T
		<TELL "You see nothing special about">
		<ARTICLE ,PRSO T>
		<TELL "." CR>)>>

<ROUTINE V-EXAMINE-THROUGH ()
	 <TELL "This reveals nothing new." CR>>

<ROUTINE V-EXIT ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (T
		<DO-WALK ,P?OUT>)>>

<ROUTINE V-FEED ("AUX" FOOD)
	 <COND (<SET FOOD <FIND-IN ,PROTAGONIST ,EATBIT>>
		<TELL "(the " D .FOOD ")" CR>
		<PERFORM ,V?GIVE .FOOD ,PRSO>
		<RTRUE>)
	       (T
		<TELL "You have nothing to feed">
		<ARTICLE ,PRSO T>
		<TELL " with." CR>)>>

<ROUTINE V-FILL ()
	 <TELL "Phil who?" CR>>

<ROUTINE V-FIND ("OPTIONAL" (WHERE <>) "AUX" (L <LOC ,PRSO>))
	 <COND (<PRSO? ,HANDS ,HEAD ,EARS ,TEETH ,EYES>
		<TELL "Are you sure">
		<ARTICLE ,PRSO T>
		<TELL " is lost?" CR>)
	       (<PRSO? ,ME>
		<TELL "You're in">
		<ARTICLE ,HERE T>
		<TELL "." CR>)
	       (<IN? ,PRSO ,PROTAGONIST>
		<TELL "You have it!" CR>)
	       (<AND <PRSO? ,PROSSER>
		     <EQUAL? ,IDENTITY-FLAG ,FORD>
		     <NOT ,GONE-AROUND>>
		<TELL "He's " ,ON-OTHER-SIDE " of the " D ,BULLDOZER "." CR>)
	       (<OR <IN? ,PRSO ,HERE>
		    <PRSO? ,PSEUDO-OBJECT>
		    <AND <PRSO? ,MECHANISM>
			 <EQUAL? ,HERE ,ACCESS-SPACE>>
		    <AND <PRSO? ,HATCH>
			 <EQUAL? ,HERE ,HATCHWAY>>>
		<TELL "Right in front of you." CR>)
	       (<GLOBAL-IN? ,PRSO ,HERE>
		<TELL "You figure it out!" CR>)
	       (<AND <FSET? .L ,ACTORBIT>
		     <VISIBLE? .L>>
		<TELL "As far as you can tell,">
		<ARTICLE .L T>
		<TELL " has it." CR>)
	       (<AND <FSET? .L ,CONTBIT>
		     <VISIBLE? ,PRSO>>
		<TELL "It's in">
		<ARTICLE .L T>
		<TELL "." CR>)
	       (.WHERE
		<TELL "Beats me." CR>)
	       (T
		<TELL "You'll have to do that yourself." CR>)>>

<ROUTINE V-FIRST-LOOK ()
	 <COND (<DESCRIBE-ROOM>
		<COND (<EQUAL? ,VERBOSITY 1 2>
		       <DESCRIBE-OBJECTS>)>)>>

<ROUTINE V-FLIPSWITCH ()
	 <COND (<AND <FSET? ,PRSO ,SWITCHBIT>
		     <PRSI? ,INTNUM>
		     <L? ,P-NUMBER 9>
		     <VISIBLE? ,BOARD>>
		<PERFORM ,V?TURN ,DIPSWITCH>
		<RTRUE>)
	       (T
		<V-TELL-TIME>)>>

<ROUTINE V-FOLLOW ()
	 <COND (<IN? ,PRSO ,HERE>
		<TELL "But">
		<ARTICLE ,PRSO T>
		<TELL " is right here!" CR>)
	       (<NOT <FSET? ,PRSO ,ACTORBIT>>
		<V-COUNT>)
	       (T
		<TELL "You have no idea where">
		<ARTICLE ,PRSO T>
		<TELL " is." CR>)>>

<GLOBAL FOLLOW-FLAG <>>

<ROUTINE I-FOLLOW ()
	 <SETG FOLLOW-FLAG <>>
	 <RFALSE>>

<ROUTINE V-FOOTNOTE ()
	 <COND (<OR <NOT ,PRSO>
		    <NOT <PRSO? ,INTNUM>>>
		<TELL "Specify a number, as in \"FOOTNOTE 6.\"" CR>)
	       (<EQUAL? ,P-NUMBER 1>
		<TELL
"In case anyone is interested, this quotation is from a letter written by John
Keats, and thus he becomes the first major 19th Century British poet to feature
in a computer game." CR>)
	       (<EQUAL? ,P-NUMBER 2>
		<TELL "Bob Dylan, 1969." CR>)
	       (<EQUAL? ,P-NUMBER 3>
		<TELL "A meaningless coincidence." CR>)
	       (<EQUAL? ,P-NUMBER 4>
		<TELL
"The first single they recorded on their own Apple label, and one of
their most successful songs ever." CR>)
	       (<EQUAL? ,P-NUMBER 5>
		<TELL
"Peacefully for a " D ,BEAST " that is. Now and then it snorts or rolls over,
and the walls shake a bit." CR>)
	       (<EQUAL? ,P-NUMBER 6>
		<TELL "That was just an example." CR>)
	       (<EQUAL? ,P-NUMBER 7>
		<SETG AWAITING-REPLY 13>
		<ENABLE <QUEUE I-REPLY 1>> ;"only 1 since FOOTNOTE isn't move"
		<NOT-VERY-GOOD "gun">)
	       (<EQUAL? ,P-NUMBER 8>
		<SETG AWAITING-REPLY 13>
		<ENABLE <QUEUE I-REPLY 1>> ;"only 1 since FOOTNOTE isn't move"
		<NOT-VERY-GOOD "legend">)
	       (<EQUAL? ,P-NUMBER 9>
		<TELL
"Unfortunately, you couldn't hear a word of it, because sound doesn't travel
in a vacuum." CR>)
	       (<EQUAL? ,P-NUMBER 10>
		<TELL
"I guess it isn't all that dangerous a place after all." CR>)
	       (<EQUAL? ,P-NUMBER 11> ;"not referenced"
		<SETG AWAITING-REPLY 14>
		<ENABLE <QUEUE I-REPLY 2>>
		<TELL "Isn't it fun reading through all the footnotes?" CR>)
	       (<EQUAL? ,P-NUMBER 12>
	        <TELL
"This is the famous recursive footnote (Footnote 12)." CR>)
	       (<EQUAL? ,P-NUMBER 13>
		<SETG AWAITING-REPLY 13>
		<ENABLE <QUEUE I-REPLY 1>>
		<NOT-VERY-GOOD "autopilot">)
	       (<EQUAL? ,P-NUMBER 14>
		<TELL
,GUIDE-NAME " is also the name of a terrific work of interactive fiction by
Douglas Adams and S. Eric Meretzky." ,ALREADY-KNOW-THAT CR>)
	       (<EQUAL? ,P-NUMBER 15>
		<SETG AWAITING-REPLY 13>
		<ENABLE <QUEUE I-REPLY 1>>
		<NOT-VERY-GOOD "banner">)
	       (T
		<TELL "There is no Footnote " N ,P-NUMBER "." CR>)>>

<ROUTINE V-FRIPPI ()
	 <TELL "Aaaaaaarggggghhhhhh!" CR>>

<ROUTINE V-GET-DRESSED (GARMENT)
	 <COND (<PRSO? ,ROOMS>
		<COND (<OR <NOT <EQUAL? ,IDENTITY-FLAG ,ARTHUR>>
			   <FSET? ,GOWN ,WORNBIT>>
		       <TELL "You are!" CR>)
		      (<HELD? ,GOWN>
		       <PERFORM ,V?WEAR ,GOWN>
		       <RTRUE>)
		      (<VISIBLE? ,GOWN>
		       <TELL ,NOT-HOLDING " " D ,GOWN "." CR>)
		      (T
		       <TELL "There's nothing to wear here." CR>)>)
	       (T
		<V-TELL-TIME>)>>

<ROUTINE V-GET-DRUNK ()
	 <COND (<PRSO? ,ROOMS>
		<COND (<EQUAL? ,HERE ,PUB>
		       <TELL
"You get drunk and have a terrific time for twelve minutes, are the life and
soul of the Pub, tell some really great stories, make everyone laugh a lot,
and they all clap you on the back and tell you what a great chap you are and
then the Earth gets unexpectedly demolished">
		       <COND (<EQUAL? ,IDENTITY-FLAG ,ARTHUR>
			      <TELL
". You wake up with a hangover which lasts for all eternity." CR>
			      <FINISH>)
			     (T
			      <JIGS-UP ".">)>)
		      (<EQUAL? ,HERE ,LIVING-ROOM ,DINING-ROOM ,KITCHEN>
		       <TELL ,YOU-ARE CR>)
		      (T
		       <TELL "You can't see any alcohol here!" CR>)>)
	       (T
		<V-TELL-TIME>)>>

<ROUTINE V-GET-UNDRESSED ()
	 <COND (<NOT ,PRSO>
		<SETG PRSO ,ROOMS>)>
	 <COND (<PRSO? ,ROOMS>
		<COND (<FSET? ,GOWN ,WORNBIT>
		       <PERFORM ,V?TAKE-OFF ,GOWN>
		       <RTRUE>)
		      (<EQUAL? ,IDENTITY-FLAG ,ARTHUR>
		       <TELL "You're not wearing anything!" CR>)
		      (T
		       <TELL ,ARRESTED CR>)>)
	       (T
		<V-TELL-TIME>)>>

<ROUTINE PRE-GIVE ()
	 <COND (<IDROP>
		<RTRUE>)>>

<ROUTINE V-GIVE ()
	 <COND (<FSET? ,PRSI ,ACTORBIT>
		<TELL "Politely,">
		<ARTICLE ,PRSI T>
		<TELL " refuses your offer." CR>)
	       (T
		<TELL "You can't give">
		<ARTICLE ,PRSO>
		<TELL " to">
		<ARTICLE ,PRSI>
		<TELL "!" CR>)>>

<ROUTINE V-GIVE-UP ()
	 <COND (<PRSO? ,ROOMS>
		<V-QUIT>)
	       (T
		<V-TELL-TIME>)>>

<ROUTINE V-HANG ()
	 <TELL "You can't hang something from">
	 <ARTICLE ,PRSI>
	 <TELL "!" CR>>

<ROUTINE V-HELLO ()
       <COND (<AND ,PRSO
		   <FSET? ,PRSO ,ACTORBIT>>
	      <TELL "\"Hello to you too.\"" CR>)
	     (,PRSO
	      <PERFORM ,V?TELL ,PRSO>
	      <RTRUE>)
	     (T
	      <PERFORM ,V?TELL ,ME>
	      <RTRUE>)>>

<ROUTINE V-HELP ()
	 <TELL
"If you're really stuck, a complete map and InvisiClues Hint Booklet are
available from your dealer, or via mail order with the form that came in
your package." CR>>

<ROUTINE V-HIDE ()
	 <TELL "There's no place to hide here." CR>>

<ROUTINE V-HITCHHIKE ()
	 <PERFORM ,V?PUSH ,GREEN-BUTTON>
	 <RTRUE>>

<ROUTINE V-I-AM ()
	 <TELL "Pleased to meet you. I'm your computer." CR>>

<ROUTINE V-IDIOT ()
	 <PERFORM ,V?TELL ,ME>
	 <RTRUE>>

<ROUTINE V-KICK ()
	 <HACK-HACK "Kicking">>

<ROUTINE V-KILL ()
	 <TELL
"You are obviously letting things get to you. You should learn to
relax a little." CR>>

<ROUTINE V-KNEEL ()
	 <V-TASTE>>

<ROUTINE V-KNOCK ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL "Nobody's home." CR>)
	       (T
		<HACK-HACK "Knocking on">)>>

<ROUTINE V-KISS ()
	 <TELL "This is family entertainment, not a video nasty." CR>>

<ROUTINE V-LAMP-OFF ()
	 <COND (<AND <FSET? ,PRSO ,LIGHTBIT>
		     <NOT <FSET? ,PRSO ,ONBIT>>>
		<TELL "It is already off." CR>)
	       (<AND <PRSO? ,INTNUM>
			 <L? ,P-NUMBER 9>
			 <ACCESSIBLE? ,BOARD>>
		<PERFORM ,V?TURN ,DIPSWITCH>
		<RTRUE>)
	       (T
		<TELL "You can't turn that off." CR>)>>

<ROUTINE V-LAMP-ON ()
	 <COND (<AND <FSET? ,PRSO ,LIGHTBIT>
		     <FSET? ,PRSO ,ONBIT>>
		<TELL "It is already on." CR>)
	       (<AND <PRSO? ,INTNUM>
		     <L? ,P-NUMBER 9>
		     <ACCESSIBLE? ,BOARD>>
		<PERFORM ,V?TURN ,DIPSWITCH>
		<RTRUE>)
	       (T
		<TELL "You can't turn that on." CR>)>>

<ROUTINE V-LEAP ()
	 <COND (,LYING-DOWN
		<TELL ,WHILE-LYING CR>)
	       (<EQUAL? ,HERE ,CAPTAINS-QUARTERS>
		<V-STAND>)
	       (<AND ,PRSO
		     <NOT <IN? ,PRSO ,HERE>>>
		<V-COUNT>)
	       (<AND <NOT ,PRSO>
		     <EQUAL? ,HERE ,SPEEDBOAT>>
		<TELL ,DONT-MIX CR>
		<RTRUE>)
	       (T
		<V-SKIP>)>>

<ROUTINE V-LEAVE ()
	 <COND (<NOT ,PRSO>
		<SETG PRSO ,ROOMS>)>
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?OUT>)
	       (<PRSO? <LOC ,WINNER>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LIE-DOWN ()
	 <COND (<EQUAL? ,HERE ,CAPTAINS-QUARTERS>
		<V-STAND>)
	       (<PRSO? ,ROOMS>
		<COND (<EQUAL? ,HERE ,BEDROOM>
		       <PERFORM ,V?LIE-DOWN ,BED>
		       <RTRUE>)
		      (T
		       <PERFORM ,V?LIE-DOWN ,GROUND>
		       <RTRUE>)>)
	       (T
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LISTEN ()
	 <TELL "At the moment,">
	 <ARTICLE ,PRSO T>
	 <TELL " makes no sound." CR>>

<ROUTINE V-LOCK ()
	 <V-CARVE>>

<ROUTINE V-LOOK ()
	 <COND (<FSET? ,TOWEL ,WORNBIT>
		<TELL "You see a towel." CR>)
	       (<DESCRIBE-ROOM T>
		<DESCRIBE-OBJECTS T>)>>

<ROUTINE V-LOOK-BEHIND ()
	 <TELL "There is nothing behind">
	 <ARTICLE ,PRSO T>
	 <TELL "." CR>>

<ROUTINE V-LOOK-DOWN ()
	 <COND (<NOT ,LIT>
		<TELL ,TOO-DARK CR>)
	       (<PRSO? ,ROOMS>
		<PERFORM ,V?EXAMINE ,GROUND>
		<RTRUE>)
	       (T
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LOOK-INSIDE ()
	 <COND (<AND <FSET? ,PRSO ,ACTORBIT>
		     <NOT <PRSO? ,SCREENING-DOOR>>>
		<TELL "There is nothing special to be seen." CR>)
	       (<AND <PRSO? ,SPARE-DRIVE ,THUMB ,PLOTTER>>
		<TELL "You can't do that." CR>)
	       (<FSET? ,PRSO ,SURFACEBIT>
		<COND (<PRSO? <LOC ,WINNER>>
		       <DESCRIBE-VEHICLE>
		       <RTRUE>)
		      (<FIRST? ,PRSO>
		       <PRINT-CONT ,PRSO>)
		      (T
		       <TELL "There is nothing on">
		       <ARTICLE ,PRSO T>
		       <TELL "." CR>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<TELL "All you can tell is that">
		<ARTICLE ,PRSO T>
		<TELL " is ">
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "open.">)
		      (T
		       <TELL "closed.">)>
		<CRLF>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<PRSO? <LOC ,WINNER>>
		       <DESCRIBE-VEHICLE>
		       <RTRUE>)
		      (<SEE-INSIDE? ,PRSO>
		       <COND (<FIRST? ,PRSO>
			      <PRINT-CONT ,PRSO>)
			     (T
			      <TELL "It's empty." CR>)>)
		      (<AND <NOT <FSET? ,PRSO ,OPENBIT>>
			    <FIRST? ,PRSO>>
		       <PERFORM ,V?OPEN ,PRSO>
		       <RTRUE>)
		      (T
		       <TELL "It seems that">
		       <ARTICLE ,PRSO T>
		       <TELL " is closed." CR>)>)
	       (T
		<TELL "You can't do that." CR>)>>

<ROUTINE V-LOOK-UNDER ()
	 <COND (<HELD? ,PRSO>
		<COND (<FSET? ,PRSO ,WORNBIT>
		       <TELL "You're wearing it!" CR>)
		      (T
		       <TELL "You're holding it!" CR>)>)
	       (T
		<TELL "There is nothing but ">
		<COND (<PRSO? ,HOOK>
		       <TELL "a " D ,FISH-HOLE>)
		      (<PRSO? ,BOAT-OBJECT>
		       <TELL "water">)
		      (<AND <PRSO? ,TOWEL>
			    <FSET? ,TOWEL ,SURFACEBIT>>
		       <TELL "a drain">)
		      (T
		       <TELL "dust">)>
		<TELL " there." CR>)>>

<ROUTINE V-LOOK-UP ()
	 <COND (<NOT ,LIT>
		<TELL ,TOO-DARK CR>)
	       (<PRSO? ,ROOMS>
		<COND (<FSET? ,HERE ,OUTSIDEBIT>
		       <PERFORM ,V?EXAMINE ,SKY>
		       <RTRUE>)
		      (T
		       <PERFORM ,V?EXAMINE ,CEILING>
		       <RTRUE>)>)
	       (T
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LOWER ()
	 <V-RAISE>>

<ROUTINE V-MAKE ()
	 <TELL "You can't make">
	 <ARTICLE ,PRSO>
	 <TELL "!" CR>>

<ROUTINE V-MOVE ()
	 <COND (<HELD? ,PRSO>
		<TELL "Why juggle objects?" CR>)
	       (<PRSO? ,PANEL-BLOCKER>
		<SETG PANEL-BLOCKER <>>
		<TELL
"Okay, it's no longer in front of the " D ,ROBOT-PANEL "." CR>)
	       (<FSET? ,PRSO ,INTEGRALBIT>
		<PART-OF>)
	       (<LOC-CLOSED>
		<RTRUE>)
	       (<FSET? ,PRSO ,TAKEBIT>
		<TELL "Moving">
		<ARTICLE ,PRSO T>
		<TELL " reveals nothing." CR>)
	       (<AND <PRSO? ,INTNUM>
		     <L? ,P-NUMBER 9>
		     <ACCESSIBLE? ,BOARD>>
		<PERFORM ,V?TURN ,DIPSWITCH>
		<RTRUE>)
	       (T
		<TELL "You can't move">
		<ARTICLE ,PRSO T>
		<TELL "." CR>)>>

<ROUTINE V-MUNG ()
	 <HACK-HACK "Trying to break">>

<ROUTINE V-MY-NAME ()
	 <COND (<PRSO? ,NAME>
		<V-I-AM>)
	       (T
		<V-TELL-TIME>)>>

<ROUTINE V-NO ()
	 <COND (<EQUAL? ,AWAITING-REPLY 1>
		<RFALSE>)
	       (<EQUAL? ,AWAITING-REPLY 2>
		<DO-WALK ,P?SOUTH>)
	       (<EQUAL? ,AWAITING-REPLY 3 10>
		<TELL "I should think not." CR>)
	       (<EQUAL? ,AWAITING-REPLY 4>
		<TELL "The word \"no\" is not in our hostess' vocabulary." CR>)
	       (<EQUAL? ,AWAITING-REPLY 5>
		<SETG AWAITING-REPLY 3>
		<V-YES>)
	       (<EQUAL? ,AWAITING-REPLY 6 11>
		<SETG AWAITING-REPLY 6>
		<V-YES>)
	       (<OR <EQUAL? ,AWAITING-REPLY 7 8>
		    <EQUAL? ,AWAITING-REPLY 13 15>>
		<SETG AWAITING-REPLY 3>
		<V-YES>)
	       (<EQUAL? ,AWAITING-REPLY 9>
		<TELL "I disagree." CR>)
	       (<EQUAL? ,AWAITING-REPLY 12>
		<ENGINEER-LEAVE>
		<TELL
"\"Think you're funny, huh?\" The " D ,ENGINEER ,ROARS-OFF ", making sure
to spray you with his Sub-Ethon exhaust." CR>)
	       (<EQUAL? ,AWAITING-REPLY 14>
		<TELL "Then stop." CR>)
	       (<EQUAL? ,AWAITING-REPLY 16>
		<TELL "I didn't think so." CR>)
	       (<EQUAL? ,AWAITING-REPLY 18 19>
		<V-YES>)
	       (T
		<TELL "You sound rather negative." CR>)>>

<ROUTINE V-OPEN ("AUX" F STR)
	 <COND (<FSET? ,PRSO ,SURFACEBIT>
		<V-COUNT>)
	       (<AND <FSET? ,PRSO ,ACTORBIT>
		     <NOT <PRSO? ,NUTRIMAT>>>
		<V-COUNT>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL ,ALREADY-OPEN CR>)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <FSET ,PRSO ,TOUCHBIT>
		       <COND (<OR <NOT <FIRST? ,PRSO>>
				  <FSET? ,PRSO ,TRANSBIT>>
			      <TELL "Opened." CR>)
			     ;(<AND <SET F <FIRST? ,PRSO>>
				   <NOT <NEXT? .F>>
				   <SET STR <GETP .F ,P?FDESC>>>
			      <TELL "Okay,">
			      <ARTICLE ,PRSO T>
			      <TELL " is now open." CR>
			      <TELL .STR CR>)
			     (T
			      <TELL "Opening">
			      <ARTICLE ,PRSO T>
			      <TELL " reveals">
			      <PRINT-CONTENTS ,PRSO>
			      <TELL "." CR>)>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL ,ALREADY-OPEN CR>)
		      (T
		       <TELL "Okay,">
		       <ARTICLE ,PRSO T>
		       <TELL " is now open." CR>
		       <FSET ,PRSO ,OPENBIT>)>)
	       (T
		<TELL-ME-HOW>)>>

<ROUTINE V-PANIC ()
	 <TELL "Not surprised." CR>>

<ROUTINE V-PICK ()
	 <V-COUNT>>

<ROUTINE V-PICK-UP ()
	 <PERFORM ,V?TAKE ,PRSO ,PRSI>
	 <RTRUE>>

<ROUTINE V-PLANT ()
	 <COND (<PRSI? ,FLOWERPOT>
		<PERFORM ,V?PUT ,PRSO ,PRSI>
		<RTRUE>)
	       (T
		<TELL "You can't plant something in">
		<ARTICLE ,PRSI>
		<TELL "." CR>)>>

<ROUTINE V-PLUG ()
	 <TELL "You can't seem to plug">
	 <ARTICLE ,PRSO T>
	 <TELL " into">
	 <ARTICLE ,PRSI T>
	 <TELL "." CR>>

<ROUTINE V-POINT ()
	 <COND (<EQUAL? ,HERE ,SPEEDBOAT>
		<PERFORM ,V?STEER ,BOAT-OBJECT ,PRSO>
		<RTRUE>)
	       (T
		<V-STEER>)>>

<ROUTINE V-POUR ()
	 <V-CARVE>>

<ROUTINE V-PROTEST ()
	 <COND (<AND <EQUAL? ,HERE ,FRONT-OF-HOUSE>
		     <RUNNING? ,I-BULLDOZER>>
		<TELL
"Prosser says \"I wouldn't stop the " D ,BULLDOZER " even if you were lying in
front of it!\"" CR>)
	       (T
		<TELL "To whom? About what? Why?" CR>)>>

<ROUTINE V-PULL-TOGETHER ()
	 <V-TELL-TIME>>

<ROUTINE V-PUSH ()
	 <COND (<AND <PRSO? ,INTNUM>
		     <L? ,P-NUMBER 9>
		     <ACCESSIBLE? ,BOARD>>
		<PERFORM ,V?TURN ,DIPSWITCH>
		<RTRUE>)
	       (T
		<HACK-HACK "Pushing">)>>

<ROUTINE PRE-PUT ()
	 <COND (<PRSI? ,GROUND>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<HELD? ,PRSI ,PRSO>
;"formerly <PRSO? <LOC ,PRSI>> but that only checked down one level"
		<TELL "You can't put">
		<ARTICLE ,PRSO T>
		<TELL " in">
		<ARTICLE ,PRSI T>
		<TELL " when">
		<ARTICLE ,PRSI T>
		<TELL " is already in">
		<ARTICLE ,PRSO T>
		<TELL "!" CR>)
	       (<IDROP>
		<RTRUE>)
	       (,IN-FRONT-FLAG
		<PERFORM ,V?PUT-IN-FRONT ,PRSO ,PRSI>
		<RTRUE>)
	       (<PRSO? ,TEA>
		<PERFORM ,V?POUR ,TEA ,PRSI>
		<RTRUE>)
	       (<PRSO? ,BROWNIAN-SOURCE>
		<SETG BROWNIAN-SOURCE <>>
		<REMOVING-BIT>
		<RFALSE>)
	       (<AND <PRSO? ,PLOTTER>
		     ,BROWNIAN-SOURCE>
		<SETG BROWNIAN-SOURCE <>>
		<REMOVING-BIT>
		<RFALSE>)
	       (<OR <AND <PRSO? ,PLOTTER>
			 ,DRIVE-TO-PLOTTER>
		    <AND <PRSO? ,SPARE-DRIVE>
			 ,DRIVE-TO-PLOTTER>
		    <AND <PRSO? ,SPARE-DRIVE>
			 ,DRIVE-TO-CONTROLS>>
		<TELL "You'll have to unplug it first." CR>)>>

<ROUTINE V-PUT ()
	 <COND (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,DOORBIT>>
		     <NOT <FSET? ,PRSI ,CONTBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>
		     <NOT <FSET? ,PRSI ,VEHBIT>>>
		<TELL "You can't put">
		<ARTICLE ,PRSO T>
		<TELL " in">
		<ARTICLE ,PRSI>
		<TELL "!" CR>
		<RTRUE>)
	       (<OR <PRSI? ,PRSO>
		    <AND <HELD? ,PRSO>
			 <NOT <FSET? ,PRSO ,TAKEBIT>>>
		    <PRSI? ,SPARE-DRIVE ,THUMB ,PLOTTER>>
		<TELL "How can you do that?" CR>)
	       (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>>
		<TELL "Inspection reveals that">
		<ARTICLE ,PRSI T>
		<TELL " isn't open." CR>
		<SETG P-IT-OBJECT ,PRSI>)
	       (<IN? ,PRSO ,PRSI>
		<TELL "I think">
		<ARTICLE ,PRSO T>
		<TELL " is already in">
		<ARTICLE ,PRSI T>
		<TELL "." CR>)
	       (<G? <- <+ <WEIGHT ,PRSI> <GETP ,PRSO ,P?SIZE>>
		       <GETP ,PRSI ,P?SIZE>>
		    <GETP ,PRSI ,P?CAPACITY>>
		<COND (<FSET? ,PRSI ,VEHBIT>
		       <V-DIG>)
		      (T
		       <TELL "There's no room." CR>)>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <EQUAL? <ITAKE> ,M-FATAL <>>>
		<RTRUE>)
	       (T
		<MOVE ,PRSO ,PRSI>
		<FSET ,PRSO ,TOUCHBIT>
		<TELL "Done." CR>)>>

<ROUTINE V-PUT-BEHIND ()
	 <V-DIG>>

<ROUTINE V-PUT-IN-FRONT ()
	 <V-DIG>>

<ROUTINE V-PUT-ON ()
	 <COND (<PRSI? ,ME>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSI ,SURFACEBIT>
		<V-PUT>)
	       (<PRSI? ,HEAD ,EYES>
		<TELL "You can't cover">
		<ARTICLE ,PRSI T>
		<TELL " with that." CR>)
	       (T
		<TELL "There's no good surface on">
		<ARTICLE ,PRSI T>
		<TELL "." CR>)>>

<ROUTINE V-PUT-UNDER ()
         <V-DIG>>

<ROUTINE V-RAPE ()
	 <V-KISS>>

<ROUTINE V-RAISE ()
	 <HACK-HACK "Playing in this way with">>

;<ROUTINE V-REACH-IN ("AUX" OBJ)
	 <COND (<OR <NOT <FSET? ,PRSO ,CONTBIT>>
		    <FSET? ,PRSO ,ACTORBIT>>
		<V-CARVE>)
	       (<NOT <FSET? ,PRSO ,OPENBIT>>
		<TELL "It's not open." CR>)
	       (<OR <NOT <SET OBJ <FIRST? ,PRSO>>>
		    <FSET? .OBJ ,INVISIBLE>
		    <NOT <FSET? .OBJ ,TAKEBIT>>>
		<TELL "It's empty." CR>)
	       (T
		<TELL "You reach into">
		<ARTICLE ,PRSO T>
		<TELL " and feel something." CR>
		<RTRUE>)>>

<ROUTINE PRE-READ ()
	 <COND (<AND <FSET? ,TOWEL ,WORNBIT>
		     <NOT <PRSO? ,TOWEL>>>
		<TELL ,WITH-TOWEL CR>)
	       (<AND <NOT ,LIT>
		     <NOT <PRSO? ,HANGOVER>>>
		<TELL ,TOO-DARK CR>)
	       (<AND ,PRSI
		     <NOT <FSET? ,PRSI ,TRANSBIT>>>
		<TELL "How does one look through">
		<ARTICLE ,PRSI>
		<TELL "?" CR>)>>

<ROUTINE V-READ ()
	 <COND (<FSET? ,PRSO ,READBIT>
		<TELL <GETP ,PRSO ,P?TEXT> CR>)
               (T
                <TELL "How can you read">
		<ARTICLE ,PRSO>
		<TELL "?" CR>)>>

<ROUTINE V-REFUSE ()
	 <SETG PRSA ,V?TAKE>
	 <DONT-F>>

<ROUTINE V-RELAX ()
	 <TELL ,ZEN CR>>

<ROUTINE V-REMOVE ()
	 <COND (<FSET? ,PRSO ,WEARBIT>
		<PERFORM ,V?TAKE-OFF ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-REPLACE ()
	 <TELL "It's not in need of replacement." CR>>

<ROUTINE V-REPAIR ()
	 <COND (<OR <AND <PRSO? ,THUMB>
		         <FSET? ,THUMB ,MUNGEDBIT>>
		    <AND <PRSO? ,HATCH>
			 ,LANDED>>
		<TELL "You have neither the tools nor the expertise." CR>)
	       (T
		<TELL "I'm not sure it's broken." CR>)>>

<ROUTINE V-REPLY ()
	 <TELL "It is hardly likely that">
	 <ARTICLE ,PRSO T>
	 <TELL " is interested." CR>
	 <FUCKING-CLEAR>>

<ROUTINE V-RUB ()
	 <COND (<LOC-CLOSED>
		<RTRUE>)
	       (T
		<HACK-HACK "Fiddling with">)>>

<ROUTINE V-SAVE-SOMETHING ()
	 <TELL "Sorry, but">
	 <ARTICLE ,PRSO T>
	 <TELL " is beyond help." CR>>

<ROUTINE V-SAY ("AUX" V)
	 <COND (<AND ,AWAITING-REPLY
		     <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?YES>>
		<V-YES>
		<FUCKING-CLEAR>)
	       (<AND ,AWAITING-REPLY
		     <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?NO>>
		<V-NO>
		<FUCKING-CLEAR>)
	       (<AND <IN? ,BEAST ,HERE>
		     <FSET? ,TOWEL ,WORNBIT>>
		<SAID-WITH-TOWEL>
		<FUCKING-CLEAR>)
	       (<AND <IN? ,BEAST ,HERE>
		     <NOT ,P-CONT>>
		<PERFORM ,V?TELL ,BEAST>
		<RTRUE>)
	       (<AND <IN? ,BEAST ,HERE>
		     <SAID-YOUR-NAME?>>
		<PERFORM ,V?SAY-NAME ,YOUR-NAME>
		<FUCKING-CLEAR>)
	       (<IN? ,BEAST ,HERE>
		<PERFORM ,V?SAY-NAME ,BEAST-NAME>
		<FUCKING-CLEAR>)
	       (<SET V <FIND-IN ,HERE ,ACTORBIT>>
		<TELL "You must address">
		<ARTICLE .V T>
		<TELL " directly." CR>
		<FUCKING-CLEAR>)
	       (T
		<PERFORM ,V?TELL ,ME>
		<FUCKING-CLEAR>)>>

<ROUTINE SAID-YOUR-NAME? ("AUX" OFFS LEN WRD)
	 <SET OFFS ,P-CONT>
	 <SET LEN ,P-LEN>
	 <REPEAT ()
		 <COND (<L? <SET LEN <- .LEN 1>> 0>
			<RFALSE>)>
		 <SET WRD <GET ,P-LEXV .OFFS>>
		 <COND (<OR <EQUAL? .WRD ,W?MY ,W?NAME ,W?IS>
			    <EQUAL? .WRD ,W?I ,W?AM ,W?I\'M>> T)
		       (<EQUAL? .WRD ,W?ARTHUR ,W?DENT>
			<RTRUE>)
		       (T
			<RFALSE>)>
		 <SET OFFS <+ .OFFS 2>>>>

<ROUTINE SAID-WITH-TOWEL ()
	 <TELL
"The Beast is puzzled by a voice coming from something it can't see."
,SLOWLY-DAWNS CR>>

<ROUTINE V-SAY-NAME ()
	 <COND (<IN? ,BEAST ,HERE>
		<COND (,NAME-TOLD
		       <TELL "You already told the Beast your name." CR>)
		      (<FSET? ,TOWEL ,WORNBIT>
		       <SAID-WITH-TOWEL>)
		      (<PRSO? ,YOUR-NAME ,ARTHUR ,NAME ,ME>
		       <ENABLE <QUEUE I-BEAST 2>>
		       <SETG NAME-TOLD T>
		       <TELL
"The Beast roars your name with relish, and explains that once it has eaten
you, your name will be added to its list of remembrance." CR>)
		      (T
		       <TELL
"There's something about detecting insincerity that transcends even the
vast gulf between Humanity and Bugblatter Bestiality. The Beast bellows,
obviously convinced that you were lying and that isn't your name nor
anything remotely like it." CR>)>)
	       (T
		<TELL "You should use quotes with this verb." CR>)>>

<ROUTINE V-SEARCH ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "That wouldn't be polite." CR>
		<RTRUE>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<PRSO? <LOC ,WINNER>>
		       <DESCRIBE-VEHICLE>
		       <RTRUE>)
		      (<NOT <FSET? ,PRSO ,OPENBIT>>
		       <TELL "You'll have to open it first." CR>
		       <RTRUE>)
		      (<AND <FIRST? ,PRSO>
			    <NOT <FSET? <FIRST? ,PRSO> ,NDESCBIT>>>
		       <PRINT-CONT ,PRSO>
		       <RTRUE>)>)>
	 <TELL "You find nothing unusual." CR>>

<ROUTINE V-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SHAKE ("AUX" X)
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Be real." CR>)
	       (T
		<HACK-HACK "Shaking">)>>

<ROUTINE V-SHAKE-WITH ()
	 <COND (<NOT <PRSO? ,HANDS>>
		<V-TELL-TIME>)
	       (<NOT <FSET? ,PRSI ,ACTORBIT>>
		<TELL "I don't think">
		<ARTICLE ,PRSI T>
		<TELL " even has hands." CR>)
	       (T
		<PERFORM ,V?THANK ,PRSI>
		<RTRUE>)>>

<ROUTINE V-SHOOT ()
	 <COND (<FSET? ,TOWEL ,WORNBIT>
		<TELL ,WITH-TOWEL CR>
		<RTRUE>)>
	 <COND (<NOT ,PRSO>
		<COND (<HELD? ,BEAST-GUN>
		       <SETG PRSO ,BEAST-GUN>)
		      (<HELD? ,BLASTER>
		       <SETG PRSO ,BLASTER>)
		      (T
		       <TELL "With what? At whom? Why?" CR>
		       <RTRUE>)>)>
	 <COND (<NOT ,PRSI>
		<COND (<PRSO? ,BEAST-GUN ,BLASTER>
		       <TELL "Some rays shoot out of the gun." CR>)
		      (<HELD? ,BEAST-GUN>
		       <PERFORM ,V?SHOOT ,PRSO ,BEAST-GUN>
		       <RTRUE>)
		      (<HELD? ,BLASTER>
		       <PERFORM ,V?SHOOT ,PRSO ,BLASTER>
		       <RTRUE>)
		      (T
		       <TELL "You have nothing to shoot">
		       <ARTICLE ,PRSO T>
		       <TELL " with." CR>)>)
	       (<PRSI? ,BEAST-GUN>
		<TELL "Some rays from the gun strike">
		<ARTICLE ,PRSO T>
		<TELL ", but ">
		<COND (<AND <PRSO? ,BEAST>
			    <NOT <FSET? ,BEAST ,MUNGEDBIT>>>
		       <SETG GUN-COUNTER <+ ,GUN-COUNTER 1>>
		       <TELL "it only seems to make it madder">
		       <COND (<EQUAL? ,GUN-COUNTER 3>
			      <TELL " (Footnote 7)">)>
		       <TELL "." CR>)
		      (T
		       <TELL "nothing else happens." CR>)>)
	       (T
		<TELL
"Don't ever bother applying for a job as an armaments expert." CR>)>>

<ROUTINE V-SHOW ()
	 <TELL "I doubt">
	 <ARTICLE ,PRSI T>
	 <TELL " is interested." CR>>

<ROUTINE V-SIT ("AUX" VEHICLE)
	 <COND (<SET VEHICLE <FIND-IN ,HERE ,VEHBIT>>
		<PERFORM ,V?BOARD .VEHICLE>
		<RTRUE>)
	       (T
		<V-DIG>)>>

<ROUTINE V-SKIP ()
	 <SETG AWAITING-REPLY 15>
	 <ENABLE <QUEUE I-REPLY 2>>
	 <TELL "Wasn't that fun?" CR>>

<ROUTINE V-SLEEP ("OPTIONAL" (TOLD? <>))
	 <COND (<EQUAL? ,HERE ,BEDROOM>
		<TELL
"You nod off and are wakened briefly a few hours later as">
		<BETTER-LUCK>)
	       (<EQUAL? ,HERE ,HOLD>
		<TELL
"You try, but the grubby mattresses are too repulsive." CR>)
	       (T
		<TELL "There's no bed here." CR>)>>

<ROUTINE V-SMELL ()
	 <TELL "It smells just like">
	 <ARTICLE ,PRSO>
	 <TELL "." CR>>

<ROUTINE V-SMILE ()
	 <COND (<AND <EQUAL? ,HERE ,CAPTAINS-QUARTERS>
		     <IN? ,POETRY ,HERE>>
		<V-APPLAUD>)
	       (T
		<TELL "How nice." CR>)>>

<ROUTINE V-SPIN ()
	 <TELL "You can't spin that!" CR>>

<ROUTINE V-SPUT-ON ()
	 <COND (<AND <PRSO? ,EARS>
		     <VISIBLE? ,POETRY>>
		<PERFORM ,V?LISTEN ,POETRY>
		<RTRUE>)
	       (T
		<PERFORM ,V?PUT-ON ,PRSI ,PRSO>
		<RTRUE>)>>

<ROUTINE V-SSHOOT ()
	 <PERFORM ,V?SHOOT ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SSHOW ()
	 <PERFORM ,V?SHOW ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-STAND ()
	 <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
		<PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		<RTRUE>)
	       (,LYING-DOWN
		<SETG LYING-DOWN <>>
		<COND (<RUNNING? ,I-PROSSER>
		       <TELL
"You are safe! Prosser heaves a visible sigh of relief, shakes his head
and wipes his brow. " ,BULLDOZER-PILES CR>
		       <BRICK-DEATH>)
		      (<AND <EQUAL? ,HERE ,FRONT-OF-HOUSE>
			    <NOT ,PROSSER-LYING>
			    <NOT <IN? ,FLEET ,HERE>>>
		       <TELL "The " D ,BULLDOZER-DRIVER
" gives a quick chew of his gum and slams in the clutch. " ,BULLDOZER-PILES CR>
		       <BRICK-DEATH>)
		      (T
		       <OWN-FEET>)>)
	       (<AND ,PRSO
		     <FSET? ,PRSO ,TAKEBIT>>
		<V-DIG>)
	       (T
		<TELL "You are already standing." CR>)>>

<ROUTINE V-STAND-BEFORE ()
	 <COND (<PRSO? ,DISPENSER>
		<TELL "The slot is too wide to block that way." CR>)
	       (<PRSO? ,FISH-HOLE ,ROBOT-PANEL ,HOOK>
		<TELL "You'd never be able to push the "
D ,DISPENSER-BUTTON " from there." ,GETTING-CLOSE CR>)
	       (<AND <PRSO? ,BULLDOZER ,HOUSE ,HOME>
		     <EQUAL? ,IDENTITY-FLAG ,ARTHUR>>
		<TELL
"The " D ,BULLDOZER " could easily maneuver around you." ,GETTING-CLOSE CR>)
	       (T
		<V-DIG>)>>

<ROUTINE V-STAND-ON ()
	 <COND (,IN-FRONT-FLAG
		<PERFORM ,V?STAND-BEFORE ,PRSO>
		<RTRUE>)
	       (T
		<V-DIG>)>>

<ROUTINE V-STEER ()
	 <TELL "That would be pointless." CR>>

<ROUTINE PRE-TAKE ()
	 <COND (<OR <AND <PRSO? ,GOWN>
			 ,GOWN-HUNG
			 ,LYING-DOWN>
		    <AND <PRSO? ,TOWEL>
			 <FSET? ,TOWEL ,SURFACEBIT>
			 ,LYING-DOWN>>
		<TELL ,WHILE-LYING CR>)
	       (<PRSO? ,BABEL-FISH>
		<RFALSE>)
	       (<LOC-CLOSED>
		<RTRUE>)
	       (<OR <AND <PRSO? ,DANGLY-BIT>
			 <PRSI? ,BROWNIAN-SOURCE>
			 ,PRSI>
		    <AND <PRSO? ,SMALL-PLUG>
			 <PRSI? ,PLOTTER ,SMALL-RECEPTACLE>
			 ,DRIVE-TO-PLOTTER>
		    <AND <PRSO? ,LARGE-PLUG>
			 <PRSI? ,CONTROLS ,LARGE-RECEPTACLE>
			 ,DRIVE-TO-CONTROLS>>
		<PERFORM ,V?REMOVE ,PRSO>
		<RTRUE>)
	       (<AND <FSET? ,PRSO ,INTEGRALBIT>
		     <PRSI? <LOC ,PRSO>>>
		<RFALSE>)
	       (<OR <IN? ,PRSO ,PROTAGONIST>
		    <AND <HELD? ,PRSO>
			 <NOT <FSET? ,PRSO ,TAKEBIT>>>>
		<COND (<FSET? ,PRSO ,WORNBIT>
		       <TELL "You are already wearing it." CR>)
		      (T
		       <TELL "You already have it." CR>)>)
	       (,PRSI
		<COND (<PRSI? ,ME>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)
		      (<AND <PRSO? ,ITEM-ON-SATCHEL>
			    <PRSI? ,SATCHEL>>
		       <RFALSE>)
		      (<AND <PRSO? ,ITEM-DROPPED-AT-PARTY>
			    <PRSI? ,HOSTESS>>
		       <RFALSE>)
		      (<NOT <PRSI? <LOC ,PRSO>>>
		       <TELL "But">
		       <ARTICLE ,PRSO T>
		       <TELL " isn't ">
		       <COND (<AND <FSET? ,PRSI ,ACTORBIT>
				   <NOT <PRSI? ,NUTRIMAT ,SCREENING-DOOR>>>
			      <TELL "being held by">)
			     (<FSET? ,PRSI ,SURFACEBIT>
			      <TELL "on">)
			     (T
			      <TELL "in">)>
		       <ARTICLE ,PRSI T>
		       <TELL "." CR>)
		      (T
		       <SETG PRSI <>>
		       <RFALSE>)>)
	       (<PRSO? <LOC ,WINNER>>
		<TELL "You are in it!" CR>)
	       (<AND ,HEADACHE
		     <NOT <PRSO? ,GOWN>>
		     <FSET? ,PRSO ,TAKEBIT>
		     <NOT <HELD? ,PRSO>>>
		<TELL <PICK-ONE ,LURCHES> CR>)>>

<GLOBAL LURCHES
	<PLTABLE
"It slips through your fumbling fingers and hits the carpet with a
nerve-shattering bang."
"It dances by you like a thing possessed."
"You lunge for it, but the room spins nauseatingly away. The floor
gives you a light tap on the forehead."
"You're certainly picking the tough tasks. The floor acts like a
trampoline on an ice rink, or like something they've been working
on for years at Disneyland.">>

<ROUTINE V-TAKE ()
	 <COND (<EQUAL? <ITAKE> T>
		<COND (<AND <PRSO? ,JACKET-FLUFF>
			    <FSET? ,JACKET-FLUFF ,TRYTAKEBIT>>
		       <FCLEAR ,JACKET-FLUFF ,TRYTAKEBIT>
		       <FCLEAR ,JACKET-FLUFF ,NDESCBIT>
		       <SETG FLUFF-REMOVED T>
		       <ENABLE <QUEUE I-ZAPHOD 6>>
		       <ENABLE <QUEUE I-ARTHUR 2>>
		       <TELL
"You remove the " D ,JACKET-FLUFF ", improving Arthur's appearance greatly.
He is clearly touched, and starts happily to chat away to you. You discover
that he is only slightly more interesting to talk to than an averagely
interesting wall." CR>)
		      (T
		       <COND (<PRSO? ,ITEM-DROPPED-AT-PARTY>
			      <FCLEAR ,ITEM-DROPPED-AT-PARTY ,NDESCBIT>
			      <COND (<NOT <HELD? ,WINE>>
				     <SETG ITEM-DROPPED-AT-PARTY ,WINE>
				     <FCLEAR ,HOSTESS ,TOUCHBIT>)
				    (<NOT <HELD? ,HANDBAG>>
				     <SETG ITEM-DROPPED-AT-PARTY ,HANDBAG>
				     <FCLEAR ,HOSTESS ,TOUCHBIT>)
				    (<NOT <HELD? ,APPETIZERS>>
				     <SETG ITEM-DROPPED-AT-PARTY ,APPETIZERS>
				     <FCLEAR ,HOSTESS ,TOUCHBIT>)
				    (T
				     <SETG ITEM-DROPPED-AT-PARTY <>>
				     <FCLEAR ,HOSTESS ,NDESCBIT>)>)
			     (<AND <PRSO? ,GOWN>
				   ,GOWN-HUNG>
			      <FCLEAR ,GOWN ,TRYTAKEBIT>
			      <FCLEAR ,GOWN ,NDESCBIT>
			      <FSET ,GOWN ,OPENBIT>
			      <SETG GOWN-HUNG <>>)
			     (<PRSO? ,PANEL-BLOCKER>
			      <SETG PANEL-BLOCKER <>>
			      <FCLEAR ,PRSO ,TRYTAKEBIT>
			      <FCLEAR ,PRSO ,NDESCBIT>)>
		       <COND (<AND <PRSO? ,SATCHEL>
				   ,ITEM-ON-SATCHEL>
			      <MOVE ,ITEM-ON-SATCHEL ,HERE>
			      <FCLEAR ,ITEM-ON-SATCHEL ,NDESCBIT>
			      <FCLEAR ,ITEM-ON-SATCHEL ,TRYTAKEBIT>
			      <SETG ITEM-ON-SATCHEL <>>)
			     (<PRSO? ,ITEM-ON-SATCHEL>
			      <FCLEAR ,ITEM-ON-SATCHEL ,NDESCBIT>
			      <FCLEAR ,ITEM-ON-SATCHEL ,TRYTAKEBIT>
			      <SETG ITEM-ON-SATCHEL <>>)>
		       <TELL "Taken." CR>)>)>>

<ROUTINE V-TAKE-OFF ()
	 <COND (<FSET? ,PRSO ,WORNBIT>
		<FCLEAR ,PRSO ,WORNBIT>
		<TELL "Okay, you're no longer wearing">
		<ARTICLE ,PRSO T>
		<TELL "." CR>)
	       (T
		<TELL "You aren't wearing that!" CR>)>>

<ROUTINE V-TASTE ()
	 <TELL "You can't. At least, not in this game you can't." CR>>

<ROUTINE V-TELL ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<COND (,P-CONT
		       <SETG WINNER ,PRSO>
		       <SETG HERE <LOC ,WINNER>>
		       <RTRUE>)
		      (T
		       <TELL "Hmmm ...">
		       <ARTICLE ,PRSO T>
		       <TELL
" looks at you expectantly, as if you seemed to be about to talk." CR>)>)
	       (T
		<TELL "You can't talk to">
		<ARTICLE ,PRSO>
		<TELL "!" CR>
		<FUCKING-CLEAR>)>>

<ROUTINE V-TELL-ABOUT ()
	 <COND (<PRSO? ,ME>
		<PERFORM ,V?WHAT ,PRSI>
		<RTRUE>)
	       (T
		<TELL "It doesn't look like">
		<ARTICLE ,PRSO T>
		<TELL " is interested." CR>)>>

<ROUTINE V-TELL-TIME ()
	 <TELL "That sentence isn't one I recognise." CR>>

<ROUTINE V-TELL-NAME ()
	 <V-TELL-TIME>>

<ROUTINE V-THANK ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "You do so, but">
		<ARTICLE ,PRSO T>
		<TELL " seems less than overjoyed." CR>)
	       (T
		<V-CARVE>)>>

<ROUTINE V-THROUGH ("AUX" M)
	<COND (<FSET? ,PRSO ,DOORBIT>
	       <DO-WALK <OTHER-SIDE ,PRSO>>
	       <RTRUE>)
	      (<FSET? ,PRSO ,VEHBIT>
	       <PERFORM ,V?BOARD ,PRSO>
	       <RTRUE>)
	      (<NOT <FSET? ,PRSO ,TAKEBIT>>
	       <TELL "You hit your head against">
	       <ARTICLE ,PRSO T>
	       <TELL " as you attempt this feat." CR>)
	      (<IN? ,PRSO ,WINNER>
	       <PERFORM ,V?EXAMINE ,EYES>
	       <RTRUE>)
	      (T
	       <V-CARVE>)>>

<ROUTINE PRE-THROW ()
	 <COND (<AND <PRSO? ,INTNUM>
		     <L? ,P-NUMBER 9>
		     <ACCESSIBLE? ,BOARD>>
		<PERFORM ,V?TURN ,DIPSWITCH>
		<RTRUE>)
	       (<FSET? ,PRSO ,SWITCHBIT>
		<RFALSE>)
	       (<IDROP>
		<RTRUE>)>>

<ROUTINE V-THROW ()
	 <COND (<EQUAL? ,HERE ,HOLD>
		<MOVE ,PRSO ,LOCAL-GLOBALS>
		<TELL ,ROBOT-FLIES-IN "collects">
		<ARTICLE ,PRSO T>
		<TELL " in mid-air, and flashes away." CR>) 
	       (<EQUAL? ,HERE ,MAZE ,ACCESS-SPACE>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (,PRSI
		<MOVE ,PRSO ,HERE>
		<TELL "You missed." CR>)
	       (T
		<MOVE ,PRSO ,HERE>
		<TELL "Thrown." CR>)>>

<ROUTINE V-THROW-OFF ()
	 <TELL "You can't do that!" CR>>

<ROUTINE V-THROW-IN-TOWEL ()
	 <COND (<PRSO? ,TOWEL>
		<V-QUIT>)
	       (T
		<V-TELL-TIME>)>>

<ROUTINE V-TIE ()
	 <TELL "You can't tie">
	 <ARTICLE ,PRSO>
	 <TELL "." CR>>

<ROUTINE V-TIE-TOGETHER ()
	 <COND (<PRSO? ,SLEEVES>
		<PERFORM ,V?TIE ,SLEEVES>
		<RTRUE>)
	       (T
		<V-TELL-TIME>)>>

<ROUTINE V-TURN ()
	 <COND (<PRSO? ,BOAT-OBJECT>
		<TELL "Try: STEER BOAT TOWARD (something)." CR>)
	       (<PRSO? ,ME ,ROOMS>
		<V-SKIP>)
	       (<AND <PRSO? ,INTNUM>
		     <L? ,P-NUMBER 9>
		     <ACCESSIBLE? ,BOARD>>
		<PERFORM ,V?TURN ,DIPSWITCH>
		<RTRUE>)
	       (T
		<TELL "This has no effect." CR>)>>

<ROUTINE V-TYPE ()
	 <COND (<NOT <EQUAL? ,HERE ,HOLD>>
		<TELL "There's no " D ,KEYBOARD " in sight." CR>
		<FUCKING-CLEAR>)
	       (<AND <NOT ,POEM-ENJOYED>
		     ,P-CONT>
		<PERFORM ,V?MUNG ,GLASS-CASE>
		<RTRUE>)
	       (<AND <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?FRIPPI>
		     <EQUAL? ,LINE-NUMBER 1 2>
		     <EQUAL? ,WORD-NUMBER 1>>
		<GLASS-CASE-OPENS>)
	       (<AND <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?LYSHUS>
		     <EQUAL? ,LINE-NUMBER 1 2>
		     <EQUAL? ,WORD-NUMBER 2>>
		<GLASS-CASE-OPENS>)
	       (<AND <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?WIMBGU>
		     <EQUAL? ,LINE-NUMBER 1 2>
		     <EQUAL? ,WORD-NUMBER 3>>
		<GLASS-CASE-OPENS>)
	       (<AND <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?GASHEE>
		     <EQUAL? ,LINE-NUMBER 3 4>
		     <EQUAL? ,WORD-NUMBER 1>>
		<GLASS-CASE-OPENS>)
	       (<AND <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?MORPHO>
		     <EQUAL? ,LINE-NUMBER 3 4>
		     <EQUAL? ,WORD-NUMBER 2>>
		<GLASS-CASE-OPENS>)
	       (<AND <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?THOU>
		     <EQUAL? ,LINE-NUMBER 3 4>
		     <EQUAL? ,WORD-NUMBER 3>>
		<GLASS-CASE-OPENS>)
	       (<AND <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?BLEEM>
		     <EQUAL? ,LINE-NUMBER 5 6>
		     <EQUAL? ,WORD-NUMBER 1>>
		<GLASS-CASE-OPENS>)
	       (<AND <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?MISERA>
		     <EQUAL? ,LINE-NUMBER 5 6>
		     <EQUAL? ,WORD-NUMBER 2>>
		<GLASS-CASE-OPENS>)
	       (<AND <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?VENCHI>
		     <EQUAL? ,LINE-NUMBER 5 6>
		     <EQUAL? ,WORD-NUMBER 3>>
		<GLASS-CASE-OPENS>)
	       (<NOT ,P-CONT>
		<TELL "You didn't specify what you wanted to type." CR>)
	       (T
		<PERFORM ,V?MUNG ,GLASS-CASE>
		<RFATAL>)>>

<ROUTINE V-TYPE-ON ()
	 <COND (<PRSO? ,KEYBOARD>
		<SETG P-CONT <>>
		<V-TYPE>)
	       (T
		<TELL "You can't type on that!" CR>)>> 

<ROUTINE V-UNLOCK ()
	 <V-CARVE>>

<ROUTINE V-UNPLUG ()
	 <COND (<PRSO? ,SPARE-DRIVE ,LARGE-PLUG ,SMALL-PLUG ,PLOTTER>
		<TELL ,NOT-PLUGGED CR>)
	       (T
		<V-COUNT>)>>

<ROUTINE V-UNTIE ()
	 <V-CARVE>>

<ROUTINE V-WALK ("AUX" PT PTS STR OBJ RM)
	 <COND (<AND <IN? ,FLEET ,HERE>
		     <NOT <PRSO? ,P?UP ,P?DOWN>>>
		<TELL "You would be no safer there." CR>)
	       (,LYING-DOWN
		<TELL ,WHILE-LYING CR>)
	       (<FSET? ,TOWEL ,WORNBIT>
		<SETG BEARINGS-LOST T>
		<TELL
"You stumble in that direction, but as you can't see where you're going you
wander around in circles.">
		<COND (<NOT <FSET? ,BEAST ,MUNGEDBIT>>
		       <TELL
" The Beast is getting puzzled that something it can't see is stumbling around
its lair." ,SLOWLY-DAWNS>)>
		<CRLF>)
	       (<AND <NOT <EQUAL? ,HERE ,MAZE>>
		     <EQUAL? ,IDENTITY-FLAG ,ARTHUR>
		     ,BRAIN-DAMAGED
		     <PROB 30>>
		<TELL
"You notice that you can't remember how to walk. Oddly, as you think about
walking, all that comes to mind is an image of">
		<ARTICLE ,BRAIN-DAMAGED>
		<TELL "." CR>)
	       (<NOT ,P-WALK-DIR>
		<PERFORM ,V?WALK-TO ,PRSO>
		<RTRUE>)
	       (<SET PT <GETPT ,HERE ,PRSO>>
		<COND (<EQUAL? <SET PTS <PTSIZE .PT>> ,UEXIT>
		       <GOTO <GETB .PT ,REXIT>>)
		      (<EQUAL? .PTS ,NEXIT>
		       <TELL <GET .PT ,NEXITSTR> CR>
		       <RFATAL>)
		      (<EQUAL? .PTS ,FEXIT>
		       <COND (<SET RM <APPLY <GET .PT ,FEXITFCN>>>
			      <GOTO .RM>)
			     (<AND <EQUAL? ,HERE ,BRIDGE>
				   <EQUAL? ,P-WALK-DIR ,P?WEST>>
			      <RTRUE>)
			     (T
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,CEXIT>
		       <COND (<VALUE <GETB .PT ,CEXITFLAG>>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,CEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL ,CANT-GO CR>
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,DEXIT>
		       <COND (<FSET? <SET OBJ <GETB .PT ,DEXITOBJ>> ,OPENBIT>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <TELL .STR CR>
			      <SETG P-IT-OBJECT .OBJ>
			      <RFATAL>)
			     (T
			      <TELL "The " D .OBJ " is closed." CR>
			      <SETG P-IT-OBJECT .OBJ>
			      <RFATAL>)>)>)
	       (T
		<COND (<PRSO? ,P?OUT ,P?IN>
		       <V-WALK-AROUND>)
		      (T
		       <TELL ,CANT-GO CR>)>
		<RFATAL>)>>

<ROUTINE V-WALK-AROUND ()
	 <SETG AWAITING-REPLY 16>
	 <ENABLE <QUEUE I-REPLY 2>>
	 <TELL "Did you have any particular direction in mind?" CR>>

<ROUTINE V-WALK-TO ()
	 <COND (<OR <IN? ,PRSO ,HERE>
		    <GLOBAL-IN? ,PRSO ,HERE>>
		<COND (<PRSO? ,TRILLIAN ,HOSTESS>
		       <TELL "She">)
		      (<AND <FSET? ,PRSO ,ACTORBIT>
			    <NOT <PRSO? ,NUTRIMAT ,SCREENING-DOOR ,BEAST>>>
		       <TELL "He">)
		      (T
		       <TELL "It">)>
		<TELL "'s here!" CR>)
	       (T
		<V-WALK-AROUND>)>>

<ROUTINE V-WAIT ("OPTIONAL" (NUM 3))
	 <TELL "Time passes..." CR>
	 <REPEAT ()
		 <COND (<L? <SET NUM <- .NUM 1>> 0>
			<RETURN>)
		       (<CLOCKER>
			<RETURN>)>>
	 <SETG CLOCK-WAIT T>>

<ROUTINE V-WAIT-FOR ()
	 <TELL "You may be waiting quite a while." CR>>

<ROUTINE V-WATER ()
	 <TELL "It doesn't need watering." CR>>

<ROUTINE V-WAVE ()
	 <V-CARVE>>

<ROUTINE V-WAVE-AT ()
	 <COND (<NOT ,PRSO>
		<V-SMILE>)
	       (T
		<TELL "Despite your friendly nature,">
		<ARTICLE ,PRSO T>
		<TELL " isn't likely to respond." CR>)>>

<ROUTINE V-WEAR ()
	 <COND (<NOT <FSET? ,PRSO ,WEARBIT>>
		<TELL "You can't wear">
		<ARTICLE ,PRSO T>
		<TELL "." CR>)
	       (<FSET? ,PRSO ,WORNBIT>
		<TELL "You're already wearing">
		<ARTICLE ,PRSO T>
		<TELL "!" CR>)
	       (T
		<MOVE ,PRSO ,PROTAGONIST>
		<FSET ,PRSO ,WORNBIT>
		<TELL "You are now wearing">
		<ARTICLE ,PRSO T>
		<TELL "." CR>)>>

<ROUTINE V-WHAT ()
	 <TELL "Good question." CR>>

<ROUTINE V-WHAT-ABOUT ()
	 <TELL "Well, what about it?" CR>>

<ROUTINE V-WHAT-TIME ()
	 <V-TELL-TIME>>

<ROUTINE V-WHERE ()
	 <V-FIND T>>

<ROUTINE V-WHO ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?WHAT ,PRSO>
		<RTRUE>)
	       (T
		<TELL "That's not a person!" CR>)>>

<ROUTINE V-WHY ()
	 <TELL "Why not?" CR>>

<ROUTINE V-YELL ()
	 <TELL "You begin to get a sore throat." CR>>

<ROUTINE V-YES ()
	 <COND (<EQUAL? ,AWAITING-REPLY 1>
		<DO-WALK ,P?SOUTH>)
	       (<EQUAL? ,AWAITING-REPLY 2>
		<RFALSE>)
	       (<EQUAL? ,AWAITING-REPLY 3>
		<TELL "Well, tough." CR>)
	       (<EQUAL? ,AWAITING-REPLY 4>
		<PERFORM ,V?TAKE ,ITEM-DROPPED-AT-PARTY>
		<RTRUE>)
	       (<EQUAL? ,AWAITING-REPLY 5>
		<TELL "So do I." CR>)
	       (<OR <EQUAL? ,AWAITING-REPLY 6 8 11>
		    <EQUAL? ,AWAITING-REPLY 13 14 15>>
		<TELL "That was just a rhetorical question." CR>)
	       (<EQUAL? ,AWAITING-REPLY 7 9>
		<TELL "Well, good for you!" CR>)
	       (<EQUAL? ,AWAITING-REPLY 10>
		<PERFORM ,V?ENJOY ,FORD>
		<RTRUE>)
	       (<EQUAL? ,AWAITING-REPLY 12>
		<ENABLE <QUEUE I-ENGINEER 2>>
		<TELL "\"Well, let's see the malfunctioning equipment.\"" CR>)
	       (<EQUAL? ,AWAITING-REPLY 16>
		<TELL "Then type it." CR>)
	       (<EQUAL? ,AWAITING-REPLY 18 19>
		<TELL "\"Well, leave me alone then! I'm busy!\"" CR>)
	       (T
		<TELL "You sound rather positive." CR>)>>


;"subtitle object manipulation"

<ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" CNT OBJ)
	 <COND (<FSET? ,PRSO ,INTEGRALBIT>
		<COND (.VB
		       <PART-OF>)>
		<RFATAL>)
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<COND (.VB
		       <V-CARVE>)>
		<RFATAL>)
	       (<AND <EQUAL? ,IDENTITY-FLAG ,TRILLIAN>
		     <G? <CCOUNT ,PROTAGONIST> 2>>
		<COND (.VB
		       <TELL
"As is the case so often at parties, you find that you are holding too much
and can't pick up anything else." CR>)>
		<RFATAL>)
	       (<NOT <IN? <LOC ,PRSO> ,WINNER>>
		<COND (<G? <+ <WEIGHT ,PRSO> <WEIGHT ,WINNER>> 100>
		       <COND (.VB
			      <TELL "Your load is too heavy." CR>)>
		       <RFATAL>)
		      (<AND <G? <SET CNT <CCOUNT ,WINNER>> 7>
			    <PROB <* .CNT 8>>>
		       <COND (.VB
			      <TELL "You're holding too much already." CR>)>
		       <RFATAL>)>)>
	 <MOVE ,PRSO ,PROTAGONIST>
	 <FSET ,PRSO ,TOUCHBIT>
	 <RTRUE>>

<ROUTINE IDROP () ;"revised 7/19/84 by SEM"
	 <COND (<PRSO? ,HANGOVER>
		<RFALSE>)
	       (<AND <PRSO? ,NO-TEA>
		     ,HOLDING-NO-TEA>
		<RFALSE>)
	       (<AND <PRSO? ,DANGLY-BIT ,LARGE-PLUG ,SMALL-PLUG>
		     <VERB? PUT PUT-ON>>
		<RFALSE>)
	       (<AND <VERB? GIVE>
		     <PRSO? ,SPEECH>>
		<RFALSE>)
	       (<PRSO? ,SLEEVES>
		<V-DIG>)
	       (<PRSO? ,EYES ,EARS ,HANDS ,HEAD>
		<COND (<VERB? DROP THROW GIVE>
		       <V-COUNT>)
		      (<AND <VERB? PUT-ON>
			    <PRSI? ,SATCHEL>>
		       <V-COUNT>)
		      (T
		       <RFALSE>)>)
	       (<AND <PRSO? ,SPARE-DRIVE>
		     <PRSI? ,LARGE-RECEPTACLE ,SMALL-RECEPTACLE
			    ,CONTROLS ,PLOTTER>>
		<RFALSE>)
	       (<NOT <HELD? ,PRSO>>
		<TELL "That's easy for you to say since you don't even have">
		<ARTICLE ,PRSO T>
		<TELL "." CR>)
	       (<PRSO? ,PLANT>
		<PERFORM ,V?DROP ,FLOWERPOT>
		<RTRUE>)
	       (<FSET? ,PRSO ,INTEGRALBIT>
		<PART-OF>)
	       (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL "Impossible because">
		<ARTICLE <LOC ,PRSO> T>
		<TELL " is closed." CR>)
	       (<OR <AND <PRSO? ,BABEL-FISH>
			 <NOT <VERB? SHOW>>>
		    <FSET? ,PRSO ,WORNBIT>>
		<TELL "You'll have to remove it first." CR>)
	       (T
		<RFALSE>)>>

<ROUTINE CCOUNT	(OBJ "AUX" (CNT 0) X)
	 <COND (<SET X <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<AND <NOT <FSET? .X ,WORNBIT>>
				    <NOT <EQUAL? .X ,BABEL-FISH>>>
			       <SET CNT <+ .CNT 1>>)>
			<COND (<NOT <SET X <NEXT? .X>>>
			       <RETURN>)>>)>
	 .CNT>

;"Gets SIZE of supplied object, recursing to nth level."
<ROUTINE WEIGHT (OBJ "AUX" CONT (WT 0))
	 <COND (<SET CONT <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<AND <EQUAL? .OBJ ,PLAYER>
				    <FSET? .CONT ,WORNBIT>>
			       <SET WT <+ .WT 1>>)
			              ;"worn things shouldn't count"
			      (<AND <EQUAL? .OBJ ,PLAYER>
				    <FSET? <LOC .CONT> ,WORNBIT>>
			       <SET WT <+ .WT 1>>)
			              ;"things in worn things shouldn't count"
			      (<AND <EQUAL? .OBJ ,PLAYER>
				    <EQUAL? .CONT ,BABEL-FISH>>
			       <SET WT <+ .WT 1>>)
			              ;"the babel fish shouldn't count"
			      (T
			       <SET WT <+ .WT <WEIGHT .CONT>>>)>
			<COND (<NOT <SET CONT <NEXT? .CONT>>> <RETURN>)>>)>
	 <+ .WT <GETP .OBJ ,P?SIZE>>>


;"subtitle describers"

<ROUTINE DESCRIBE-ROOM ("OPTIONAL" (LOOK? <>) "AUX" V? STR AV)
	 <SET V? <OR .LOOK? <EQUAL? ,VERBOSITY 2>>>
	 <COND (<NOT ,LIT>
		<TELL "It is pitch black.">
		<CRLF>
		<RETURN <>>)>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<FSET ,HERE ,TOUCHBIT>
		<SET V? T>)>
	 <COND (<IN? ,HERE ,ROOMS>
		<TELL D ,HERE>
		<SET AV <LOC ,WINNER>>
		<COND (<AND <NOT ,LYING-DOWN>
			    <NOT <FSET? .AV ,VEHBIT>>>
		       <CRLF>)>)>
	 <COND (<OR .LOOK?
		    <EQUAL? ,VERBOSITY 1 2>>
		<COND (<FSET? .AV ,VEHBIT>
		       <TELL ", in the " D .AV CR>)
		      (,LYING-DOWN
		       <TELL ", lying down" CR>)>
		<COND (<AND .V? <APPLY <GETP ,HERE ,P?ACTION> ,M-LOOK>>
		       <RTRUE>)
		      (<AND .V? <SET STR <GETP ,HERE ,P?LDESC>>>
		       <TELL .STR CR>)
		      (T
		       <APPLY <GETP ,HERE ,P?ACTION> ,M-FLASH>)>
		<COND (<AND <NOT <EQUAL? ,HERE .AV>>
			    <FSET? .AV ,VEHBIT>>
		       <APPLY <GETP .AV ,P?ACTION> ,M-LOOK>)>)>
	 T>

<ROUTINE DESCRIBE-OBJECTS ("OPTIONAL" (V? <>))
   <COND (,LIT
	  <COND (<FIRST? ,HERE>
		 <PRINT-CONT ,HERE <SET V? <OR .V? <==? ,VERBOSITY 2>>> -1>)>)
	 (T
	  <TELL ,TOO-DARK CR>)>>

"DESCRIBE-OBJECT -- takes object and flag.  if flag is true will print a
long description (fdesc or ldesc), otherwise will print short."
<ROUTINE DESCRIBE-OBJECT (OBJ V? LEVEL "AUX" (STR <>) AV)
	 <COND (<AND <0? .LEVEL>
		     <APPLY <GETP .OBJ ,P?DESCFCN> ,M-OBJDESC>>
		<RTRUE>)
	       (<AND <0? .LEVEL>
		     <OR <AND <NOT <FSET? .OBJ ,TOUCHBIT>>
			      <SET STR <GETP .OBJ ,P?FDESC>>>
			 <SET STR <GETP .OBJ ,P?LDESC>>>>
		<TELL .STR>)
	       (<0? .LEVEL>
		<TELL "There is">
		<ARTICLE .OBJ>
		<TELL " here.">)
	       (T
		<TELL <GET ,INDENTS .LEVEL>>
		<COND (<FSET? .OBJ ,NARTICLEBIT>
		       T)
		      (<FSET? .OBJ ,VOWELBIT>
		       <TELL "an ">)
		      (T
		       <TELL "a ">)>
		<TELL D .OBJ>
		<COND (<FSET? .OBJ ,WORNBIT>
		       <TELL " (being worn)">)
		      (<EQUAL? .OBJ ,BABEL-FISH>
		       <TELL " (in your ear)">)
		      (<AND <EQUAL? .OBJ ,PLOTTER>
			    ,BROWNIAN-SOURCE>
		       <TELL " (suspended in">
		       <ARTICLE ,BROWNIAN-SOURCE>
		       <TELL ")">)
		      (<AND <EQUAL? .OBJ ,SPARE-DRIVE>
			    <OR ,DRIVE-TO-PLOTTER ,DRIVE-TO-CONTROLS>>
		       <TELL " (connected to">
		       <COND (,DRIVE-TO-PLOTTER
			      <TELL " the plotter">
			      <COND (,DRIVE-TO-CONTROLS
				     <TELL " and">)>)>
		       <COND (,DRIVE-TO-CONTROLS
			      <TELL " the control console">)>
		       <TELL ")">)>)>
	 <COND (<AND <0? .LEVEL>
		     <NOT <FSET? .OBJ ,ACTORBIT>>
		     <SET AV <LOC ,WINNER>>
		     <FSET? .AV ,VEHBIT>>
		<TELL " (outside the " D .AV ")">)>
	 <CRLF>
	 <COND (<AND <SEE-INSIDE? .OBJ> <FIRST? .OBJ>>
		<PRINT-CONT .OBJ .V? .LEVEL>)>>

<ROUTINE PRINT-CONT (OBJ
		     "OPTIONAL" (V? <>) (LEVEL 0)
		     "AUX" Y (1ST? T) (AV <>) STR (PV? <>) (INV? <>) (SC <>))
	 <COND (<NOT <SET Y <FIRST? .OBJ>>>
		<RTRUE>)>
	 <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
		<SET AV <LOC ,WINNER>>)>
	 <COND (<EQUAL? ,PROTAGONIST .OBJ <LOC .OBJ>>
		<SET INV? T>)
	       (T
		<REPEAT ()
			<COND (<NOT .Y>
			       <RETURN <NOT .1ST?>>)
			      (<EQUAL? .Y .AV>
			       <SET PV? T>)
			      (<EQUAL? .Y ,WINNER>)
			      (<AND <NOT <FSET? .Y ,INVISIBLE>>
				    <NOT <FSET? .Y ,TOUCHBIT>>
				    <SET STR <GETP .Y ,P?FDESC>>>
			       <COND (<NOT <FSET? .Y ,NDESCBIT>>
				      <TELL .STR CR>)>
			       <COND (<AND <SEE-INSIDE? .Y>
					   <NOT <GETP <LOC .Y> ,P?DESCFCN>>
					   <FIRST? .Y>>
				      <PRINT-CONT .Y .V? 0>)>)>
			<SET Y <NEXT? .Y>>>)>
	 <SET Y <FIRST? .OBJ>>
	 ;<COND (<AND <EQUAL? .OBJ ,HERE>
		     <IN? ,SATCHEL ,HERE>>
		<DESCRIBE-OBJECT ,SATCHEL .V? .LEVEL>
		<SET SC T>)>
	 <REPEAT ()
		 <COND (<NOT .Y>
			<COND (<AND .PV? .AV <FIRST? .AV>>
			       <PRINT-CONT .AV .V? .LEVEL>)>
			<RETURN <NOT .1ST?>>)
		       (<EQUAL? .Y .AV ,PROTAGONIST> T)
		       ;(<AND .SC <EQUAL? .Y ,SATCHEL>> T)
		       (<AND <NOT <FSET? .Y ,INVISIBLE>>
			     <OR .INV?
				 <FSET? .Y ,TOUCHBIT>
				 <NOT <GETP .Y ,P?FDESC>>>>
			<COND (<AND <EQUAL? .Y ,STONE>
				    <EQUAL? ,HERE ,OUTER-LAIR>
				    <IN? .Y ,HERE>>
			       <FSET .Y ,NDESCBIT>)
			      (<NOT <FSET? .Y ,NDESCBIT>>
			       <COND (.1ST?
				      <COND (<FIRSTER .OBJ .LEVEL>
					     <COND (<L? .LEVEL 0>
						    <SET LEVEL 0>)>)>
				      <SET LEVEL <+ 1 .LEVEL>>
				      <SET 1ST? <>>)>
			       <DESCRIBE-OBJECT .Y .V? .LEVEL>)
			      (<AND <FIRST? .Y>
				    <SEE-INSIDE? .Y>>
			       <PRINT-CONT .Y .V? .LEVEL>)>)>
		 <SET Y <NEXT? .Y>>>>

<ROUTINE PRINT-CONTENTS (OBJ "AUX" F N (1ST? T) (IT? <>) (TWO? <>))
	 <COND (<SET F <FIRST? .OBJ>>
		<REPEAT ()
			<SET N <NEXT? .F>>
			<COND (.1ST?
			       <SET 1ST? <>>)
			      (T
			       <TELL ",">
			       <COND (<NOT .N>
				      <TELL " and">)>)>
			<ARTICLE .F>
			<COND (<AND <NOT .IT?>
				    <NOT .TWO?>>
			       <SET IT? .F>)
			      (T
			       <SET TWO? T>
			       <SET IT? <>>)>
			<SET F .N>
			<COND (<NOT .F>
			       <COND (<AND .IT? <NOT .TWO?>>
				      <SETG P-IT-OBJECT .IT?>)>
			       <RTRUE>)>>)>>

<ROUTINE FIRSTER (OBJ LEVEL)
	 <COND (<EQUAL? .OBJ ,WINNER>
		<RTRUE>)
	       (<NOT <IN? .OBJ ,ROOMS>>
		<COND (<G? .LEVEL 0>
		       <TELL <GET ,INDENTS .LEVEL>>)>
		<COND (<FSET? .OBJ ,SURFACEBIT>
		       <TELL "Sitting on the " D .OBJ " is:" CR>)
		      (<AND <FSET? .OBJ ,ACTORBIT>
			    <NOT <EQUAL? .OBJ ,NUTRIMAT>>>
		       <TELL ,IT-LOOKS-LIKE>
		       <ARTICLE .OBJ T>
		       <TELL " is holding:" CR>)
		      (T
		       <TELL ,IT-LOOKS-LIKE>
		       <ARTICLE .OBJ T>
		       <TELL " contains:" CR>)>)>>

<ROUTINE DESCRIBE-VEHICLE () ;"for LOOK AT vehicle when you're in it"
	 <MOVE ,PROTAGONIST ,ROOMS>
	 <COND (<FIRST? ,PRSO>
		<PRINT-CONT ,PRSO>)
	       (T
		<TELL "It's empty (not counting you)." CR>)>
	 <MOVE ,PROTAGONIST ,PRSO>>


;"subtitle movement and death"

<CONSTANT REXIT 0>
<CONSTANT UEXIT 1>
<CONSTANT NEXIT 2>
<CONSTANT FEXIT 3>
<CONSTANT CEXIT 4>
<CONSTANT DEXIT 5>

<CONSTANT NEXITSTR 0>
<CONSTANT FEXITFCN 0>
<CONSTANT CEXITFLAG 1>
<CONSTANT CEXITSTR 1>
<CONSTANT DEXITOBJ 1>
<CONSTANT DEXITSTR 1>

<ROUTINE GOTO (RM "OPTIONAL" (V? T))
	 <MOVE ,PROTAGONIST .RM>
	 <SETG HERE .RM>
	 <COND (<NOT <EQUAL? ,HERE ,DARK>>
		<MOVE ,NAME ,HERE>)>
	 <SETG LIT <LIT? ,HERE>>
	 <UNPLUG-HELD-STUFF>
	 <APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
	 <COND (<AND .V?
		     <EQUAL? ,HERE .RM>>
		<V-FIRST-LOOK>)>
	 <RTRUE>>

<ROUTINE UNPLUG-HELD-STUFF ()
	 <COND (<AND ,DRIVE-TO-CONTROLS
		     <HELD? ,SPARE-DRIVE>>
		<SETG DRIVE-TO-CONTROLS <>>
		<FCLEAR ,SPARE-DRIVE ,NDESCBIT>
		<TELL "(unplugging the spare drive first)" CR>)>
	 <COND (<AND <HOLDING-ONE-BUT-NOT-BOTH? ,SPARE-DRIVE ,PLOTTER>
		     ,DRIVE-TO-PLOTTER>
		<SETG DRIVE-TO-PLOTTER <>>
		<TELL "(disconnecting the short cord first)" CR>)>
	 <COND (<AND <HOLDING-ONE-BUT-NOT-BOTH? ,BROWNIAN-SOURCE ,PLOTTER>
		     ,BROWNIAN-SOURCE>
		<SETG BROWNIAN-SOURCE <>>
		<REMOVING-BIT>)>>

<ROUTINE JIGS-UP (DESC)
	 <TELL .DESC>	       
	 <COND (,DREAMING
		<TELL " Everything becomes..." CR CR>
		<COND (<EQUAL? ,IDENTITY-FLAG ,FORD>
		       <ROB ,PROTAGONIST ,LOCAL-GLOBALS>
		       <COND (<GET ,FORD-TABLE 4>
			      <FSET ,THUMB ,MUNGEDBIT>)>
		       <ROB ,MEMORIAL ,PROTAGONIST>
		       <MOVE ,SATCHEL <GET ,FORD-TABLE 0>>
		       <MOVE ,THUMB <GET ,FORD-TABLE 1>>
		       <MOVE ,GUIDE <GET ,FORD-TABLE 2>>
		       <MOVE ,TOWEL <GET ,FORD-TABLE 3>>
		       <MOVE ,MINERAL-WATER <GET ,FORD-TABLE 5>>
		       <COND (<NOT <FSET? ,COUNTRY-LANE ,REVISITBIT>>
		       	      <MOVE ,SATCHEL-FLUFF ,SATCHEL>)>
		       <FCLEAR ,SATCHEL ,OPENBIT>
		       <FCLEAR ,COUNTRY-LANE ,NDESCBIT>
		       <SETG TOWEL-OFFERED <>>
		       <SETG GONE-AROUND <>>
		       <DISABLE <INT I-ARTHUR>>
		       <LEAVE-EARTH>)
		      (<EQUAL? ,IDENTITY-FLAG ,TRILLIAN>
		       <MOVE ,HANDBAG <GET ,PARTY-TABLE 0>>
		       <COND (<IN? ,TWEEZERS ,HANDBAG>
			      <MOVE ,TWEEZERS <GET ,PARTY-TABLE 1>>)>
		       <COND (<GET ,PARTY-TABLE 2>
			      <FSET ,HANDBAG ,OPENBIT>)
			     (T
			      <FCLEAR ,HANDBAG ,OPENBIT>)>
		       <COND (<NOT <FSET? ,LIVING-ROOM ,REVISITBIT>>
			      <MOVE ,JACKET-FLUFF ,LOCAL-GLOBALS>
			      <FSET ,JACKET-FLUFF ,TRYTAKEBIT>
			      <FSET ,JACKET-FLUFF ,NDESCBIT>
			      <SETG FLUFF-REMOVED <>>
			      <FCLEAR ,HOSTESS ,NDESCBIT>)>
		       <ROB ,RAMP ,HANDBAG>
		       <FCLEAR ,LIVING-ROOM ,TOUCHBIT>
		       <FCLEAR ,HANDBAG ,NDESCBIT>
		       <FCLEAR ,WINE ,NDESCBIT>
		       <FCLEAR ,APPETIZERS ,NDESCBIT>
		       <MOVE ,WINE ,LOCAL-GLOBALS>
		       <MOVE ,APPETIZERS ,LOCAL-GLOBALS>
		       <SETG TRILLIAN-PROB 10>
		       <SETG ITEM-DROPPED-AT-PARTY <>>
		       <DISABLE <INT I-ARTHUR>>
		       <DISABLE <INT I-ZAPHOD>>
		       <DISABLE <INT I-HOSTESS>>)
		      (<EQUAL? ,IDENTITY-FLAG ,ZAPHOD>
		       <SETG BOAT-DOCKED <>>
		       <SETG BOAT-COUNTER 0>
		       <SETG CRASH-COUNTER 0>
		       <SETG DAIS-COUNTER 0>
		       <MOVE ,GUARDS ,LOCAL-GLOBALS>
		       <MOVE ,BLASTER ,LOCAL-GLOBALS>
		       <MOVE ,RIFLES ,LOCAL-GLOBALS>
		       <FCLEAR ,SPEEDBOAT ,TOUCHBIT>
		       <FSET ,RIFLES ,NDESCBIT>
		       <DISABLE <INT I-GUARDS>>
		       <DISABLE <INT I-SPEEDBOAT>>
		       <COND (<NOT <FSET? ,SPEEDBOAT ,REVISITBIT>>
			      <MOVE ,TOOLBOX ,SPEEDBOAT>
			      <MOVE ,CUSHION-FLUFF ,LOCAL-GLOBALS>
			      <MOVE ,KEY ,LOCAL-GLOBALS>)>
		       <ROB ,PROTAGONIST ,LOCAL-GLOBALS>)
		      (<EQUAL? ,HERE ,INSIDE-WHALE> ;"remove non-worn items"
		       <ROB ,INSIDE-WHALE ,BULLDOZER>
		       <MOVE ,WHALE-OBJECT ,INSIDE-WHALE>
		       <COND (<NOT <HELD? ,FLOWERPOT ,THING>>
			      <MOVE ,FLOWERPOT ,HERE>)>
		       <ROB ,PROTAGONIST ,BULLDOZER>
		       <FCLEAR ,INSIDE-WHALE ,TOUCHBIT>
		       <COND (<AND <IN? ,GOWN ,BULLDOZER>
				   <FSET? ,GOWN ,WORNBIT>>
			      <MOVE ,GOWN ,PROTAGONIST>)>
		       <COND (<IN? ,BABEL-FISH ,BULLDOZER>
			      <MOVE ,BABEL-FISH ,PROTAGONIST>)>)
		      (<EQUAL? ,HERE ,WAR-CHAMBER ,MAZE>
		       <DISABLE <INT I-DOG>>
		       <FCLEAR ,WAR-CHAMBER ,TOUCHBIT>
		       <MOVE ,THIRD-PLANET ,LOCAL-GLOBALS>
		       <SETG DOG-COUNTER 0>
		       <COND (<EQUAL? ,HERE ,WAR-CHAMBER>
			      <ROB ,WAR-CHAMBER ,LOCAL-GLOBALS>
			      <MOVE ,AWL ,HERE>
			      <MOVE ,GGUGVUNT ,HERE>
			      <MOVE ,VLHURG ,HERE>
			      <MOVE ,CANOPY ,HERE>
			      <MOVE ,MICROSCOPIC-FLEET ,HERE>
			      <MOVE ,OTHER-PLANETS ,HERE>
			      <FCLEAR ,VLHURG ,MUNGEDBIT>)>)
		      (<EQUAL? ,HERE ,LAIR ,INNER-LAIR ,OUTER-LAIR>
		       <FCLEAR ,BEAST ,MUNGEDBIT>
		       <SETG BEAST-COUNTER 0>
		       <SETG BEARINGS-LOST <>>
		       <SETG NAME-TOLD <>>
		       <FCLEAR ,TOWEL ,WORNBIT>
		       <FCLEAR ,LAIR ,NDESCBIT>
		       <MOVE ,STONE ,OUTER-LAIR>
		       <MOVE ,BEAST ,LAIR>
		       <DISABLE <INT I-BEAST>>)>
		<SETG TEA-COUNTER 0>
		<MOVE ,MAIN-DRIVE ,GLOBAL-OBJECTS>
		<SETG HEART-PROB 100>
		<GOTO ,DARK>)
	       (T
		<TELL CR CR
"    ****  You have died  ****" CR CR>
		<FINISH>)>>


;"subtitle useful utility routines"

<ROUTINE ACCESSIBLE? (OBJ "AUX" (L <LOC .OBJ>)) ;"can player TOUCH object?"
	 ;"revised 5/2/84 by SEM and SWG"
	 <COND (<FSET? .OBJ ,INVISIBLE>
		<RFALSE>)
	       (<EQUAL? .OBJ ,PSEUDO-OBJECT>
		<COND (<EQUAL? ,LAST-PSEUDO-LOC ,HERE>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<NOT .L>
		<RFALSE>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<RTRUE>)	       
	       (<AND <EQUAL? .L ,LOCAL-GLOBALS>
		     <GLOBAL-IN? .OBJ ,HERE>>
		<RTRUE>)
	       (<NOT <EQUAL? <META-LOC .OBJ> ,HERE>>
		<RFALSE>)
	       (<EQUAL? .L ,WINNER ,HERE>
		<RTRUE>)
	       (<AND <FSET? .L ,OPENBIT>
		     <ACCESSIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE VISIBLE? (OBJ "AUX" (L <LOC .OBJ>)) ;"can player SEE object"
	 ;"revised 5/2/84 by SEM and SWG"
	 <COND (<ACCESSIBLE? .OBJ>
		<RTRUE>)
	       (<AND <SEE-INSIDE? .L>
		     <VISIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE META-LOC (OBJ)
	 <REPEAT ()
		 <COND (<NOT .OBJ>
			<RFALSE>)
		       (<IN? .OBJ ,GLOBAL-OBJECTS>
			<RETURN ,GLOBAL-OBJECTS>)>
		 <COND (<IN? .OBJ ,ROOMS>
			<RETURN .OBJ>)
		       (T
			<SET OBJ <LOC .OBJ>>)>>>

<ROUTINE OTHER-SIDE (DOBJ "AUX" (P 0) TEE) ;"finds room on others side of door"
	 <REPEAT ()
		 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
			<RETURN <>>)
		       (T
			<SET TEE <GETPT ,HERE .P>>
			<COND (<AND <EQUAL? <PTSIZE .TEE> ,DEXIT>
				    <EQUAL? <GETB .TEE ,DEXITOBJ> .DOBJ>>
			       <RETURN .P>)>)>>>

<ROUTINE HELD? (OBJ "OPTIONAL" (CONT <>))
	 <COND (<NOT .CONT>
		<SET CONT ,WINNER>)>
	 <COND (<NOT .OBJ>
		<RFALSE>)
	       (<IN? .OBJ .CONT>
		<RTRUE>)
	       (<IN? .OBJ ,ROOMS>
		<RFALSE>)
	       (<IN? .OBJ ,GLOBAL-OBJECTS>
		<RFALSE>)
	       (T
		<HELD? <LOC .OBJ> .CONT>)>>

<ROUTINE SEE-INSIDE? (OBJ)
	 <AND <NOT <FSET? .OBJ ,INVISIBLE>>
	      <OR <FSET? .OBJ ,TRANSBIT>
	          <FSET? .OBJ ,OPENBIT>>>>

<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TEE)
	 <COND (<SET TEE <GETPT .OBJ2 ,P?GLOBAL>>
		<ZMEMQB .OBJ1 .TEE <- <PTSIZE .TEE> 1>>)>>

<ROUTINE FIND-IN (WHERE WHAT "AUX" W)
	 <SET W <FIRST? .WHERE>>
	 <COND (<NOT .W>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<FSET? .W .WHAT>
			<RETURN .W>)
		       (<NOT <SET W <NEXT? .W>>>
			<RETURN <>>)>>>

<ROUTINE LOC-CLOSED ()
	 <COND (<AND <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>
		     <FSET? ,PRSO ,TAKEBIT>>
		<TELL "But">
		<ARTICLE <LOC ,PRSO> T>
		<TELL " is closed!" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE DO-WALK (DIR)
	 <SETG P-WALK-DIR .DIR>
	 <PERFORM ,V?WALK .DIR>>

<ROUTINE FUCKING-CLEAR ()
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RFATAL>>

<ROUTINE ROB (WHO "OPTIONAL" (WHERE <>) "AUX" N X)
	 <SET X <FIRST? .WHO>>
	 <REPEAT ()
		 <COND (<NOT .X>
			<RETURN>)>
		 <SET N <NEXT? .X>>
		 <MOVE .X .WHERE>
		 <SET X .N>>>

<ROUTINE HOLDING-ONE-BUT-NOT-BOTH? (ONE TWO)
	 <COND (<AND <HELD? .ONE>
		     <HELD? .TWO>>
		<RFALSE>)
	       (<HELD? .ONE>
		<RTRUE>)
	       (<HELD? .TWO>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE HACK-HACK (STR)
	 <TELL .STR>
	 <ARTICLE ,PRSO T>
	 <TELL <PICK-ONE ,HO-HUM> CR>>

<ROUTINE ARTICLE (OBJ "OPTIONAL" (THE <>))
	 <COND (<NOT .OBJ>
		<SET OBJ ,NOT-HERE-OBJECT>)>
	 <COND (<NOT <FSET? .OBJ ,NARTICLEBIT>>
		<COND (.THE
		       <TELL " the">)
		      (<FSET? .OBJ ,VOWELBIT>
		       <TELL " an">)
		      (T
		       <TELL " a">)>)>
	 <TELL " " D .OBJ>>

<GLOBAL HO-HUM
	<PLTABLE
	 " doesn't do anything."
	 " accomplishes nothing."
	 " has no desirable effect.">>		 

<GLOBAL YUKS
	<PLTABLE
	 "What a concept."
         "Nice try."
	 "You can't be serious."
	 "Not bloody likely.">>

<GLOBAL IMPOSSIBLES
	<PLTABLE
	 "You have lost your mind."
	 "You are clearly insane."
	 "You appear to have gone barking mad."
	 "I'm not convinced you're allowed to be playing with this computer."
	 "Run out on the street and say that. See what happens."
	 "No, no, a thousand times no. Go boil an egg.">>

<GLOBAL WASTES
	<PLTABLE
	  "Complete waste of time."
	  "Useless. Utterly useless."
	  "A totally unhelpful idea.">>