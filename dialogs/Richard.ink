INCLUDE common.ink

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

~ who("")
Interact with shadow Appuyez sur XXXX pour basculer d’un plan à l’autre

# Richard
~ who("Richard")
Oh monsieur c’est incroyable ! Vous avez disparu pendant un instant !

# Erwin
~ who("Erwin")
Oui oui je sais je suis incroyable.

# Erwin
~ who("Erwin")
~ mood("think")
Bon comment faire en sorte qu’il se mette quelque part et ne bouge plus ?..

Je vais devoir m’intéresser ce benêt.

-> quizz_richard
=== quizz_richard ===

# Erwin
~ who("Erwin")
+ Qu’est-ce qui vous insupporte Richard ?
    # Richard
    ~ who("Richard")
    Eh bien, sans vous manquez de respect, vous savez bien que je déteste le désordre et les cafards non ?

    # Erwin
    ~ who("Erwin")
    Non j’en avais aucune idée car j’en avais pas grand-chose à faire en fait.

+ Qu’est-ce que vous ferait plaisir Richard ?
    # Richard
    ~ who("Richard")
    Oh c’est gentil de demander, eh bien j’adore le chocolat.

+ Nothing
    -> after_quizz

- -> quizz_richard


=== after_quizz ===

~ pause_after()

~ who("")
Vous en avez appris davantage sur Richard et donc sur son ombre, regardez son onglet personnalité

-> quizz_richard

-> END
