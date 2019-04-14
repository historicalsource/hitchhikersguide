"EARTH for
		  THE HITCHHIKER'S GUIDE TO THE GALAXY
	(c) Copyright 1984 Infocom, Inc.  All Rights Reserved."

<OBJECT HOME
	(IN LOCAL-GLOBALS)
	(DESC "your home")
	(SYNONYM HOME)
	(ADJECTIVE MY YOUR)
	(FLAGS NARTICLEBIT)
	(ACTION HOME-F)>

<ROUTINE HOME-F ()
	 <COND (<AND ,HOUSE-DEMOLISHED
		     <VERB? ENJOY>>
		<TELL
,ZEN " You can't enjoy a " D ,RUBBLE " properly till it's at least a hundred
years old. Also, you are haunted by the tragic vision of your favourite teapot
lying shattered among the dust.|
There is also the matter of all your clothes." CR>)
	       (<VERB? THROUGH WALK-TO BOARD>
		<COND (<EQUAL? ,HERE ,FRONT-OF-HOUSE ,FRONT-PORCH>
		       <DO-WALK ,P?NORTH>)
		      (<EQUAL? ,HERE ,BEDROOM>
		       <TELL ,LOOK-AROUND CR>)
		      (T
		       <V-WALK-AROUND>)>)
	       (<VERB? LEAVE EXIT DISEMBARK>
		<COND (<EQUAL? ,HERE ,FRONT-PORCH>
		       <DO-WALK ,P?SOUTH>)
		      (<EQUAL? ,HERE ,BEDROOM>
		       <V-WALK-AROUND>)
		      (T
		       <TELL ,LOOK-AROUND CR>)>)
	       (<AND <VERB? LIE-DOWN>
		     <EQUAL? ,HERE ,FRONT-OF-HOUSE>
		     ,IN-FRONT-FLAG>
		<PERFORM ,V?LIE-DOWN ,GROUND>
		<RTRUE>)
	       (<AND <VERB? EXAMINE>
		     ,HOUSE-DEMOLISHED>
		<TELL "It is now a " D ,RUBBLE "." CR>)
	       (<EQUAL? ,IDENTITY-FLAG ,FORD> ;"since DESC is YOUR HOME"
		<UNIMPORTANT-THING-F>)>>

<OBJECT HOUSE
	(IN LOCAL-GLOBALS)
	(DESC "it")
	(SYNONYM HOUSE)
	(ADJECTIVE MY YOUR)
	(FLAGS NARTICLEBIT)
	(ACTION HOUSE-F)>

<ROUTINE HOUSE-F ()
	 <COND (<PRSO? ,HOUSE>
		<PERFORM ,PRSA ,HOME ,PRSI>
		<RTRUE>)
	       (T
		<PERFORM ,PRSA ,PRSO ,HOME>
		<RTRUE>)>>

<OBJECT RUBBLE
	(IN LOCAL-GLOBALS)
	(DESC "pile of rubble")
	(SYNONYM PILE RUBBLE DEBRIS)
	(FLAGS NDESCBIT)
	(ACTION HOME-F)>

<ROUTINE I-HOUSEWRECK ()
	 <COND (<EQUAL? ,HERE ,BEDROOM ,FRONT-PORCH>
		<TELL CR
"Astoundingly, a " D ,BULLDOZER " pokes through your wall. However, you have
no time for surprise because the ceiling is collapsing on you as">
		<BETTER-LUCK>)
	       (T
		<RFALSE>)>>

<ROUTINE BETTER-LUCK ()
	 <TELL
" your home is unexpectedly demolished to make way for a new bypass. You are
seriously injured in the process, but on your way to the hospital">
	 <MAKE-WAY-FOR>
	 <CRLF>
	 <COND (<NOT <FSET? ,BEDROOM ,ONBIT>>
		<TELL "Next time, try turning on the light." CR>)
	       (<AND <NOT <FSET? ,GOWN ,OPENBIT>>
		     ,HEADACHE> 
		<TELL
"Too bad you never found an aspirin for your hangover." CR>)
	       (T
		<TELL "Better luck next life." CR>)>
	 <FINISH>>

<GLOBAL HOUSE-DEMOLISHED <>>

<GLOBAL HEADACHE T>

<GLOBAL SLEEVE-TIED <>>

<OBJECT HANGOVER
	(IN GLOBAL-OBJECTS)
	(DESC "splitting headache")
	(SYNONYM HEADAC HANGOV THROBB)
	(ADJECTIVE SPLITT BIG BLINDI)
	(ACTION HANGOVER-F)>

<ROUTINE HANGOVER-F ()
	 <COND (<AND <VERB? ASK-ABOUT>
		     <PRSI? ,HANGOVER>>
		<RFALSE>)
	       (<AND <NOT ,HEADACHE>
		     <NOT <EQUAL? ,IDENTITY-FLAG ,ZAPHOD>>>
		<TELL "You can't feel any">
		<COND (<EQUAL? ,HANGOVER ,PRSO>
		       <PRSO-PRINT>)
		      (T
		       <PRSI-PRINT>)>
		<TELL " here." CR>)
	       (<VERB? EXAMINE>
		<V-DIAGNOSE>)
	       (<VERB? GIVE THROW DROP>
		<V-COUNT>)>>

<ROOM BEDROOM
      (IN ROOMS)
      (SYNONYM TRAVEL)
      (ADJECTIVE TIME)
      (DESC "Bedroom")
      (SOUTH PER BEDROOM-EXIT-F)
      (OUT PER BEDROOM-EXIT-F)
      (DOWN PER BEDROOM-EXIT-F)
      (FLAGS RLANDBIT)
      (GLOBAL HOUSE HOME GLOBAL-BED BULLDOZER WINDOW STAIRS
       	      BEDROOM-DOOR THIRD-PLANET)
      (PSEUDO "WATER" UNIMPORTANT-THING-F "BEDROO" GLOBAL-ROOM-F)
      (ACTION BEDROOM-F)>

<ROUTINE BEDROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The bedroom is a mess.|
It is a small bedroom with a faded carpet and old wallpaper. There is a
washbasin, a chair">
		<COND (<FSET? ,GOWN ,NDESCBIT>
		       <TELL " with a tatty dressing gown slung over it">)>
		<TELL
", and a window with the curtains drawn. Near the exit leading south is a
phone." CR>)>>

<ROUTINE BEDROOM-EXIT-F ()
	 <COND (<NOT <FSET? ,BEDROOM-DOOR ,OPENBIT>>
		<TELL "The door is closed." CR>
		<SETG P-IT-OBJECT ,BEDROOM-DOOR>
		<RFALSE>)
	       (,HEADACHE
		<TELL
"You miss the doorway by a good eighteen inches. The wall jostles you
rather rudely." CR>
		<RFALSE>)
	       (<FSET? ,BULLDOZER ,INVISIBLE>
		<TELL "You make your way down to the front porch." CR CR>)
	       (T
		<TELL "You rush down the stairs in panic." CR CR>)>
	 <FCLEAR ,LIGHT ,LIGHTBIT>
	 ,FRONT-PORCH>

<OBJECT PHONE
	(IN BEDROOM)
	(DESC "telephone")
	(SYNONYM PHONE TELEPH RECEIV)
	(FLAGS NDESCBIT TAKEBIT TRYTAKEBIT)
	(ACTION PHONE-F)>

<ROUTINE PHONE-F ()
	 <COND (<VERB? TAKE>
		<COND (<FSET? ,PHONE ,TOUCHBIT>
		       <PERFORM ,V?CALL ,DAIS>
		       <RTRUE>)
		      (T
		       <FSET ,PHONE ,TOUCHBIT>
		       <TELL "You pick up the receiver." ,DIALLING-TONE>
		       <COND (<FSET? ,TOOTHBRUSH ,TOUCHBIT>
		              <TWO-TREES>)>
		       <CRLF>)>)
	       (<VERB? REPLY>
		<TELL "It isn't ringing." CR>)>>

<OBJECT BEDROOM-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "door")
	(SYNONYM DOOR)
	(FLAGS DOORBIT OPENBIT NDESCBIT)>

<OBJECT GLOBAL-BED
	(IN LOCAL-GLOBALS)
	(DESC "bed")
	(SYNONYM BED)
	(FLAGS VEHBIT)
	(ACTION GLOBAL-BED-F)>

<ROUTINE GLOBAL-BED-F ()
	 <COND (<EQUAL? ,GLOBAL-BED ,PRSO>
		<PERFORM ,PRSA ,BED ,PRSI>
		<RTRUE>)
	       (T
		<PERFORM ,PRSA ,PRSO ,BED>
		<RTRUE>)>>

<OBJECT BED
	(IN BEDROOM)
	(DESC "bed")
	(SYNONYM BED)
	(FLAGS VEHBIT CONTBIT SURFACEBIT SEARCHBIT OPENBIT NDESCBIT)
	(ACTION BED-F)>

<ROUTINE BED-F ("OPTIONAL" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? TAKE>
		            <FSET? ,PRSO ,TAKEBIT>
			    <NOT <IN? ,PRSO ,BED>>
			    <NOT <HELD? ,PRSO>>>
		       <TELL "You can't reach it from the bed.">
		       <COND (,HEADACHE
			      <TELL " The effort almost kills you.">)>
		       <CRLF>)
		      (<AND <VERB? OPEN LOOK-INSIDE>
			    <PRSO? ,CURTAINS>>
		       <PERFORM ,V?TAKE ,PHONE>
		       <SETG P-IT-OBJECT ,CURTAINS>
		       <RTRUE>)
		      (<AND <VERB? OPEN CLOSE>
			    <PRSO? ,BEDROOM-DOOR>>
		       <PERFORM ,V?TAKE ,PHONE>
		       <SETG P-IT-OBJECT ,BEDROOM-DOOR>
		       <RTRUE>)
		      (<VERB? WALK>
		       <OUT-OF-FIRST ,BED>)>)
	       (.RARG
		<RFALSE>)
	       (<AND <VERB? DISEMBARK>
		     ,HEADACHE
		     <EQUAL? <LOC ,PROTAGONIST> ,BED>>
		<MOVE ,PROTAGONIST ,HERE>
		<SETG LYING-DOWN <>>
		<TELL
"Very difficult, but you manage it. The room is still spinning.
It dips and sways a little." CR>)
	       (<VERB? LOOK-UNDER>
		<MOVE ,STUFF-UNDER-BED ,HERE>
		<TELL
"There's nothing there. Well, there are a few soiled handkerchiefs, a book you
thought you'd lost, a couple of foreign coins, and something else which can't
be fully described in a family game, but nothing you'd actually want." CR>)
	       (<AND <VERB? OPEN CLOSE>
		     <PRSO? ,BED>>
		<TELL-ME-HOW>)>>

<OBJECT STUFF-UNDER-BED
	(IN LOCAL-GLOBALS) ;"for purposes of MOBY-FIND"
	(DESC "it")
	(SYNONYM BOOK COIN HANDKE COINS)
	(ADJECTIVE SOILED FOREIG)
	(FLAGS NDESCBIT NARTICLEBIT)
	(ACTION UNIMPORTANT-THING-F)>

<OBJECT CURTAINS
	(IN BEDROOM)
	(DESC "your curtains")
	(SYNONYM CURTAI SHADE SHADES)
	(ADJECTIVE YOUR)
	(FLAGS NDESCBIT NARTICLEBIT)
	(ACTION CURTAINS-F)>

<ROUTINE CURTAINS-F ()
	 <COND (<VERB? OPEN LOOK-INSIDE>
		<FCLEAR ,BULLDOZER ,INVISIBLE>
		<TELL
"As you part " D ,CURTAINS " you see that i" ,NICE-DAY ", and a large yellow "
D ,BULLDOZER " is advancing on " D ,HOME "." CR>)>>

<OBJECT GOWN
	(IN BEDROOM)
	(DESC "your gown")
	(LDESC "Your gown is here.")
	(SYNONYM GOWN POCKET ROBE LOOP)
	(ADJECTIVE MY YOUR DRESSI TATTY FADED BATTER)
        (FLAGS
	 WEARBIT TRYTAKEBIT TAKEBIT CONTBIT NDESCBIT NARTICLEBIT SEARCHBIT)
	(SIZE 15)
	(CAPACITY 14)
	(ACTION GOWN-F)>

<ROUTINE GOWN-F ()
	 <COND (<AND <VERB? OPEN CLOSE>
		     <NOT <FSET? ,GOWN ,WORNBIT>>>
		<TELL
"It's hard to open or close the pocket unless you're wearing the gown." CR>)
	       (<VERB? EXAMINE>
		<TELL "The dressing gown is faded and battered, and is
clearly a garment which has seen better decades. It has a pocket which is ">
		<COND (<FSET? ,GOWN ,OPENBIT>
		       <TELL "open">)
		      (T
		       <TELL "closed">)>
		<COND (,GOWN-HUNG
		       <TELL ". It is hanging from a " D ,HOOK ".">)
		      (T
		       <TELL ", and a small loop at the back of the collar.">)>
		<COND (,SLEEVE-TIED
		       <TELL " The sleeves are tied closed.">)>
		<CRLF>)
	       (<AND <VERB? TAKE>
		     <EQUAL? ,GOWN ,PRSO>
		     ,HEADACHE>
		<FCLEAR ,GOWN ,TRYTAKEBIT>
		<FCLEAR ,GOWN ,NDESCBIT>
		<MOVE ,GOWN ,PROTAGONIST>
		<TELL
"Luckily, this is large enough for you to get hold of. You notice something
in the pocket." CR>)
	       (<AND <VERB? WEAR>
		     ,SLEEVE-TIED>
		<TELL "You'll have to untie the sleeve first." CR>)
	       (<VERB? TIE UNTIE>
		<PERFORM ,PRSA ,SLEEVES>
		<RTRUE>)>>

<OBJECT SLEEVES
	(IN GLOBAL-OBJECTS)
	(DESC "sleeve")
	(SYNONYM SLEEVE)
	(ACTION SLEEVES-F)>

<ROUTINE SLEEVES-F ()
	 <COND (<NOT <VISIBLE? ,GOWN>>
		<CANT-SEE ,SLEEVES>)
	       (<VERB? WEAR TAKE>
		<PERFORM ,PRSA ,GOWN>
		<RTRUE>)
	       (<VERB? TIE CLOSE>
		<SETG PRSO ,GOWN>
		<COND (<IDROP>
		       <RTRUE>)
		      (,SLEEVE-TIED
		       <TELL "It is." CR>)
		      (T
		       <SETG SLEEVE-TIED T>
		       <TELL "The sleeves are now tied closed." CR>)>)
	       (<VERB? UNTIE OPEN>
		<COND (,SLEEVE-TIED
		       <SETG SLEEVE-TIED <>>
		       <TELL "Untied." CR>)
		      (T
		       <TELL "It isn't tied!" CR>)>)>>

<ROUTINE TWO-TREES ()
	 <SETG AWAITING-REPLY 9>
	 <ENABLE <QUEUE I-REPLY 2>>
	 <TELL
" Shouldn't you be taking more interest in events in the world around you?
While you've got it...?">>

<OBJECT THING
	(IN GOWN)
	(DESC "thing your aunt gave you which you don't know what it is")
	(SYNONYM THING GIFT)
	(ADJECTIVE AUNT\'S)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT OPENBIT)
	(SIZE 6)
	(CAPACITY 90)
	(ACTION THING-F)>

<ROUTINE THING-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"Apart from a label on the bottom saying \"Made in Ibiza\" it furnishes you
with no clue as to its purpose, if indeed it has one. You are surprised to see
it because you thought you'd thrown it away. Like most gifts from your aunt,"
,GET-RID CR>)
	       (<AND <VERB? DROP>
		     <NOT <EQUAL? ,HERE ,MAZE ,ACCESS-SPACE>>>
		<MOVE ,THING ,HERE>
		<TELL
"It falls to the ground with a light \"thunk.\" It doesn't do anything
else at all." CR>)
	       (<VERB? CLOSE>
		<TELL
"Come to think of it, you vaguely remember an instruction booklet with
directions for that. You never read it and lost it months ago." CR>)>>

<ROUTINE I-THING ()
	 <ENABLE <QUEUE I-THING <+ 4 <RANDOM 4>>>>
	 <COND (<OR <NOT <EQUAL? ,IDENTITY-FLAG ,ARTHUR>>
		    <AND <EQUAL? ,HERE ,ENGINE-ROOM>
			 <L? ,LOOK-COUNTER 3>>
		    <EQUAL? ,HERE ,DARK ,ACCESS-SPACE ,MAZE>
		    <VISIBLE? ,THING>
		    <HELD? ,THING ,PROTAGONIST>
		    <IN? ,FLEET ,HERE>>
		<RFALSE>)>
	 <COND (<PROB 40>
		<MOVE ,THING ,HERE>)
	       (<AND <FSET? ,GOWN ,WORNBIT>
		     <FSET? ,GOWN ,OPENBIT>
		     <PROB 65>>
		<MOVE ,THING ,GOWN>)
	       (T
		<MOVE ,THING ,PROTAGONIST>)>
	 <RFALSE>>

<OBJECT POCKET-FLUFF
	(IN GOWN)
	(DESC "pocket fluff")
	(SYNONYM FLUFF LINT)
	(ADJECTIVE POCKET)
	(FLAGS TAKEBIT NARTICLEBIT)
	(SIZE 1)
	(GENERIC POCKET-FLUFF)>

<OBJECT TABLET
	(IN GOWN)
	(DESC "buffered analgesic")
	(SYNONYM ANALGE TABLET ASPIRI PILL)
	(ADJECTIVE LARGE BUFFER)
	(FLAGS TAKEBIT EATBIT)
        (SIZE 2)
	(ACTION TABLET-F)>

<ROUTINE TABLET-F ()
	 <COND (<VERB? EAT TAKE DRINK> ;"SWALLOW is synonym of DRINK"
		<MOVE ,TABLET ,LOCAL-GLOBALS>
		<FCLEAR ,SCREWDRIVER ,TRYTAKEBIT>
		<FCLEAR ,TOOTHBRUSH ,TRYTAKEBIT>
		<SETG HEADACHE <>>
		<SETG SCORE <+ ,SCORE 10>>
		<TELL
"You swallow the tablet. After a few seconds the room begins to calm
down and behave in an orderly manner. Your terrible headache goes." CR>)>>

<OBJECT SINK
	(IN BEDROOM)
	(DESC "it")
	(SYNONYM BASIN WASHBA SINK)
	(ADJECTIVE WASH)
	(FLAGS NDESCBIT NARTICLEBIT)
	(ACTION UNIMPORTANT-THING-F)>

<OBJECT BEDROOM-FURNISHINGS
	(IN BEDROOM)
	(DESC "it")
	(SYNONYM CARPET WALLPA PAPER CHAIR)
	(ADJECTIVE WALL FADED OLD)
	(FLAGS NDESCBIT NARTICLEBIT)
	(ACTION UNIMPORTANT-THING-F)>

<ROOM FRONT-PORCH
      (IN ROOMS)
      (SYNONYM BEAM BEAMS)
      (ADJECTIVE MATTER TRANSF)
      (DESC "Front Porch")
      (LDESC
"This is the enclosed front porch of your home. Your front garden lies to
the south, and you can re-enter your home to the north.")
      (UP TO BEDROOM)
      (NORTH TO BEDROOM)
      (SOUTH PER CLOTHES-EXIT-F)
      (OUT PER CLOTHES-EXIT-F)
      (FLAGS RLANDBIT ONBIT)
      (PSEUDO "DOORMA" UNIMPORTANT-THING-F "MAT" UNIMPORTANT-THING-F)
      (GLOBAL HOUSE HOME STAIRS THIRD-PLANET BEDROOM-DOOR)>

<ROUTINE CLOTHES-EXIT-F ()
	 <COND (<FSET? ,GOWN ,WORNBIT>
		,FRONT-OF-HOUSE)
	       (T
		<SETG AWAITING-REPLY 10>
		<ENABLE <QUEUE I-REPLY 2>>
		<TELL ,ARRESTED CR>
		<RFALSE>)>>

<OBJECT MAIL
	(IN FRONT-PORCH)
	(DESC "loose pile of junk mail")
	(FDESC "On the doormat is a pile of junk mail.")
	(SYNONYM ORDER MAIL PILE LETTER)
	(ADJECTIVE DEMOLI JUNK MY OFFICI LOOSE)
	(FLAGS TAKEBIT READBIT TRYTAKEBIT)
	(SIZE 4)
	(TEXT
"There are many pieces of mail. Most are from some computer company called
Infocom which wants you to buy their games. Hidden underneath is an official
letter from the local council, dated some two years ago and inexplicably not
delivered till now, explaining that a demolition order has been served on your
home. The date of demolition is today's date.")
	(ACTION MAIL-F)>

<ROUTINE MAIL-F ()
	 <COND (<AND <VERB? TAKE>
		     <NOT <FSET? ,MAIL ,TOUCHBIT>>>
		<FSET ,MAIL ,TOUCHBIT>
		<FCLEAR ,MAIL ,TRYTAKEBIT>
		<MOVE ,MAIL ,PROTAGONIST>
		<TELL "You gather up the pile of mail." CR>)
	       (<VERB? OPEN>
		<PERFORM ,V?READ ,MAIL>
		<RTRUE>)>>

<ROOM FRONT-OF-HOUSE
      (IN ROOMS)
      (SYNONYM WOONBE)
      (ADJECTIVE GALAXI)
      (DESC "Front of House")
      (NORTH PER HOUSE-ENTER-F)
      (SOUTH TO COUNTRY-LANE)
      (NE TO BACK-OF-HOUSE)
      (NW TO BACK-OF-HOUSE)
      (FLAGS RLANDBIT ONBIT OUTSIDEBIT)
      (GLOBAL HOUSE HOME BULLDOZER CONVERSATION THIRD-PLANET RUBBLE)
      (PSEUDO "TREE" TREE-PSEUDO)
      (ACTION FRONT-OF-HOUSE-F)>

<ROUTINE HOUSE-ENTER-F ()
	 <COND (,HOUSE-DEMOLISHED
		<TELL "You can't enter a " D ,RUBBLE "." CR>
		<RFALSE>)
	       (<EQUAL? ,IDENTITY-FLAG ,FORD>
		<COND (<NOT <VERB? THROUGH>>
		       <TELL "Enter the house? ">)>
		<PRIVATE "Arthur">
		<RFALSE>)
	       (<NOT ,PROSSER-LYING>
		<TELL "The " D ,BULLDOZER>
		<JIGS-UP
", which you may have noticed outside, just pushed your home down
on top of you.">
		<RFALSE>)
	       (T
		<ENABLE <QUEUE I-HOUSEWRECK 5>>
		,FRONT-PORCH)>>

<ROUTINE FRONT-OF-HOUSE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<FCLEAR ,BULLDOZER ,INVISIBLE>
		<COND (<IN? ,DOG ,COUNTRY-LANE>
		       <COND (<NOT ,DOG-FED>
			      <I-DOG>)>
	               <ENABLE <QUEUE I-VOGONS 3>>
		       <TELL "You reach the site of what was ">
		       <COND (<EQUAL? ,IDENTITY-FLAG ,FORD>
			      <TELL "Arthur's">)
			     (T
			      <TELL "your">)>
		       <TELL
" home. It is now a " D ,RUBBLE ". " D ,PROSSER " looks sheepishly
triumphant, a trick few people can do, as it requires a lot of
technically complex deltoid muscle work." CR CR>)
		      (<AND <NOT <EQUAL? ,IDENTITY-FLAG ,FORD>>
			    <NOT ,PROSSER-LYING>>
		       <ENABLE <QUEUE I-BULLDOZER -1>>
		       <RFALSE>)>)
	       (<EQUAL? .RARG ,M-LOOK>
		<COND (<AND <EQUAL? ,IDENTITY-FLAG ,FORD>
			    <NOT <FSET? ,FRONT-OF-HOUSE ,NDESCBIT>>>
		       <FSET ,BEER ,NDESCBIT>
		       <SETG DRUNK-LEVEL 0>
		       <FSET ,ARTHUR ,NDESCBIT>
		       <FSET ,FRONT-OF-HOUSE ,NDESCBIT>
		       <TELL
"Before you is the house of your friend, " D ,ARTHUR ", who is lying in front
of a " D ,BULLDOZER "; you have no idea why. You have no idea about most things
about Arthur, even why you regard him as a friend, but you do, and must
therefore return his towel before you leave.">)
		      (T
		       <COND (,HOUSE-DEMOLISHED
			      <TELL "There is a huge " D ,RUBBLE>)
			     (<EQUAL? ,IDENTITY-FLAG ,FORD>
			      <TELL "Arthur's house is">)
			     (T
			      <TELL "You can enter your home">)>
		       <TELL
" to the north. A path leads around it to the northeast and northwest,
and a country lane is visible to the south.">)>
		<COND (<AND <NOT <FSET? ,FRONT-OF-HOUSE ,NDESCBIT>>
			    <EQUAL? ,IDENTITY-FLAG ,ARTHUR>>
		       <FSET ,FRONT-OF-HOUSE ,NDESCBIT>
		       <TELL
" All that lies between your home and the huge yellow " D ,BULLDOZER " bearing
down on it is a few yards of mud.">)>
		<CRLF> <CRLF>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <EQUAL? ,IDENTITY-FLAG ,FORD>
		     <FSET? ,ARTHUR ,NDESCBIT>>
		<FCLEAR ,ARTHUR ,NDESCBIT>
		<RFALSE>)>>

<OBJECT ROSES
	(IN FRONT-OF-HOUSE)
	(DESC "it")
	(SYNONYM ROSE ROSES ROSEBE BED)
	(ADJECTIVE ROSE)
	(FLAGS NDESCBIT NARTICLEBIT)
	(ACTION UNIMPORTANT-THING-F)>

<GLOBAL BULLDOZER-COUNTER 0>

<ROUTINE I-BULLDOZER ()
	 <COND (<OR ,LYING-DOWN
		    ,HOUSE-DEMOLISHED>
		<DISABLE <INT I-BULLDOZER>>
		<RFALSE>)>
	 <FSET ,PROSSER ,TOUCHBIT>
	 <SETG BULLDOZER-COUNTER <+ ,BULLDOZER-COUNTER 1>>
	 <COND (<G? ,BULLDOZER-COUNTER 4>
	        <DISABLE <INT I-BULLDOZER>>
		<TELL ,BULLDOZER-PILES CR>
		<BRICK-DEATH>)
	       (<EQUAL? ,HERE ,FRONT-OF-HOUSE>
		<TELL
"The " D ,BULLDOZER " rumbles slowly toward your home." CR>)
	       (T
		<RFALSE>)>>

<ROUTINE BRICK-DEATH ()
	 <TELL CR
"Your home collapses in a cloud of dust, and a stray flying brick hits you
squarely on the back of the head. You try to think of some suitable last words,
but what with the confusion of the moment and the spinning of your head, you
are unable to compose anything pithy and expire in silence.">
	 <REPEAT ()
		 <CRLF> <CRLF>
	         <PRINTI ">">
	         <READ ,P-INBUF ,P-LEXV>
	         <SETG DEAD-COUNTER <+ ,DEAD-COUNTER 1>>
	         <COND (<EQUAL? ,DEAD-COUNTER 1 2>
			<TELL "You keep out of this, you're dead">
			<COND (<EQUAL? ,DEAD-COUNTER 1>
			       <TELL ". An ambulance arrives.">)
			      (T
			       <TELL
" and should be concentrating on developing a good firm rigor mortis. You
are put in the ambulance, which drives away.">)>)
	              (<EQUAL? ,DEAD-COUNTER 3>
		       <TELL
"For a dead person you are talking too much.
As the ambulance reaches the mortuary">
		       <MAKE-WAY-FOR>
		       <FINISH>)>>>

<GLOBAL DEAD-COUNTER 0>

<OBJECT BULLDOZER-DRIVER
	(IN FRONT-OF-HOUSE)
	(DESC "bulldozer driver")
	(SYNONYM DRIVER)
	(ADJECTIVE BULLDO DOZER)
	(FLAGS NDESCBIT ACTORBIT)
	(ACTION BULLDOZER-DRIVER-F)>

<ROUTINE BULLDOZER-DRIVER-F ()
	 <COND (<VERB? TELL HELLO>
		<TELL "The " D ,BULLDOZER-DRIVER
", perusing a booklet of union rules, ignores you." CR>
		<FUCKING-CLEAR>)>>

<OBJECT BULLDOZER
	(IN LOCAL-GLOBALS)
	(DESC "bulldozer")
	(SYNONYM BULLDO DOZER)
	(ADJECTIVE LARGE YELLOW BULL HUGE)
	(FLAGS NDESCBIT INVISIBLE)
	(ACTION BULLDOZER-F)>

<ROUTINE BULLDOZER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's one of those really big " D ,BULLDOZER "s that can actually crush other "
D ,BULLDOZER "s, let alone houses." CR>)
	       (<AND <NOT <EQUAL? ,HERE ,FRONT-OF-HOUSE>>
		     <VERB? RUB PUSH MOVE TAKE KICK BLOCK WALK-AROUND>>
		<TELL "The " D ,BULLDOZER " isn't here." CR>)
	       (<VERB? LIE-DOWN>
		<PERFORM ,V?BLOCK ,BULLDOZER>
		<RTRUE>)
	       (<AND <VERB? BLOCK>
		     <EQUAL? ,IDENTITY-FLAG ,ARTHUR>>
		<COND (,HOUSE-DEMOLISHED
		       <TELL "Too late now." CR>)
		      (,LYING-DOWN
		       <PERFORM ,V?LIE-DOWN ,GROUND>
		       <RTRUE>)
		      (,PROSSER-LYING
		       <TELL "Prosser's doing that for you." CR>)
		      (T
		       <SETG LYING-DOWN T>
		       <ENABLE <QUEUE I-PROSSER 2>>
		       <TELL
"You lie down in the path of the advancing " D ,BULLDOZER ". Prosser yells
at you to for crissake move!!!" CR>)>)
	       (<VERB? WALK-AROUND>
		<COND (<EQUAL? ,IDENTITY-FLAG ,ARTHUR>
		       <V-DIG>)
		      (<NOT ,TOWEL-OFFERED>
		       <TELL
"Didn't you come here for a purpose? Something about a towel?" CR>)
		      (,GONE-AROUND
		       <TELL "You already did. It's not a merry-go-round." CR>)
		      (T
		       <SETG GONE-AROUND T>
		       <TELL
"You walk around the " D ,BULLDOZER ". Prosser is standing here, looking cross
and frustrated. Realising that you are a friend of Arthur's he starts to talk
at you. He says that this sort of protest is all very well, but what Mr. Dent
must realise is that he's had plenty of time to make a formal protest at the
proper time and place, and that spending months going through the appropriate
official channels, filling in the appropriate official forms, and going to the
appropriate official public hearings is the right way of going about it, and
lying around whimsically in the mud is not. He says that he personally hates
mud and despises the sort of people who lie in it." CR>)>)
	       (<AND <VERB? LISTEN>
		     <RUNNING? ,I-PROSSER>>
		<TELL "\"Rumble...rumble...\"" CR>)>>

<GLOBAL PROSSER-COUNTER 0>

<GLOBAL PROSSER-LYING <>>

<GLOBAL GONE-AROUND <>>

<ROUTINE I-PROSSER ()
	 <COND (<NOT ,LYING-DOWN>
		<DISABLE <INT I-PROSSER>>
		<I-BULLDOZER>
		<RTRUE>)>
	 <ENABLE <QUEUE I-PROSSER -1>>
	 <SETG PROSSER-COUNTER <+ ,PROSSER-COUNTER 1>>
	 <CRLF>
	 <COND (<EQUAL? ,PROSSER-COUNTER 1>
		<TELL
"The " D ,BULLDOZER " thunders toward you. The ground is shaking beneath you
as you lie in the mud." CR>)
	       (<EQUAL? ,PROSSER-COUNTER 2>
		<TELL
"The noise of the giant " D ,BULLDOZER " is now so violently loud that you
can't even hear Prosser yelling to warn you that you will be killed if you
don't get the hell out of the way. You just see him gesticulating wildly." CR>)
	       (<EQUAL? ,PROSSER-COUNTER 3>
		<DISABLE <INT I-PROSSER>>
		<ENABLE <QUEUE I-FORD -1>>
		<MOVE ,FORD ,HERE>
		<SETG P-IT-OBJECT ,TOWEL>
		<TELL
"With a terrible grinding of gears the " D ,BULLDOZER" comes to an abrupt halt
just in front of you. It shakes, shudders, and emits noxious substances all
over your rose bed. Prosser is incoherent with rage.|
|
Moments later, your friend " D ,FORD " arrives. He hardly seems to notice
your predicament, but keeps glancing nervously at the sky. He says \"Hello,
Arthur,\" takes a towel from his battered leather satchel, and offers it to
you." CR>)>>

<OBJECT PROSSER
	(IN FRONT-OF-HOUSE)
	(DESC "Mr. Prosser")
	(DESCFCN PROSSER-DESCFCN)
	(SYNONYM PROSSE FOREMA CREW)
	(ADJECTIVE WRECKI MR MISTER)
	(FLAGS NARTICLEBIT ACTORBIT CONTBIT OPENBIT)
	(ACTION PROSSER-F)>

<ROUTINE PROSSER-DESCFCN ("OPTIONAL" X)
	 <COND (<AND <EQUAL? ,IDENTITY-FLAG ,FORD>
		     <NOT <FSET? ,PROSSER ,TOUCHBIT>>>
		<FSET ,PROSSER ,TOUCHBIT>
		<TELL
"Nearby stands an impatient man. There seems to be a bit of an atmosphere.">)
	       (T
		<TELL D ,PROSSER ", from the local council, is ">
	 	<COND (,PROSSER-LYING
		       <TELL "lying in front">)
		      (,GONE-AROUND
		       <TELL "standing at the side">)
		      (T
		       <TELL ,ON-OTHER-SIDE>)>
		<TELL
" of the " D ,BULLDOZER ". He seems to be wearing a " D ,DIGITAL-WATCH ".">
	        <COND (<NOT <FSET? ,PROSSER ,TOUCHBIT>>
		       <FSET ,PROSSER ,TOUCHBIT>
		       <TELL
" He looks startled to see you emerge, and yells at you to get out of
the way.">)>)>
	 <CRLF>>

<ROUTINE PROSSER-F ()
	 <COND (<EQUAL? ,PROSSER ,WINNER>
		<COND (<IN? ,FLEET ,HERE>
		       <TELL
"Prosser is too preoccupied with recent events to give your remarks much
consideration. He is running off and saying a number of things about his
mother in a high voice." CR>
		       <FUCKING-CLEAR>)
		      (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ASK-ABOUT ,PROSSER ,PRSI>
		       <SETG WINNER ,PROSSER>
		       <RTRUE>)
		      (<VERB? HELLO>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?HELLO ,PROSSER>
		       <SETG WINNER ,PROSSER>
		       <RTRUE>)
		      (<AND <VERB? WHAT>
			    <PRSO? ,OBJECT-OF-GAME>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ASK-ABOUT ,PROSSER ,OBJECT-OF-GAME>
		       <SETG WINNER ,PROSSER>
		       <RTRUE>)
		      (<OR <AND <VERB? WHAT>
			        <PRSO? ,TIME>>
			   <AND <VERB? TELL-TIME>
				<PRSO? ,ME>
				<PRSI? ,TIME>>
			   <AND <VERB? WHAT-TIME>
				<PRSO? ,TIME>>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ASK-FOR ,PROSSER ,TIME>
		       <SETG WINNER ,PROSSER>
		       <RTRUE>)
		      (<AND <VERB? WHAT>
			    <PRSO? ,OBJECT-OF-GAME>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ASK-ABOUT ,PROSSER ,PRSO>
		       <SETG WINNER ,PROSSER>
		       <RTRUE>)
		      (<EQUAL? ,IDENTITY-FLAG ,FORD>
		       <COND (<OR <AND <VERB? LIE-DOWN>
				       <PRSO? ,BULLDOZER>
				       ,IN-FRONT-FLAG>
			          <AND <VERB? LIE-DOWN>
				       <PRSO? ,GROUND ,ROOMS>
				       <NOT ,HOUSE-DEMOLISHED>>
				  <AND <VERB? REPLACE>
				       <PRSO? ,ARTHUR>
				       <NOT ,HOUSE-DEMOLISHED>>>
			      <COND (,PROSSER-LYING
				     <TELL "He's already lying there!" CR>
				     <RTRUE>)>
			      <SETG PROSSER-LYING T>
			      <ENABLE <QUEUE I-ARTHUR -1>>
			      <TELL
"Prosser blinks in astonishment. \"You mean, go and lie in the mud in his
place...?\" You explain that Arthur will only move if someone else takes over
for him. Prosser shakes his head in such a manner as to suggest that he is very
weary of the world, and you tactfully forebear from mentioning that it won't be
troubling him much longer. Reluctantly, he follows you back toward Arthur.|
|
You rapidly conclude the business. Prosser lies in the mud. Arthur, bewildered,
nevertheless stands up and appears ready to follow you to the Pub." CR>)
			     (T
			      <STAND-ASIDE>
			      <FUCKING-CLEAR>)>)
			    (<AND <VERB? WHAT-ABOUT>
				  <PRSO? ,HOUSE ,HOME>
				  ,HOUSE-DEMOLISHED>
			     <TELL
"Prosser explains the local planning regulations and says, by way of
reassurance, that you will probably be rehoused within a couple of years." CR>)
			    (<AND <VERB? BLOCK>
				  <PRSO? ,BULLDOZER>
				  <RUNNING? ,I-BULLDOZER>>
			     <V-PROTEST>)
			    (T
			     <STAND-ASIDE>
			     <FUCKING-CLEAR>)>)
	       (<AND <NOT ,GONE-AROUND>
		     <EQUAL? ,IDENTITY-FLAG ,FORD>
		     <VERB? TELL HELLO ASK-FOR ASK-ABOUT TELL-ABOUT>
		     <PRSO? ,PROSSER>
		     <NOT <IN? ,FLEET ,HERE>>>
		<TELL "Prosser can't hear you from here." CR>
		<FUCKING-CLEAR>)
	       (<VERB? GIVE SHOW>
		<COND (<PRSO? ,THING>
		       <TELL
"He is much impressed and says, \"You must have the same aunt I have.\"" CR>)
		      (<PRSO? ,TOWEL>
		       <SETG TOWEL-MUDDY T>
		       <TELL
"Prosser thanks you, wipes the mud off his boots, and hands it back." CR>)
		      (<PRSO? ,GUIDE>
		       <TELL
"Prosser takes a quick look at " D ,GUIDE ", says he doesn't read that kind of
rubbish, and hands it back." CR>)
		      (<PRSO? ,SATCHEL>
		       <TELL
"Prosser says he wouldn't be seen dead with that kind of thing slung over his
shoulder." CR>)>)
	       (<AND <VERB? WALK-TO>
		     <EQUAL? ,HERE ,FRONT-OF-HOUSE>>
		<COND (<AND <EQUAL? ,IDENTITY-FLAG ,FORD>
			    <NOT ,GONE-AROUND>>
		       <PERFORM ,V?WALK-AROUND ,BULLDOZER>
		       <RTRUE>)
		      (T
		       <TELL
"You're already as close as any reasonable person would want to get." CR>)>)
	       (<AND <VERB? KILL KICK>
		     ,LYING-DOWN>
		<TELL ,WHILE-LYING CR>)
	       (<AND <VERB? KILL>
		     <PRSO? ,PROSSER>
		     ,HOUSE-DEMOLISHED>
		<TELL
"You muck up all his fancy facial work. This is the last moment of
satisfaction you will experience for some time." CR>)
	       (<AND <VERB? KILL KICK>
		     <PRSO? ,PROSSER>>
		<TELL
"He dodges, insisting that this is incorrect procedure." CR>)
	       (<AND <VERB? THROW>
		     <PRSI? ,PROSSER>>
		<MOVE ,PRSO ,HERE>
		<PERFORM ,V?KILL ,PROSSER>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<PROSSER-DESCFCN>)
	       (<AND <VERB? LISTEN>
		     <NOT <FSET? ,CONVERSATION ,INVISIBLE>>>
		<PERFORM ,V?LISTEN ,CONVERSATION>
		<RTRUE>)
	       (<AND <VERB? ASK-ABOUT>
		     <PRSI? ,OBJECT-OF-GAME>>
		<TELL
"Prosser pulls a booklet out of his back pocket. \"My game manual says that the
goal is getting this here house knocked down.\"" CR>)
	       (<AND <VERB? ASK-ABOUT>
		     <PRSI? ,DIGITAL-WATCH>>
		<PERFORM ,V?ASK-FOR ,PROSSER ,TIME>
		<RTRUE>)
	       (<AND <VERB? ASK-FOR>
		     <PRSI? ,TIME>>
		<TELL
"Prosser shakes the " D ,DIGITAL-WATCH ". \"Hasn't worked for months. I keep
wearing it only because I think " D ,DIGITAL-WATCH "es are neat.\"" CR>)>>

<ROUTINE STAND-ASIDE ()
	 <COND (,PROSSER-LYING
		<TELL "\"Leave me alone,\" Prosser whimpers miserably." CR>
		<RTRUE>)>
	 <TELL "\"Please step aside as I need to be able to ">
	 <COND (,HOUSE-DEMOLISHED
		<TELL "clear this " D ,RUBBLE " away.\"" CR>)
	       (T
		<TELL "knock ">
		<COND (<EQUAL? ,IDENTITY-FLAG ,ARTHUR>
		       <TELL "your">)
		      (T
		       <TELL "that">)>
		<TELL " house down.\"" CR>)>>

<OBJECT DIGITAL-WATCH
	(IN PROSSER)
	(DESC "digital watch")
	(SYNONYM WATCH WATCHE)
	(ADJECTIVE DIGITA)
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION DIGITAL-WATCH-F)>

<ROUTINE DIGITAL-WATCH-F ()
	 <COND (<VERB? TAKE READ>
		<PRIVATE "Prosser">)>>

<OBJECT TIME
	(IN GLOBAL-OBJECTS)
	(DESC "time")
	(SYNONYM TIME)>

<OBJECT FORD
	(IN LOCAL-GLOBALS) ;"just for the purpose of MOBY-FIND"
	(DESC "Ford Prefect")
	(DESCFCN FORD-DESCFCN)
	(SYNONYM FORD PREFEC)
	(ADJECTIVE FORD)
	(FLAGS ACTORBIT CONTBIT SEARCHBIT OPENBIT NARTICLEBIT)
	(ACTION FORD-F)>

<ROUTINE FORD-DESCFCN ("OPTIONAL" X)
	 <COND (,FORD-SLEEPING
		<TELL "Ford is in the corner, snoring loudly." CR>)
	       (T
		<TELL D ,FORD " is here." CR>)>>

<ROUTINE FORD-F ()
	 <COND (<EQUAL? ,IDENTITY-FLAG ,FORD>
		<COND (<EQUAL? ,FORD ,PRSO>
		       <PERFORM ,PRSA ,ME ,PRSI>
		       <RTRUE>)
		      (T
		       <PERFORM ,PRSA ,PRSO ,ME>
		       <RTRUE>)>)
	       (<EQUAL? ,FORD ,WINNER>
		<COND (<IN? ,FLEET ,HERE>
		       <TELL ,ABOVE-NOISE CR>
		       <FUCKING-CLEAR>)
		      (<OR <PRSI? ,HOUSE>
			   <PRSO? ,HOUSE>>
		       <TELL
"\"It's not a house, it's a home.\" (Footnote 2)" CR>
		       <FUCKING-CLEAR>)
		      (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ASK-ABOUT ,FORD ,PRSI>
		       <SETG WINNER ,FORD>
		       <RTRUE>)
		      (<VERB? HELLO>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?HELLO ,FORD>
		       <SETG WINNER ,FORD>
		       <RTRUE>)
		      (<AND <VERB? WHAT>
			    <PRSO? ,OBJECT-OF-GAME>>
		       <TELL ,ASK-ABOUT-OBJECT CR>)
		      (<AND <VERB? WHAT-ABOUT>
			    <L? ,FORD-COUNTER 2>
			    <EQUAL? ,HERE ,FRONT-OF-HOUSE>
			    <PRSO? ,HOME>>
		       <TELL "Ford">
		       <FORD-DECIDES>)
		      (<AND <VERB? WHAT-ABOUT>
			    <PRSO? ,HOME ,THIRD-PLANET>
			    ,EARTH-DEMOLISHED>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ASK-ABOUT ,FORD ,THIRD-PLANET>
		       <SETG WINNER ,FORD>
		       <RTRUE>)
		      (<NOT ,EARTH-DEMOLISHED>
		       <COND (<AND <L? ,DRUNK-LEVEL 3>
				   <EQUAL? ,HERE ,PUB>>
			      <TELL
"\"Shut up and drink your beer. You're going to need it.\"" CR>)
			     (T
			      <TELL "Ford, busy ">
			      <COND (<EQUAL? ,FORD-COUNTER 2>
				     <TELL "talking to Prosser">)
				    (T
				     <TELL "scanning the sky ">)>
			      <COND (<EQUAL? ,HERE ,PUB>
				     <TELL "through the window">)
				    (<NOT <EQUAL? ,FORD-COUNTER 2>>
				     <TELL "for something">)>
			      <TELL ", ignores you." CR>)>
		       <ENABLE <QUEUE I-FORD 2>>)
		      (T
		       <TELL "Ford seems deep in thought." CR>
		       <FUCKING-CLEAR>)>)
	       (<AND <VERB? TELL TELL-ABOUT HELLO ASK-FOR ASK-ABOUT>
		     <PRSO? ,FORD>
		     ,FORD-SLEEPING>
		<TELL "Ford is sleeping!" CR>
		<FUCKING-CLEAR>)
	       (<AND <VERB? GIVE>
		     <PRSI? ,FORD>
		     ,FORD-SLEEPING>
		<PERFORM ,V?HELLO ,FORD>
		<RTRUE>)
	       (<AND <EQUAL? ,FOLLOW-FLAG 1>
		     <NOT <IN? ,FORD ,HERE>>
		     <VERB? FOLLOW>>
		<TELL
"In a state of anxiety and confusion you follow Ford down the lane..." CR CR>
		<GOTO <LOC ,FORD>>)
	       (<AND <EQUAL? ,FOLLOW-FLAG 3>
		     <VERB? FOLLOW>>
		<DO-WALK ,P?WEST>)
	       (<AND <VERB? FOLLOW>
		     <EQUAL? ,FOLLOW-FLAG 5>>
		<DO-WALK ,P?SOUTH>)
	       (<AND <VERB? ALARM SHAKE>
		     ,FORD-SLEEPING>
		<TELL "Rather like trying to wake the dead." CR>)
	       (<AND <VERB? ASK-ABOUT>
		     <PRSI? ,OBJECT-OF-GAME>>
		<TELL ,ASK-ABOUT-OBJECT CR>)
	       (<AND <VERB? ASK-ABOUT>
		     <PRSI? ,THIRD-PLANET>>
		<TELL
"Ford explains that the Earth has been demolished. To cheer you up, he points
out that there are an awful lot of little planets like that around, and the
Earth wasn't even a particularly nice one." CR>)
	       (<AND <VERB? GIVE>
		     <PRSO? ,THUMB>
		     <IN? ,FLEET ,HERE>>
		<TELL "You can't reach him in this wind." CR>)
	       (<VERB? LISTEN>
		<COND (<NOT <FSET? ,CONVERSATION ,INVISIBLE>>
		       <PERFORM ,V?LISTEN ,CONVERSATION>
		       <RTRUE>)
		      (,FORD-SLEEPING
		       <TELL "\"Zzzzzzz...\"" CR>)>)
	       (<AND <VERB? EXAMINE>
		     ,FORD-SLEEPING>
		<TELL "He's sleeping." CR>)
	       (<AND <VERB? ASK-FOR>
		     <PRSI? ,TOWEL>
		     <EQUAL? ,FORD-COUNTER 0 1>>
		<PERFORM ,V?TAKE ,TOWEL>
		<RTRUE>)>>

<ROUTINE FORD-DECIDES ()
	 <FCLEAR ,CONVERSATION ,INVISIBLE>
	 <ENABLE <QUEUE I-FORD 2>>
	 <SETG FORD-COUNTER 2>
	 <TELL
" looks startled, then guilty. He starts to say something and stops.
He starts to say something else and stops. Suddenly he seems to see the "
D ,BULLDOZER " for the first time, stops starting to say things and starts.|
|
He seems to come to a momentous decision, says he has something of
Earth-shattering importance to tell you, and stresses the importance
of a quick drink at the Horse 'n Groom.||">
	 <BUT-THAT-MAN "you exclaim">
	 <TELL
" Ford goes off for a quiet word with Prosser. From where you're lying,
you cannot hear what's happening, although they seem deeply engrossed in "
D ,CONVERSATION "." CR>>

<GLOBAL FORD-COUNTER 0>

<GLOBAL FORD-SLEEPING <>>

<GLOBAL GUARDS-COUNTER 0>

<GLOBAL HEART-COUNTER 0>

<ROUTINE I-FORD ()
	 <ENABLE <QUEUE I-FORD -1>>
	 <COND (<IN-HEART? ,PROTAGONIST>
		<SETG HEART-COUNTER <+ ,HEART-COUNTER 1>>
		<COND (<EQUAL? ,HEART-COUNTER 1>
		       <MOVE ,FORD ,HERE>
		       <TELL CR
"\"This looks like that incredible new" ,IID " spaceship, " D ,HEART-OF-GOLD
"!\" says Ford, with growing excitement." CR CR ,ANNOUNCEMENT D ,EDDIE ". We
have just picked up two hitchhikers">
		       <FACTOR "21,914">
		       <TELL "\"" CR>)
		      (<EQUAL? ,HEART-COUNTER 2>
		       <TELL CR
"\"Come on, let's look for the Bridge.\" You follow Ford, and eventually
come to the..." CR CR>
		       <GOTO ,BRIDGE>
		       <MOVE ,FORD ,HERE>)
		      (<EQUAL? ,HEART-COUNTER 3>
		       <COND (<NOT <EQUAL? ,HERE ,BRIDGE>>
				   <RFALSE>)>
		       <TELL CR
"\"Hey, Zaphod, how ya doing?\" says Ford. He's cool. \"Not bad, Ford. Great to
see you,\" replies Zaphod. He's cooler. You suddenly realise that the woman is
Tricia MacMillan (\"Call me " D ,TRILLIAN "\"), whom you were trying to pick up
at a party in Islington just a few weeks ago, and that Zaphod is the guy she
eventually left the party with! Odd." CR>)
		      (<EQUAL? ,HEART-COUNTER 4>
		       <MOVE ,FORD ,LOCAL-GLOBALS>
		       <MOVE ,ZAPHOD ,LOCAL-GLOBALS>
		       <MOVE ,TRILLIAN ,LOCAL-GLOBALS>
		       <MOVE ,HANDBAG ,BRIDGE>
		       <MOVE ,SATCHEL ,BRIDGE>
		       <FCLEAR ,HANDBAG ,NDESCBIT>
		       <FCLEAR ,HANDBAG ,TRYTAKEBIT>
		       <DISABLE <INT I-FORD>>
		       <ENABLE <QUEUE I-MARVIN -1>>
		       <COND (<EQUAL? ,HERE ,BRIDGE>
			      <SETG FOLLOW-FLAG 3>
			      <ENABLE <QUEUE I-FOLLOW 2>>
			      <TELL CR
"\"Like my spaceship, Ford?\" Zaphod asks. \"YOUR spaceship?\" says Ford,
losing his cool for a second. \"Yeah, I stole it,\" Zaphod admits. \"I'm gonna
use it to find" ,LOST-PLANET ". Let's go sit in the sauna while I explain.\"
Zaphod, Ford, and " D ,TRILLIAN " all head off to port." CR>)
			     (T
			      <RFALSE>)>)>)
	       (<EQUAL? ,HERE ,HOLD>
		<COND (<FSET? ,CAPTAINS-QUARTERS ,TOUCHBIT>
		       <SETG GUARDS-COUNTER <+ ,GUARDS-COUNTER 1>>
		       <COND (<EQUAL? ,GUARDS-COUNTER 1>
			      <TELL CR
"The guard releases you and Ford and begins cycling the air in the
airlock. \"Hey, guard!\" shouts Ford, \"do you really enjoy this sort
of thing? Shouting, stomping around, shooting people, is it really a
fulfilling career?\"" CR>)
			     (<EQUAL? ,GUARDS-COUNTER 6>
			      <DISABLE <INT I-FORD>>
			      <MOVE ,SATCHEL ,FORD>
			      <FCLEAR ,SATCHEL ,NDESCBIT>
			      <SETG PANEL-BLOCKER <>>
			      <FSET ,HOLD ,REVISITBIT>
			      <TELL CR "The guard says, \"">
			      <COND (<HELD? ,BABEL-FISH ,PROTAGONIST>
				     <TELL
"Well, all things considered, I guess I like being a guard. Especially
the shouting. Resistance is useless!\"">)
				    (T
				     <TELL "I">
				     <PRODUCE-GIBBERISH 3>)>
			      <TELL
" He throws you and Ford into the airlock and closes the door." CR CR>
			      <GOTO ,AIRLOCK>
			      <MOVE ,FORD ,AIRLOCK>)
			     (T
			      <TELL CR
"Ford continues trying to talk the guard into a sudden career change." CR>)>)
		      (T
		       <MOVE ,GUIDE ,PROTAGONIST>
		       <DISABLE <INT I-FORD>>
		       <SETG FORD-SLEEPING T>
		       <COND (<IN? ,MINERAL-WATER ,FORD>
			      <MOVE ,MINERAL-WATER ,SATCHEL>)>
		       <COND (<IN? ,TOWEL ,FORD>
			      <MOVE ,TOWEL ,HERE>)>
		       <MOVE ,SATCHEL ,HERE>
		       <FCLEAR ,SATCHEL ,TRYTAKEBIT>
		       <TELL CR
"Ford yawns. \"Matter transference always tires me out. I'm going to take a
nap.\" He places something on top of his satchel. \"If you have any questions,
here's " ,GUIDE-NAME "\" (Footnote 14). Ford lowers his voice to a whisper.
\"I'm not supposed to tell you this, but you'll never be able to finish the
game without consulting the Guide about lots of stuff.\" As he curls up in a
corner and begins snoring, you pick up " D ,GUIDE "." CR>)>)
	       (<EQUAL? ,FORD-COUNTER 0>
		<SETG FORD-COUNTER 1>
		<TELL CR
"Ford glances uncomfortably at the sky. He offers you the towel again." CR>)
	       (<EQUAL? ,FORD-COUNTER 1>
		<TELL CR "Ford seems oblivious to your trouble, so you ask
\"Ford, what about my home?\" He">
		<FORD-DECIDES>)
	       (<EQUAL? ,FORD-COUNTER 2>
		<SETG FORD-COUNTER 3>
	        <SETG LYING-DOWN <>>
		<SETG PROSSER-LYING T>
	        <ENABLE <QUEUE I-FORD 2>>
		<FSET ,CONVERSATION ,INVISIBLE>
	        <TELL CR
"Ford and Prosser stop talking and approach you. Ford says that Prosser has
agreed to lie in your place so that the two of you can go off to the Pub.
Reluctantly, Prosser steps forward and lies down in front of the " D ,BULLDOZER
". You stand up." CR>)
	       (<EQUAL? ,FORD-COUNTER 3>
		<MOVE ,FORD ,COUNTRY-LANE>
		<SETG FORD-COUNTER 4>
		<COND (<EQUAL? ,HERE ,FRONT-OF-HOUSE>
		       <SETG FOLLOW-FLAG 1>
		       <ENABLE <QUEUE I-FOLLOW 2>>
		       <TELL
"Ford, urging you to follow, hurries toward the country lane." CR>)
		      (<EQUAL? ,HERE ,COUNTRY-LANE>
		       <TELL "Ford enters from the north." CR>)
		      (T
		       <RFALSE>)>)
	       (<AND <EQUAL? ,FORD-COUNTER 4>
		     <EQUAL? ,HERE ,COUNTRY-LANE>
		     <NOT <FSET? ,PUB ,TOUCHBIT>>>
		<SETG FORD-COUNTER 5>
		<SETG FOLLOW-FLAG 1>
		<ENABLE <QUEUE I-FOLLOW 2>>
		<MOVE ,FORD ,PUB>
		<TELL CR
"\"Come along, Arthur,\" says Ford impatiently, and enters the Pub." CR>)
	       (<AND <NOT <IN? ,FORD ,HERE>>
		     <FSET? ,PUB ,TOUCHBIT>>
		<MOVE ,FORD ,HERE>
		<TELL CR "Ford hurries after you." CR>)
	       (<L? ,DRUNK-LEVEL 3>
		<COND (<AND <PRSO? ,BEER>
			    <VERB? DRINK ENJOY>>
		       <RFALSE>)
		      (<AND <EQUAL? ,L-PRSO ,BEER>
			    <VERB? AGAIN>
			    <EQUAL? ,L-PRSA ,V?DRINK ,V?ENJOY>>
		       <RFALSE>)
		      (<NOT <EQUAL? ,HERE ,PUB>>
		       <RFALSE>)
		      (<FSET? ,BEER ,NDESCBIT>
		       <RFALSE>)>
		<TELL CR "\"Drink the beer,\" urges Ford. \"It will help">
		<CUSHION>
		<TELL "\"" CR>)
	       (T
		<RFALSE>)>>

<OBJECT SATCHEL
	(IN FORD)
	(DESC "satchel")
	(DESCFCN SATCHEL-DESCFCN)
	(SYNONYM SATCHE)
	(ADJECTIVE BATTER LEATHE BULKY)
	(FLAGS CONTBIT SEARCHBIT TAKEBIT TRYTAKEBIT)
	(CAPACITY 30)
	(SIZE 20)
	(ACTION SATCHEL-F)>

<ROUTINE SATCHEL-DESCFCN ("OPTIONAL" X)
	 <TELL "There is a satchel here">
	 <COND (<EQUAL? ,PANEL-BLOCKER ,SATCHEL>
		<TELL ", resting in front of the " D ,ROBOT-PANEL>)>
	 <TELL ".">
	 <ITEM-ON-SATCHEL-DESCRIPTION>
	 <CRLF>
	 <RTRUE>>

<ROUTINE ITEM-ON-SATCHEL-DESCRIPTION ()
	 <COND (,ITEM-ON-SATCHEL
		<TELL " Sitting on top of it is">
		<ARTICLE ,ITEM-ON-SATCHEL>
		<TELL ".">)>>

<ROUTINE SATCHEL-F ()
	 <COND (<AND <VERB? OPEN>
		     <NOT <EQUAL? ,IDENTITY-FLAG ,FORD>>>
		<PRIVATE "Ford">)
	       (<AND <VERB? PUT-ON>
		     <EQUAL? ,SATCHEL ,PRSI>>
		<COND (<HELD? ,SATCHEL>
		       <TELL "Put down the satchel first." CR>)
		      (,ITEM-ON-SATCHEL
		       <TELL "But">
		       <ARTICLE ,ITEM-ON-SATCHEL T>
		       <TELL " is already on the satchel." CR>)
		      (T
		       <SETG ITEM-ON-SATCHEL ,PRSO>
		       <MOVE ,PRSO ,HERE>
		       <FSET ,PRSO ,NDESCBIT>
		       <FSET ,PRSO ,TRYTAKEBIT>
		       <TELL "Okay,">
		       <ARTICLE ,PRSO T>
		       <TELL " is now sitting on the satchel." CR>)>)
	       (<VERB? EXAMINE>
		<TELL "The satchel, which is ">
		<COND (<FSET? ,SATCHEL ,OPENBIT>
		       <TELL "open">)
		      (T
		       <TELL "closed">)>
		<TELL ", is fairly bulky.">
		<ITEM-ON-SATCHEL-DESCRIPTION>
		<CRLF>)
	       (<AND <VERB? TAKE>
		     <IN? ,SATCHEL ,FORD>>
		<TELL
"Ford says, \"Hey, Arthur, keep " D ,HANDS "s off my satchel!\"" CR>)>>

<OBJECT SATCHEL-FLUFF
	(IN SATCHEL)
	(DESC "satchel fluff")
	(SYNONYM FLUFF LINT)
	(ADJECTIVE SATCHE)
	(FLAGS TAKEBIT NARTICLEBIT)
	(SIZE 1)
	(GENERIC POCKET-FLUFF)>

<GLOBAL FLUFF-TO-GOWN <>>

<GLOBAL TOWEL-MUDDY <>>

<GLOBAL TOWEL-OFFERED <>>

<OBJECT TOWEL
	(IN FORD)
	(DESC "towel")
        (SYNONYM TOWEL TOWELS)
	(FLAGS TAKEBIT TRYTAKEBIT)
	(SIZE 7)
	(CAPACITY 40)
	(ACTION TOWEL-F)>

<ROUTINE TOWEL-F ()
	 <COND (<AND <VERB? TAKE>
		     <FSET? ,TOWEL ,TRYTAKEBIT>
		     <EQUAL? ,HERE ,FRONT-OF-HOUSE>
		     ,LYING-DOWN>
		<FCLEAR ,TOWEL ,TRYTAKEBIT>
		<MOVE ,TOWEL ,PROTAGONIST>
		<MOVE ,FORD ,LOCAL-GLOBALS>
		<SETG FORD-GONE T>
		<SETG FOLLOW-FLAG 5>
		<ENABLE <QUEUE I-FOLLOW 2>>
		<DISABLE <INT I-FORD>>
		<TELL
"As you take it, Ford says \"Er, look, thanks for lending me the towel...
been nice knowing you... got to go now...\" He smiles oddly and walks down
the " D ,COUNTRY-LANE "." CR>)
	       (<AND <VERB? TAKE MOVE>
		     <PRSO? ,TOWEL>
		     <FSET? ,TOWEL ,SURFACEBIT>>
		<FCLEAR ,TOWEL ,TRYTAKEBIT>
		<FCLEAR ,TOWEL ,SURFACEBIT>
		<ROB ,TOWEL ,HERE>
		<FCLEAR ,TOWEL ,CONTBIT>
		<FCLEAR ,TOWEL ,OPENBIT>
		<FCLEAR ,TOWEL ,NDESCBIT>
		<COND (<VERB? MOVE>
		       <TELL "Okay, it's no longer covering the drain." CR>)
		      (T
		       <RFALSE>)>)
	       (<AND <VERB? PUT-ON TIE>
		     <PRSI? ,BEAST>>
		<TELL "The effect is decorative rather than helpful." CR>)
	       (<AND <VERB? PUT-ON TIE>
		     <PRSI? ,HEAD ,EYES>>
		<COND (<FSET? ,TOWEL ,WORNBIT>
		       <TELL "It already is." CR>)
		      (<IN? ,BEAST ,HERE>
		       <FSET ,TOWEL ,WORNBIT>
		       <MOVE ,TOWEL ,PROTAGONIST>
		       <ENABLE <QUEUE I-BEAST 11>>
		       <TELL
"The " D ,BEAST " is completely bewildered. It is so dim it thinks that
if you can't see it, it can't see you. You have a few seconds before it
realises its mistake." CR>)
		      (T
		       <TELL
"There's no need for that. It's not like there's a " D ,BEAST " around,
or something." CR>)>)
	       (<AND <FSET? ,TOWEL ,WORNBIT>
		     <VERB? TAKE-OFF REMOVE UNTIE>>
		<FCLEAR ,TOWEL ,WORNBIT>
		<TELL "You unwrap the towel from your head.">
		<COND (<FSET? ,BEAST ,MUNGEDBIT>
		       <CRLF> <CRLF>
		       <V-LOOK>
		       <RTRUE>)>
		<COND (,BEARINGS-LOST
		       <TELL " You see that you have wandered in circles">
		       <COND (<EQUAL? ,HERE ,OUTER-LAIR>
			      <TELL
" and ended right beside the " D ,MEMORIAL>)>
		       <TELL ".">)>
		<TELL
" Unfortunately, the Beast has also caught sight of you again. All this
fooling around has made it doubly angry and hungry. ">
		<BEAST-DEATH>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<COND (<FSET? ,TOWEL ,SURFACEBIT>
		       <PERFORM ,V?EXAMINE ,DRAIN>
		       <COND (<FIRST? ,TOWEL>
			      <RFALSE>)>
		       <RTRUE>)
		      (,TOWEL-MUDDY
		       <TELL "It is caked with mud." CR>)
		      (T
		       <TELL
"It's covered with little pink and blue flowers." CR>)>)
	       (<AND <VERB? LIE-DOWN>
		     <FSET? ,TOWEL ,SURFACEBIT>>
		<PERFORM ,V?STAND-BEFORE ,HOOK>
		<RTRUE>)>>

<ROOM BACK-OF-HOUSE
      (IN ROOMS)
      (SYNONYM LIST QUESTI)
      (ADJECTIVE GREAT UNANSW)
      (DESC "Back of House")
      (SE TO FRONT-OF-HOUSE)
      (SW TO FRONT-OF-HOUSE)
      (FLAGS RLANDBIT ONBIT OUTSIDEBIT)
      (GLOBAL HOUSE HOME THIRD-PLANET RUBBLE)
      (PSEUDO "TREE" TREE-PSEUDO "BIRDS" UNIMPORTANT-THING-F)
      (ACTION BACK-OF-HOUSE-F)>

<ROUTINE BACK-OF-HOUSE-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <NOT <RUNNING? ,I-VOGONS>>
 		     ,HOUSE-DEMOLISHED>
		<I-VOGONS>
		<ENABLE <QUEUE I-VOGONS 2>>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The rear garden is a pleasant place. I" ,NICE-DAY ", and it's a lovely day for
a walk. A path leads around the house to the southeast and southwest." CR>)>>

<ROUTINE TREE-PSEUDO ()
	 <COND (<VERB? CLIMB-UP CLIMB-FOO>
		<TELL "You were never very good at that." CR>)>>

<ROOM COUNTRY-LANE
      (IN ROOMS)
      (SYNONYM SPACE)
      (DESC "Country Lane")
      (NORTH TO FRONT-OF-HOUSE)
      (WEST TO PUB)
      (IN TO PUB)
      (FLAGS RLANDBIT ONBIT OUTSIDEBIT)
      (GLOBAL HOUSE HOME PUB-OBJECT BULLDOZER THIRD-PLANET)
      (PSEUDO "TREE" TREE-PSEUDO)
      (ACTION COUNTRY-LANE-F)>

<ROUTINE COUNTRY-LANE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<COND (<AND <NOT ,PROSSER-LYING>
			    <NOT ,HOUSE-DEMOLISHED>
			    <NOT <FSET? ,HOLD ,TOUCHBIT>>>
		       <SETG BULLDOZER-COUNTER 3>
		       <I-BULLDOZER>)
		      (<AND <EQUAL? ,IDENTITY-FLAG ,FORD>
			    ,HOUSE-DEMOLISHED>
		       <ENABLE <QUEUE I-DOG 1>>
		       <RFALSE>)
		      (<AND <EQUAL? ,DRUNK-LEVEL 3>
			    <EQUAL? ,IDENTITY-FLAG ,ARTHUR>>
		       <ENABLE <QUEUE I-DOG 1>>
		       <RFALSE>)
		      (<AND <FSET? ,HOLD ,TOUCHBIT>
			    <NOT <FSET? ,COUNTRY-LANE ,NDESCBIT>>>
		       <PUT ,FORD-TABLE 0 <LOC ,SATCHEL>>
		       <PUT ,FORD-TABLE 1 <LOC ,THUMB>>
		       <PUT ,FORD-TABLE 2 <LOC ,GUIDE>>
		       <PUT ,FORD-TABLE 3 <LOC ,TOWEL>>
		       <PUT ,FORD-TABLE 5 <LOC ,MINERAL-WATER>>
		       <COND (<FSET? ,THUMB ,MUNGEDBIT>
			      <PUT ,FORD-TABLE 4 T>
			      <FCLEAR ,THUMB ,MUNGEDBIT>)>
		       <FSET ,COUNTRY-LANE ,NDESCBIT>
		       <ROB ,PROTAGONIST ,MEMORIAL>
		       <MOVE ,SATCHEL ,PROTAGONIST>
		       <MOVE ,THUMB ,SATCHEL>
		       <MOVE ,GUIDE ,SATCHEL>
		       <MOVE ,TOWEL ,SATCHEL>
		       <MOVE ,MINERAL-WATER ,SATCHEL>
		       <MOVE ,ARTHUR ,FRONT-OF-HOUSE>
		       <SETG IDENTITY-FLAG ,FORD>
		       <MOVE ,FORD ,GLOBAL-OBJECTS>
		       <MOVE ,PEANUTS ,PUB>
		       <FSET ,PEANUTS ,TRYTAKEBIT>
		       <FSET ,PEANUTS ,NDESCBIT>
		       <SETG PEANUTS-BOUGHT <>>
		       <SETG DREAMING T>
		       <ENABLE <QUEUE I-VOGONS 38>>
		       <TELL
"You are hurrying up a country lane. The sky is light and clear, but you keep
glancing at it with apprehension because you know that it will shortly be torn
apart by Vogon ships, and that the hills and trees around you will just burn
up and blow away, and you hope there's time for a quick drink beforehand.|
|
You want to hitch a ride aboard the Vogon fleet, but are anxious because it's
so long since you were through a" ,BEAM "." CR CR>)>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <FSET? ,COUNTRY-LANE ,REVISITBIT>>
		<SETG DREAMING T>
		<TELL
"Suddenly a shadow passes in front of the sun. You look up. The shadow is a "
D ,FLEET ". You fumble for ">
		<JIGS-UP
"your Thumb, but before you can hitch a ride the planet is destroyed.">
		<RTRUE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL "The road runs from ">
		<COND (<EQUAL? ,IDENTITY-FLAG ,ARTHUR>
		       <TELL "your">)
		      (T
		       <TELL "Arthur's">)>
		<TELL
" home, to the north, toward the village Pub, to the west." CR>)>>

<ROUTINE I-DOG ()
	 <COND (<EQUAL? ,HERE ,WAR-CHAMBER>
		<SETG DOG-COUNTER <+ ,DOG-COUNTER 1>>
		<COND (<AND <L? ,DOG-COUNTER 13>
			    <VERB? WAIT>>
		       <RFALSE>)>
		<CRLF>
		<COND (<L? ,DOG-COUNTER 13>
		       <TELL "The fleet continues to hurtle sunwards." CR>)
		      (,DOG-FED
		       <SETG LYING-DOWN <>>
		       <TELL
"Your simple act of kindness at a moment of great personal anxiety (you fed
the dog, remember?) now brings rich rewards. " ,FLEET-PLUNGES " spots the dog
(which appears to them as a gigantic monster) cheerfully tucking into a
" D ,SANDWICH ".|
|
The Vl'Hurgs and the G'Gugvunts are moved by this simple picture of happiness,
compared with the furious savagery of their own lives. They think back to a day
when they used to relax over an odd " D ,SANDWICH " themselves, often at sunset
after a hearty day working in the fields back in Vl'Hurgon and G'Gugvia, and
decide to return and rebuild their homes in a new spirit of harmony and
cooperation.|
|
Grateful, they offer to drop you at " D ,HEART-OF-GOLD " on the way home.
After a brief 900 parsec trip, you are escorted into the Transporter Chamber
of the warship. The transporter glows, and your surroundings change..." CR CR>
		       <GOTO ,MAZE>)
		      (T
		       <TELL ,FLEET-PLUNGES>
		       <JIGS-UP 
", due to a terrible miscalculation in scale, is swallowed by a small dog.">
		       <RTRUE>)>)
	       (<EQUAL? ,IDENTITY-FLAG ,FORD>
		<MOVE ,DOG ,HERE>
		<DISABLE <INT I-DOG>>
	 	<TELL "You run up the lane after Arthur. You pass a">
	 	<COND (,DOG-FED
		       <TELL
" serene dog. Fate cannot harm him, he has dined today." CR>)
	       	      (T
		       <TELL "n irritable dog who yaps at you." CR>)>)
	       (<AND <NOT <IN? ,DOG ,HERE>>
		     <NOT <IN? ,FLEET ,HERE>>
		     <EQUAL? ,HERE ,COUNTRY-LANE>>
		<MOVE ,DOG ,HERE>
		<ENABLE <QUEUE I-DOG 2>>
	        <TELL
"You see the huge " D ,BULLDOZER " heaving itself among the cloud of brick dust
which is all that remains of " D ,HOME ". As you start up the lane, a small dog
runs up to you, yapping." CR>)
	       (<AND <NOT ,DOG-FED>
		     <IN? ,DOG ,HERE>
		     <NOT <FSET? ,DOG ,TOUCHBIT>>>
		<FSET ,DOG ,TOUCHBIT>
		<TELL
"The dog carries on yapping for a moment and then gulps uncomfortably." CR>)
	       (T
		<RFALSE>)>>

<OBJECT DOG
	(IN LOCAL-GLOBALS) ;"just for the purpose of MOBY-FIND"
	(DESC "dog")
	(SYNONYM DOG MONGRE)
	(ADJECTIVE SMALL SERENE IRRITA)
        (ACTION DOG-F)>

<ROUTINE DOG-F ()
	 <COND (<VERB? GIVE THROW>
		<COND (<PRSO? ,SANDWICH>
		       <COND (<EQUAL? ,IDENTITY-FLAG ,FORD>
			      <MOVE ,SANDWICH ,HERE>
			      <TELL
"The dog is in a bad mood and tries to bite " D ,HANDS ". The " D ,SANDWICH
" lies ignored in the roadside dust." CR>)
			     (<FSET? ,DOG ,TOUCHBIT> ;"already swallowed fleet"
			      <TELL
"The dog, which seems to have a slight case of indigestion,
ignores the " D ,SANDWICH "." CR>)
			     (T
			      <MOVE ,SANDWICH ,LOCAL-GLOBALS>
			      <SETG DOG-FED T>
			      <TELL
"The dog is deeply moved. With powerful sweeps of its tail it indicates that
it regards this " D ,SANDWICH " as one of the great " D ,SANDWICH "es. Nine
out of ten pet owners could happen by at this point expressing any preference
they pleased, but this dog would spurn both them and all their tins. This is
a dog which has met its main sandwich. It eats" ,WITH-PASSION CR>)>)
		      (<PRSO? ,PEANUTS>
		       <TELL "This is a dog, not an elephant." CR>)>)
	       (<AND <VERB? EXAMINE>
		     <NOT ,DOG-FED>>
		<TELL "The mongrel looks hungry." CR>)
	       (<VERB? RUB KICK PUSH>
		<TELL "The dog tries to bite your ">
		<COND (<VERB? KICK>
		       <TELL "foot">)
		      (T
		       <TELL "hand">)>
		<TELL "." CR>)>>

<OBJECT PUB-OBJECT
	(IN LOCAL-GLOBALS)
	(DESC "Pub")
	(SYNONYM PUB GROOM)
	(ADJECTIVE HORSE \'N)
	(ACTION PUB-OBJECT-F)>

<ROUTINE PUB-OBJECT-F ()
	 <COND (<VERB? WALK-TO THROUGH>
		<COND (<EQUAL? ,HERE ,PUB>
		       <TELL ,LOOK-AROUND CR>)
		      (<EQUAL? ,HERE ,COUNTRY-LANE>
		       <DO-WALK ,P?WEST>)
		      (T
		       <V-WALK-AROUND>)>)
	       (<VERB? EXIT LEAVE DISEMBARK>
		<COND (<EQUAL? ,HERE ,PUB>
		       <DO-WALK ,P?EAST>)
		      (T
		       <TELL ,LOOK-AROUND CR>)>)>>

<ROOM PUB
      (IN ROOMS)
      (SYNONYM ALCOHO)
      (DESC "Pub")
      (EAST TO COUNTRY-LANE)
      (OUT TO COUNTRY-LANE)
      (FLAGS RLANDBIT ONBIT OUTSIDEBIT)
      (GLOBAL PUB-OBJECT WINDOW THIRD-PLANET PUB-FURNISHINGS)
      (PSEUDO "PEOPLE" UNIMPORTANT-THING-F)
      (ACTION PUB-F)>

<ROUTINE PUB-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT ,TOWEL-OFFERED>
		     <AND <EQUAL? ,IDENTITY-FLAG ,FORD>>>
		<ENABLE <QUEUE I-UNEASY -1>>
		<RFALSE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The Pub is pleasant and cheerful and full of pleasant and cheerful people who
don't know they've got about twelve minutes to live and are therefore having a
spot of lunch. Some music is playing on an old jukebox. The exit is east." CR>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <FSET? ,BEER ,NDESCBIT>
		     <IN? ,FORD ,HERE>
		     <NOT <EQUAL? ,IDENTITY-FLAG ,FORD>>>
		<FCLEAR ,BEER ,NDESCBIT>
		<ENABLE <QUEUE I-FORD 2>>
		<SETG FORD-COUNTER 5>
		<CRLF>
		<TELL
"Ford buys " D ,BEER " and offers half to you. \"Muscle relaxant...\" he
says, impenetrably." CR>)>>

<OBJECT BAR
	(IN PUB)
	(DESC "bar")
	(SYNONYM BAR COUNTE)
	(FLAGS NDESCBIT CONTBIT SURFACEBIT OPENBIT)
	(CAPACITY 60)
	(ACTION BAR-F)>

<ROUTINE BAR-F ()
	 <COND (<VERB? LOOK-BEHIND>
		<PERFORM ,V?EXAMINE ,PUB-SHELF>
		<RTRUE>)>>

<OBJECT PUB-SHELF
	(IN PUB)
	(DESC "shelf of items")
	(LDESC
"Behind the bar is a shelf. It is full of the sort of items you find on shelves
behind bars in pubs.")
	(SYNONYM SHELF ITEMS SHELVE)
	(ACTION PUB-SHELF-F)>

<ROUTINE PUB-SHELF-F ()
	 <COND (<VERB? EXAMINE>
		<FSET ,PUB-SHELF ,NDESCBIT>
		<TELL
"On the shelf behind the bar is the usual array of bottles, glasses
and soggy beermats">
		<COND (<NOT ,PEANUTS-BOUGHT>
		       <FSET ,PEANUTS ,TAKEBIT>
		       <FSET ,PEANUTS ,TRYTAKEBIT>
		       <COND (,SANDWICH-BOUGHT
			      <TELL ", and">)
			     (T
			      <TELL ",">)>
		       <TELL " some packets of peanuts">)>
		<COND (<NOT ,SANDWICH-BOUGHT>
		       <FSET ,SANDWICH ,TAKEBIT>
		       <FSET ,SANDWICH ,TRYTAKEBIT>
		       <TELL ", and a plate of uninviting " D ,SANDWICH "es">)>
		<TELL "." CR>)>>

<OBJECT MUSIC
	(IN PUB)
	(DESC "music")
	(SYNONYM MUSIC SONG SONGS)
	(FLAGS NARTICLEBIT NDESCBIT)
	(ACTION MUSIC-F)>

<ROUTINE MUSIC-F ()
	 <COND (<VERB? LISTEN ENJOY>
		<PERFORM ,V?LISTEN ,JUKEBOX>
		<RTRUE>)>>

<OBJECT JUKEBOX
	(IN PUB)
	(DESC "jukebox")
	(SYNONYM JUKEBO BOX)
	(ADJECTIVE JUKE OLD)
	(FLAGS NDESCBIT LIGHTBIT ONBIT)
	(ACTION JUKEBOX-F)>

<ROUTINE JUKEBOX-F ()
	 <COND (<VERB? LISTEN>
		<TELL "The song is ">
		<COND (<PROB 25>
		       <TELL
"a Walker Brothers single, \"The Sun Ain't Gonna Shine Anymore.\"" CR>)
		      (<PROB 33>
		       <TELL
"\"Get Back\" by the Beatles." CR>)
		      (<PROB 50>
		       <TELL
"\"Hey Jude\" by the Beatles (Footnote 4). It's a particular favourite, and
listening to it calms you down, and cheers you up." CR>)
		      (T
		       <TELL "\"Tie a Yellow Ribbon.\"">
		       <COND (<EQUAL? ,IDENTITY-FLAG ,FORD>
			      <TELL
" You can't stand it, and are pleased to think that this is probably the
last time it will ever be heard.">)>
		       <CRLF>)>)
	       (<VERB? LAMP-OFF>
		<PRIVATE "the Pub">)>>

<OBJECT PUB-FURNISHINGS
	(IN LOCAL-GLOBALS)
	(DESC "it")
	(SYNONYM BEERMA GLASSE BOTTLE GLASS)
	(ADJECTIVE USUAL SOGGY)
	(FLAGS NDESCBIT NARTICLEBIT)
	(GENERIC MINERAL-WATER)
	(ACTION UNIMPORTANT-THING-F)>

<OBJECT BARMAN
	(IN PUB)
	(DESC "barman")
	(LDESC "There is a barman serving at the bar.")
	(SYNONYM BARMAN BARTEN)
	(FLAGS ACTORBIT)
	(ACTION BARMAN-F)>

<ROUTINE BARMAN-F ()
	 <COND (<EQUAL? ,BARMAN ,WINNER>
		<COND (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ASK-ABOUT ,BARMAN ,PRSI>
		       <SETG WINNER ,BARMAN>
		       <RTRUE>)
		      (<VERB? HELLO>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?HELLO ,BARMAN>
		       <SETG WINNER ,BARMAN>
		       <RTRUE>)
		      (<AND <VERB? GIVE>
			    <PRSO? ,ME>
			    <PRSI? ,SANDWICH ,BEER ,PEANUTS>>
		       <PERFORM ,V?BUY ,PRSI>
		       <RTRUE>)
		      (T
		       <TELL
"The barman ignores you and keeps polishing the other end of the bar." CR>)>)
	       (<AND <VERB? ASK-FOR>
		     <PRSI? ,SANDWICH ,BEER ,PEANUTS>>
		<PERFORM ,V?BUY ,PRSI>
		<RTRUE>)>>

<OBJECT BEER
	(IN PUB)
	(DESC "lots of beer")
	(SYNONYM LOTS BITTER PINT BEER)
	(FLAGS DRINKBIT NARTICLEBIT NDESCBIT)
	(ACTION BEER-F)>

<GLOBAL DRUNK-LEVEL 0>

<GLOBAL FORD-POINT 15>

<ROUTINE BEER-F ()
	 <COND (<AND <VERB? DRINK ENJOY COUNT SMELL RUB TAKE>
		     <FSET? ,BEER ,NDESCBIT>>
		<TELL "You'd better buy some first." CR>)
	       (<VERB? COUNT>
		<TELL "Lots." CR>)
	       (<VERB? TAKE>
		<TELL "Just drink it!" CR>)
	       (<EQUAL? ,IDENTITY-FLAG ,FORD>
		<COND (<VERB? BUY>
		       <COND (<NOT <FSET? ,BEER ,NDESCBIT>>
			      <TELL "You already did!" CR>
			      <RTRUE>)>
		       <FCLEAR ,BEER ,NDESCBIT>
		       <COND (<IN? ,ARTHUR ,HERE>
			      <TELL
"You order six pints of bitter -- three for you, three for Arthur. According
to " D ,GUIDE " this should">
			      <CUSHION>
			      <TELL CR CR
"As you drink the first pint, you mention to Arthur that you are from a
different planet, but it makes little impression. This surprises you, because
you thought it was the sort of thing that would interest people." CR>)
			     (T
			      <TELL
"You buy yourself three pints, which you calculate you will need to">
			      <CUSHION>
			      <TELL
" This is a tip you picked up from " D ,GUIDE "." CR>)>)
		      (<VERB? DRINK ENJOY>
		       <SETG DRUNK-LEVEL <+ ,DRUNK-LEVEL 1>>
		       <COND (<NOT <IN? ,ARTHUR ,HERE>>
			      <TELL ,DOWN-WELL>
			      <CRLF>)
			     (<EQUAL? ,DRUNK-LEVEL 1>
			      <SETG SCORE <+ ,SCORE ,FORD-POINT>>
			      <SETG FORD-POINT 0>
			      <TELL
,DOWN-WELL " At least they managed to get something right on this benighted
planet. You decide it's time to tell Arthur that the world is about to end.
You tell him. Arthur is completely unperturbed. Curious. You wonder what sort
of news it would take to disturb him." CR>)
			     (<EQUAL? ,DRUNK-LEVEL 2>
			      <TELL ,DOWN-WELL>
			      <SCENE-THROUGH-WINDOW>)
			     (T
			      <TELL "You've had enough." CR>)>)>)
	       (T
		<COND (<VERB? DRINK ENJOY>
		       <SETG SCORE <+ ,SCORE 5>>
		       <SETG DRUNK-LEVEL <+ ,DRUNK-LEVEL 1>>
		       <COND (<EQUAL? ,DRUNK-LEVEL 4>
			      <TELL
"You can hear the muffled noise of your home being demolished, and the
taste of the beer sours in your mouth." CR CR>
		              <PERFORM ,V?GET-DRUNK ,ROOMS>
			      <RTRUE>)
			     (<EQUAL? ,DRUNK-LEVEL 3>
			      <ENABLE <QUEUE I-FORD -1>>
			      <SETG HOUSE-DEMOLISHED T>
			      <SETG PROSSER-LYING <>>
			      <TELL
"There is a distant crash which Ford explains is nothing to worry about,
probably just your house being knocked down." CR>)
			     (<EQUAL? ,DRUNK-LEVEL 2>
			      <TELL
"It is really very pleasant stuff, with a very good dry, nutty flavour, some
light froth on top, and a deep colour. It is at exactly room temperature. You
reflect that the world cannot be all bad when there are such pleasures in it.|
|
Ford mentions that the world is going to end in about twelve minutes." CR>)
			     (<EQUAL? ,DRUNK-LEVEL 1>
			      <TELL
"It's very good beer, brewed by a small local company. You particularly like
its flavour, which is why you woke up feeling so wretched this morning. You
were at somebody's birthday party here in the Pub last night.|
|
You begin to relax and enjoy yourself, so when Ford mentions that he's from a
small planet in the vicinity of Betelgeuse, not from Guildford as he usually
claims, you take it in your stride, and say \"Oh yes, which part?\"" CR>)>)
		      (<VERB? BUY>
		       <COND (<FSET? ,BEER ,NDESCBIT>
			      <PERFORM ,V?BUY ,PEANUTS>
			      <RTRUE>)
			     (T
			      <TELL
D ,FORD " has already bought an enormous quantity for you!" CR>)>)>)>>

<OBJECT PEANUTS
	(IN PUB)
	(DESC "peanuts")
	(SYNONYM PACKET PEANUT NUT NUTS)
	(FLAGS TRYTAKEBIT NDESCBIT NARTICLEBIT EATBIT)
	(ACTION PEANUTS-F)>

<ROUTINE PEANUTS-F ()
	 <COND (<AND <EQUAL? ,IDENTITY-FLAG ,FORD>
		     <VERB? BUY>>
		<COND (,PEANUTS-BOUGHT
		       <TELL "You did!" CR>
		       <RTRUE>)>
		<SETG PEANUTS-BOUGHT T>
		<MOVE ,PEANUTS ,PROTAGONIST>
		<FCLEAR ,PEANUTS ,TRYTAKEBIT>
		<FCLEAR ,PEANUTS ,NDESCBIT>
		<TELL
"You buy some peanuts, which you'll need to replace protein loss from the"
,BEAM ", a tip you picked up from " D ,GUIDE "." CR>)
	       (<VERB? OPEN>
		<TELL "Just eat 'em." CR>)
	       (<AND <VERB? EAT ENJOY>
		     ,EARTH-DEMOLISHED
		     ,GROGGY>
		<SETG GROGGY <>>
		<MOVE ,PEANUTS ,PUB>
		<FSET ,PEANUTS ,TRYTAKEBIT>
		<FSET ,PEANUTS ,NDESCBIT>
		<TELL
"You feel stronger as the peanuts replace some of the protein you lost
in the" ,BEAM "." CR>)
	       (<AND <VERB? BUY>
		     <EQUAL? ,HERE ,PUB>>
		<TELL
"However much you clear your throat, wave your forefinger, or wiggle your
eyebrows, the barman pays no attention, but carries on wiping another part
of the bar." CR>)
	       (<AND <VERB? TAKE EAT>
		     <FSET? ,PEANUTS ,TRYTAKEBIT>
		     <EQUAL? ,HERE ,PUB>>
		<TELL ,HANDS-OFF CR>)>>

<OBJECT SANDWICH
	(IN PUB)
	(DESC "cheese sandwich")
	(SYNONYM PLATE SANDWI)
	(ADJECTIVE CHEESE UNINVI)
	(FLAGS NDESCBIT EATBIT TRYTAKEBIT)
	(SIZE 10)
	(ACTION SANDWICH-F)>

<ROUTINE SANDWICH-F ()
	 <COND (<AND <VERB? BUY>
		     <NOT ,SANDWICH-BOUGHT>>
	        <MOVE ,SANDWICH ,PROTAGONIST>
		<FSET ,SANDWICH ,TAKEBIT>
	        <FCLEAR ,SANDWICH ,TRYTAKEBIT>
		<FCLEAR ,SANDWICH ,NDESCBIT>
		<SETG SANDWICH-BOUGHT T>
		<TELL
"The barman gives you a " D ,SANDWICH ". The bread is like the stuff that
stereos come packed in, the cheese would be great for rubbing out spelling
mistakes, and margarine and pickle have performed an unedifying chemical
reaction to produce something that shouldn't be, but is, turquoise. Since
it is clearly unfit for human consumption you are grateful to be charged
only a pound for it." CR>)
	       (<VERB? BUY>
		<TELL "You already did." CR>)
	       (<AND <VERB? TAKE EAT ENJOY>
		     <FSET? ,SANDWICH ,TRYTAKEBIT>
		     <EQUAL? ,HERE ,PUB>>
		<TELL ,HANDS-OFF CR>)
	       (<VERB? EAT ENJOY>
		<MOVE ,SANDWICH ,LOCAL-GLOBALS>
		<SETG SCORE <- ,SCORE 30>>
		<COND (<EQUAL? ,IDENTITY-FLAG ,FORD>
		       <TELL
"You swallow with revulsion, astonished that life forms which have spent 4.6
billion years evolving cannot produce a better " D ,SANDWICH " than this." CR>)
		      (T
		       <TELL
"It is one of the least rewarding taste experiences you can recall." CR>)>)>>

<GLOBAL DOG-FED <>>

<GLOBAL PEANUTS-BOUGHT <>>

<GLOBAL SANDWICH-BOUGHT <>>

<GLOBAL VOGON-COUNTER 0>

<GLOBAL FORD-GONE <>>

<ROUTINE I-VOGONS ()
	 <ENABLE <QUEUE I-VOGONS -1>>
	 <SETG VOGON-COUNTER <+ ,VOGON-COUNTER 1>>
	 <COND (<EQUAL? ,VOGON-COUNTER 1>
		<COND (<EQUAL? ,HERE ,PUB>
			      <GO-TO-LANE>)>
		<MOVE ,FLEET ,HERE>
		<CRLF>
		<COND (<EQUAL? ,IDENTITY-FLAG ,FORD>
		       <MOVE ,ARTHUR ,HERE>
		       <TELL
"Right on schedule (according to the news you picked up last night on your
Sub-Etha Sens-O-Matic), a huge " D ,FLEET " hurtles noisily through the sky.
Time is very, very short. Storms break in the wake of the ships, the wind
whips at you and makes it difficult to stand. You grab hold of a tree." CR>)
		      (T
		       <TELL
"With a noise like a cross between Led Zeppelin's farewell concert and the
eruption of Krakatoa, a huge " D ,FLEET " flies overhead and announces that
the Earth will be demolished to make way for a new hyperspace bypass in \"two
of your Earth minutes.\"" CR>
		       <COND (<AND <IN? ,FORD ,HERE>
				   <EQUAL? ,FORD-COUNTER 0>>
			      <MOVE ,FORD ,LOCAL-GLOBALS>
			      <DISABLE <INT I-FORD>>
			      <SETG FORD-GONE T>
			      <MOVE ,TOWEL ,HERE>
			      <FCLEAR ,TOWEL ,TRYTAKEBIT>
			      <TELL CR
"Ford drops the towel and dashes away." CR>)>
		       <COND (<HELD? ,THING>
			      <MOVE ,THING ,LOCAL-GLOBALS>
			      <TELL CR "In all the turmoil, ">
			      <COND (<IN? ,THING ,GOWN>
				     <TELL
"the " D ,THING " drops out of your pocket and rolls away.">)
				    (T
				     <TELL
"you drop the " D ,THING " and it rolls away.">)>
			      <TELL
" It is the least of your worries. Anyway," ,GET-RID CR>)>)>)
	       (<EQUAL? ,VOGON-COUNTER 2>
		<CRLF>
		<TELL
"The vast yellow ships thunder across the sky, spreading waves of terror and
panic in their wake. The voice of the " D ,VOGON-CAPTAIN " slams across the
country, insisting that the planning charts and demolition orders have been
available at the local planning office in Alpha Centauri for fifty years and
it's too late to start making a fuss about it now.">
		<CRLF>
		<COND (,FORD-GONE
		       <RTRUE>)>
		<CRLF>
		<COND (<EQUAL? ,IDENTITY-FLAG ,FORD>
		       <COND (<HELD? ,THUMB ,PROTAGONIST>
			      <COND (<IN? ,THUMB ,PROTAGONIST>
				     <TELL
"The " D ,THUMB " in " D ,HANDS " begins to whine.">)
				    (T
				     <TELL
"You remove the " D ,THUMB " from your satchel.">)>
			      <TELL
" Lights pulsate across its surface. " ,THUMB-FUMBLE>
			      <MOVE ,THUMB ,HERE>
			      <SETG P-IT-OBJECT ,THUMB>)
			     (T
			      <TELL
"You wish you were holding your " D ,THUMB ".">)>
		       <TELL
" Arthur is struggling desperately towards you. The end of this planet is
now only seconds away." CR>)
		      (T
		       <MOVE ,THUMB ,HERE>
		       <SETG P-IT-OBJECT ,THUMB>
		       <TELL 
"Throughout the noise, Ford is shouting at you. He removes a small black
device from his satchel, but accidentally drops it at your feet." CR>)>)
	       (<EQUAL? ,VOGON-COUNTER 3>
		<CRLF>
		<TELL
"Fierce gales whip across the land, and thunder bangs continuously through
the air in the wake of the giant ships. ">
		<COND (<AND <EQUAL? ,IDENTITY-FLAG ,ARTHUR>
			    <NOT ,FORD-GONE>>
		       <TELL
"Ford fights to reach you, but the wind is too fierce. Further announcements
from the " D ,VOGON-CAPTAIN " make it clear that demolition will begin in
just a few seconds.|
|
Through the blinding rain, you see lights flickering on the small device." CR>)
		      (<AND <EQUAL? ,IDENTITY-FLAG ,FORD>
			    <IN? ,THUMB ,HERE>>
		       <COND (,FLUFF-TO-GOWN
			      <FSET ,COUNTRY-LANE ,REVISITBIT>)>
		       <TELL ,DRIVEN-BACK>
		       <TELL
" Fortunately, at this point, Arthur picks up the Thumb, and somehow
manages to push the right button">
		       <COND (<FSET? ,THUMB ,MUNGEDBIT>
			      <TELL ". Unfortunately, the" ,THUMB-CLICKS>
			      <SETG VOGON-COUNTER 4>
			      <TELL " ">
			      <I-VOGONS>
			      <RTRUE>)
			     (T
			      <TELL "." CR CR>
			      <JIGS-UP
"However often you do it, you are still stunned by the shock of
dematerialisation. The scene around is ripped away like a flimsy backcloth.">
			      <RTRUE>)>)
		      (T
		       <CRLF>)>)
	       (<EQUAL? ,VOGON-COUNTER 5>
		<TELL "The Earth is destroyed by the " D ,FLEET>
		<COND (,FLUFF-TO-GOWN
		       <FSET ,COUNTRY-LANE ,REVISITBIT>)>
		<JIGS-UP ".">
		<RTRUE>)>>

<ROUTINE GO-TO-LANE ()
	 <SETG LYING-DOWN <>>
	 <TELL CR "You hear sounds of panic from the street. You ">
	 <COND (<AND <EQUAL? ,IDENTITY-FLAG ,FORD>
		     <NOT <IN? ,ARTHUR ,HERE>>>
		<TELL "leave the Pub and run into Arthur..." CR CR>)
	       (T
		<COND (<EQUAL? ,IDENTITY-FLAG ,FORD>
		       <TELL "and Arthur">)
		      (T
		       <TELL "and Ford">)>
		<TELL " rush outside..." CR CR>)>
	 <GOTO ,COUNTRY-LANE>
	 <COND (<EQUAL? ,IDENTITY-FLAG ,FORD>
		<MOVE ,ARTHUR ,COUNTRY-LANE>)
	       (T
		<MOVE ,FORD ,COUNTRY-LANE>)>>

<GLOBAL FORD-TABLE
	<TABLE 0 0 0 0 0>>

<OBJECT FLEET
	(IN LOCAL-GLOBALS) ;"just for the purpose of MOBY-FIND"
	(DESC "fleet of Vogon Constructor ships")
	(SYNONYM FLEET SHIP SHIPS SPACES)
	(ADJECTIVE VOGON CONSTR HUGE UGLY YELLOW)
	(FLAGS NDESCBIT)
	(ACTION FLEET-F)>

<ROUTINE FLEET-F ()
	 <COND (<VERB? ENJOY>
		<TELL ,ZEN CR>)
	       (<VERB? WALK-TO THROUGH>
		<SETG AWAITING-REPLY 11>
		<ENABLE <QUEUE I-REPLY 2>>
		<TELL "From here?" CR>)
	       (<AND <VERB? EXAMINE>
		     <NOT <EQUAL? ,HERE ,HOLD ,AIRLOCK ,CAPTAINS-QUARTERS>>>
		<TELL
"The fleet consists of terrifying numbers of huge, ugly, yellow ships, all
scarred with the results of many such past demolition jobs. Chicago's John
Hancock tower, knocked about a bit and painted yellow, is what they each look
like. That is, knocked about a bit, painted yellow, and flying." CR>)>>

<GLOBAL EARTH-DEMOLISHED <>>

<ROUTINE LEAVE-EARTH ()
	 <DISABLE <INT I-HOUSEWRECK>>
	 <DISABLE <INT I-BULLDOZER>>
	 <DISABLE <INT I-PROSSER>>
	 <DISABLE <INT I-FORD>>
	 <DISABLE <INT I-VOGONS>>
	 <SETG HEADACHE <>>
	 <SETG BULLDOZER-COUNTER 0>
	 <SETG PROSSER-COUNTER 0>
	 <SETG PROSSER-LYING <>>
	 <SETG FORD-COUNTER 0>
	 <SETG DRUNK-LEVEL 0>
	 <SETG HOUSE-DEMOLISHED <>>
	 <SETG VOGON-COUNTER 0>
	 <SETG EARTH-DEMOLISHED T>
	 <SETG IDENTITY-FLAG ,ARTHUR>
	 <MOVE ,ARTHUR ,GLOBAL-OBJECTS>
	 <MOVE ,DOG ,LOCAL-GLOBALS>
	 <MOVE ,FLEET ,LOCAL-GLOBALS>
	 <MOVE ,FORD ,LOCAL-GLOBALS>
	 <COND (<AND <NOT <HELD? ,SANDWICH>>
		     ,SANDWICH-BOUGHT>
		<MOVE ,SANDWICH ,LOCAL-GLOBALS>)>
	 <FSET ,BEER ,NDESCBIT>
	 <FCLEAR ,PROSSER ,TOUCHBIT>
	 <FCLEAR ,FRONT-OF-HOUSE ,NDESCBIT>
	 <FCLEAR ,FRONT-OF-HOUSE ,TOUCHBIT>
	 <FCLEAR ,COUNTRY-LANE ,TOUCHBIT>>

;"second time around"

<OBJECT ARTHUR
	(IN LOCAL-GLOBALS) ;"just for the purpose of MOBY-FIND"
	(DESC "Arthur Dent")
	(LDESC "Arthur Dent is here.")
	(SYNONYM ARTHUR DENT)
	(ADJECTIVE ARTHUR)
	(FLAGS NARTICLEBIT VOWELBIT ACTORBIT)
	(ACTION ARTHUR-F)>

<ROUTINE ARTHUR-F ()
	 <COND (<EQUAL? ,IDENTITY-FLAG ,ARTHUR>
		<COND (<EQUAL? ,ARTHUR ,PRSO>
		       <PERFORM ,PRSA ,ME ,PRSI>
		       <RTRUE>)
		      (T
		       <PERFORM ,PRSA ,PRSO ,ME>
		       <RTRUE>)>)
	       (<EQUAL? ,ARTHUR ,WINNER>
		<COND (<IN? ,FLEET ,HERE>
		       <TELL ,ABOVE-NOISE CR>)
		      (<AND <VERB? FOLLOW>
			    <EQUAL? ,HERE ,FRONT-OF-HOUSE>
			    <PRSO? ,ME>>
		       <COND (,PROSSER-LYING
			      <TELL "Arthur seems willing to do so." CR>)
			     (T
			      <BUT-THAT-MAN "Arthur exclaims">
			      <CRLF>)>)
		      (<AND <VERB? DRINK>
			    <PRSO? ,BEER>>
		       <COND (<FSET? ,BEER ,NDESCBIT>
			      <SETG WINNER ,PROTAGONIST>
			      <PERFORM ,V?DRINK ,BEER>
			      <SETG WINNER ,ARTHUR>
			      <RTRUE>)
			     (T
			      <TELL
"Arthur seems to be waiting to follow your lead." CR>)>)
		      (T
		       <TELL "Arthur looks too confused to respond." CR>)>
		<FUCKING-CLEAR>)
	       (<AND <VERB? HELLO TELL ASK-FOR ASK-ABOUT TELL-ABOUT>
		     <EQUAL? ,IDENTITY-FLAG ,TRILLIAN>
		     <PRSO? ,ARTHUR>>
		<COND (,FLUFF-REMOVED
		       <I-ARTHUR>)
		      (T
		       <TELL
"You approach Arthur. He seems to find your tone a little cool, smiles
unhappily, and wanders to the other end of the room." CR>)>
		<ENABLE <QUEUE I-ARTHUR 2>>
		<FUCKING-CLEAR>)
	       (<AND <VERB? TELL-ABOUT ASK-ABOUT ASK-FOR>
		     <PRSO? ,ARTHUR>
		     <EQUAL? ,IDENTITY-FLAG ,TRILLIAN>>
		<PERFORM ,V?HELLO ,ARTHUR>
		<RTRUE>)
	       (<AND <VERB? CARVE>
		     <PRSI? ,MEMORIAL>>
		<PERFORM ,V?CARVE ,YOUR-NAME ,MEMORIAL>
		<RTRUE>)
	       (<AND <VERB? GIVE>
		     <PRSO? ,TOWEL>
		     <EQUAL? ,HERE ,FRONT-OF-HOUSE>
		     <NOT ,TOWEL-OFFERED>>
		<SETG TOWEL-OFFERED T>
	        <TELL
"Inexplicably, Arthur takes no notice of the towel which, magnificently, you
are trying to return to him. Instead, he says, \"Ford, what about my home?\"|
|
You start guiltily. Does he actually KNOW that the Earth is about to be
destroyed? You start to ask him, then stop. If he knows, what the Zark is he
doing lying here in the mud in front of...|
|
You look around. You notice the " D ,BULLDOZER " properly for the first time.
You notice Arthur's house. You notice the workmen. The penny drops. His HOUSE
is about to be demolished. You feel like a complete...what's the word?">
		<COND (<IDIOT?>
		       <TELL
"Thank you. An idiot is exactly what you feel like.">)
		      (T
		       <TELL
"No, actually, \"idiot\" was the word I was looking for.">)>
		<TELL CR CR
"In a reckless moment you go completely mad and decide that you ought to take
Arthur with you. You try to tell Arthur about the importance of getting a
drink, but he's rambling on about a man called Prosser." CR>
		<RFATAL>)
	       (<AND <PRSO? ,SANDWICH>
		     <VERB? GIVE>>
		<MOVE ,SANDWICH ,ARTHUR>
		<TELL
"Arthur takes it, sniffs it suspiciously, and wisely decides that it's
safer in his pocket than in his stomach." CR>)
	       (<AND <VERB? GIVE>
		     <PRSO? ,SATCHEL-FLUFF>>
		<COND (,HOUSE-DEMOLISHED
		       <MOVE ,SATCHEL-FLUFF ,LOCAL-GLOBALS>
		       <SETG FLUFF-TO-GOWN T>
		       <TELL
"Arthur hiccups, takes the fluff, and sticks it in his pocket." CR>)
		      (T
		       <TELL
"Arthur blinks several times, but doesn't take the fluff. Perhaps if he
had a few drinks in him..." CR>)>)
	       (<AND <VERB? EXAMINE>
		     <EQUAL? ,IDENTITY-FLAG ,TRILLIAN>>
		<TELL
"Arthur seems nice and well meaning, but also terribly shy.">
		<COND (<NOT ,FLUFF-REMOVED>
		       <MOVE ,JACKET-FLUFF ,HERE>
		       <ENABLE <QUEUE I-ARTHUR -1>>
		       <TELL
" He has tried to start a " D ,CONVERSATION " with you several times, but still
hasn't gotten past \"Hello.\" He has an enormous, unsightly ball of fluff
on his jacket.">)>
		<CRLF>)
	       (<AND <VERB? FOLLOW>
		     <EQUAL? ,FOLLOW-FLAG 4>>
		<DO-WALK ,P?EAST>)
	       (<AND <VERB? PICK-UP>
		     <EQUAL? ,IDENTITY-FLAG ,TRILLIAN>>
		<PERFORM ,V?PICK-UP ,ZAPHOD>
		<RTRUE>)
	       (<AND <VERB? LISTEN>
		     <EQUAL? ,IDENTITY-FLAG ,TRILLIAN>
		     ,FLUFF-REMOVED>
		<TELL "Unfortunately, you seem to have no choice." CR>)>> 

<ROUTINE IDIOT? ()
	 <CRLF> <CRLF>
	 <PRINTI ">">
	 <READ ,P-INBUF ,P-LEXV>
	 <COND (<EQUAL? <GET ,P-LEXV 1> ,W?IDIOT>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<GLOBAL UNEASY-COUNTER 0>

<GLOBAL IDENTITY-FLAG <>>

<ROUTINE I-UNEASY ()
	 <SETG UNEASY-COUNTER <+ ,UNEASY-COUNTER 1>>
	 <COND (<NOT <EQUAL? ,HERE ,PUB>>
		<DISABLE <INT I-UNEASY>>
		<RFALSE>)>
	 <CRLF>
	 <COND (<EQUAL? ,UNEASY-COUNTER 1>
		<TELL "You feel uneasy about something." CR>)
	       (<EQUAL? ,UNEASY-COUNTER 2 3 4>
		<TELL "You still feel uneasy." CR>)
	       (T
		<TELL
"The sense of uneasiness you've been so busy ignoring now utterly engulfs you,
as you realise that you've broken the fundamental rule of time travel: \"Do as
you would have done by.\" The rational foundation of the Universe crashes and
within a few seconds the whole of creation ceases ever to have exis" CR CR CR>
		<QUIT>)>>

<ROUTINE I-ARTHUR ()
	 <ENABLE <QUEUE I-ARTHUR -1>>
	 <COND (<EQUAL? ,IDENTITY-FLAG ,TRILLIAN>
		<COND (,FLUFF-REMOVED
		       <CRLF>
		       <COND (<NOT <IN? ,ARTHUR ,HERE>>
			      <MOVE ,ARTHUR ,HERE>
			      <TELL
"Arthur follows you like an eager puppy." CR>)
			     (T
			      <TELL
"Arthur tries, unsuccessfully, to interest you by talking about "
<PICK-ONE ,BORES> CR>)>)
		      (<PROB 20>
		       <MOVE ,ARTHUR ,HERE>
		       <MOVE ,JACKET-FLUFF ,HERE>
		       <TELL CR
"Arthur walks up and says \"Hello, again.\" He looks shy, embarrassed and stuck
for anything else to say, and quickly walks to the other end of the room." CR>)
		      (T
		       <RFALSE>)>)
	       (<IN? ,ARTHUR ,HERE>
		<RFALSE>)
	       (T
		<MOVE ,ARTHUR ,HERE>
		<TELL "Arthur follows you." CR>)>>

<GLOBAL BORES
	<PLTABLE
"newts he has known."
"cricket."
"how badly Americans make tea."
"the deteriorating condition of the motorways."
"a recent visit to Tiverton."
"a new book by Douglas Adams."
"computers.">>

<ROUTINE SCENE-THROUGH-WINDOW ()
	 <MOVE ,ARTHUR ,FRONT-OF-HOUSE>
	 <DISABLE <INT I-ARTHUR>>
	 <SETG HOUSE-DEMOLISHED T>
	 <SETG PROSSER-LYING <>>
	 <SETG FOLLOW-FLAG 4>
	 <ENABLE <QUEUE I-FOLLOW 2>>
	 <TELL
" You hear a muffled crash. It's probably Arthur's little house getting knocked
down, which you tell him. This DOES upset him, and he tears out the door.|
|
Through the window, you see him running up the lane. A small dog chases after
him, yapping, ">
	 <COND (<OR ,DOG-FED
		    <IN? ,SANDWICH ,ARTHUR>>
		<SETG DOG-FED T>
		<TELL "and he throws it a " D ,SANDWICH
". The dog devours the sandwich" ,WITH-PASSION CR>)
	       (T
		<TELL "but he ignores it. The dog gulps uncomfortably." CR>)>>