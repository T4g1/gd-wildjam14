INCLUDE ../common.ink

# Richard's Shadow
~ who("Richard's Shadow")
Can you stop those pesky magical back and forth in my room? You are not at home you know?

-> start
=== start ===

# Erwin
~ who("Erwin")
+ { knows("richard_sofa") } I give you a raise if you get on that sofa
    ~ pause_after()

    # Richard's Shadow
    ~ who("Richard's Shadow")
    My salary? Who are you to say that? Get the fuck out!

+ { knows("richard_sofa") && knows("sofa_is_infested") } There's cockroach on that sofa
    # Richard's Shadow
    ~ who("Richard's Shadow")
    Really? I should check that out. Oh, and get the fuck out!

    ~ move("Richard's Shadow", "sofa")

    ~ learn("shadow_sofa")

    ~ pause_after()

    ~ who("Erwin")
    ~ mood("think")
    perfect!

+ Nothing
    ~ pause_after()
    I should probably continue to look for clues...

-

-> start
