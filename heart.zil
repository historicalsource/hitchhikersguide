"HEART for
		  THE HITCHHIKER'S GUIDE TO THE GALAXY
	(c) Copyright 1984 Infocom, Inc.  All Rights Reserved."

<ROUTINE IN-HEART? (OBJ)
   <COND (<OR <EQUAL? <META-LOC .OBJ> ,ENTRY-BAY ,FORE-CORRIDOR ,AFT-CORRIDOR>
	      <EQUAL? <META-LOC .OBJ> ,GALLEY ,BRIDGE ,ENGINE-ROOM>
	      <EQUAL? <META-LOC .OBJ> ,HATCHWAY ,PANTRY ,ACCESS-SPACE>>
	  <RTRUE>)
	 (T
	  <RFALSE>)>>

<OBJECT HEART-OF-GOLD
	(IN LOCAL-GLOBALS)
	(DESC "the Heart of Gold")
	(SYNONYM HEART GOLD SHIP SPACES)
	(ADJECTIVE SPACE INCRED NEW)
	(FLAGS NARTICLEBIT)
	(ACTION HEART-OF-GOLD-F)>

<ROUTINE HEART-OF-GOLD-F ()
	 <COND (<VERB? LEAVE EXIT DISEMBARK>
		<COND (<EQUAL? ,HERE ,HATCHWAY>
		       <DO-WALK ,P?DOWN>)
		      (<EQUAL? ,HERE ,DAIS>
		       <TELL ,LOOK-AROUND CR>)
		      (T
		       <V-WALK-AROUND>)>)
	       (<VERB? THROUGH WALK-TO BOARD>
		<COND (<EQUAL? ,HERE ,DAIS>
		       <DO-WALK ,P?EAST>)
		      (<IN-HEART? ,PROTAGONIST>
		       <TELL ,LOOK-AROUND CR>)>)>>

<GLOBAL TEA-SHOWN <>>

<GLOBAL SUBSTITUTE-DRUNK <>>

<ROOM PANTRY
      (IN ROOMS)
      (SYNONYM INTELL)
      (DESC "Marvin's Pantry")
      (LDESC "This is a small closet with an exit to starboard.")
      (EAST TO AFT-CORRIDOR)
      (OUT TO AFT-CORRIDOR)
      (FLAGS RLANDBIT ONBIT NARTICLEBIT)
      (PSEUDO "PANTRY" GLOBAL-ROOM-F "CLOSET" GLOBAL-ROOM-F)
      (GLOBAL HEART-OF-GOLD SCREENING-DOOR)
      (ACTION PANTRY-F)>

<ROUTINE PANTRY-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<COND (<NOT ,LANDED>
		       <MOVE ,MARVIN ,HERE>
		       <DISABLE <INT I-MARVIN>>)>
		<COND (<FSET? ,SCREENING-DOOR ,MUNGEDBIT>
		       <TELL
"As you pass the door, it slams against you, bruising your upper arm, and then
opens again. \"Take that, door-kicker.\"" CR CR>)>
		<TELL
"Upon entering the room, you are battered by tidal waves of depression. ">
		<COND (<L? ,SCORE 300>
		       <JIGS-UP "In fact, a lethal dose.">
		       <RTRUE>)
		      (T
		       <COND (<NOT <FSET? ,PANTRY ,REVISITBIT>>
			      <FSET ,PANTRY ,REVISITBIT>
			      <SETG SCORE <+ ,SCORE 25>>)>
		       <TELL
"However, the happiness derived from your high score and that thoroughly
excellent cup of tea you had recently help you to survive." CR CR>)>)>> 

<OBJECT SCREENING-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "screening door")
	(SYNONYM DOOR)
	(ADJECTIVE SCREEN)
	(FLAGS DOORBIT NDESCBIT ACTORBIT)
	(ACTION SCREENING-DOOR-F)>

<ROUTINE SCREENING-DOOR-F ()
	 <COND (<EQUAL? ,SCREENING-DOOR ,WINNER>
		<COND (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ASK-ABOUT ,SCREENING-DOOR ,PRSI>
		       <SETG WINNER ,SCREENING-DOOR>
		       <RTRUE>)
		      (<VERB? HELLO>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?HELLO ,SCREENING-DOOR>
		       <SETG WINNER ,SCREENING-DOOR>
		       <RTRUE>)
		      (<AND <VERB? WHAT>
			    <PRSO? ,OBJECT-OF-GAME>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ASK-ABOUT ,SCREENING-DOOR ,OBJECT-OF-GAME>
		       <SETG WINNER ,SCREENING-DOOR>
		       <RTRUE>)
		      (T
		       <TELL
"\"Unless you're here to show me some clear sign of your intelligence, please
leave me alone. I'm a very busy door.\"" CR>
		       <FUCKING-CLEAR>)>)
	       (<AND <FSET? ,SCREENING-DOOR ,OPENBIT>
		     <VERB? SHOW GIVE KNOCK OPEN>>
		<TELL "You already induced the door to open." CR>)
	       (<AND <FSET? ,SCREENING-DOOR ,OPENBIT>
		     <VERB? CLOSE>>
		<TELL
"The door snaps, \"Hey! I'm resting. I've had a very busy day.\"" CR>)
	       (<VERB? KICK>
		<FSET ,SCREENING-DOOR ,MUNGEDBIT>
		<TELL
"\"I suppose you think that since you have legs and I have not, you can get
away with that sort of thing. Well,\" the door continues stiffly, \"maybe you
can and maybe you can't.\"" CR>)
	       (<VERB? SHOW GIVE>
		<COND (<AND <PRSO? ,TEA ,NO-TEA>
			    ,TEA-SHOWN
			    <HELD? ,TEA>
			    ,HOLDING-NO-TEA
			    <NOT <PRSO? ,TEA-SHOWN>>>
		       <PERFORM ,V?KNOCK ,SCREENING-DOOR>
		       <RTRUE>)
		      (T
		       <COND (<PRSO? ,TEA ,NO-TEA>
			      <SETG TEA-SHOWN ,PRSO>)>
		       <COND (<PROB 50>
			      <TELL
"The door says \"Big deal. Anyone can have">
			      <ARTICLE ,PRSO>
			      <TELL ".\"" CR>)
			     (T
			      <TELL "The door yawns." CR>)>)>)
	       (<VERB? OPEN KNOCK>
		<COND (<AND <HELD? ,TEA>
			    ,HOLDING-NO-TEA>
		       <FSET ,SCREENING-DOOR ,OPENBIT>
		       <TELL
"The door is almost speechless with admiration. \"Wow. Simultaneous tea
and no tea. My apologies. You are clearly a heavy-duty philosopher.\" It
opens respectfully." CR>)
		      (T
		       <TELL
"The door explains, in a haughty tone, that the room is occupied by a
super-intelligent robot and that lesser beings (by which it means you)
are not to be admitted. \"Show me some tiny example of your intelligence,\"
it says, \"and maybe, just maybe, I might reconsider.\"" CR>)>)
	       (<AND <VERB? ASK-ABOUT>
		     <PRSI? ,OBJECT-OF-GAME>>
		<TELL "\"To keep out sub-intelligent beings.\"" CR>)
	       (<VERB? THROUGH>
		<COND (<EQUAL? ,HERE ,PANTRY>
		       <DO-WALK ,P?EAST>)
		      (T
		       <DO-WALK ,P?WEST>)>)
	       (<VERB? EXAMINE>
		<FCLEAR ,SCREENING-DOOR ,ACTORBIT>
		<V-LOOK-INSIDE>
		<FSET ,SCREENING-DOOR ,ACTORBIT>)>>

<OBJECT MARVIN
	(IN PANTRY)
	(DESC "Marvin")
	(LDESC "Marvin, the Paranoid Android, is here.")
	(SYNONYM MARVIN MARV ROBOT ANDROI)
	(ADJECTIVE DEPRES PARANO)
	(FLAGS NARTICLEBIT ACTORBIT)
	(ACTION MARVIN-F)>

<ROUTINE MARVIN-F ()
	 <COND (<EQUAL? ,MARVIN ,WINNER>
		<COND (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ASK-ABOUT ,MARVIN ,PRSI>
		       <SETG WINNER ,MARVIN>
		       <RTRUE>)
		      (<VERB? HELLO>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?HELLO ,MARVIN>
		       <SETG WINNER ,MARVIN>
		       <RTRUE>)
		      (<AND <VERB? WHAT>
			    <PRSO? ,OBJECT-OF-GAME>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ASK-ABOUT ,MARVIN ,OBJECT-OF-GAME>
		       <SETG WINNER ,MARVIN>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,PANTRY>
		       <COND (<AND <VERB? REPAIR OPEN>
				   <PRSO? ,HATCH ,MECHANISM>>
			      <COND (<NOT ,LANDED>
				     <TELL
"\"" ,HUMANS "stupid. Are you aware,\" he asks, \"that this ship is in
space, that space is an almost perfect vacuum, and that the hatch is the
only thing holding in all the air?\"" CR>)
				    (<EQUAL? ,MARVIN-COUNTER 3>
				     <TELL
"\"After the help I got last time? " ,HUMANS "ungrateful. Go away.\""CR>)
				    (<EQUAL? ,MARVIN-COUNTER 4>
				     <TELL "\"I did.\"" CR>)
				    (<G? ,MARVIN-COUNTER 0>
				     <TELL
"\"Yes, I said I'd do it! " ,HUMANS "repetitious.\"" CR>)
				    (T
				     <SETG MARVIN-COUNTER 1>
				     <ENABLE <QUEUE I-MARVIN 12>>
				     <TELL
"\"" ,HUMANS "demanding. Do this. Pick up that. Unjam the opening mechanism
of the other. Meet me in the hatchway " D ,ACCESS-SPACE " in twelve turns. I
suppose,\" he mutters, \"you can count up to twelve. So hard to know with
morons. And don't forget to bring the proper tool.\"" CR>)>)
			     (<AND <VERB? WHAT>
				   <PRSO? ,TWEEZERS>
				   <G? ,MARVIN-COUNTER 0>>
			      <TELL
"Marvin looks scornful. \"How did you get past my door if you're so
primordially benighted that you don't even know which tool is needed
for a job like this?\"" CR>)
			     (T
			      <TELL "\"Please don't feel you have
to take any notice of me. I'm just a menial robot.\"" CR>
			      <FUCKING-CLEAR>)>) 
		      (T
		       <TELL
"\"I think you ought to know I'm feeling very depressed.\"" CR>
		       <FUCKING-CLEAR>)>)
	       (<AND <VERB? ASK-ABOUT>
		     <PRSI? ,OBJECT-OF-GAME>>
		<TELL
"\"Being clever doesn't always make you happy, you know. Look at me, brain
the size of a planet, how many points do you think I've got? Minus thirty
zillion at the last count.\"" CR>)
	       (<AND <VERB? FOLLOW>
		     <EQUAL? ,FOLLOW-FLAG 2>>
		<COND (<IN? ,MARVIN ,PANTRY>
		       <DO-WALK ,P?WEST>)
		      (T
		       <GOTO <LOC ,MARVIN>>)>)
	       (<AND <VERB? FOLLOW>
		     <EQUAL? ,FOLLOW-FLAG 7>>
		<DO-WALK ,P?WEST>)
	       (<AND <VERB? GIVE>
		     <EQUAL? ,MARVIN-COUNTER 2>>
		<COND (<PRSO? ,TOOL-REQUIRED>
		       <SETG SCORE <+ ,SCORE 25>>
		       <SETG MARVIN-COUNTER 4>
		       <SETG FOLLOW-FLAG 7>
		       <ENABLE <QUEUE I-FOLLOW 2>>
		       <DISABLE <INT I-MARVIN>>
		       <FSET ,HATCH ,OPENBIT>
		       <MOVE ,MARVIN ,PANTRY>
		       <MOVE ,TOOL-REQUIRED ,MARVIN>
		       <TELL
"Marvin fiddles inside the " D ,MECHANISM " with the " D ,TOOL-REQUIRED " for
about three-tenths of a second. You hear the hatchway slide open. \"I don't
expect you to be grateful,\" says Marvin, \"or even interested, but that was
probably more complicated than every single action you'll ever perform in your
entire life put together.\" He limps away. \"And me,\" you hear him mutter as
he goes, \"with this terrible pain in all the diodes down my left side.\"" CR>)
		      (T
		       <TELL "\"That's not">
		       <ARTICLE ,TOOL-REQUIRED>
		       <TELL ".\"" CR>)>)>>

<ROUTINE I-MARVIN ()
	 <ENABLE <QUEUE I-MARVIN -1>>
	 <COND (<EQUAL? ,MARVIN-COUNTER 2>
		<SETG MARVIN-COUNTER 3>
		<CRLF>
		<COND (<EQUAL? ,HERE ,HATCHWAY>
		       <TELL "Marvin emerges from the " D, ACCESS-SPACE ". ">)>
		<TELL "\"">
		<MARVIN-BITCH>
		<SETG MARVIN-COUNTER 3>)
	       (<IN? ,MARVIN ,ACCESS-SPACE>
		<COND (<EQUAL? ,HERE ,ACCESS-SPACE>
		       <COND (<NOT ,TOOL-REQUIRED>
			      <REPEAT ()
			       <SETG TOOL-REQUIRED <PICK-ONE ,TOOL-LIST>>
			       <COND (<NOT <HELD? ,TOOL-REQUIRED ,PROTAGONIST>>
				      <RETURN>)>>)>
		       <SETG P-IT-OBJECT ,TOOL-REQUIRED>
		       <SETG MARVIN-COUNTER 2>
		       <TELL "Marvin, looking bored, says \"Hand me">
		       <ARTICLE ,TOOL-REQUIRED>
		       <TELL ".\"" CR>)
		      (T
		       <TELL CR "Marvin wanders up to you. \"I went to the "
D ,ACCESS-SPACE " but you never showed up. ">
		       <MARVIN-BITCH>
		       <SETG MARVIN-COUNTER 3>)>)
	       (<EQUAL? ,MARVIN-COUNTER 1>
		<MOVE ,MARVIN ,ACCESS-SPACE>
		<COND (<EQUAL? ,HERE ,ACCESS-SPACE>
		       <TELL "Marvin shambles in." CR>)
		      (T
		       <RFALSE>)>)
	       (<IN? ,MARVIN ,HERE>
		<ENABLE <QUEUE I-FOLLOW 2>>
		<SETG FOLLOW-FLAG 2>
		<CRLF>
		<COND (<OR <EQUAL? ,HERE ,HATCHWAY ,GALLEY ,ENTRY-BAY>
		           <EQUAL? ,HERE ,FORE-CORRIDOR ,ENGINE-ROOM ,BRIDGE>>
		       <TELL "Marvin wanders off." CR>
		       <COND (<EQUAL? ,HERE ,FORE-CORRIDOR 
				      	    ,ENGINE-ROOM ,HATCHWAY>
		              <MOVE ,MARVIN ,AFT-CORRIDOR>)
		             (T
		              <MOVE ,MARVIN ,FORE-CORRIDOR>)>)
		      (<EQUAL? ,HERE ,AFT-CORRIDOR>
		       <MOVE ,MARVIN ,PANTRY>
		       <TELL
"Marvin enters a room to port, and the door closes behind him." CR>)
		      (T
		       <TELL "Bug #17">)>)
	       (<NOT <IN? ,MARVIN ,PANTRY>>
		<MOVE ,MARVIN ,PANTRY>
		<RFALSE>)
	       (<OR <NOT <IN-HEART? ,PROTAGONIST>>
		    <EQUAL? ,HERE ,ACCESS-SPACE>
		    <FSET? ,SCREENING-DOOR ,OPENBIT>
		    ,AWAITING-REPLY>
		<RFALSE>)
	       (<AND <EQUAL? ,HERE ,ENGINE-ROOM>
		     <L? ,LOOK-COUNTER 3>>
		<RFALSE>)
	       (<PROB 8>
		<MOVE ,MARVIN ,HERE>
		<TELL CR
"You feel a wave of depression sweep over you, and you turn to see that
Marvin the robot has stalked miserably into the room." CR>)
	       (T
		<RFALSE>)>>

<ROUTINE MARVIN-BITCH ()
	 <DISABLE <INT I-MARVIN>>
	 <MOVE ,MARVIN ,PANTRY>
	 <TELL
"Ah. I was misled into thinking that you wanted me to open the hatch,
probably by the fact that you asked me to. Obviously you changed your mind
or I misunderstood you or you are a moronic imbecile. I wonder which">
	 <COND (<NOT <EQUAL? ,HERE ,PANTRY>>
		<TELL
". I'm going back to my pantry to be alone with my grief">)>
	 <TELL ".\" Marvin stalks miserably away." CR>>

<GLOBAL MARVIN-COUNTER 0>
;"1 = Marvin's been asked to fix hatch.
  2 = Marvin's waiting for you to hand him the right tool.
  3 = Marvin's pissed because you weren't there or gave him the wrong tool.
  4 = Marvin's already opened the hatch."

<GLOBAL TOOL-REQUIRED <>>

<GLOBAL FLUFF-COUNTER 0>

<GLOBAL PLANT-BLOOMED <>>

<OBJECT FLOWERPOT
	(IN INSIDE-WHALE)
	(DESC "flowerpot")
	(SYNONYM FLOWER POT SOIL DIRT)
	(ADJECTIVE FLOWER FERTIL)
	(CAPACITY 1)
	(SIZE 15)
	(FLAGS TAKEBIT CONTBIT OPENBIT)
	(ACTION FLOWERPOT-F)>

<ROUTINE FLOWERPOT-F ()
	 <COND (<AND <VERB? WATER>
		     <PRSO? ,FLOWERPOT>
		     <IN? ,PLANT ,FLOWERPOT>>
		<PERFORM ,V?WATER ,PLANT ,PRSI>
		<RTRUE>)
	       (<VERB? EXAMINE READ LOOK-INSIDE>
		<TELL "The pot is filled with fertile soil">
		<COND (<IN? ,PLANT ,FLOWERPOT>
		       <TELL ", out of which has sprouted a ">
		       <COND (,PLANT-BLOOMED
		       	      <TELL "large, leafy plant">)
			     (T
			      <TELL "tiny plant stalk">)>)
		      (T
		       <TELL
". It is inscribed \"Inertial Guidance System -- Magrathean Missile Company.\"
It must have been created by the same burst of improbability that created
the whale itself">)>
		<TELL "." CR>)
	       (<AND <VERB? PUT>
		     <PRSO? ,POCKET-FLUFF ,JACKET-FLUFF
			    ,SATCHEL-FLUFF ,CUSHION-FLUFF>>
		<MOVE ,PRSO ,LOCAL-GLOBALS>
		<SETG FLUFF-COUNTER <+ ,FLUFF-COUNTER 1>>
		<COND (<EQUAL? ,FLUFF-COUNTER 4>
		       <ENABLE <QUEUE I-PLANT 10>>)>
		<TELL
"You dig a " D ,FISH-HOLE ", gingerly place the fluff at the bottom, and
cover it over." CR>)
	       (<AND <VERB? OPEN CLOSE>
		     <PRSO? ,FLOWERPOT>>
		<TELL-ME-HOW>)>>

<ROUTINE I-PLANT ()
	 <MOVE ,PLANT ,FLOWERPOT>
	 <COND (<VISIBLE? ,FLOWERPOT>
		<TELL CR
"You notice a tiny movement from the " D ,FLOWERPOT ". You look closely, and
see a tiny sprout poking out of the soil." CR>)
	       (T
		<RFALSE>)>>

<OBJECT PLANT
	(IN LOCAL-GLOBALS) ;"just for the purpose of MOBY-FIND"
	(DESC "plant")
	(SYNONYM PLANT SPROUT STEM STALK)
	(ADJECTIVE SMALL LARGE LEAFY)
	(FLAGS NDESCBIT INTEGRALBIT)
	(ACTION PLANT-F)>

<ROUTINE PLANT-F ()
	 <COND (<VERB? EXAMINE>
		<COND (,PLANT-BLOOMED
		       <TELL "The plant is now large and leafy.">
		       <COND (<AND <FSET? ,FRUIT ,NDESCBIT>
				   <VISIBLE? ,FRUIT>>
			      <TELL
" Hanging from it is a large, succulent fruit.">)>
		       <CRLF>)
		      (T
		       <TELL "The plant is just a tiny stem." CR>)>)
	       (<AND <VERB? TAKE DROP>
		     <PRSO? ,PLANT>>
		<COND (,PRSI
		       <PART-OF>)
		      (T
		       <PERFORM ,PRSA ,FLOWERPOT ,PRSI>
		       <RTRUE>)>)
	       (<AND <VERB? WATER>
		     <NOT ,PLANT-BLOOMED>
		     <PRSI? ,MINERAL-WATER ,SUBSTITUTE ,TEA>>
		<MOVE ,PRSI ,LOCAL-GLOBALS>
		<MOVE ,PLANT ,LOCAL-GLOBALS>
		<TELL "After several seconds, the plant shrivels up.">
		<ANTI-LITTER "cup">
		<CRLF>)>>

<OBJECT FRUIT
	(IN LOCAL-GLOBALS) ;"just for the purpose of MOBY-FIND"
	(DESC "fruit")
	(SYNONYM FRUIT)
	(ADJECTIVE LARGE SUCCUL)
	(FLAGS NDESCBIT TRYTAKEBIT TAKEBIT EATBIT)
	(ACTION FRUIT-F)>

<ROUTINE FRUIT-F ("AUX" X)
	 <COND (<AND <VERB? TAKE PICK>
		     <FSET? ,FRUIT ,TRYTAKEBIT>>
		<FCLEAR ,FRUIT ,TRYTAKEBIT>
		<FCLEAR ,FRUIT ,NDESCBIT>
		<MOVE ,FRUIT ,PROTAGONIST>
		<TELL "Done." CR>)
	       (<AND <VERB? DROP THROW>
		     <FSET? ,FRUIT ,TRYTAKEBIT>>
		<FCLEAR ,FRUIT ,TRYTAKEBIT>
		<FCLEAR ,FRUIT ,NDESCBIT>
		<MOVE ,FRUIT ,HERE>
		<COND (<VERB? DROP>
		       <TELL "Dropped." CR>)
		      (T
		       <TELL "Thrown." CR>)>)
	       (<VERB? EAT>
		<REPEAT ()
			<SETG TOOL-REQUIRED <PICK-ONE ,TOOL-LIST>>
			<SET X <+ .X 1>>
			<COND (<OR <NOT <IN-HEART? ,TOOL-REQUIRED>>
				   <G? .X 50>>
			       <RETURN>)>>
		<MOVE ,FRUIT ,LOCAL-GLOBALS>
		<TELL
"The fruit has a zesty taste, and you devour it greedily. Suddenly, your vision
wavers, and you see yourself, as though from a distance, standing near Marvin,
who asks you for">
		<ARTICLE ,TOOL-REQUIRED>
		<TELL
". Then, the image vanishes like a movie when the film breaks, and you find
yourself still in">
		<ARTICLE ,HERE T>
		<TELL ".|
|
It seems that this plant is a rare horticultural phenomenon long thought to
be extinct: The Tree of Foreknowledge." CR>)>>

<ROOM GALLEY
      (IN ROOMS)
      (SYNONYM CORPOR SCC)
      (ADJECTIVE SIRIUS CYBERN)
      (DESC "Galley")
      (EAST TO FORE-CORRIDOR)
      (OUT TO FORE-CORRIDOR)
      (FLAGS RLANDBIT ONBIT)
      (PSEUDO "GALLEY" GLOBAL-ROOM-F)
      (GLOBAL HEART-OF-GOLD)
      (ACTION GALLEY-F)>

<ROUTINE GALLEY-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in the Galley area of the ship, containing a machine which is the
state of the art in Nutritional Technology, a " ,SCC " " D ,NUTRIMAT ". There
is an exit to starboard." CR>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <NOT <RUNNING? ,I-TEA>>
		     <PROB 3>>
		<SETG FOLLOW-FLAG 6>
		<ENABLE <QUEUE I-FOLLOW 2>>
		<TELL CR
D ,ZAPHOD " walks in and presses the " D ,PAD ". The " D ,NUTRIMAT
" produces a huge, ice-cold Pan-Galactic Gargle Blaster. Zaphod heads off
toward the sauna, sipping loudly." CR>)>>

<OBJECT NUTRIMAT
	(IN GALLEY)
	(DESC "Nutrimat")
	(SYNONYM NUTRIM MACHIN PANEL)
	(ADJECTIVE SERVIC)
	(FLAGS NDESCBIT ACTORBIT CONTBIT LIGHTBIT SEARCHBIT)
	(ACTION NUTRIMAT-F)>

<ROUTINE NUTRIMAT-F ()
	 <COND (<EQUAL? ,NUTRIMAT ,WINNER>
		<COND (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ASK-ABOUT ,NUTRIMAT ,PRSI>
		       <SETG WINNER ,NUTRIMAT>
		       <RTRUE>)
		      (<VERB? HELLO>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?HELLO ,NUTRIMAT>
		       <SETG WINNER ,NUTRIMAT>
		       <RTRUE>)
		      (<AND <VERB? WHAT>
			    <PRSO? ,OBJECT-OF-GAME>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ASK-ABOUT ,NUTRIMAT ,OBJECT-OF-GAME>
		       <SETG WINNER ,NUTRIMAT>
		       <RTRUE>)
		      (<OR <AND <VERB? SGIVE>
				<PRSO? ,ME>>
			   <AND <VERB? GIVE>
				<PRSI? ,ME>>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ASK-FOR ,NUTRIMAT ,PRSI>
		       <SETG WINNER ,NUTRIMAT>
		       <RTRUE>)
		      (<AND <VERB? MAKE>
			    <PRSO? ,TEA ,NO-TEA>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?RUB ,PAD>
		       <SETG WINNER ,NUTRIMAT>
		       <RTRUE>)
		      (T
		       <TELL "The " D ,NUTRIMAT " ignores you." CR>
		       <FUCKING-CLEAR>)>)
	       (<VERB? EXAMINE>
		<TELL
"The " D ,NUTRIMAT " has a " D ,PAD ", a dispensing slot, and a
service panel which is ">
		<COND (<FSET? ,NUTRIMAT ,OPENBIT>
		       <TELL "open">)
		      (T
		       <TELL "closed">)>
		<TELL ".">
		<FINE-PRODUCT>
		<COND (<RUNNING? ,I-TEA>
		       <TELL " ">
		       <PERFORM ,V?LISTEN ,NUTRIMAT>
		       <RTRUE>)
		      (T
		       <CRLF>)>)
	       (<AND <VERB? LISTEN>
		     <RUNNING? ,I-TEA>>
		<TELL
"The " D ,NUTRIMAT " is making a faint whirring noise." CR>)
	       (<AND <VERB? ASK-FOR>
		     <PRSI? ,TEA ,SUBSTITUTE>>
		<PERFORM ,V?RUB ,PAD>
		<RTRUE>)
	       (<VERB? LAMP-ON>
		<PERFORM ,V?RUB ,PAD>
		<RTRUE>)
	       (<AND <VERB? LAMP-OFF>
		     <RUNNING? ,I-TEA>>
		<PERFORM ,V?RUB ,PAD>
		<RTRUE>)
	       (<AND <VERB? KILL KICK SHAKE>
		     ,SUBSTITUTE-DRUNK>
		<TELL "The " D ,NUTRIMAT " says ">
		<COND (<PROB 50>
		       <TELL "\"Share and Enjoy.\"" CR>)
		      (T
		       <TELL
"\"If you have enjoyed the experience of this drink, why not share it with
your friends?\"" CR>)>)
	       (<AND <VERB? PUT PLUG>
		     <PRSI? ,NUTRIMAT>>
		<COND (<NOT <FSET? ,NUTRIMAT ,OPENBIT>>
		       <TELL "The panel is closed." CR>)
		      (<FIRST? ,NUTRIMAT>
		       <TELL "There's no room." CR>)
		      (<PRSO? ,BOARD ,NUT-COM-INTERFACE>
		       <MOVE ,PRSO ,NUTRIMAT>
		       <TELL "Done." CR>)
		      (T
		       <V-PLUG>)>)
	       (<VERB? LOOK-INSIDE>
		<COND (<NOT <FSET? ,NUTRIMAT ,OPENBIT>>
		       <PERFORM ,V?OPEN ,NUTRIMAT>
		       <RTRUE>)
		      (<IN? ,BOARD ,NUTRIMAT>
		       <TELL "There is a " D ,BOARD " there." CR>)
		      (<IN? ,NUT-COM-INTERFACE ,NUTRIMAT>
		       <TELL "There is a " D ,NUT-COM-INTERFACE " there." CR>)
		      (T
		       <TELL "There's nothing in the " D ,NUTRIMAT "." CR>)>)
	       (<AND <VERB? ASK-ABOUT>
		     <PRSI? ,OBJECT-OF-GAME>>
		<TELL
"\"To provide a nutritious and flavour-enhanced diet.\"" CR>)>>

<OBJECT PAD
	(IN GALLEY)
	(DESC "touch-sensitive pad")
	(SYNONYM PAD)
	(ADJECTIVE TOUCH SENSIT)
	(FLAGS NDESCBIT)
	(ACTION PAD-F)>

<ROUTINE PAD-F ()
	 <COND (<VERB? RUB PUSH>
		<COND (<IN? ,NUT-COM-INTERFACE ,NUTRIMAT>
		       <COND (<RUNNING? ,I-TEA>
			      <TELL
"\"Please wait..." D ,NUTRIMAT " engaged.\"" CR>)
			     (<IN? ,TEA ,PAD>
			      <ENABLE <QUEUE I-TEA -1>>
			      <TELL
"The " D ,NUTRIMAT " is puzzled that you want something made by pouring
boiling water on dead leaves and squirting stuff from a cow in it, and
says that it will need some help from " D ,EDDIE "." CR>)
			     (T
			      <TELL
"\"I won't go through that again. If " D ,SUBSTITUTE " isn't good
enough, too bad.\"" CR>)>)
		      (<IN? ,SUBSTITUTE ,PAD>
		       <MOVE ,SUBSTITUTE ,SLOT>
		       <SETG P-IT-OBJECT ,SUBSTITUTE>
		       <TELL
"The " D ,NUTRIMAT " makes an instant but highly detailed examination of
your taste buds, a spectroscopic analysis of your metabolism and
sends tiny experimental signals down your neural pathways to see
what you like.|
A cupful of " D ,SUBSTITUTE " appears in the dispensing slot." CR>)
		      (T
		       <TELL
"\"You still haven't drunk the nutritious and flavour-enhanced cupful of "
D ,SUBSTITUTE " I already gave you,\" scolds the " D ,NUTRIMAT "." CR>)>)>>

<OBJECT SLOT
	(IN GALLEY)
	(DESC "slot")
	(SYNONYM SLOT)
	(ADJECTIVE DISPEN)
	(FLAGS NDESCBIT CONTBIT OPENBIT SEARCHBIT)
	(CAPACITY 20)
	(ACTION SLOT-F)>

<ROUTINE SLOT-F ()
	 <COND (<AND <VERB? OPEN CLOSE>
		     <PRSO? ,SLOT>>
		<TELL-ME-HOW>)>>

<OBJECT BOARD
	(IN NUTRIMAT)
	(DESC "circuit board")
	(SYNONYM BOARD MESSAG LETTER MICROC)
	(ADJECTIVE CIRCUI MICROS PRINTE)
	(FLAGS TAKEBIT CONTBIT TRANSBIT)
	(ACTION BOARD-F)>

<ROUTINE BOARD-F ()
	 <COND (<AND <VERB? OPEN CLOSE>
		     <PRSO? ,BOARD>>
		<TELL-ME-HOW>)
	       (<VERB? EXAMINE>
		<TELL
"The " D ,PRSO " is square, about ten inches on each side. It has a number
of microchips, some printed circuitry, and a message printed in microscopic
letters. There are also eight " D ,DIPSWITCH "es, marked:|
  1  Cholesterol Register|
  2  MSG Specifier|
  3  Thiamin Stack|
  4  Piquant-O-Mat|
  5  Flavour Dump|
  6  Vitamin Interrupts|
  7  Nose Sequencer|
  8  Bouquet Arbitration Bus" CR>)
	       (<VERB? MUNG>
		<MOVE ,BOARD ,LOCAL-GLOBALS>
		<TELL
"It's all the device deserves. It shatters with a satisfying crunch." CR>)
	       (<AND <VERB? READ EXAMINE-THROUGH>
		     <PRSI? ,MAGNIFYING-GLASS>>
		<TELL
"The message reads \"This is just a satirical device. It has no
practical function.\"" CR>)
	       (<VERB? READ>
		<TELL "The message is too small for you to read." CR>)>>

<OBJECT DIPSWITCH
	(IN BOARD)
	(DESC "dipswitch")
	(SYNONYM SWITCH DIPSWI)
	(ADJECTIVE FIRST SECOND THIRD FOURTH FIFTH SIXTH SEVENT EIGHTH)
	(FLAGS NDESCBIT SWITCHBIT)
	(ACTION DIPSWITCH-F)>

<ROUTINE DIPSWITCH-F ()
	 <COND (<VERB? TURN THROW LAMP-ON LAMP-OFF PUSH MOVE>
		<TELL "Switched.">
		<COND (<IN? ,BOARD ,NUTRIMAT>
		       <TELL
" Some lights on the " D ,NUTRIMAT " flash briefly. A promising hum
quickly dies away." CR>)
		      (T
		       <CRLF>
		       <RTRUE>)>)>>

;<OBJECT DIPSWITCH-8
	(IN BOARD)
	(DESC "eighth dipswitch")
	(SYNONYM SWITCH DIPSWI)
	(ADJECTIVE EIGHTH DIP)
	(FLAGS NDESCBIT SWITCHBIT)
	(ACTION DIPSWITCH-F)>

;<OBJECT DIPSWITCH-7
	(IN BOARD)
	(DESC "seventh dipswitch")
	(SYNONYM SWITCH DIPSWI)
	(ADJECTIVE SEVENTH DIP)
	(FLAGS NDESCBIT SWITCHBIT)
	(ACTION DIPSWITCH-F)>

;<OBJECT DIPSWITCH-6
	(IN BOARD)
	(DESC "sixth dipswitch")
	(SYNONYM SWITCH DIPSWI)
	(ADJECTIVE SIXTH DIP)
	(FLAGS NDESCBIT SWITCHBIT)
	(ACTION DIPSWITCH-F)>

;<OBJECT DIPSWITCH-5
	(IN BOARD)
	(DESC "fifth dipswitch")
	(SYNONYM SWITCH DIPSWI)
	(ADJECTIVE FIFTH DIP)
	(FLAGS NDESCBIT SWITCHBIT)
	(ACTION DIPSWITCH-F)>

;<OBJECT DIPSWITCH-4
	(IN BOARD)
	(DESC "fourth dipswitch")
	(SYNONYM SWITCH DIPSWI)
	(ADJECTIVE FOURTH DIP)
	(FLAGS NDESCBIT SWITCHBIT)
	(ACTION DIPSWITCH-F)>

;<OBJECT DIPSWITCH-3
	(IN BOARD)
	(DESC "third dipswitch")
	(SYNONYM SWITCH DIPSWI)
	(ADJECTIVE THIRD DIP)
	(FLAGS NDESCBIT SWITCHBIT)
	(ACTION DIPSWITCH-F)>

;<OBJECT DIPSWITCH-2
	(IN BOARD)
	(DESC "second dipswitch")
	(SYNONYM SWITCH DIPSWI)
	(ADJECTIVE SECOND DIP)
	(FLAGS NDESCBIT SWITCHBIT)
	(ACTION DIPSWITCH-F)>

<OBJECT SUBSTITUTE
	(IN PAD)
	(DESC "Advanced Tea Substitute")
	(DESCFCN SUBSTITUTE-DESCFCN)
	(SYNONYM CUP CUPFUL SUBSTI ATS)
	(ADJECTIVE TEA ADVANC NICE HOT)
	(FLAGS NARTICLEBIT VOWELBIT TAKEBIT DRINKBIT)
	(ACTION SUBSTITUTE-F)>

<ROUTINE SUBSTITUTE-DESCFCN ("OPTIONAL" X)
	 <DESCRIBE-DRINK ,SUBSTITUTE>>

<ROUTINE SUBSTITUTE-F ()
	 <COND (<VERB? DRINK ENJOY DRINK-FROM>
		<COND (<NOT <HELD? ,SUBSTITUTE>>
		       <TELL ,NOT-HOLDING " the cup!" CR>
		       <RTRUE>)
		      (<G? ,SCORE 300>
		       <TELL
"You'd rather continue savouring that delicious tea." CR>
		       <RTRUE>)
		      (,SUBSTITUTE-DRUNK
		       <SETG SCORE <- ,SCORE 30>>
		       <SETG DREAMING <>>
		       <TELL "That last gulp of the vile " D ,SUBSTITUTE>
		       <JIGS-UP
" was a bit too much for you. You expire from sheer misery and unhappiness.">
		       <RTRUE>)>
		<COND (<EQUAL? ,SUBSTITUTE ,BROWNIAN-SOURCE>
		       <SETG BROWNIAN-SOURCE <>>)>
		<SETG SUBSTITUTE-DRUNK T>
		<SETG SCORE <- ,SCORE 30>>
		<MOVE ,SUBSTITUTE ,PAD>
		<TELL
"It tastes almost, but not quite, entirely unlike tea. It's absolutely
disgusting.">
		<ANTI-LITTER "cup">
		<COND (<EQUAL? ,HERE ,GALLEY>
		       <TELL " ">
		       <PERFORM ,V?KILL ,NUTRIMAT>
		       <RTRUE>)>
		<CRLF>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"About the only characteristic it shares with tea is that of" ,BROWNIAN ".">
		<COND (<PRSO? ,BROWNIAN-SOURCE>
		       <TELL " ">
		       <PERFORM ,V?EXAMINE ,DANGLY-BIT>
		       <RTRUE>)
		      (T
		       <CRLF>)>)
	       (<VERB? POUR THROW>
		<LIQUID-SPILL>)>>

<OBJECT INTERFACE-BOX
	(IN GALLEY)
	(DESC "shipping carton")
	(LDESC
"A carton labelled \"Nutrimat/Computer Interface\" is sitting here.")
	(SYNONYM CARTON BOX)
	(ADJECTIVE SHIPPI)
	(FLAGS CONTBIT TAKEBIT SEARCHBIT READBIT)
	(SIZE 15)
	(CAPACITY 14)
	(ACTION INTERFACE-BOX-F)>

<ROUTINE INTERFACE-BOX-F ()
	 <COND (<VERB? READ EXAMINE>
		<TELL
"The carton is labelled \"" D ,NUT-COM-INTERFACE ".\"" CR>
		<COND (<VERB? EXAMINE>
		       <RFALSE>)
		      (T
		       <RTRUE>)>)>> 

<OBJECT BEAST-GUN
	(IN INTERFACE-BOX)
	(DESC "strange gun")
	(SYNONYM GUN WEAPON)
	(ADJECTIVE STRANGE RAY ANTI- BEAST)
	(FLAGS TAKEBIT)
	(SIZE 4)
	(ACTION BEAST-GUN-F)>

<ROUTINE BEAST-GUN-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"The gun has a large label which reads \"Anti-Bugblatter Beast Ray Gun.\"">
		<FINE-PRODUCT>
		<CRLF>)>>

<GLOBAL GUN-COUNTER 0>

<GLOBAL TEA-COUNTER 0>

<GLOBAL LANDED <>>

<ROUTINE I-TEA ()
	 <SETG TEA-COUNTER <+ ,TEA-COUNTER 1>>
	 <COND (<AND <NOT <EQUAL? ,HERE ,GALLEY>>
		     <L? ,TEA-COUNTER 7>>
		<RFALSE>)>
	 <CRLF>
	 <COND (<EQUAL? ,TEA-COUNTER 1>
		<TELL "The nutrimat begins to whirr." CR>)
	       (<EQUAL? ,TEA-COUNTER 2>
		<TELL
"A red sign lights up saying:|
   MEMORY OVERLOAD" CR>)
	       (<EQUAL? ,TEA-COUNTER 3>
		<TELL
"Another red sign lights up saying:|
   RESERVE MEMORY OVERLOAD" CR>)
	       (<EQUAL? ,TEA-COUNTER 4>
		<TELL
"A third sign lights up:|
   PROCESSOR OVERLOAD,|
   SWITCH TO TERMINAL MODE" CR>)
	       (<EQUAL? ,TEA-COUNTER 5>
		<TELL
"A blue sign lights up:|
   NUTRIMAT GOING ON LINE" CR>)
	       (<EQUAL? ,TEA-COUNTER 6>
		<TELL
"More and more signs light up:|
   SHIPBOARD COMPUTER ACCESSED|
   MAIN MEMORY OVERLOAD|
   RESERVE MEMORY ACCESSED|
   PARALLEL PROCESSORS ON LINE|
|
   ****************************|
   ** NUMBERS BEING CRUNCHED **|
   ****************************" CR>)
	       (<EQUAL? ,TEA-COUNTER 7>
		<FSET ,THUMB ,MUNGEDBIT>
		<TELL ,ANNOUNCEMENT D ,EDDIE
". Emergency situation! Nuclear missiles have just been launched at us from the
approaching planet, which my data banks indicate is" ,LOST-PLANET ". I cannot
perform evasive maneuvers because" ,ENGAGED D ,NUTRIMAT ". The missiles will
turn this ship into a huge atomic fireball in approximately eight turns. By
the way, somebody didn't finish their spinach at dinner.\"" CR>)
	       (<L? ,TEA-COUNTER 15>
		<TELL
"You hear distant sounds of panic: shouts of anger, cries of alarm,
pounding feet." CR>)
	       (T
		<DISABLE <INT I-TEA>>
		<TELL "It seems that the missiles struck " D ,HEART-OF-GOLD>
		<JIGS-UP
" about three nanoseconds ago. Sure enough, here comes that huge atomic fireb">
		<RTRUE>)>>

<ROUTINE I-LANDING ()
	 <COND (<NOT <IN-HEART? ,PROTAGONIST>>
		<ENABLE <QUEUE I-LANDING 12>>
		<RFALSE>)
	       (T
		<MOVE ,MARVIN ,PANTRY>
		<DISABLE <INT I-MARVIN>>
		<SETG LANDED T>
		<TELL CR ,ANNOUNCEMENT D ,EDDIE
". We have just landed on" ,LOST-PLANET ". I don't want anyone going outside
until I've checked the atmosphere, climatic conditions, existence of dangerous
wildlife, airborne diseases, volcanic activity, presence of real estate agents,
and more than eight thousand other possible dangers. This routine check will
take 14.9 years. And don't even think about leaving until I finish, because
I'm jamming the hatch.\"" CR>)>>

<ROOM BRIDGE
      (IN ROOMS)
      (SYNONYM MOVEME MOTION RANDOM)
      (ADJECTIVE BROWNI)
      (DESC "Bridge")
      (DOWN TO FORE-CORRIDOR)
      (WEST PER SAUNA-ENTER-F)
      (FLAGS ONBIT RLANDBIT)
      (GLOBAL STAIRS CONTROLS HEART-OF-GOLD)
      (PSEUDO "SAUNA" SAUNA-PSEUDO "PEOPLE" PEOPLE-PSEUDO)
      (ACTION BRIDGE-F)>

<ROUTINE SAUNA-ENTER-F ()
	 <UNPLUG-HELD-STUFF>
	 <SETG MOVES <+ ,MOVES <+ 10 <RANDOM 12>>>>
	 <TELL "You enter the sauna. After several ">
	 <COND (<RUNNING? ,I-FORD>
		<TELL "minutes">)
	       (T
		<TELL "hours">)>
	 <TELL ", you come out a changed man.">
	 <COND (<AND <HELD? ,FLOWERPOT>
		     <IN? ,PLANT ,FLOWERPOT>
		     <NOT ,PLANT-BLOOMED>>
		<SETG PLANT-BLOOMED T>
		<SETG SCORE <+ ,SCORE 25>>
		<MOVE ,FRUIT ,FLOWERPOT>
		<TELL " You have with you a changed plant.">)>
	 <CRLF>
	 <COND (<IN? ,MARVIN ,BRIDGE>
		<MOVE ,MARVIN ,PANTRY>)>
	 <RFALSE>>

<ROUTINE BRIDGE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is the bridge of " D ,HEART-OF-GOLD ". A gangway leads down, and steam
comes from an entrance to port. Next to the control console is " D ,EDDIE ".">
		<COND (,DRIVE-TO-CONTROLS
		       <TELL " ">
		       <PERFORM ,V?EXAMINE ,LARGE-RECEPTACLE>)
		      (T
		       <CRLF>)>
		<COND (<NOT <FSET? ,BRIDGE ,NDESCBIT>>
		       <FSET ,BRIDGE ,NDESCBIT>
		       <TELL CR
"At the controls, apparently expecting you and Ford, are a man with more than
the usual number of heads (the name \"Zaphod\" is stitched on his shirt) and a
dark-haired woman, holding a handbag. Both seem somehow familiar." CR>)>)>>

<ROUTINE SAUNA-PSEUDO ()
	 <COND (<AND <VERB? THROUGH WALK-TO BOARD>
		     <EQUAL? ,HERE ,BRIDGE>>
		<DO-WALK ,P?WEST>)>>

<ROUTINE PEOPLE-PSEUDO ()
	 <COND (<NOT <IN? ,ZAPHOD ,HERE>>
		<TELL "What people?" CR>)
	       (<VERB? EXAMINE>
		<PERFORM ,V?EXAMINE ,ZAPHOD>
		<PERFORM ,V?EXAMINE ,TRILLIAN>
		<RTRUE>)>>

<OBJECT EDDIE
	(IN BRIDGE)
	(DESC "Eddie (the shipboard computer)")
	(SYNONYM EDDIE ED COMPUT)
	(ADJECTIVE SHIP\'S SHIPBO)
	(FLAGS VOWELBIT NARTICLEBIT NDESCBIT ACTORBIT LIGHTBIT ONBIT)
	(ACTION EDDIE-F)>

<ROUTINE EDDIE-F ()
	 <COND (<EQUAL? ,EDDIE ,WINNER>
		<COND (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ASK-ABOUT ,EDDIE ,PRSI>
		       <SETG WINNER ,EDDIE>
		       <RTRUE>)
		      (<VERB? HELLO>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?HELLO ,EDDIE>
		       <SETG WINNER ,EDDIE>
		       <RTRUE>)
		      (<AND <VERB? WHAT>
			    <PRSO? ,OBJECT-OF-GAME>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ASK-ABOUT ,EDDIE ,OBJECT-OF-GAME>
		       <SETG WINNER ,EDDIE>
		       <RTRUE>)
		      (<AND <VERB? LAMP-ON>
			    <PRSO? ,MAIN-DRIVE ,SPARE-DRIVE>>
		       <COND (<RUNNING? ,I-TEA>
			      <TELL
"\"Sorry," ,ENGAGED D ,NUTRIMAT ". I can't do everything, you know.\"" CR>)
			     (T
			      <TELL "\"Sorry, current course for"
,LOST-PLANET " can be countermanded only by " D ,ZAPHOD ".\"" CR>)>)
		      (<AND <VERB? REPAIR OPEN>
			    <PRSO? ,HATCH>
			    ,LANDED>
		       <TELL
"\"Not until I completely check out the safety of this planet. Please
wait approximately fourteen years. In the meantime, have you brushed
your teeth lately?\"" CR>)
		      (<AND <VERB? YES>
			    <EQUAL? ,AWAITING-REPLY 18>>
		       <V-YES>)
		      (<AND <VERB? NO>
			    <EQUAL? ,AWAITING-REPLY 18>>
		       <V-NO>) 
		      (T
		       <SETG AWAITING-REPLY 18>
		       <ENABLE <QUEUE I-REPLY 2>>
		       <TELL
"Eddie sighs deeply. \"I can't talk right now. Do you know how difficult it is
to pilot a ship as complicated as this one?\"" CR>
		       <FUCKING-CLEAR>)>)
	       (<VERB? LAMP-OFF>
		<TELL "You don't know how (fortunately)." CR>)
	       (<AND <VERB? ASK-ABOUT>
		     <PRSI? ,OBJECT-OF-GAME>>
		<SETG AWAITING-REPLY 19>
		<ENABLE <QUEUE I-REPLY 2>>
		<TELL
"\"To pilot " D ,HEART-OF-GOLD ", process data requests from the " D ,NUTRIMAT
" and keep the crew healthy. Read your manual! How do you expect to get
anywhere in life? But don't read unless there's enough light.\"" CR>)>>

<OBJECT LARGE-RECEPTACLE
	(IN BRIDGE)
	(DESC "large receptacle")
	(SYNONYM RECEPT)
	(ADJECTIVE LARGE MANUAL OVERRI)
	(FLAGS NDESCBIT)
	(ACTION LARGE-RECEPTACLE-F)>

<ROUTINE LARGE-RECEPTACLE-F ()
	 <COND (<AND ,DRIVE-TO-CONTROLS
		     <VERB? EXAMINE>>
		<TELL
"A " D ,SPARE-DRIVE " is plugged into the large receptacle." CR>)>>

<OBJECT PHIL
	(IN LOCAL-GLOBALS) ;"just for the purpose of MOBY-FIND"
	(DESC "Phil")
	(LDESC "Phil is here.")
	(SYNONYM PHIL)
	(FLAGS NARTICLEBIT ACTORBIT)
	(ACTION ZAPHOD-F)>

<OBJECT ZAPHOD
	(IN BRIDGE)
	(DESC "Zaphod Beeblebrox")
	(SYNONYM BEEBLE ZAPHOD PRESID)
	(ADJECTIVE ZAPHOD PRESID)
	(FLAGS NARTICLEBIT ACTORBIT NDESCBIT)
	(ACTION ZAPHOD-F)>

<ROUTINE ZAPHOD-F ()
	 <COND (<EQUAL? ,IDENTITY-FLAG ,ZAPHOD>
		<COND (<PRSO? ,ZAPHOD ,PHIL>
		       <PERFORM ,PRSA ,ME ,PRSI>
		       <RTRUE>)
		      (T
		       <PERFORM ,PRSA ,PRSO ,ME>
		       <RTRUE>)>)
	       (<EQUAL? ,WINNER ,ZAPHOD>
		<COND (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ASK-ABOUT ,ZAPHOD ,PRSI>
		       <SETG WINNER ,ZAPHOD>
		       <RTRUE>)
		      (<VERB? HELLO>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?HELLO ,ZAPHOD>
		       <SETG WINNER ,ZAPHOD>
		       <RTRUE>)
		      (<AND <VERB? WHAT>
			    <PRSO? ,OBJECT-OF-GAME>>
		       <TELL ,ASK-ABOUT-OBJECT CR>)
		      (T
		       <TELL "\"Shut up, Earthman.\"" CR>
		       <FUCKING-CLEAR>)>)
	       (<EQUAL? ,IDENTITY-FLAG ,TRILLIAN>
		<COND (<AND <PRSI? ,PHIL>
			    <VERB? SHOW GIVE>>
		       <PERFORM ,V?HELLO ,PHIL>
		       <RTRUE>)
		      (<AND <VERB? SGIVE HELLO TELL ASK-ABOUT ASK-FOR>
			    <PRSO? ,PHIL>>
		       <COND (<NOT <IN? ,PHIL ,HERE>>
			      ;"fixes GIVE ALL TO PHIL case"
			      <TELL "Phil's not here anymore!" CR>
			      <RTRUE>)>
		       <COND (<NOT <FSET? ,JACKET-FLUFF ,TRYTAKEBIT>>
			      <ENABLE <QUEUE I-ZAPHOD 3>>)>
		       <TELL
"Phil must not have noticed you, because he just moved into the ">
		       <COND (<EQUAL? ,HERE ,LIVING-ROOM>
			      <MOVE ,PHIL ,DINING-ROOM>
			      <MOVE ,CAGE ,DINING-ROOM>
			      <TELL D ,DINING-ROOM>)
			     (<EQUAL? ,HERE ,DINING-ROOM>
			      <MOVE ,PHIL ,KITCHEN>
			      <MOVE ,CAGE ,KITCHEN>
			      <TELL D ,KITCHEN>)
			     (T
			      <MOVE ,PHIL ,LIVING-ROOM>
			      <MOVE ,CAGE ,LIVING-ROOM>
			      <TELL D ,LIVING-ROOM>)>
		       <TELL "." CR>
		       <FUCKING-CLEAR>)
		      (<VERB? EXAMINE>
		       <TELL
"He is very attractive, if a little weird, and has a slight other-worldly
look. You suspect he's a party-crasher, an impression reinforced by his
inappropriate garb; he seems clothed for a fancy dress party or something,
because he has what appears to be a large birdcage on his shoulder with a
black drape over it. The bird inside must be asleep, because you can hear
snoring coming from inside it." CR>)
		      (<VERB? PICK-UP>
		       <TELL "You're not that kind of girl." CR>)>)
	       (<VERB? EXAMINE>
		<TELL "Zaphod has two heads." CR>)
	       (<VERB? FOLLOW>
		<COND (<EQUAL? ,FOLLOW-FLAG 3>
		       <DO-WALK ,P?WEST>)
		      (<EQUAL? ,FOLLOW-FLAG 6>
		       <DO-WALK ,P?EAST>)>)
	       (<AND <VERB? ASK-ABOUT>
		     <PRSI? ,OBJECT-OF-GAME>>
		<TELL ,ASK-ABOUT-OBJECT CR>)>>

<ROUTINE I-ZAPHOD ()
	 <COND (,ITEM-DROPPED-AT-PARTY
		<ENABLE <QUEUE I-ZAPHOD 3>>
		<COND (<RUNNING? ,I-HOSTESS>
		       <MOVE ,PHIL ,HERE>
		       <MOVE ,CAGE ,HERE>
		       <TELL CR
"Out of the corner of your eye, you see Phil leering at you. He starts
to approach, but then notices the hostess with you and veers away." CR>)>)
	       (T
		<SETG SCORE <+ ,SCORE 25>>
		<FSET ,LIVING-ROOM ,REVISITBIT>
		<FSET ,HOSTESS ,NDESCBIT>
		<CRLF>
		<JIGS-UP
"Phil comes up and grips your shoulder. \"Hey babe, this guy boring you? Why
not come with me instead? I'm from a different planet.\" He takes you out to
the parking lot, where his flashy inter-orbital ion scooter is parked between
two Volkswagens. After mounting it, the scooter accelerates at such a great
speed that you black out almost immediately.">
		<RTRUE>)>>

<OBJECT TRILLIAN
	(IN BRIDGE)
	(DESC "Trillian")
	(SYNONYM TRILLI MCMILL WOMAN TRICIA)
	(ADJECTIVE TRICIA DARK- DARK HAIRED)
	(FLAGS NARTICLEBIT ACTORBIT NDESCBIT CONTBIT OPENBIT)
	(ACTION TRILLIAN-F)>

<ROUTINE TRILLIAN-F ()
	 <COND (<EQUAL? ,IDENTITY-FLAG ,TRILLIAN>
		<COND (<EQUAL? ,TRILLIAN ,PRSO>
		       <PERFORM ,PRSA ,ME ,PRSI>
		       <RTRUE>)
		      (T
		       <PERFORM ,PRSA ,PRSO ,ME>
		       <RTRUE>)>)
	       (<EQUAL? ,TRILLIAN ,WINNER>
		<COND (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ASK-ABOUT ,TRILLIAN ,PRSI>
		       <SETG WINNER ,TRILLIAN>
		       <RTRUE>)
		      (<VERB? HELLO>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?HELLO ,TRILLIAN>
		       <SETG WINNER ,TRILLIAN>
		       <RTRUE>)
		      (<AND <VERB? WHAT>
			    <PRSO? ,OBJECT-OF-GAME>>
		       <TELL ,ASK-ABOUT-OBJECT CR>)
		      (<OR <AND <VERB? SHOOT>
				<IN? ,BLASTER ,TRILLIAN>
				<PRSO? ,RIFLES>>
			   <AND <VERB? SSHOOT>
				<IN? ,BLASTER ,TRILLIAN>
				<PRSI? ,RIFLES>>>
		       <MOVE ,BLASTER ,PROTAGONIST>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?SHOOT ,RIFLES ,BLASTER>
		       <SETG WINNER ,TRILLIAN>
		       <MOVE ,BLASTER ,TRILLIAN>
		       <RTRUE>)
		      (<EQUAL? ,IDENTITY-FLAG ,ZAPHOD>
		       <TELL "\"Shut up, you jerk!\" hisses " D ,TRILLIAN
". \"Just get on with the plan.\"" CR>
		       <FUCKING-CLEAR>)
		      (T
		       <TELL
D ,TRILLIAN " smiles disinterestedly at you and looks away." CR>
		       <FUCKING-CLEAR>)>)
	       (<AND <VERB? SHOOT>
		     <PRSI? ,BLASTER>>
		<TELL
"How heartless! Fortunately, justice prevails as the guards">
		<GUARD-DEATH>
		<RTRUE>) 
	       (<AND <VERB? ASK-ABOUT>
		     <PRSI? ,OBJECT-OF-GAME>>
		<TELL ,ASK-ABOUT-OBJECT CR>)
	       (<AND <EQUAL? ,FOLLOW-FLAG 3>
		     <VERB? FOLLOW>>
		<DO-WALK ,P?WEST>)
	       (<AND <VERB? EXAMINE>
		     <IN? ,BLASTER ,TRILLIAN>>
		<TELL "She's holding a blaster at your head." CR>)>>

<OBJECT HANDBAG
	(IN TRILLIAN)
	(DESC "handbag")
	(SYNONYM HANDBA BAG PURSE)
	(FLAGS CONTBIT TAKEBIT TRYTAKEBIT SEARCHBIT NDESCBIT)
	(SIZE 15)
	(CAPACITY 10)
	(ACTION HANDBAG-F)>

<ROUTINE HANDBAG-F ()
	 <COND (<AND <VERB? DROP THROW>
		     <EQUAL? ,IDENTITY-FLAG ,TRILLIAN>>
		<DROP-AT-PARTY>)
	       (<AND <VERB? TAKE>
		     <IN? ,HANDBAG ,TRILLIAN>>
		<TELL D ,TRILLIAN " pulls it away." CR>)>>

<ROOM FORE-CORRIDOR
      (IN ROOMS)
      (DESC "Corridor, Fore End")
      (UP TO BRIDGE)
      (NORTH TO ENTRY-BAY)
      (WEST TO GALLEY)
      (SOUTH TO AFT-CORRIDOR)
      (FLAGS ONBIT RLANDBIT)
      (GLOBAL STAIRS HEART-OF-GOLD)
      (ACTION FORE-CORRIDOR-F)>

<ROUTINE FORE-CORRIDOR-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "This is one end of a short corridor that continues ">
		<COND (<EQUAL? ,HERE ,FORE-CORRIDOR>
		       <TELL "aft">)
		      (T
		       <TELL "fore">)>
		<TELL
" along the main deck of " D ,HEART-OF-GOLD ". Doorways lead to ">
		<COND (<EQUAL? ,HERE ,FORE-CORRIDOR>
		       <TELL "fore">)
		      (T
		       <TELL "aft">)>
		<TELL " and port. In addition, a gangway leads ">
		<COND (<EQUAL? ,HERE ,FORE-CORRIDOR>
		       <TELL "up">)
		      (T
		       <TELL "down">)>
		<TELL "ward." CR>)>>

<ROOM AFT-CORRIDOR
      (IN ROOMS)
      (SYNONYM ROBOT ROBOTS)
      (ADJECTIVE CLEANI UPPER LOWER)
      (DESC "Corridor, Aft End")
      (SOUTH PER ENGINE-ROOM-ENTER-F)
      (NORTH TO FORE-CORRIDOR)
      (WEST TO PANTRY IF SCREENING-DOOR IS OPEN)
      (DOWN TO HATCHWAY)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL STAIRS HEART-OF-GOLD SCREENING-DOOR)
      (ACTION AFT-CORRIDOR-F)>

<ROUTINE AFT-CORRIDOR-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<FCLEAR ,HATCH ,DOORBIT>
		<RFALSE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<FORE-CORRIDOR-F ,M-LOOK>)>>

<ROUTINE I-REPLY ()
	 <SETG AWAITING-REPLY <>>
	 <RFALSE>>

<GLOBAL AWAITING-REPLY <>>

<GLOBAL ARGUMENT-COUNTER 0>

<GLOBAL LOOK-COUNTER 0>

<ROUTINE ENGINE-ROOM-ENTER-F ()
	 <SETG ARGUMENT-COUNTER <+ ,ARGUMENT-COUNTER 1>>
	 <COND (<EQUAL? ,ARGUMENT-COUNTER 1>
		<SETG AWAITING-REPLY 1>
		<ENABLE <QUEUE I-ARGUMENT 2>>
		<TELL
"That entrance leads to the" ,IID " chamber. It's supposed to be a terribly
dangerous area of the ship. Are you sure you want to go in there?" CR>
		<RFALSE>)
	       (<EQUAL? ,ARGUMENT-COUNTER 2>
		<SETG AWAITING-REPLY 1>
		<ENABLE <QUEUE I-ARGUMENT 2>>
		<TELL "Absolutely sure?" CR>
		<RFALSE>)
	       (<EQUAL? ,ARGUMENT-COUNTER 3>
		<DISABLE <INT I-ARGUMENT>>
		<SETG AWAITING-REPLY 100>
		<ENABLE <QUEUE I-REPLY 2>>
		<TELL
"I can tell you don't want to really. You stride away with a spring in your
step, wisely leaving the Drive Chamber safely behind you. Telegrams arrive from
well-wishers in all corners of the Galaxy congratulating you on your prudence
and wisdom, cheering you up immensely." CR>
		<RFALSE>)
	       (<EQUAL? ,ARGUMENT-COUNTER 4>
		<ENABLE <QUEUE I-ARGUMENT 2>>
		<ENABLE <QUEUE I-REPLY 2>>
		<SETG AWAITING-REPLY 2>
		<TELL
"What? You're joking, of course. Can I ask you to reconsider?" CR>
		<RFALSE>)
	       (<G? ,ARGUMENT-COUNTER 4>
		<DISABLE <INT I-ARGUMENT>>
		<SETG AWAITING-REPLY <>>
		,ENGINE-ROOM)>>

<ROUTINE I-ARGUMENT ()
	 <COND (<OR <AND <VERB? NO>
		         <EQUAL? ,AWAITING-REPLY 1>>
		    <AND <VERB? YES>
		         <EQUAL? ,AWAITING-REPLY 2>>>
		T)
	       (T
		<CRLF>)>
	 <SETG AWAITING-REPLY <>>
	 <SETG ARGUMENT-COUNTER 0>
	 <TELL
"I knew you weren't serious about entering that extremely dangerous area." CR>>

<ROOM ENTRY-BAY
      (IN ROOMS)
      (SYNONYM BLASTE)
      (ADJECTIVE PAN-GA GARGLE)
      (DESC "Entry Bay Number Two")
      (LDESC
"This is an entry bay for the Heart of Gold. A corridor lies aft of here.")
      (SOUTH TO FORE-CORRIDOR)
      (FLAGS RLANDBIT ONBIT NARTICLEBIT)
      (GLOBAL HEART-OF-GOLD)
      (ACTION ENTRY-BAY-F)>

<ROUTINE ENTRY-BAY-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<SETG IDENTITY-FLAG ,ARTHUR>
		<MOVE ,HATCH ,GLOBAL-OBJECTS> ;"so you can ask Marv to fix it"
		<MOVE ,MECHANISM ,GLOBAL-OBJECTS> ;"ditto"
		<MOVE ,ARTHUR ,GLOBAL-OBJECTS>
		<COND (<FSET? ,ENTRY-BAY ,NDESCBIT>
		       <MOVE ,FORD ,LOCAL-GLOBALS>
		       <MOVE ,TRILLIAN ,LOCAL-GLOBALS>
		       <MOVE ,ZAPHOD ,LOCAL-GLOBALS>)
		      (T
		       <FSET ,ENTRY-BAY ,NDESCBIT>
		       <ENABLE <QUEUE I-FORD 1>>)>
		<RFALSE>)>>

<OBJECT SALES-BROCHURE
	(IN ENTRY-BAY)
	(DESC "sales brochure")
	(SYNONYM BROCHURE)
	(ADJECTIVE SALES)
	(FLAGS TAKEBIT READBIT)
	(ACTION SALES-BROCHURE-F)>

<ROUTINE SALES-BROCHURE-F ()
	 <COND (<VERB? READ>
		<TELL
"\"Equipped with a sensational breakthrough in Improbability Physics, "
D ,HEART-OF-GOLD " will make you the envy of every major government. When the
ship's" ,IID " is activated, " D ,HEART-OF-GOLD " passes through every point in
the universe simultaneously, making travel to any single location a breeze!\"|
|
The " D ,SALES-BROCHURE " goes on to describe the ship's complement of " ,SCC
"-designed robots and computers, all equipped with GPP (" ,GPP ")." CR>)>>  

<ROOM ENGINE-ROOM
      (IN ROOMS)
      (SYNONYM IMPROB PHYSIC DRIVES PROBAB)
      (ADJECTIVE IMPROB INFINI)
      (DESC "Engine Room")
      (NORTH TO AFT-CORRIDOR)
      (OUT TO AFT-CORRIDOR)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL HEART-OF-GOLD)
      (ACTION ENGINE-ROOM-F)>

<ROUTINE ENGINE-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<SETG LOOK-COUNTER <+ ,LOOK-COUNTER 1>>
		<COND (<EQUAL? ,LOOK-COUNTER 1>
		       <TELL
"You're in the" ,IID " chamber. Nothing happens; there is nothing to see." CR>)
		      (<EQUAL? ,LOOK-COUNTER 2>
		       <TELL "I mean it! There's nothing to see here!" CR>)
		      (<G? ,LOOK-COUNTER 2>
		       <COND (<EQUAL? ,LOOK-COUNTER 3>
			      <MOVE ,MAIN-DRIVE ,GLOBAL-OBJECTS>
			      	     	;"so you can ask Ed to turn it on"
			      <MOVE ,SPARE-DRIVE ,HERE>
			      <MOVE ,PLIERS ,HERE>
			      <MOVE ,RASP ,HERE>
			      <SETG SCORE <+ ,SCORE 25>>
			      <TELL
"Okay, okay, there are a FEW things to see here. ">)>
		       <TELL
"This is the room that houses the powerful In" ,FIG
" that drives " D ,HEART-OF-GOLD ". An exit lies fore of here." CR>)>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <EQUAL? ,LOOK-COUNTER 3>>
		<SETG LOOK-COUNTER 4>
		<TELL CR "(Footnote 10)" CR>)>>

<OBJECT MAIN-DRIVE
	(IN LOCAL-GLOBALS) ;"for purposes of MOBY-FIND"
	(DESC "main Improbability Drive")
	(SYNONYM DRIVE GENERA)
	(ADJECTIVE MAIN INFINI IMPROB)
	(FLAGS NDESCBIT LIGHTBIT)
	(GENERIC SPARE-DRIVE)
	(ACTION MAIN-DRIVE-F)>

<ROUTINE MAIN-DRIVE-F ()
	 <COND (<AND <VERB? EXAMINE RUB>
		     <NOT <EQUAL? ,HERE ,ENGINE-ROOM>>>
		<CANT-SEE ,MAIN-DRIVE>)
	       (<VERB? LAMP-ON>
		<TELL "Only " D ,EDDIE " can activate the drive." CR>)>>

<GLOBAL DRIVE-TO-CONTROLS <>>

<GLOBAL DRIVE-TO-PLOTTER <>>

<GLOBAL BROWNIAN-SOURCE <>>

<GLOBAL DARK-CONTROLLED <>>

<OBJECT SPARE-DRIVE
	(IN LOCAL-GLOBALS) ;"for purposes of MOBY-FIND"
	(DESC "spare Improbability Drive")
	(FDESC
"Sitting in the corner is a spare, portable Improbability Generator.")
	(SYNONYM DRIVE GENERA)
	(ADJECTIVE SPARE PORTAB INFINI IMPROB)
	(FLAGS TAKEBIT TRANSBIT CONTBIT LIGHTBIT)
	(SIZE 50)
	(GENERIC SPARE-DRIVE)
	(ACTION SPARE-DRIVE-F)>

<ROUTINE SPARE-DRIVE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "The " D ,SPARE-DRIVE " has a switch">
		<COND (<IN? ,LARGE-PLUG ,SPARE-DRIVE>
		       <TELL ", a long cord ">
		       <COND (,DRIVE-TO-CONTROLS
			      <TELL "plugged into the control console,">)
			     (T
			      <TELL "ending with a " D ,LARGE-PLUG ",">)>)
		      (T
		       <TELL ", a fused spot where a long cord once began,">)>
		<TELL " and a short cord ">
		<COND (,DRIVE-TO-PLOTTER
		       <TELL "plugged into the " D ,PLOTTER>)
		      (T
		       <TELL "ending with a " D ,SMALL-PLUG>)>
		<TELL ".">
		<FINE-PRODUCT>
		<CRLF>)
	       (<OR <AND <VERB? PLUG TIE>
			 <PRSO? ,SPARE-DRIVE>>
		    <AND <VERB? PUT>
			 <PRSI? ,LARGE-RECEPTACLE ,SMALL-RECEPTACLE>>>
		<COND (<IN? ,LARGE-PLUG ,SPARE-DRIVE>
		       <TELL
"In case you hadn't noticed, there are two connections leading from the "
D ,SPARE-DRIVE "..." CR>)
		      (T
		       <PERFORM ,V?PLUG ,SMALL-PLUG ,PRSI>
		       <RTRUE>)>)
	       (<VERB? UNPLUG>
		<COND (<OR ,DRIVE-TO-CONTROLS ,DRIVE-TO-PLOTTER>
		       <SETG DRIVE-TO-PLOTTER <>>
		       <SETG DRIVE-TO-CONTROLS <>>
		       <FCLEAR ,SPARE-DRIVE ,NDESCBIT>
		       <TELL "Done." CR>)
		      (T
		       <TELL ,NOT-PLUGGED CR>)>)
	       (<VERB? LAMP-ON>
		<PERFORM ,V?LAMP-ON ,SWITCH>
		<RTRUE>)
	       (<VERB? OPEN CLOSE>
		<V-CARVE>)>>

<OBJECT LARGE-PLUG
	(IN SPARE-DRIVE)
	(DESC "large plug")
	(SYNONYM CORD PLUG)
	(ADJECTIVE LARGE LONG)
	(FLAGS NDESCBIT INTEGRALBIT)
	(SIZE 1)
	(ACTION LARGE-PLUG-F)>

<ROUTINE LARGE-PLUG-F ()
	 <COND (<AND <VERB? PLUG PUT TIE>
		     <PRSI? ,LARGE-RECEPTACLE ,CONTROLS>>
		<COND (,DRIVE-TO-CONTROLS
		       <TELL "It already is!" CR>
		       <RTRUE>)>
		<SETG DRIVE-TO-CONTROLS T>
		<FSET ,SPARE-DRIVE ,NDESCBIT>
		<TELL "Plugged.">
		<COND (<NOT <RUNNING? ,I-TEA>>
		       <TELL
" " D ,EDDIE " says \"You shouldn't be playing around with a " D ,SPARE-DRIVE
". Who knows where it's been?\"" CR CR ,ANNOUNCEMENT D ,EDDIE ". Someone has
connected a " D ,SPARE-DRIVE " to" ,MOP ". Better be an emergency, that's all
I have to say.\"">)>
		<CRLF>)
	       (<AND <VERB? TAKE>
		     <PRSI? ,CONTROLS>>
		<PERFORM ,V?UNPLUG ,LARGE-PLUG>
		<RTRUE>)
	       (<VERB? UNPLUG REMOVE>
		<COND (,DRIVE-TO-CONTROLS
		       <SETG DRIVE-TO-CONTROLS <>>
		       <FCLEAR ,SPARE-DRIVE ,NDESCBIT>
		       <TELL "Done." CR>)
		      (T
		       <TELL ,NOT-PLUGGED CR>)>)>>

<OBJECT SMALL-PLUG
	(IN SPARE-DRIVE)
	(DESC "small plug")
	(SYNONYM CORD PLUG)
	(ADJECTIVE SMALL SHORT)
	(FLAGS NDESCBIT INTEGRALBIT)
	(SIZE 1)
	(ACTION SMALL-PLUG-F)>

<ROUTINE SMALL-PLUG-F ()
	 <COND (<AND <VERB? PLUG PUT TIE>
		     <PRSI? ,SMALL-RECEPTACLE ,PLOTTER>>
		<COND (,DRIVE-TO-PLOTTER
		       <TELL "It already is!" CR>
		       <RTRUE>)>
		<SETG DRIVE-TO-PLOTTER T>
		<TELL "Plugged." CR>)
	       (<AND <VERB? TAKE>
		     <PRSI? ,PLOTTER>>
		<PERFORM ,V?UNPLUG ,SMALL-PLUG>
		<RTRUE>)
	       (<VERB? UNPLUG REMOVE>
		<COND (,DRIVE-TO-PLOTTER
		       <SETG DRIVE-TO-PLOTTER <>>
		       <TELL "Done." CR>)
		      (T
		       <TELL ,NOT-PLUGGED CR>)>)>>

<OBJECT SWITCH
	(IN SPARE-DRIVE)
	(DESC "generator switch")
	(SYNONYM SWITCH)
	(ADJECTIVE GENERA)
	(FLAGS NDESCBIT SWITCHBIT)
	(SIZE 1)
	(ACTION SWITCH-F)>

<ROUTINE SWITCH-F ()
	 <COND (<VERB? LAMP-ON TURN PUSH MOVE THROW>
		<COND (<AND ,DRIVE-TO-PLOTTER
			    ,BROWNIAN-SOURCE>
		       <MOVE ,SPARE-DRIVE ,HERE>
		       <MOVE ,PLOTTER ,HERE>
		       <MOVE ,BROWNIAN-SOURCE ,HERE>
		       <COND (<EQUAL? ,BROWNIAN-SOURCE ,TEA>
			      <SETG HOLDING-NO-TEA T>)>
		       <COND (,DRIVE-TO-CONTROLS
			      <TELL
"As you flip the switch, sparks fly from the large receptacle. ">
			      <COND (<AND <RUNNING? ,I-TEA>
					  <G? ,TEA-COUNTER 6>>
				     <TELL
"\"My new control console!\" wails " D ,EDDIE ". \"This is the thanks I get">)
				    (T
				     <TELL
"\"Now look what you've done. You've destroyed" ,MOP ". Don't you
know it's only for emergencies">)>
			      <TELL "?\"" CR CR>
			      <SETG DRIVE-TO-CONTROLS <>>
			      <FCLEAR ,SPARE-DRIVE ,NDESCBIT>
			      <MOVE ,LARGE-PLUG ,LOCAL-GLOBALS>
			      <MOVE ,LARGE-RECEPTACLE ,LOCAL-GLOBALS>
			      <COND (<AND <RUNNING? ,I-TEA>
					  <G? ,TEA-COUNTER 6>>
				     <MOVE ,TEA ,SLOT>
				     <DISABLE <INT I-TEA>>
				     <ENABLE <QUEUE I-LANDING 24>>
	       			     <SETG FOLLOW-FLAG 3>
			      	     <ENABLE <QUEUE I-FOLLOW 2>>
				     <TELL
"The universe goes crazy for a moment." CR CR ,ANNOUNCEMENT D ,EDDIE ". The
missiles have turned into a sperm whale">
				     <FACTOR "39,745">
				     <TELL
" The whale is currently plummeting toward" ,LOST-PLANET ". I hope this will
teach you to listen to me when I say that legendary lost planets can be
dangerous. I am proceeding with the pre-set landing instructions.\"|
|
Ford, Zaphod, and " D ,TRILLIAN " saunter by on their way back to the sauna.
\"Good work, kid,\" says Zaphod, slamming you on the back." CR>)
				    (T
				     <DISABLE <INT I-TEA>>
				     <SETG SCORE <- ,SCORE 30>>
				     <TELL
,ANNOUNCEMENT D ,EDDIE ". Someone has activated a " D ,SPARE-DRIVE " at"
,MOP ", moving us 8 billion parsecs away from our destination, adding seven
weeks to our trip. As if that isn't bad enough, all 300 members of the
Fronurbdi Planetary Senate appeared in the " D ,HATCHWAY>
				     <FACTOR "79,818">
				     <TELL
" I'm flushing them into space now, but who knows what sort of germs they've
dragged into the ship? Everyone should take extra vitamins today.\"" CR>)>)
			     (<RUNNING? ,I-TEA>
			      <SETG DREAMING T>
			      <DISABLE <INT I-TEA>>
			      <JIGS-UP
"Everything becomes dark! But no, not quite everything ... There's a big bright
planet below, just visible behind your mighty tail fin. Air begins rushing by,
tickling your snout and dorsal fins ... you suddenly realise that, improbably
enough, you've turned yourself into a sperm whale and are plummeting through
the atmosphere of a planet! You begin experimenting with your new body, opening
and closing your spout and wagging your enormous tail. Just as you are getting
used to being a whale, the ground rushes up and hits you at about 200 mph.">
			      <RTRUE>)
			     (T
			      <COND (<EQUAL? ,BROWNIAN-SOURCE ,TEA>
				     <SETG DARK-CONTROLLED T>)>
			      <MOVE ,HATCH ,LOCAL-GLOBALS>
			      <MOVE ,MECHANISM ,LOCAL-GLOBALS>
			      <TELL <PICK-ONE ,DARK-ENTRANCES> CR CR>
			      <GOTO ,DARK>
			      <RTRUE>)>)
		      (T
		       <TELL "Nothing happens." CR>)>)>>

<GLOBAL DARK-ENTRANCES
	<PLTABLE
"You are disoriented. Blackness swims toward you like a shoal of eels who
have just seen something that eels like a lot..."
"Like fog rolling in off the ocean, a shroud of blackness billows toward
you. Unlike fog rolling in off the ocean, the blackness hits you like
a sixteen-tonne truck..." 
"A mist spins round your head. You fall into what seems like a bottomless
pit. Suddenly, you hit the bottom so hard that you wish it had been
bottomless...">>

<OBJECT PLOTTER
	(IN GLASS-CASE)
	(DESC "atomic vector plotter")
	(DESCFCN PLOTTER-DESCFCN)
	(SYNONYM PLOTTE)
	(ADJECTIVE ATOMIC VECTOR)
	(FLAGS VOWELBIT TAKEBIT CONTBIT TRANSBIT TRYTAKEBIT)
	(SIZE 20)
	(ACTION PLOTTER-F)>

<ROUTINE PLOTTER-DESCFCN ("OPTIONAL" X)
	 <TELL "Lying on the deck is a plotter">
	 <COND (,DRIVE-TO-PLOTTER
		<TELL " connected to a " D ,SPARE-DRIVE ".">)
	       (T
		<TELL ".">)>
	 <COND (,BROWNIAN-SOURCE
		<TELL
" The plotter's " D ,DANGLY-BIT " is submerged in " D ,BROWNIAN-SOURCE ".">)>
	 <CRLF>>

<ROUTINE PLOTTER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The " D ,PRSO " has a " D ,SMALL-RECEPTACLE " and a " D ,DANGLY-BIT>
		<COND (,BROWNIAN-SOURCE
		       <TELL " which is sitting in " D ,BROWNIAN-SOURCE>)>
		<COND (,DRIVE-TO-PLOTTER
		       <TELL
". The short cord from the " D ,SPARE-DRIVE " is plugged in the receptacle">)>
		<TELL ".">
		<FINE-PRODUCT>
		<CRLF>)
	       (<AND <VERB? PLUG>
		     <PRSI? ,SPARE-DRIVE>>
		<PERFORM ,V?PLUG ,SPARE-DRIVE ,PLOTTER>
		<RTRUE>)
	       (<VERB? UNPLUG>
		<COND (,DRIVE-TO-PLOTTER
		       <SETG DRIVE-TO-PLOTTER <>>
		       <TELL "Unplugged." CR>)
		      (T
		       <TELL ,NOT-PLUGGED CR>)>)
	       (<VERB? OPEN CLOSE>
		<V-CARVE>)>>

<OBJECT SMALL-RECEPTACLE
	(IN PLOTTER)
	(DESC "small receptacle")
	(SYNONYM RECEPT)
	(ADJECTIVE SMALL)
	(SIZE 1)
	(FLAGS NDESCBIT INTEGRALBIT)>

<OBJECT DANGLY-BIT
	(IN PLOTTER)
	(DESC "long, dangly bit")
	(SYNONYM BIT)
	(ADJECTIVE LONG DANGLY)
	(FLAGS NDESCBIT INTEGRALBIT)
	(SIZE 1)
	(ACTION DANGLY-BIT-F)>

<ROUTINE DANGLY-BIT-F ()
	 <COND (<AND <VERB? PUT>
		     <PRSI? ,SUBSTITUTE ,TEA>>
		<COND (,BROWNIAN-SOURCE
		       <TELL "But the " D ,DANGLY-BIT " is already in">
		       <ARTICLE ,BROWNIAN-SOURCE T>
		       <TELL "!" CR>
		       <RTRUE>)>
		<SETG BROWNIAN-SOURCE ,PRSI>
		<COND (<AND <PRSI? ,TEA>
			    <NOT ,CARELESS-WORDS-FLAG>>
		       <SETG CARELESS-WORDS-FLAG T>
		       <SAVE-INPUT ,FIRST-BUFFER>
		       <ENABLE <QUEUE I-CARELESS-WORDS 3>>)>
		<TELL "Done." CR>)
	       (<AND <VERB? EXAMINE>
		     ,BROWNIAN-SOURCE>
		<TELL
"The " D ,DANGLY-BIT " is suspended in the cup of " D ,BROWNIAN-SOURCE "." CR>)
	       (<AND <VERB? REMOVE>
		     ,BROWNIAN-SOURCE>
		<TELL "The " D ,DANGLY-BIT " is no longer suspended in">
		<ARTICLE ,BROWNIAN-SOURCE T>
		<TELL "." CR>
		<SETG BROWNIAN-SOURCE <>>
		<RTRUE>)>>

<ROOM HATCHWAY
      (IN ROOMS)
      (SYNONYM GPP PERSON)
      (ADJECTIVE GENUIN PEOPLE)
      (DESC "Hatchway")
      (UP TO AFT-CORRIDOR)
      (DOWN TO RAMP IF HATCH IS OPEN)
      (OUT TO RAMP IF HATCH IS OPEN)
      (EAST PER ACCESS-SPACE-ENTER-F)
      (FLAGS ONBIT RLANDBIT)
      (GLOBAL STAIRS HEART-OF-GOLD)
      (ACTION HATCHWAY-F)>

<ROUTINE HATCHWAY-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are at the bottom of a gangway. A hatch below you is ">
		<COND (<FSET? ,HATCH ,OPENBIT>
		       <TELL "open">)
		      (T
		       <TELL "closed">)>
		<TELL ". There is a small access space to starboard." CR>)
	       (<EQUAL? .RARG ,M-ENTER>
		<FSET ,HATCH ,DOORBIT>
		<RFALSE>)>>

<ROUTINE ACCESS-SPACE-ENTER-F ()
	 <COND (<G? <ACCESS-SPACE-LOOP ,PROTAGONIST> 1>
		<TELL
"That entrance is so narrow that you probably couldn't pass by holding
anything. Well, maybe ONE thing." CR>
		<RFALSE>)
	       (T
		<FCLEAR ,HATCH ,DOORBIT>
		,ACCESS-SPACE)>>

<ROUTINE ACCESS-SPACE-LOOP (CONT "AUX" X NUMBER)
	 <SET X <FIRST? .CONT>>
	 <REPEAT ()
		 <COND (<NOT .X>
			<RETURN>)>
		 <COND (<AND <NOT <FSET? .X ,WORNBIT>>
			     <NOT <FSET? .X ,INTEGRALBIT>>
			     <NOT <EQUAL? .X ,BABEL-FISH>>>
			<SET NUMBER <+ .NUMBER 1>>)>
		 <COND (<FIRST? .X>
			<SET NUMBER <+ .NUMBER <ACCESS-SPACE-LOOP .X>>>)>
		 <SET X <NEXT? .X>>>
	 <RETURN .NUMBER>>

<OBJECT HATCH
	(IN LOCAL-GLOBALS) ;"for purposes of MOBY-FIND"
	(DESC "hatch")
	(SYNONYM HATCH HATCHW)
	(ACTION HATCH-F)>

<ROUTINE HATCH-F ()
	 <COND (<AND <NOT <EQUAL? ,HERE ,HATCHWAY>>
		     <VERB? OPEN CLOSE EXAMINE RUB>>
		<CANT-SEE ,HATCH>)
	       (<AND <VERB? OPEN THROUGH>
		     <NOT ,LANDED>>
		<TELL
"Loud sirens blare, fantastically bright red lights flash from all sides, and
a soft female voice mentions that opening this hatch in space will evacuate
the air from the ship." CR>)
	       (<AND <VERB? OPEN THROUGH>
		     <NOT <FSET? ,HATCH ,OPENBIT>>>
		<TELL "The hatch appears to be jammed shut." CR>)>>

<OBJECT MECHANISM
	(IN LOCAL-GLOBALS) ;"for purposes of MOBY-FIND"
	(DESC "mechanism")
	(SYNONYM MECHAN)
	(ADJECTIVE HATCH HATCHW)
	(ACTION MECHANISM-F)>

<ROUTINE MECHANISM-F ()
	 <COND (<AND <NOT <EQUAL? ,HERE ,ACCESS-SPACE>>
		     <VERB? EXAMINE SMELL RUB REPAIR>>
		<CANT-SEE ,MECHANISM>)
	       (<VERB? REPAIR>
		<PERFORM ,V?REPAIR ,HATCH>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL
"I don't even understand it, and I'm a computer!" CR>)>>

<ROOM ACCESS-SPACE
      (IN ROOMS)
      (SYNONYM AGENCY)
      (ADJECTIVE GALACT SECURI)
      (DESC "Access Space")
      (OUT TO HATCHWAY)
      (WEST TO HATCHWAY)
      (FLAGS ONBIT RLANDBIT)
      (PSEUDO "MESH" MESH-PSEUDO)
      (GLOBAL HEART-OF-GOLD)
      (ACTION ACCESS-SPACE-F)>

<ROUTINE ACCESS-SPACE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This tiny area, with an exit to port, is for working on the hatch
" D ,MECHANISM ", which is vastly more complicated than your rather
ordinary intelligence can comprehend. ">
		<PERFORM ,V?EXAMINE ,GROUND>
		<RTRUE>)>>

<ROUTINE MESH-PSEUDO ()
	 <COND (<PRSI? ,PSEUDO-OBJECT>
		<PERFORM ,PRSA ,PRSO ,GROUND>
		<RTRUE>)
	       (T
		<PERFORM ,PRSA ,GROUND ,PRSI>
		<RTRUE>)>>

<ROOM RAMP
      (IN ROOMS)
      (SYNONYM PLANET MAGRAT)
      (ADJECTIVE LEGEND)
      (DESC "Ramp")
      (LDESC
"The wind moans. Dust drifts across the surface of the alien world. Zaphod,
Ford, and Trillian appear and urge you forward.")
      (FLAGS RLANDBIT ONBIT)
      (ACTION RAMP-F)>

<ROUTINE RAMP-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<TELL
"You step onto the landing ramp leading down toward the surface of"
,LOST-PLANET ". " ,ANNOUNCEMENT D ,EDDIE ". Someone is leaving the ship
on a strange planet without wrapping up all nice and warm. It'll all end
in tears, I just know it...\" The voice fades behind you." CR CR>)
	       (<EQUAL? .RARG ,M-END>
		<TELL CR
"Slowly, nervously, you step downwards, the cold thin air rasping in your
lungs. You set one single foot on the ancient dust -- and almost instantly
the most incredible adventure starts which you'll have to buy the next game
to find out about." CR CR>
		<V-SCORE>
		<TELL CR
"By the way, there WAS a causal relationship between your taking the "
D ,TOOTHBRUSH " and the tree collapsing at the very beginning of the game.
We apologise for this slight inaccuracy." CR>
		<FINISH>)>>