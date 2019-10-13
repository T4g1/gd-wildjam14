VAR character_name = "Moriarty"
VAR character_mood = "normal"


~ who("Moriarty")
~ mood("think")
What the hell happenned?

~ mood("think")
* [Ask my shadow]
	~ who("Moriarty's Shadow")
	Get lost looser!

	* * [Get lost]
		~ who("Moriarty")
		Let's go then
		-> after_though

	* * [Don't]
		~ who("Moriarty")
		You go!

		~ who("Moriarty")
		~ mood("think")
		Well...
		-> after_though

* [Figure it out myself]
	~ who("Moriarty")
	I screwed up again didnt I?
	-> after_though

= after_though

~ who("Moriarty's Shadow")
k thx bye

~ who("Moriarty's Shadow")
~ mood("think")
Dumbass

~ who("Moriarty")
See you soon


-> END


=== function who(value) ===
	~ character_mood = "normal"
	~ character_name = value


=== function mood(value)
	~ character_mood = value
