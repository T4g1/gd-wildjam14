INCLUDE common.ink

-> start
=== start ===

{
    - has("Gun"):
        -> armed
}

# Erwin
~ who("Erwin")
Grmbl qui a encore fermé cette porte ?  RICHARD !

# Richard
~ who("Richard")
OUI MONSIEUR ?

~ pause_after()

# Erwin
~ who("Erwin")
Putain gueule pas t'es juste à côté couillon x)

-> start

=== armed ===

# Richard
~ who("Richard")
OKAY I CALL THE COP DANGEROUS CRIMINAL WHO HAS A GUN!!!!!

~ game_over()

-> END
