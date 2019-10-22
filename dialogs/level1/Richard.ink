INCLUDE ../common.ink

VAR has_chocolate = false

-> start
=== start ===

# Richard
~ who("Richard")

What is hapening mister? There was some ground shaking and a mysterious black figure went out with your keys and closed the door behind him

# Erwin
~ who("Erwin")
He locked me inside that son... !? Well, give me your keys then

# Richard
~ who("Richard")
Er... I don't know where they are...

# Erwin
~ who("Erwin")
What? But you don't forget anything usualy

# Richard
~ who("Richard")
I dont know mister, since the ground shaking, I dont feel well at all and I experience loads of memory losses

~ switch_realm()

# Erwin
~ who("Erwin")
~ mood("think")
Wow, again? Wait, is that my shadow?

# Richard's Shadow
~ who("Richard's Shadow")
Who are you? What are you doing in this stupid Erwin's house?

# Erwin
~ who("Erwin")
* [I'm Erwin]
    Maybe I'm here because I am Erwin and maybe you should be more polite?

    # Richard's Shadow
    ~ who("Richard's Shadow")
    Well, that would surprise me a lot, you do look like him but a bit less winy if you ask me

* Is that you Richard?
    # Richard's Shadow
    ~ who("Richard's Shadow")
    How do you know my name? You look less dumb than my boss

-

# Erwin
~ who("Erwin")
~ mood("think")
Seems like it is Richard's Shadow but it looks like he got the exact opposite characteristics, like my own shadow. It may explain why he is so execrable

~ who("")
In the Shadow Realm, the characters have a behavior opposite to their human alter ego, use that to identify them

# Erwin
~ who("Erwin")
Forget that, do you know where is the front door key?

# Richard's Shadow
~ who("Richard's Shadow")
I'm afraid not, I don't find those. Anyway, I loose everything and I don't see a reason to give it to you

# Erwin
~ who("Erwin")
~ mood("think")
Maybe they loose memory when they are sperated. I should try to re-unite them. Maybe if I can manage to superimpose them on both plan ?...

~ who("")
To merge a shadow with it's human alter ego, you must lead them to do the exact same thing at the exact same time on both the real world and the shadow realm

~ switch_realm()

# Erwin
~ who("Erwin")
I'll puke if this keeps hapenning but I believe I've found the trick

~ unlock("shadow_switching")

~ who("")
You can now interact with the strange looking ripling on the walls. This will allow you to travel to the Shadow Realm and back.

# Richard
~ who("Richard")
Mister, that is incredible! You disapeared during a while!

# Erwin
~ who("Erwin")
Yes, yes, incredible I am

# Erwin
~ who("Erwin")
~ mood("think")
Well, now how to make that dumbass sit somewhere and not move anymore?...

I probably should check him out first and learn a thing or two about him...

VAR dislike = false
VAR like = false

-> quizz_richard
=== quizz_richard ===

{ has_chocolate && like && dislike:
    -> move_sofa
}

# Erwin
~ who("Erwin")
+ What do you hate?
    # Richard
    ~ who("Richard")
    You do know that I dislike cockroach, disorder and mess, don't you?

    # Erwin
    ~ who("Erwin")
    I didn't because I wasn't interested in fact...

    ~ dislike = true

+ What do you love ?
    # Richard
    ~ who("Richard")
    Kind to ask sir, I do love chocolate

    ~ like = true

+ { like && dislike } Nothing
    -> after_quizz

- -> quizz_richard


=== after_quizz ===

~ pause_after()

~ who("")
You know more about Richard and his shadow now, chocolate and cockroach, try to use that information

-> quizz_richard


=== move_sofa ===

# Richard
~ who("Richard")
Thank you sir! I'll go eat that in the sofa

~ move("Richard", "sofa")

~ learn("richard_sofa")

-> chocolate
=== chocolate ===

{
    knows("Richard_is_complete"):
        -> complete
}

~ pause_after()

~ who("Erwin")
~ mood("think")
He is eating his chocolate, better not to disturb him. I know he hates cockroach so that mean his shadow probably loves them... Eeek

-> chocolate

=== complete ===

# Richard
~ who("Richard")

Woaw ! Je ne sais pas ce qui s’est passé monsieur mais je me sens à nouveau complet. Les clefs de secours sont sous l’escalier en fait. D’ailleurs je crois me souvenir que la forme noire qui est passé à marmonné quelque chose comme "J’arrive ma nouvelle famille !"

~ learn("master_key_location")

# Erwin
~ who("Erwin")
Oh me dis pas qu’il est retourné à la maison familial celui-là...

-> END
