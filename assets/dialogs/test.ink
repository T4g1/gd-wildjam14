LIST Moods = normal, think

VAR character_name = "Moriarty"
VAR character_mood = normal


~ who("Moriarty")
~ mood(think)
What the hell happenned?

~ who("Moriarty's Shadow")
Get lost looser! Get lost looser! Get lost looser! Get lost looser! Get lost looser! 
Get lost looser! Get lost looser! Get lost looser! Get lost looser! Get lost looser! 
Get lost looser! Get lost looser! Get lost looser! Get lost looser! Get lost looser! 
Get lost looser! Get lost looser! Get lost looser! Get lost looser! Get lost looser! 
Get lost looser! Get lost looser! Get lost looser! Get lost looser! Get lost looser! 
Get lost looser! Get lost looser!

~ who("Moriarty")
Oh nose I broke the world	 

~ who("Moriarty's Shadow")
I will now go to the end of the game, have fun to find me 

~ who("Moriarty")
Damn, I need to play this game to find you du coup 

~ mood(think)
* [I remember...]
	~ who("Moriarty's Shadow")
	Do you even listen to me?
	-> after_though
	
* [omagad i can think]
	~ who("Moriarty")
	AH AH I CAN THINK
	-> after_though

= after_though

~ who("Moriarty's Shadow")
k thx bye

~ who("Moriarty's Shadow")
bug?


-> END


=== function who(value) ===
	~ character_mood = normal
	~ character_name = value


=== function mood(value)
	~ character_mood = value