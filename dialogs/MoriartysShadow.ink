INCLUDE common.ink

# Moriarty # Moriarty's Shadow

-> greetings
=== greetings ===

~ who("Moriarty")
~ pause_after()
Greetings stranger

~ who("Moriarty's Shadow")
~ pause_after()
Pause quand je me tait

~ who("Moriarty")
Rebonjour

~ who("Moriarty's Shadow")
~ pause_after()
Ok ta mére

-> greetings


~ who("Moriarty")
~ mood("think")
What the hell happenned?
	* [Ask my shadow]
		~ who("Moriarty's Shadow")
		Get lost looser!

		* * [Get lost]
			~ who("Moriarty")
			Let's go then

		* * [Don't]
			~ who("Moriarty")
			You go!

			~ who("Moriarty")
			~ mood("think")
			Well...

	* [Figure it out myself]
		~ who("Moriarty")
		I screwed up again didnt I?


-
~ who("Moriarty's Shadow")
k thx bye

~ who("Moriarty's Shadow")
~ mood("think")
Dumbass

~ who("Moriarty")
See you soon

# Moriarty # Moriarty's Shadow # Jonh

~ who("Jonh")
Hello you two!


-> END
