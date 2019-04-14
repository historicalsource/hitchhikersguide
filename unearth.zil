"UNEARTH for
		  THE HITCHHIKER'S GUIDE TO THE GALAXY
	(c) Copyright 1984 Infocom, Inc.  All Rights Reserved."

;"Traal stuff"

<OBJECT LAIR-OBJECT
	(IN LOCAL-GLOBALS)
	(DESC "lair")
	(SYNONYM LAIR COURTY YARD)
	(ADJECTIVE COURT INNER OUTER)
	(ACTION LAIR-OBJECT-F)>

<ROUTINE LAIR-OBJECT-F ()
	 <COND (<VERB? LEAVE EXIT DISEMBARK THROUGH BOARD WALK-TO>
		<V-WALK-AROUND>)>>

<ROOM LAIR
      (IN ROOMS)
      (DESC "Lair")
      (EAST TO OUTER-LAIR)
      (SW PER INNER-LAIR-ENTER-F)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL LAIR-OBJECT)
      (ACTION LAIR-F)>

<ROUTINE INNER-LAIR-ENTER-F ()
	 <COND (<FSET? ,BEAST ,MUNGEDBIT>
		,INNER-LAIR)
	       (T
		<TELL "The Beast blocks the exit." CR>
		<RFALSE>)>>

<ROUTINE LAIR-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "This is the lair of the " D ,BEAST
". There are exits east and southwest." CR>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <NOT <FSET? ,LAIR ,NDESCBIT>>>
		<SETG DREAMING T>
		<FSET ,LAIR ,NDESCBIT>
		<FCLEAR ,SARCASTIC-NAME ,INVISIBLE>
		<FCLEAR ,BEAST-NAME ,INVISIBLE>
		<ENABLE <QUEUE I-BEAST 2>>
		<CRLF>
		<TELL
"The Beast whips its evil-smelling tail away from your nose and bellows a
brain-shattering roar. By suddenly popping out of nowhere you have disturbed
its train of thought. However, ">
		<COND (<FSET? ,LAIR ,REVISITBIT>
		       <TELL
"the Beast is beginning to get used to this sort of thing, shrugs it off,
and sinks ten or so of" ,CLAWS>
		       <JIGS-UP " into you.">
		       <RTRUE>)
		      (T
		       <TELL
"since its train of thought was the usual one, and in fact the only one it
knows, which goes like this \"hungry ... hungry ... hungry ... hungry ...
bad-tempered ... hungry ...\", it soon starts to chug along again." CR CR
,BEAST-DESC " It advances on you, and roars out a demand that you say your
name." CR>)>)>>

<GLOBAL NAME-TOLD <>>

<GLOBAL BEARINGS-LOST <>>

<GLOBAL BEAST-COUNTER 0>

<ROOM OUTER-LAIR
      (IN ROOMS)
      (DESC "Beast's Outer Lair")
      (WEST TO LAIR)
      (FLAGS RLANDBIT ONBIT OUTSIDEBIT)
      (PSEUDO "BONE" UNIMPORTANT-THING-F "BONES" UNIMPORTANT-THING-F)
      (GLOBAL LAIR-OBJECT)
      (ACTION OUTER-LAIR-F)>

<ROUTINE OUTER-LAIR-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a large walled courtyard. Strewn about are a profusion of gnawed bones
bleaching in the sun. In case the significance of these fails to strike you,
there is also a " D ,MEMORIAL " in the middle of the courtyard, on which the
Beast has roughly carved the names of all its victims.">
		<COND (<IN? ,STONE ,HERE>
		       <TELL CR
"Some " D ,STONE "s lie near the exit to the west.">)>
		<CRLF>)>>

<OBJECT MEMORIAL
	(IN OUTER-LAIR)
	(DESC "sandstone memorial")
	(SYNONYM MEMORI LIST REMEMB MONUME)
	(ADJECTIVE SANDST)
	(FLAGS NDESCBIT READBIT)
	(ACTION MEMORIAL-F)>

<ROUTINE MEMORIAL-F ()
	 <COND (<AND <VERB? CARVE>
		     <EQUAL? ,MEMORIAL ,PRSI>>
		<COND (<FSET? ,BEAST ,MUNGEDBIT>
		       <V-DIG>)
		      (<PRSO? ,NAME>
		       <TELL
"Whose name? The " D ,BEAST-NAME "? Your aunt's name? One of the Infinite
Unknowable names of Buddha? How about the name of Fred who runs (or rather
ran) your local chip shop? At least that's a short name -- you might have
time to write it before the Beast eats you." CR>)
		      (<PRSO? ,SARCASTIC-NAME>
		       <TELL
"Concentrate. Learn to distinguish between genuinely helpful suggestions
and mere sarcasm." CR>)
		      (<NOT <FSET? ,TOWEL ,WORNBIT>>
		       <ENABLE <QUEUE I-BEAST 2>>
		       <TELL
"Before you even chip the first letter, the Beast sees you and hurls you
spinning away with a bellow of rage." ,GETTING-CLOSE CR>)
		      (,BEARINGS-LOST
		       <TELL
"You cannot see and have lost your bearings. You stumble hopelessly and begin
to arouse the Beast's suspicions. It's stupid but not THAT stupid." CR>)
		      (<PRSO? ,YOUR-NAME ,ARTHUR ,ME>
		       <COND (<FSET? ,BEAST ,MUNGEDBIT>
			      <TELL "You already did that!" CR>
			      <RTRUE>)>
		       <TELL
"You chip away with the stone. It's not your best writing, what with
your mounting sense of panic and a towel wrapped around your head.
However, it suffices..." CR CR ,JUST-AS>
		       <COND (,NAME-TOLD
			      <FSET ,BEAST ,MUNGEDBIT>
			      <ENABLE <QUEUE I-BEAST 9>>
			      <TELL
"suddenly sees your name freshly carved on its memorial of remembrance.
Mystery solved. It realises it must have already eaten you in a fit of
absent-mindedness. (Its mind is very very small and quite frequently absent.)
It decides to give up the rest of its afternoon to the twin arts of
digestion and contemplation. It settles down for a snooze." CR>)
			     (T
			      <TELL
"sees \"" D ,ARTHUR "\" freshly carved on the " D ,MEMORIAL ". This
doesn't ring any bells with the Beast. It roars with fury, and eyes
the thing it can't see because it's got a towel on its head (i.e. you)
with deepening suspicion." CR>)>)
		      (T
		       <TELL ,JUST-AS "suddenly sees ">
		       <COND (<PRSO? ,BEAST ,BEAST-NAME>
			      <TELL "its own name">)
			     (T
			      <TELL "\"" D ,PRSO "\"">)>
		       <TELL
" freshly carved on the " D, MEMORIAL ". This disconcerts it, as it has
no recollection of eating ">
		       <COND (<PRSO? ,BEAST ,BEAST-NAME>
			      <TELL "itself">)
			     (T
			      <TELL "anyone by that name">)>
		       <TELL "." ,SLOWLY-DAWNS CR>)>)
	       (<VERB? READ>
		<TELL
"Gleb Snardfitz, Bibs Trench, Zeke Fitzberry, Elmo Smith, ">
		<COND (<FSET? ,BEAST ,MUNGEDBIT>
		       <TELL D ,ARTHUR ", ">)>
		<TELL
"Brian \"Spike\" Berkowitz, Clybert Quackentotter..." CR>)
	       (<VERB? EXAMINE>
		<TELL
"There are countless names carved on the " D ,MEMORIAL ":" CR>
		<PERFORM ,V?READ ,MEMORIAL>
		<RTRUE>)>>

<OBJECT STONE
	(IN OUTER-LAIR)
	(DESC "sharp stone")
	(SYNONYM STONE STONES ROCK ROCKS)
	(ADJECTIVE SHARP)
	(FLAGS NDESCBIT TAKEBIT TRYTAKEBIT)
	(SIZE 20)
	(ACTION STONE-F)>

<ROUTINE STONE-F ()
	 <COND (<AND <VERB? TAKE>
		     <FSET? ,STONE ,TRYTAKEBIT>>
		<FCLEAR ,STONE ,NDESCBIT>
		<FCLEAR ,STONE ,TRYTAKEBIT>
		<RFALSE>)
	       (<AND <VERB? DROP>
		     <EQUAL? ,HERE ,OUTER-LAIR>>
		<FSET ,STONE ,NDESCBIT>
		<FSET ,STONE ,TRYTAKEBIT>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL "It's hard as a rock." CR>)>>

<OBJECT BEAST
	(IN LAIR)
	(DESC "Ravenous Bugblatter Beast of Traal")
	(DESCFCN BEAST-DESCFCN)
	(SYNONYM BEAST TRAAL)
	(ADJECTIVE RAVENO BUGBLA BEAST)
	(FLAGS ACTORBIT)
	(ACTION BEAST-F)>

<ROUTINE BEAST-DESCFCN ("OPTIONAL" X)
	 <COND (<FSET? ,BEAST ,MUNGEDBIT>
		<TELL
"The Beast is in the corner, sleeping peacefully (Footnote 5)." CR>)
	       (T
		<TELL
"The " D ,BEAST " is here, looking particularly nasty and hungry." CR>)>>

<ROUTINE BEAST-F ()
	 <COND (<EQUAL? ,BEAST ,WINNER>
		<COND (<FSET? ,TOWEL ,WORNBIT>
		       <V-SAY>)
		      (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ASK-ABOUT ,BEAST ,PRSI>
		       <SETG WINNER ,BEAST>
		       <RTRUE>)
		      (<VERB? HELLO>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?HELLO ,BEAST>
		       <SETG WINNER ,BEAST>
		       <RTRUE>)
		      (<AND <VERB? WHAT>
			    <PRSO? ,OBJECT-OF-GAME>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ASK-ABOUT ,BEAST ,OBJECT-OF-GAME>
		       <SETG WINNER ,BEAST>
		       <RTRUE>)
		      (<AND <NOT ,NAME-TOLD>
			    <VERB? MY-NAME>
			    <PRSO? ,NAME>>
		       <COND (<PRSI? ,ARTHUR>
			      <SETG WINNER ,PROTAGONIST>
			      <PERFORM ,V?SAY-NAME ,YOUR-NAME>
			      <SETG WINNER ,BEAST>
			      <RTRUE>)
			     (T
			      <SETG WINNER ,PROTAGONIST>
			      <PERFORM ,V?SAY-NAME ,BEAST-NAME>
			      <SETG WINNER ,BEAST>
			      <RTRUE>)>)
		      (<AND <NOT ,NAME-TOLD>
			    <VERB? I-AM>>
		       <COND (<PRSO? ,ARTHUR>
			      <SETG WINNER ,PROTAGONIST>
			      <PERFORM ,V?SAY-NAME ,YOUR-NAME>
			      <SETG WINNER ,BEAST>
			      <RTRUE>)
			     (T
			      <SETG WINNER ,PROTAGONIST>
			      <PERFORM ,V?SAY-NAME ,BEAST-NAME>
			      <SETG WINNER ,BEAST>
			      <RTRUE>)>)
		      (T
		       <TELL "The Beast just roars at you." CR>
		       <FUCKING-CLEAR>)>)
	       (<AND <VERB? TELL HELLO ASK-ABOUT ASK-FOR TELL-ABOUT>
		     <PRSO? ,BEAST>>
		<COND (<FSET? ,BEAST ,MUNGEDBIT>
		       <TELL "The Beast is sleeping!" CR>
		       <FUCKING-CLEAR>)
		      (<FSET? ,TOWEL ,WORNBIT>
		       <SAID-WITH-TOWEL>
		       <FUCKING-CLEAR>)>)
	       (<AND <VERB? TELL-TIME>
		     <PRSI? ,YOUR-NAME>>
		<PERFORM ,V?SAY-NAME ,YOUR-NAME>
		<RTRUE>)
	       (<AND <VERB? TELL-NAME>
		     <PRSO? ,YOUR-NAME>>
		<PERFORM ,V?SAY-NAME ,YOUR-NAME>
		<RTRUE>)
	       (<AND <VERB? SHOW GIVE>
		     <EQUAL? ,THING ,PRSO>>
		<ENABLE <QUEUE I-BEAST 2>>
		<TELL
"The Beast stops in its tracks, deeply impressed, and compliments you on the
quality of your aunts, and complains that all its aunts are complete horrors.
It then continues its dreadful attack." CR>)
	       (<AND <VERB? THROW>
		     <PRSI? ,BEAST>
		     <NOT <IDROP>>>
		<MOVE ,PRSO ,HERE>
		<PERFORM ,V?KILL ,BEAST>
		<RTRUE>)
	       (<AND <VERB? KILL>
		     <PRSO? ,BEAST>>
		<COND (<FSET? ,BEAST ,MUNGEDBIT>
		       <PERFORM ,V?ALARM ,BEAST>
		       <RTRUE>)>
		<ENABLE <QUEUE I-BEAST 2>>
		<TELL "A footling effort. The shock waves of the Beast's
laughter push you back." CR>)
	       (<AND <VERB? ALARM>
		     <FSET? ,BEAST ,MUNGEDBIT>>
		<TELL "The Beast casually brushes you away with one of" ,CLAWS>
		<JIGS-UP ".">
		<RTRUE>)
	       (<AND <VERB? ASK-ABOUT>
		     <PRSI? ,OBJECT-OF-GAME>>
		<TELL
"\"Eat. Carve name on memorial. Sleep. Eat more. Roar a lot. Stuff like
that.\"" CR>)
	       (<VERB? EXAMINE>
		<TELL ,BEAST-DESC CR>)>>

<ROUTINE I-BEAST ()
	 <ENABLE <QUEUE I-BEAST -1>>
	 <CRLF>
	 <COND (<FSET? ,BEAST ,MUNGEDBIT>
		<MOVE ,CHIPPER ,PROTAGONIST>
		<FCLEAR ,LAIR ,NDESCBIT>
		<FSET ,LAIR ,REVISITBIT>
		<JIGS-UP
"Suddenly a team of Fronurbdian Beasthunters charges in, intent on catching
the Beast for their zoo. Mistaking you for the Beast, they fire stun guns at
you, wrap you in nets, and install you in a lovely little lair in the
Fronurbdi National Zoo.|
|
Three months later the error is discovered, but while your damage suit is
pending in the Fronurbdian courts the planet is invaded by Bureaucratic Pirates
from Pallidon IV. Impressed into bondage for a 16-year filing and sorting
mission on the so-called \"basement world\" of Sporla in the Lesser Magellanic
Cloud, you escape with the help of a tribe of nomadic asteroid painters.|
|
You develop a unique talent for asteroid painting, gaining considerable fame
throughout the Cloud. A nickel-ore deluxe is commissioned by His Royal Gorpness
Orbjfelk, the ruler of the Nine Hundred Worlds of Gorp, but while working on
this new masterpiece your asteroid slips into a small passing black hole.">
		<RTRUE>)
	       (<FSET? ,TOWEL ,WORNBIT>
		<TELL
"The Beast still thinks it can't see you, but it's so irritated at having
an invisible object stumble around its lair that it swipes out angrily
with one of" ,CLAWS>
		<JIGS-UP
" and life in the Universe has to carry on without you.">
		<RTRUE>)
	       (<NOT <IN? ,BEAST ,HERE>>
		<MOVE ,BEAST ,HERE>
		<MOVE ,NAME ,HERE>
		<SETG BEAST-COUNTER 0>
		<TELL "Bellowing with rage, the Beast charges after you." CR>)
	       (T
		<SETG BEAST-COUNTER <+ ,BEAST-COUNTER 1>>
		<COND (<EQUAL? ,BEAST-COUNTER 1>
		       <TELL
"With a headsplitting roar, the " D ,BEAST " charges towards you." CR>)
		      (<AND <EQUAL? ,BEAST-COUNTER 2>
			    <NOT ,NAME-TOLD>>
		       <TELL
"The Beast, sharpening" ,CLAWS ", demands again that you say your name." CR>)
		      (<G? ,BEAST-COUNTER 4>
		       <BEAST-DEATH>)
		      (T
		       <TELL "The Beast is nearly upon you." CR>)>)>>

<ROUTINE BEAST-DEATH ()
	 <TELL
"With a vast savage roar, the Beast tears you limb from limb with" ,CLAWS>
	 <JIGS-UP " and ... well, do you really want to know the rest?
The point is that you have died.">
	 <RTRUE>>

<OBJECT NAME ;"for things like MY NAME IS..."
	(IN BEDROOM)
	(DESC "name")
	(SYNONYM NAME)
	(FLAGS NDESCBIT)>

<OBJECT SARCASTIC-NAME
	(IN GLOBAL-OBJECTS)
	(DESC "other name")
	(SYNONYM NAME BUDDHA AUNT FRED)
	(ADJECTIVE AUNT\'S FRED\'S BUDDHA)
	(FLAGS VOWELBIT INVISIBLE)>

<OBJECT YOUR-NAME
	(IN GLOBAL-OBJECTS)
	(DESC "your name")
	(SYNONYM NAME)
	(ADJECTIVE YOUR MY ARTHUR)
	(FLAGS NARTICLEBIT)
	(ACTION YOUR-NAME-F)>

<ROUTINE YOUR-NAME-F ()
	 <COND (<VERB? WHAT>
		<PERFORM ,V?WHO ,ME>
		<RTRUE>)
	       (<AND <EQUAL? ,HERE ,OUTER-LAIR>
		     <FSET? ,BEAST ,MUNGEDBIT>>
		<RFALSE>)
	       (<VERB? EXAMINE RUB MOVE>
		<TELL "Huh?" CR>)>>

<OBJECT BEAST-NAME
	(IN GLOBAL-OBJECTS)
	(DESC "Beast's name")
	(SYNONYM NAME)
	(ADJECTIVE BEAST)
	(FLAG NARTICLEBIT INVISIBLE)>

<ROOM INNER-LAIR
      (IN ROOMS)
      (DESC "Inner Lair")
      (LDESC
"This is the heart of the Beast's lair. The only exit leads northeast.")
      (NE TO LAIR)
      (FLAGS ONBIT RLANDBIT)
      (GLOBAL LAIR-OBJECT)>

<OBJECT SKELETON
	(IN INNER-LAIR)
	(DESC "skeleton")
	(FDESC
"The skeleton of a dead Beasthunter lies nearby, clutching something labelled
\"Nutrimat/Computer Interface.\"") 
	(SYNONYM SKELETON BEASTH BONE BONES)
	(FLAGS RLANDBIT TRYTAKEBIT)>

<OBJECT NUT-COM-INTERFACE
	(IN INNER-LAIR)
	(DESC "Nutrimat/Computer Interface")
	(SYNONYM INTERF)
	(ADJECTIVE NUTRIM COMPUT)
	(FLAGS NDESCBIT TRYTAKEBIT TAKEBIT)
	(SIZE 4)
	(ACTION NUT-COM-INTERFACE-F)>

<ROUTINE NUT-COM-INTERFACE-F ()
	 <COND (<AND <VERB? TAKE>
		     <FSET? ,NUT-COM-INTERFACE ,TRYTAKEBIT>>
		<FCLEAR ,NUT-COM-INTERFACE ,TRYTAKEBIT>
		<FCLEAR ,NUT-COM-INTERFACE ,NDESCBIT>
		<FSET ,SKELETON ,TOUCHBIT>
		<SETG SCORE <+ ,SCORE 25>>
		<RFALSE>)
	       (<AND <VERB? TAKE>
		     <RUNNING? ,I-TEA>>
		<TELL "You get a powerful electric shock." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The " D ,PRSO " is square, about ten inches on each side.">
		<FINE-PRODUCT>
		<CRLF>)>>

;"V'lhurgs and G'Gugvuntts stuff"

<ROUTINE I-CARELESS-WORDS ()
	 <CRLF>
	 <SETG FLEET-PROB 60>
	 <TELL
"It is of course well known that careless talk costs lives, but the full
scale of the problem is not always appreciated. For instance, at the exact
moment you said \"">
	 <RESTORE-INPUT ,FIRST-BUFFER>
	 <TELL "\" a freak wormhole opened in the fabric of the space-time
continuum and carried your words far far back in time across almost infinite
reaches of space to a distant galaxy where strange and warlike beings were
poised on the brink of frightful interstellar battle.|
|
The two opposing leaders were meeting for the last time. A dreadful silence
fell across the conference table as the commander of the Vl'Hurgs, resplendent
in his" ,BATTLE-SHORTS "gazed levelly at the " D ,GGUGVUNT " squatting opposite
him" ,CLOUD-OF-STEAM "As a million sleek and horribly beweaponed star cruisers
poised to unleash electric death at his single word of command, the Vl'Hurg
challenged his vile enemy to take back what it had said about his mother.|
|
The creature stirred in its sickly broiling vapour, and at that very moment
the words \"">
	 <RESTORE-INPUT ,FIRST-BUFFER>
	 <TELL "\" drifted across the conference table.
Unfortunately, in the Vl'Hurg tongue this was the most dreadful insult
imaginable, and there was nothing for it but to wage terrible war for
centuries. Eventually the error was detected, but over two hundred and
fifty thousand worlds, their peoples and cultures perished in the holocaust.|
|
You have destroyed most of a small galaxy. Please pick your words with
greater care." CR>>

<GLOBAL CARELESS-WORDS-FLAG <>>

<GLOBAL DOG-COUNTER 0>

<OBJECT MICROSCOPIC-FLEET
	(IN WAR-CHAMBER)
	(DESC "battle fleet")
	(SYNONYM FLEET SHIP SHIPS SPACES)
	(ADJECTIVE BATTLE HORRIB BEWEAP MICROS SPACE VAST)
	(FLAGS NDESCBIT)
	(ACTION MICROSCOPIC-FLEET-F)>

<ROUTINE MICROSCOPIC-FLEET-F ()
	 <COND (<VERB? THROUGH>
		<TELL ,LOOK-AROUND CR>)>>

<OBJECT CANOPY
	(IN WAR-CHAMBER)
	(DESC "domed canopy")
	(SYNONYM CANOPY DOME WINDOW)
	(ADJECTIVE DOMED)
	(FLAGS NDESCBIT TRANSBIT)
	(ACTION CANOPY-F)>

<ROUTINE CANOPY-F ()
	 <COND (<VERB? LOOK-INSIDE>
		<TELL "Through the " D ,CANOPY " of the ship you can see a
vast " D ,MICROSCOPIC-FLEET " flying in formation behind you through the
black, glittering emptiness of space. Ahead is a star system towards which
you are hurtling at a terrifying speed." CR>)>>

<ROOM WAR-CHAMBER
      (IN ROOMS)
      (SYNONYM WALKIN)
      (DESC "War Chamber")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL CONVERSATION)
      (ACTION WAR-CHAMBER-F)>

<ROUTINE WAR-CHAMBER-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<FCLEAR ,CONVERSATION ,INVISIBLE>
		<MOVE ,THIRD-PLANET ,HERE>
		<SETG DREAMING T>
		<ENABLE <QUEUE I-DOG -1>>
		<RFALSE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Spread before you, astonishingly enough, is the " D ,WAR-CHAMBER " of a star
battle cruiser. ">
		<PERFORM ,V?LOOK-INSIDE ,CANOPY>
		<RTRUE>)>>

<OBJECT VLHURG
	(IN WAR-CHAMBER)
	(DESC "Vl'Hurg leader")
	(DESCFCN VLHURG-DESCFCN)
	(SYNONYM VL\'HUR LEADER CREATU)
	(ADJECTIVE VL\'HUR)
	(FLAGS ACTORBIT)
	(ACTION VLHURG-F)>

<ROUTINE VLHURG-DESCFCN ("OPTIONAL" X)
	 <TELL CR
"Standing near you are two creatures who are gazing at the star system with
terrible hatred in their eyes. One is wearing" ,BATTLE-SHORTS "and the other
is wreathed" ,CLOUD-OF-STEAM "They are engaged in " D ,CONVERSATION "." CR>>

<ROUTINE VLHURG-F ()
	 <COND (<VERB? TELL>
		<TELL
"You are clearly the worst diplomat that ever lived, and are about to become
the worst one that ever died. That is an even worse insult in the G'Gugvunt
tongue than \"">
		<RESTORE-INPUT ,FIRST-BUFFER>
		<TELL "\" is in the Vl'Hurg tongue." CR>
		<FUCKING-CLEAR>)
	       (<VERB? EXAMINE>
		<TELL "The " D ,VLHURG " looks typically Vl'Hurgish." CR>)
	       (<VERB? LISTEN>
		<COND (<FSET? ,VLHURG ,MUNGEDBIT>
		       <TELL
"The creatures are speculating about who you are and what to do with you." CR>)
		      (T
		       <FSET ,VLHURG ,MUNGEDBIT>
		       <TELL
"  \"Hated planet!\" snarls the Vl'Hurg.|
  \"Home of he that dared to say '">
		       <RESTORE-INPUT ,FIRST-BUFFER>
		       <TELL
"'\" rasps the G'Gugvunt.|
  \"Detested words! Even now it sticks my soul to hear them uttered,\"
barks the Vl'Hurg, \"even though ten thousand years have passed...\"|
  \"And as many senseless megadeaths! Worlds destroyed! My race and
yours laid to waste! All because of he that dared shape the words '">
		       <RESTORE-INPUT ,FIRST-BUFFER>
		       <TELL "'.\"|
  \"Torture to my Vl'Hurgish warrior heart to hear it spoken! Yet, even
now, the hot breath of our vengeance blows hard upon this little world...\"|
  \"Vengeance on him who said '">
		       <RESTORE-INPUT ,FIRST-BUFFER>
		       <TELL "'.\"|
  \"Yes, there's no need to keep repeating it,\" growls the Vl'Hurg.|
  \"One happy thought,\" adds the G'Gugvunt. \"After millenia of bloody
and perpetual conflict, our races have been brought together by this
Quest for the Source of the Offending Remark. Perhaps, after our vengeance
has been exacted on him who said '">
		       <RESTORE-INPUT ,FIRST-BUFFER>
		       <TELL "'...\"|
  \"Will you stop saying it?\"|
  \"...perhaps we will continue to live in peace and harmony and...\"|
  \"We will talk about that AFTER we ... who's this?\"|
|
The two creatures turn and stare at you." CR>)>)>>

<OBJECT GGUGVUNT
	(IN WAR-CHAMBER)
	(DESC "G'Gugvunt leader")
	(SYNONYM G\'GUGV LEADER CREATU)
	(ADJECTIVE G\'GUGV)
	(FLAGS ACTORBIT NDESCBIT)
	(ACTION GGUGVUNT-F)>

<ROUTINE GGUGVUNT-F ()
	 <COND (<VERB? TELL>
		<PERFORM ,V?TELL ,VLHURG>
		<FUCKING-CLEAR>)
	       (<VERB? EXAMINE>
		<TELL
"The " D ,GGUGVUNT " is looking typically G'Gugvuntish." CR>)
	       (<VERB? LISTEN>
		<PERFORM ,V?LISTEN ,VLHURG>
		<RTRUE>)>>

<OBJECT OTHER-PLANETS
	(IN WAR-CHAMBER)
	(DESC "other planets")
	(SYNONYM PLANET)
	(ADJECTIVE OTHER)
	(FLAGS NDESCBIT VOWELBIT NARTICLEBIT)>

<OBJECT THIRD-PLANET
	(IN LOCAL-GLOBALS)
	(DESC "third planet")
	(SYNONYM PLANET EARTH)
	(ADJECTIVE THIRD BLUE BLUE- GREEN SMALL)
	(FLAGS NDESCBIT)
	(ACTION THIRD-PLANET-F)>

<ROUTINE THIRD-PLANET-F ()
	 <COND (<NOT ,EARTH-DEMOLISHED>
		<COND (<PRSO? ,THIRD-PLANET>
		       <PERFORM ,PRSA ,GROUND ,PRSI>
		       <RTRUE>)
		      (T
		       <PERFORM ,PRSA ,PRSO ,GROUND>)>)
	       (<VERB? LEAVE DISEMBARK>
		<TELL "You did!" CR>)
	       (<VERB? EXAMINE>
		<TELL
"It is an utterly insignificant little blue-green planet, of the sort
where they probably still wear " D ,DIGITAL-WATCH "es." CR>)>>

<ROOM MAZE
      (IN ROOMS)
      (SYNONYM INFOCO ADAMS MERETZ)
      (ADJECTIVE DOUGLA STEVE STEVEN)
      (DESC "Maze")
      (LDESC
"This is part of a spongy gray maze of twisty little synapses, all alike.")
      (NORTH PER MAZE-EXIT-F)
      (NE PER MAZE-EXIT-F)
      (EAST PER MAZE-EXIT-F)
      (SE PER MAZE-EXIT-F)
      (SOUTH PER MAZE-EXIT-F)
      (SW PER MAZE-EXIT-F)
      (WEST PER MAZE-EXIT-F)
      (NW PER MAZE-EXIT-F)
      (UP PER MAZE-EXIT-F)
      (DOWN PER MAZE-EXIT-F)
      (IN PER MAZE-EXIT-F)
      (OUT PER MAZE-EXIT-F)
      (FLAGS RLANDBIT ONBIT)
      (PSEUDO "MAZE" GLOBAL-ROOM-F)>

<GLOBAL MAZE-COUNTER 0>

<GLOBAL BRAIN-DAMAGED <>>

<ROUTINE MAZE-EXIT-F ()
	 <COND (<PROB 40>
		<TELL
"An electrical impulse across a synapse gap temporarily blocks your way." CR>)
	       (T
		<SETG MAZE-COUNTER <+ ,MAZE-COUNTER 1>>
		<COND (<EQUAL? ,MAZE-COUNTER 3 17 36>
		       <MOVE ,PARTICLE ,HERE>)
		      (T
		       <MOVE ,PARTICLE ,LOCAL-GLOBALS>)>
		<V-LOOK>)>
	 <RFALSE>>

<OBJECT BRAIN
	(IN MAZE)
	(DESC "brain")
	(SYNONYM BRAIN)
	(ADJECTIVE MY YOUR)
	(FLAGS NDESCBIT)
	(ACTION GLOBAL-ROOM-F)>

<OBJECT SYNAPSE
	(IN MAZE)
	(DESC "synapse")
	(SYNONYM SYNAPS GAP)
	(ADJECTIVE SYNAPS)
	(FLAGS NDESCBIT)>

<OBJECT PARTICLE
	(IN LOCAL-GLOBALS) ;"just for the purpose of MOBY-FIND"
	(DESC "particle")
	(LDESC
"Blocking the gap between two synapses is a large black particle. There seem
to be some faint markings on it.")
	(SYNONYM PARTIC SENSE LETTER MARKIN)
	(ADJECTIVE LARGE BLACK COMMON FAINT)
	(FLAGS TAKEBIT TRYTAKEBIT READBIT)
	(ACTION PARTICLE-F)>

<ROUTINE PARTICLE-F ()
	 <COND (<VERB? TAKE MOVE>
		<MOVE ,PARTICLE ,LOCAL-GLOBALS>
		<FSET ,PARTICLE ,MUNGEDBIT>
		<SETG SCORE <+ ,SCORE 25>>
		<FSET ,WAR-CHAMBER ,REVISITBIT>
		<TELL "As you remove the " D ,PARTICLE>
		<JIGS-UP
", electrical impulses begin leaping madly across the now-unblocked synaptic
gap. Unfortunately, YOU were in the gap at the time.">
		<RTRUE>)
	       (<VERB? EXAMINE READ>
		<TELL
"As you look closer you see, inscribed in tiny letters on the "
D ,PARTICLE ":|
|
  Sense, Common for:|
     Dent, Arthur|
   (for replacement,|
  order part #31-541)" CR>)>>

;"the Party stuff"

<OBJECT APARTMENT
	(IN LOCAL-GLOBALS)
	(DESC "apartment")
	(SYNONYM APARTM)
	(FLAGS VOWELBIT)
	(ACTION APARTMENT-F)>

<ROUTINE APARTMENT-F ()
	 <COND (<VERB? LEAVE EXIT>
		<COND (<EQUAL? ,HERE ,LIVING-ROOM>
		       <DO-WALK ,P?SOUTH>)
		      (T
		       <V-WALK-AROUND>)>)
	       (<VERB? THROUGH>
		<TELL ,LOOK-AROUND CR>)>>

<GLOBAL ITEM-DROPPED-AT-PARTY <>>

<GLOBAL FLUFF-REMOVED <>>

<GLOBAL PARTY-TABLE
	<TABLE 0 0 0>>

<ROUTINE PARTY-DESC (ROOM)
	 <TELL "You are in a large " D .ROOM
". There is a party going on. Other rooms lie to the ">>

<ROOM LIVING-ROOM
      (IN ROOMS)
      (DESC "Living Room")
      (SOUTH PER PARTY-EXIT-F)
      (WEST TO DINING-ROOM)
      (SW TO KITCHEN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL APARTMENT)
      (PSEUDO "PARTY" APARTMENT-F)
      (ACTION LIVING-ROOM-F)>

<ROUTINE PARTY-EXIT-F ()
	  <COND (<FSET? ,APARTMENT-DOOR ,OPENBIT>
		 <TELL "What! Leave a fun party like this?" CR>
		 <SETG AWAITING-REPLY 3>
		 <ENABLE <QUEUE I-REPLY 2>>
		 <RFALSE>)
		(T
		 <TELL "The door is closed." CR>
		 <SETG P-IT-OBJECT ,APARTMENT-DOOR>
		 <RFALSE>)>>

<ROUTINE LIVING-ROOM-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <EQUAL? ,IDENTITY-FLAG ,TRILLIAN>>>
		<PUT ,PARTY-TABLE 0 <LOC ,HANDBAG>>
		<PUT ,PARTY-TABLE 1 <LOC ,TWEEZERS>>
		<COND (<FSET? ,HANDBAG ,OPENBIT>
		       <PUT ,PARTY-TABLE 2 T>)
		      (T
		       <PUT ,PARTY-TABLE 2 <>>)>
		<SETG IDENTITY-FLAG ,TRILLIAN>
		<MOVE ,TRILLIAN ,GLOBAL-OBJECTS>
		<SETG DREAMING T>
		<ROB ,PROTAGONIST ,MEMORIAL>
		<ROB ,HANDBAG ,RAMP>
		<FCLEAR ,HANDBAG ,OPENBIT>
		<MOVE ,HANDBAG ,PROTAGONIST>
		<MOVE ,TWEEZERS ,HANDBAG>
		<MOVE ,WINE ,PROTAGONIST>
		<MOVE ,APPETIZERS ,PROTAGONIST>
		<MOVE ,ARTHUR ,HERE>
		<MOVE ,PHIL ,HERE>
		<MOVE ,CAGE ,HERE>
		<TELL
"You're at a party being given by a distant and incredibly boring acquaintance.
Among the people you've been introduced to are a shy, mousy fellow from the
West Country named Arthur, and a flamboyant guy named Phil. You've had too many
drinks already, and the room is beginning to buzz..." CR CR>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <FSET? ,LIVING-ROOM ,REVISITBIT>>
		<CRLF>
		<JIGS-UP
"The hostess, a lethally dull woman, corners you and bores you to
death. Literally.">
		<RTRUE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<PARTY-DESC ,LIVING-ROOM>
		<TELL
"west and southwest, and the " D ,APARTMENT "'s front door is south of
here." CR>)>> 

<OBJECT APARTMENT-DOOR
	(IN LIVING-ROOM)
	(DESC "door")
	(SYNONYM DOOR)
	(FLAGS DOORBIT OPENBIT NDESCBIT)
	(ACTION APARTMENT-DOOR-F)>

<ROUTINE APARTMENT-DOOR-F ()
	 <COND (<VERB? THROUGH>
		<DO-WALK ,P?SOUTH>)>>

<ROOM DINING-ROOM
      (IN ROOMS)
      (DESC "Dining Room")
      (SOUTH TO KITCHEN)
      (EAST TO LIVING-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL APARTMENT)
      (PSEUDO "PARTY" APARTMENT-F)
      (ACTION DINING-ROOM-F)>

<ROUTINE DINING-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<PARTY-DESC ,DINING-ROOM>
		<TELL "south and east." CR>)>>

<ROOM KITCHEN
      (IN ROOMS)
      (DESC "Kitchen")
      (NORTH TO DINING-ROOM)
      (NE TO LIVING-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL APARTMENT)
      (PSEUDO "PARTY" APARTMENT-F)
      (ACTION KITCHEN-F)>

<ROUTINE KITCHEN-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<PARTY-DESC ,KITCHEN>
		<TELL "north and northeast." CR>)>>

<OBJECT WINE
	(IN LOCAL-GLOBALS) ;"just for the purpose of MOBY-FIND"
	(DESC "glass of white wine")
	(SYNONYM GLASS WINE)
	(ADJECTIVE WHITE)
	(FLAGS TAKEBIT DRINKBIT)
	(SIZE 15)
	(ACTION WINE-F)>

<ROUTINE WINE-F ()
	 <COND (<VERB? DRINK ENJOY>
		<TELL
"You take a sip, and the room spins a little faster." CR>)
	       (<VERB? THROW POUR>
		<SHRIEK>)
	       (<VERB? DROP>
		<DROP-AT-PARTY>)>>

<OBJECT APPETIZERS
	(IN LOCAL-GLOBALS) ;"just for the purpose of MOBY-FIND"
	(DESC "plate of hors d'oeuvres")
	(SYNONYM PLATE D\'OEUV APPETI SNACKS)
	(ADJECTIVE HORS)
	(FLAGS TAKEBIT EATBIT)
	(SIZE 15)
	(ACTION APPETIZERS-F)>

<ROUTINE APPETIZERS-F ()
	 <COND (<VERB? EAT ENJOY>
		<TELL
"You nibble at one of the hors d'oeuvres. It tastes ">
		<COND (<PROB 40>
		       <TELL "okay." CR>)
		      (<PROB 50>
		       <TELL "delicious." CR>)
		      (T
		       <TELL "terrible." CR>)>)
	       (<VERB? THROW>
		<SHRIEK>)
	       (<VERB? COUNT>
		<TELL
"More than three, which is as high as you can count in your condition." CR>)
	       (<VERB? DROP>
		<DROP-AT-PARTY>)>>

<ROUTINE DROP-AT-PARTY ()
	 <COND (<NOT ,ITEM-DROPPED-AT-PARTY>
		<SETG ITEM-DROPPED-AT-PARTY ,PRSO>
		<FSET ,HOSTESS ,NDESCBIT>
	 	<ENABLE <QUEUE I-HOSTESS 3>>)>
	 <MOVE ,PRSO ,HERE>
	 <COND (<VERB? DROP>
		<TELL "Dropped." CR>)
	       (T
		<TELL "Thrown." CR>)>>

<ROUTINE SHRIEK ()
	 <TELL
"The hostess lets out a blood-chilling shriek. \"My new carpet!\" ">
	 <COND (<VERB? THROW>
		<TELL
"Grabbing a shard from your broken " D ,PRSO ", s">)
	       (T
		<TELL "S">)>
	 <JIGS-UP "he rushes toward you, vengeance burning in her eyes.">
	 <RTRUE>>

<OBJECT HOSTESS
	(IN LIVING-ROOM)
	(DESC "hostess")
	(LDESC
"You notice the hostess approaching, but using several mingling couples
as cover you maneuver away.")
	(SYNONYM HOSTESS)
	(FLAGS ACTORBIT)
	(ACTION HOSTESS-F)>

<ROUTINE HOSTESS-F ()
	 <COND (<EQUAL? ,HOSTESS ,WINNER>
		<COND (<AND <VERB? YES>
			    <EQUAL? ,AWAITING-REPLY 4>>
		       <SETG WINNER ,PROTAGONIST>
		       <V-YES>
		       <SETG WINNER ,HOSTESS>)
		      (<AND <VERB? NO>
			    <EQUAL? ,AWAITING-REPLY 4>>
		       <SETG WINNER ,PROTAGONIST>
		       <V-NO>
		       <SETG WINNER ,HOSTESS>)
		      (T
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?HELLO ,HOSTESS>
		       <FUCKING-CLEAR>)>)
	       (<AND <VERB? HELLO ASK-ABOUT TELL-ABOUT>
		     <PRSO? ,HOSTESS>>
		<TELL
"The hostess is delighted to engage in " D ,CONVERSATION>
		<JIGS-UP
" and pulls you into a corner. Days later, you expire from thirst
and exhaustion.">
		<RTRUE>)>>

<ROUTINE I-HOSTESS ()
	 <ENABLE <QUEUE I-HOSTESS -1>>
	 <COND (<NOT ,ITEM-DROPPED-AT-PARTY>
		<FCLEAR ,HOSTESS ,TOUCHBIT>
		<DISABLE <INT I-HOSTESS>>
		<RFALSE>)>
	 <MOVE ,HOSTESS ,HERE>
	 <MOVE ,ITEM-DROPPED-AT-PARTY ,HERE>
	 <CRLF>
	 <COND (<FSET? ,HOSTESS ,TOUCHBIT>
		<SETG AWAITING-REPLY 4>
		<ENABLE <QUEUE I-REPLY 2>>
		<TELL
"\"Tricia dear,\" says the hostess insistently, \"don't you want
your " D ,ITEM-DROPPED-AT-PARTY "?\"" CR>)
	       (T
		<FSET ,HOSTESS ,TOUCHBIT>
		<SETG P-IT-OBJECT ,ITEM-DROPPED-AT-PARTY>
		<FSET ,ITEM-DROPPED-AT-PARTY ,NDESCBIT>
		<TELL
"The hostess, whom you've been avoiding all evening, scurries up with your "
D ,ITEM-DROPPED-AT-PARTY ". \"Oh, hello Tricia, how lovely to see you, I think
you dropped this, dear.\"" CR>)>>

<OBJECT JACKET-FLUFF
	(IN LOCAL-GLOBALS) ;"for purposes of MOBY-FIND"
	(DESC "jacket fluff")
	(SYNONYM FLUFF LINT)
	(ADJECTIVE JACKET UNSIGH)
	(FLAGS NARTICLEBIT TAKEBIT TRYTAKEBIT NDESCBIT)
	(GENERIC POCKET-FLUFF)>

<OBJECT CAGE
	(IN LOCAL-GLOBALS) ;"for the purposes of MOBY-FIND"
	(DESC "it")
	(SYNONYM DRAPE CAGE BIRDCA SNORIN)
	(ADJECTIVE LARGE BLACK BIRD)
	(FLAGS NDESCBIT NARTICLEBIT)
	(ACTION UNIMPORTANT-THING-F)> 

;"Damogran stuff"

<OBJECT DAMOGRAN
	(IN LOCAL-GLOBALS)
	(DESC "Damogran")
	(SYNONYM DAMOGR)>

<ROOM SPEEDBOAT
      (IN ROOMS)
      (DESC "Presidential Speedboat")
      (NORTH TO DAIS IF BOAT-DOCKED)
      (OUT TO DAIS IF BOAT-DOCKED)
      (FLAGS ONBIT RLANDBIT OUTSIDEBIT)
      (GLOBAL CONTROLS DAMOGRAN PLATFORM)
      (PSEUDO "CROWD" CROWD-PSEUDO "WATER" WATER-PSEUDO)
      (ACTION SPEEDBOAT-F)>

<ROUTINE SPEEDBOAT-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<SETG DREAMING T>
		<SETG IDENTITY-FLAG ,ZAPHOD>
		<MOVE ,ZAPHOD ,GLOBAL-OBJECTS>
		<MOVE ,WRENCH ,TOOLBOX>
		<MOVE ,MAGNIFYING-GLASS ,TOOLBOX>
		<FCLEAR ,TOOLBOX ,OPENBIT>
		<ROB ,PROTAGONIST ,MEMORIAL>
		<MOVE ,PROTAGONIST ,PILOT-SEAT>
		<SETG DESTINATION ,CHANNEL>
		<ENABLE <QUEUE I-SPEEDBOAT 2>>
		<TELL
"The pain at the back of your eyes is from partying until very late last night,
and both your heads are suffering the worst hangover you've ever experienced.
You remember formulating a plan to steal " D ,HEART-OF-GOLD ", but you can't
for the life of you remember any details." CR CR>)
	       (<EQUAL? .RARG ,M-LOOK>
		<COND (,BOAT-DOCKED
		       <TELL
"The boat is resting atop a plume of water. The dais for the dedication
ceremonies for " D ,HEART-OF-GOLD " lies immediately north." CR>)
		      (T
		       <TELL
"You are piloting the " D ,BOAT-OBJECT ", which features very simple controls,
toward the island of France (Footnote 3), where the dedication ceremonies for "
D ,HEART-OF-GOLD " will occur. You are currently steering the boat toward">
		       <COND (<EQUAL? ,DESTINATION ,CHANNEL>
		              <TELL
" a " D ,CHANNEL " between " D ,CLIFF " and a " D ,SPIRE "." CR>)
		             (T
		              <ARTICLE ,DESTINATION>
			      <TELL "." CR>)>)>)>>

<ROUTINE I-SPEEDBOAT ()
	 <SETG BOAT-COUNTER <+ ,BOAT-COUNTER 1>>
	 <ENABLE <QUEUE I-SPEEDBOAT -1>>
	 <COND (<EQUAL? ,DESTINATION ,CLIFF ,SPIRE>
		<SETG CRASH-COUNTER <+ ,CRASH-COUNTER 1>>
		<COND (<EQUAL? ,CRASH-COUNTER 4>
		       <SETG BOAT-DOCKED T>
		       <DISABLE <INT I-SPEEDBOAT>>
		       <TELL CR
"Suddenly, the autopilot leaps to life, steering the boat away from the "
D ,DESTINATION ". The crowd gathered for the dedication oohs and aahs as the
boat swerves through the " D ,CHANNEL ". As it reaches the base of the "
D ,CLIFF " a plume of water forms under it, sending it higher and higher.
The crowd bursts into applause as the boat reaches the top of the cliff, just
south of the ceremonial dais." CR>
		       <RTRUE>)>)> 
	 <COND (<VERB? STEER POINT>
		<RFALSE>)>
	 <COND (<AND <VERB? AGAIN>
		     <EQUAL? ,L-PRSA ,V?STEER ,V?POINT>>
		<RFALSE>)>
	 <CRLF>
	 <COND (<L? ,BOAT-COUNTER 7>
		<TELL
"You continue to steer toward the " D ,DESTINATION "." CR>)
	       (T
		<DISABLE <INT I-SPEEDBOAT>>
		<TELL
"You almost make it through the " D ,CHANNEL " but the turbulent waters push
the boat toward the rocks. The " D ,AUTOPILOT-BUTTON>
		<TELL " lights up and an " ,EYE-STALK>
		<JIGS-UP
"but a split-second later the boat smashes into the rocks.">
		<RTRUE>)>>

<GLOBAL CRASH-COUNTER 0> 

<GLOBAL BOAT-COUNTER 0>

<GLOBAL DESTINATION <>>

<GLOBAL BOAT-DOCKED <>>

<GLOBAL AUTOPILOT-COUNTER 0>

<GLOBAL DAIS-COUNTER 0>

<OBJECT BOAT-OBJECT
	(IN SPEEDBOAT)
	(DESC "speedboat")
	(SYNONYM SPEEDB BOAT)
	(ADJECTIVE PRESID SPEED)
	(FLAGS NDESCBIT)
	(ACTION BOAT-OBJECT-F)>

<ROUTINE BOAT-OBJECT-F ()
	 <COND (<AND <VERB? STEER>
		     <PRSO? ,BOAT-OBJECT>>
		<COND (,BOAT-DOCKED
		       <TELL "You've already reached your destination!" CR>)
		      (<PRSI? ,DESTINATION>
		       <TELL
"You already ARE steering the boat toward the " D ,DESTINATION "." CR>)
		      (<NOT <PRSI? ,CLIFF ,SPIRE ,CHANNEL>>
		       <TELL "You can't steer the boat toward">
		       <ARTICLE ,PRSI T>
		       <TELL "!" CR>)
		      (T
		       <SETG DESTINATION ,PRSI>
		       <COND (<G? ,BOAT-COUNTER 3>
			      <SETG BOAT-COUNTER 3>)>
		       <TELL
"The boat is now heading straight at the " D ,DESTINATION "." CR>)>)
	       (<VERB? EXIT LEAVE DISEMBARK THROUGH>
		<COND (,BOAT-DOCKED
		       <DO-WALK ,P?NORTH>)
		      (T
		       <TELL ,DONT-MIX CR>)>)>>

<ROUTINE WATER-PSEUDO ()
	 <COND (<VERB? THROUGH BOARD>
		<TELL ,DONT-MIX CR>)
	       (<AND <VERB? PUT THROW>
		     <PRSI? ,PSEUDO-OBJECT>>
		<MOVE ,PRSO ,LOCAL-GLOBALS>
		<TELL "Glub..." CR>)>>

<OBJECT PILOT-SEAT
	(IN SPEEDBOAT)
	(DESC "pilot seat")
	(SYNONYM SEAT CHAIR CUSHION)
	(ADJECTIVE PILOT SEAT THICK PLUSH)
	(FLAGS VEHBIT CONTBIT SURFACEBIT SEARCHBIT OPENBIT)
	(ACTION PILOT-SEAT-F)>

<ROUTINE PILOT-SEAT-F ("OPTIONAL" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? WALK>
		       <OUT-OF-FIRST ,PILOT-SEAT>)>)
	       (.RARG
		<RFALSE>)
	       (<AND <VERB? LOOK-UNDER RAISE SEARCH TAKE>
		     <IN? ,KEY ,LOCAL-GLOBALS>>
		<MOVE ,CUSHION-FLUFF ,PROTAGONIST>
		<MOVE ,KEY ,PROTAGONIST>
		<TELL
"You discover and pick up a small key and a piece of fluff under the
seat cushion." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The chair is very comfortable, with a thick plush cushion." CR>)
	       (<AND <VERB? OPEN CLOSE>
		     <PRSO? ,PILOT-SEAT>>
		<TELL-ME-HOW>)>>

<OBJECT KEY
	(IN LOCAL-GLOBALS) ;"for purposes of MOBY-FIND"
	(DESC "small key")
	(SYNONYM KEY)
	(ADJECTIVE SMALL)
	(FLAGS TAKEBIT)
	(SIZE 2)
	(ACTION KEY-F)>

<ROUTINE KEY-F ()
	 <COND (<AND <VERB? WHERE>
		     <EQUAL? ,HERE ,SPEEDBOAT>
		     <IN? ,KEY ,LOCAL-GLOBALS>>
		<TELL "It's probably around the boat somewhere." CR>)>>

<OBJECT CUSHION-FLUFF
	(IN LOCAL-GLOBALS) ;"just for the purpose of MOBY-FIND"
	(DESC "seat cushion fluff")
	(SYNONYM FLUFF LINT)
	(ADJECTIVE SEAT CUSHION)
	(FLAGS TAKEBIT NARTICLEBIT)
	(SIZE 1)
	(GENERIC POCKET-FLUFF)>

<OBJECT TOOLBOX
	(IN SPEEDBOAT)
	(DESC "tool box")
	(SYNONYM TOOLBO LOCK BOX)
	(ADJECTIVE TOOL)
	(FLAGS CONTBIT TAKEBIT SEARCHBIT)
	(SIZE 25)
	(CAPACITY 20)
	(ACTION TOOLBOX-F)>

<ROUTINE TOOLBOX-F ()
	 <COND (<AND <VERB? OPEN>
		     <NOT ,PRSI>
		     <NOT <FSET? ,TOOLBOX ,OPENBIT>>>
		<TELL "It's locked." CR>)
	       (<VERB? LOCK>
		<COND (<FSET? ,TOOLBOX ,OPENBIT>
		       <PERFORM ,V?CLOSE ,TOOLBOX>
		       <RTRUE>)
		      (T
		       <TELL "It is." CR>)>)
	       (<VERB? OPEN UNLOCK>
		<COND (<FSET? ,TOOLBOX ,OPENBIT>
		       <TELL ,ALREADY-OPEN CR>
		       <RTRUE>)>
		<COND (<AND <NOT ,PRSI>
			    <HELD? ,KEY>>
		       <SETG PRSI ,KEY>
		       <TELL "(with the key)" CR>)>
		<COND (<PRSI? ,KEY>
		       <FSET ,TOOLBOX ,OPENBIT>
		       <TELL "The tool box opens">
		       <COND (<FIRST? ,TOOLBOX>
			      <TELL " revealing">
			      <PRINT-CONTENTS ,TOOLBOX>)>
		       <TELL "." CR>)
		      (T
		       <TELL "You can't unlock it with">
		       <COND (,PRSI
			      <ARTICLE ,PRSI>)
			     (T
			      <TELL " " D ,HANDS>)>
		       <TELL "!" CR>)>)>>

<OBJECT MAGNIFYING-GLASS
	(IN TOOLBOX)
	(DESC "magnifying glass")
	(SYNONYM GLASS)
	(ADJECTIVE MAGNIF)
	(FLAGS TAKEBIT TRANSBIT)
	(ACTION MAGNIFYING-GLASS-F)>

<ROUTINE MAGNIFYING-GLASS-F ()
	 <COND (<VERB? LOOK-INSIDE>
		<TELL
"You see your environs upside-down and slightly distorted." CR>)>>

<OBJECT AUTOPILOT-BUTTON
	(IN SPEEDBOAT)
	(DESC "autopilot button")
	(SYNONYM BUTTON PILOT AUTOPI)
	(ADJECTIVE AUTOPI AUTO LARGE RED)
	(FLAGS VOWELBIT NDESCBIT LIGHTBIT)
	(ACTION AUTOPILOT-BUTTON-F)>

<ROUTINE AUTOPILOT-BUTTON-F ()
	 <COND (<VERB? PUSH LAMP-ON>
		<SETG AUTOPILOT-COUNTER <+ ,AUTOPILOT-COUNTER 1>>
		<TELL "The button glows. An "
,EYE-STALK "looks around, and withdraws. The light fades.">
		<COND (<EQUAL? ,AUTOPILOT-COUNTER 3>
		       <TELL " (Footnote 13)">)>
		<CRLF>)>>

<OBJECT CHANNEL
	(IN SPEEDBOAT)
	(DESC "narrow channel")
	(SYNONYM CHANNEL OPENIN)
	(ADJECTIVE NARROW)
	(FLAGS NDESCBIT)>

<OBJECT SPIRE
	(IN SPEEDBOAT)
	(DESC "rocky spire")
	(SYNONYM SPIRE ROCK ROCKS)
	(ADJECTIVE ROCKY)
	(FLAGS NDESCBIT)
	(ACTION DESTINATION-F)>

<OBJECT CLIFF
	(IN SPEEDBOAT)
	(DESC "towering cliffs")
	(SYNONYM CLIFF CLIFFS ISLAND FRANCE)
	(ADJECTIVE TOWERI)
	(FLAGS NDESCBIT NARTICLEBIT)
	(ACTION DESTINATION-F)>

<ROUTINE DESTINATION-F ()
	 <COND (<AND <VERB? WALK-TO>
		     <NOT ,BOAT-DOCKED>>
		<PERFORM ,V?STEER ,BOAT-OBJECT ,PRSO>
		<RTRUE>)>>

<ROOM DAIS
      (IN ROOMS)
      (SYNONYM POLICE COPS)
      (DESC "Dais")
      (SOUTH "The boat is gone.")
      (EAST PER DAIS-EXIT-F)
      (IN PER DAIS-EXIT-F)
      (OUT PER DAIS-EXIT-F)
      (FLAGS RLANDBIT ONBIT OUTSIDEBIT)
      (GLOBAL HEART-OF-GOLD DAMOGRAN PLATFORM)
      (PSEUDO "CROWD" CROWD-PSEUDO)
      (ACTION DAIS-F)>

<ROUTINE DAIS-EXIT-F ()
	 <COND (<NOT <IN? ,GUARDS ,HERE>>
		<SETG AWAITING-REPLY 5>
		<ENABLE <QUEUE I-REPLY 2>>
		<TELL
"Don't you think it would be a bad idea to leave the ceremonies?" CR>
		<RFALSE>)
	       (<OR <IN? ,RIFLES ,HERE>
		    <IN? ,RIFLES ,GUARDS>>
		<TELL
"You and " D ,TRILLIAN " break for " D ,HEART-OF-GOLD ". ">
		<COND (<FSET? ,BLASTER ,TRYTAKEBIT>
		       <TELL ,GUARDS-REALIZE "They">)
		      (T
		       <TELL "The guards">)>
		<GUARD-DEATH>
		<RFALSE>)
	       (T
		<SETG SCORE <+ ,SCORE 25>>
		<FSET ,SPEEDBOAT ,REVISITBIT>
		<MOVE ,BLASTER ,LOCAL-GLOBALS>
		<ROB ,PROTAGONIST ,HATCHWAY>
		<TELL
"You and " D ,TRILLIAN " enter " D ,HEART-OF-GOLD ", that beautiful bauble
you've been coveting ever since your decision to run for" ,PRESIDENT>
		<JIGS-UP
". The excitement overwhelms you (or perhaps it's just the awesome hangover
from last night).">
		<RFALSE>)>> 

<ROUTINE DAIS-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <FSET? ,SPEEDBOAT ,REVISITBIT>>
		<SETG DREAMING T>
		<JIGS-UP
"The remnants of a rapidly dispersing crowd gasp at your appearance. You
are immediately seized by guards who, in an unconstitutional departure from
protocol, hurl you over the cliff.">
		<RTRUE>)
	       (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,SPEEDBOAT ,REVISITBIT>>>
		<PUTP ,PROTAGONIST ,P?ACTION ,DAIS-FUNCTION>
		<TELL
"As you step out of the boat, the plume of water lowers it away. The crowd,
unaware of the autopilot, bursts into a round of admiring applause." CR CR>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a platform surrounded by a crowd. ">
		<COND (<IN? ,BANNER ,HERE>
		       <TELL
"Several members of the crowd are holding a huge banner. ">)>
		<TELL "Just to the east is " D ,HEART-OF-GOLD>
		<COND (<IN? ,RIFLES ,GUARDS>
		       <TELL ". A semi-circle of guards are aiming "
D ,RIFLES "s at you and " D ,TRILLIAN>)
		      (<IN? ,GUARDS ,HERE>
		       <TELL
". Many disarmed guards are nervously eyeing you and " D ,TRILLIAN>)>
	        <COND (<IN? ,BLASTER ,TRILLIAN>
		       <TELL
", who is pointing a blaster at your head">)>
		<TELL "." CR>)>>

<ROUTINE DAIS-FUNCTION ()
	 <COND (<VERB? QUIT RESTART RESTORE SCORE VERSION SAVE AGAIN WALK
		       VERBOSE BRIEF SUPER-BRIEF SCRIPT UNSCRIPT FOOTNOTE
		       LOOK INVENTORY HELP WHO WHAT WHERE WHY YES NO THROUGH>
		<>)
	       (<AND <PRSO? ,BANNER ,PSEUDO-OBJECT>
		     <VERB? COUNT EXAMINE THROUGH READ>>
		<>)
	       (T
		<SETG DAIS-COUNTER <+ ,DAIS-COUNTER 1>>
		<TELL ,CROWD-CHEERS>
		<COND (<EQUAL? ,DAIS-COUNTER 4>
		       <PUTP ,PROTAGONIST ,P?ACTION ,PROTAGONIST-F>
		       <MOVE ,TRILLIAN ,HERE>
		       <MOVE ,BLASTER ,TRILLIAN>
		       <MOVE ,GUARDS ,HERE>
		       <MOVE ,RIFLES ,GUARDS>
		       <ENABLE <QUEUE I-GUARDS 8>>
		       <TELL
" Suddenly, " D ,TRILLIAN " leaps out of the crowd, grabs you by the necks,
and points a blaster at your left head. Guards rush up, " D ,RIFLES "s poised
to shoot. \"Stay back!\" shouts " D ,TRILLIAN ". \"One more step and the"
,PRESIDENT " is fried meat!\" The guards seem unsure, and look at you for
instructions.">)>
		<FUCKING-CLEAR>
		<CRLF>)>>

<ROUTINE CROWD-PSEUDO ()
	 <COND (<VERB? COUNT EXAMINE>
		<TELL "It's big." CR>)
	       (<VERB? SHOOT>
		<COND (<BLASTER-HOLD>
		       <RTRUE>)>
		<TELL
"You may be a scoundrel, but you're not a mass murderer." CR>)
	       (<VERB? THROUGH>
		<TELL
"You'd be crushed by the enthusiasm of your admirers." CR>)
	       (<VERB? TELL WAVE-AT>
		<TELL ,CROWD-CHEERS CR>
		<FUCKING-CLEAR>
		<RTRUE>)>>

<OBJECT PLATFORM
	(IN LOCAL-GLOBALS)
	(DESC "Dais")
	(SYNONYM DAIS PLATFO)
	(ACTION PLATFORM-F)>

<ROUTINE PLATFORM-F ()
	 <COND (<AND <EQUAL? ,HERE ,SPEEDBOAT>
		     <NOT ,BOAT-DOCKED>>
		<CANT-SEE ,PLATFORM>)
	       (<VERB? THROUGH WALK-TO>
		<COND (<EQUAL? ,HERE ,DAIS>
		       <TELL ,LOOK-AROUND CR>)
		      (T
		       <DO-WALK ,P?NORTH>)>)
	       (<VERB? LEAVE DISEMBARK>
		<COND (<EQUAL? ,HERE ,DAIS>
		       <DO-WALK ,P?EAST>)
		      (T
		       <TELL ,LOOK-AROUND CR>)>)>>

<OBJECT BANNER
	(IN DAIS)
	(DESC "banner")
	(SYNONYM BANNER)
	(ADJECTIVE HUGE)
	(FLAGS NDESCBIT READBIT)
	(TEXT "\"President Beeblebrox is a Swell Guy\" (Footnote 15).")>

<OBJECT BLASTER
	(IN LOCAL-GLOBALS) ;"just for the purpose of MOBY-FIND"
	(DESC "blaster")
	(SYNONYM BLASTE WEAPON)
	(FLAGS NDESCBIT TAKEBIT TRYTAKEBIT)
        (ACTION BLASTER-F)>

<ROUTINE BLASTER-F ()
	 <COND (<AND <VERB? TAKE>
		     <FSET? ,BLASTER ,TRYTAKEBIT>>
		<TELL ,GUARDS-REALIZE "They">
		<COND (<IN? ,RIFLES ,GUARDS>
		       <GUARD-DEATH>)
		      (T
		       <FCLEAR ,BLASTER ,TRYTAKEBIT>
		       <FCLEAR ,BLASTER ,NDESCBIT>
		       <MOVE ,BLASTER ,PROTAGONIST>
		       <ENABLE <QUEUE I-GUARDS 5>>
		       <TELL
" are disarmed, though, and unable to do anything as you take
the blaster." CR>)>)
	       (<AND <VERB? SHOOT>
		     <PRSI? ,BLASTER>>
		<COND (<PRSO? ,BLASTER>
		       <V-COUNT>)
		      (<PRSO? ,GROUND>
		       <V-DIG>)
		      (<OR <FSET? ,PRSO ,TAKEBIT>
			   <PRSO? ,BANNER>>
		       <MOVE ,PRSO ,LOCAL-GLOBALS>
		       <TELL "With a cloud of sparks">
		       <COND (<PRSO? ,RIFLES>
			      <TELL " the pile of " D ,RIFLES "s">)
			     (T
			      <ARTICLE ,PRSO T>)>
		       <TELL " disintegrates. " ,CROWD-CHEERS CR>)
		      (<PRSO? ,HEART-OF-GOLD>
		       <TELL "You're too far." CR>)>)>>

<ROUTINE BLASTER-HOLD ()
	 <COND (<NOT <HELD? ,BLASTER>>
		<TELL ,NOT-HOLDING " the " D ,BLASTER "." CR>
		<RTRUE>)>>

<OBJECT RIFLES
	(IN LOCAL-GLOBALS) ;"for purposes of MOBY-FIND"
	(DESC "photon rifle")
	(SYNONYM RIFLE RIFLES PILE WEAPON)
	(ADJECTIVE PHOTON YOUR)
	(FLAGS NDESCBIT TRYTAKEBIT)
        (ACTION RIFLES-F)>

<ROUTINE RIFLES-F ()
	 <COND (<VERB? SHOOT>
		<COND (<BLASTER-HOLD>
		       <RTRUE>)>
		<COND (<IN? ,RIFLES ,GUARDS>
		       <PERFORM ,V?SHOOT ,GUARDS>
		       <RTRUE>)
		      (T
		       <MOVE ,RIFLES ,LOCAL-GLOBALS>
		       <TELL
"The rifles explode in a flashy display of sparks and shrapnel. " ,CROWD-CHEERS
" The guards begin to look a bit concerned." CR>)>)
	       (<AND <VERB? TAKE>
		     <FSET? ,RIFLES ,TRYTAKEBIT>>
		<TELL ,GUARDS-REALIZE>
		<TELL
"As you begin taking the rifles, so do several of the guards. They may be dim,
but they know what to do with a " D ,RIFLES>
		<JIGS-UP ".">
		<RTRUE>)>>

<ROUTINE GUARD-DEATH ()
	 <COND (<NOT <VISIBLE? ,RIFLES>>
		<TELL " grab the blaster and">)
	       (<NOT <IN? ,RIFLES ,GUARDS>>
		<TELL " pick up their rifles and">)>
	 <JIGS-UP " reduce you to a smoking pile of ash.">>

;"Whale stuff"

<ROOM INSIDE-WHALE
      (IN ROOMS)
      (SYNONYM TREE FOREKN)
      (DESC "Inside the Sperm Whale")
      (LDESC
"You are in the stomach of a sperm whale. You can hear a distant sound
of rushing wind.")
      (FLAGS ONBIT RLANDBIT NARTICLEBIT)
      (ACTION INSIDE-WHALE-F)>

<ROUTINE INSIDE-WHALE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<ENABLE <QUEUE I-WHALE 11>>
		<SETG DREAMING T>
		<RFALSE>)>>

<ROUTINE I-WHALE ()
	 <COND (<EQUAL? ,HERE ,INSIDE-WHALE>
		<CRLF>
		<JIGS-UP "SPLAT!!!!!">
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT WHALE-OBJECT
	(IN INSIDE-WHALE)
	(DESC "innard of a whale")
	(SYNONYM INNARD WHALE STOMAC)
	(ADJECTIVE SPERM)
	(FLAGS VOWELBIT NDESCBIT)
	(ACTION WHALE-OBJECT-F)>

<ROUTINE WHALE-OBJECT-F ()
	 <COND (<VERB? EXIT LEAVE DISEMBARK>
		<V-WALK-AROUND>)>>