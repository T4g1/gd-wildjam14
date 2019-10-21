INCLUDE ../common.ink

-> content
=== content ===

{   has("Appartment's key"):
        -> end
}

# Erwin
~ who("Erwin")
~ mood("think")
Gosh, who closed that door?

~ who("Erwin")
RICHARD!?

# Richard
~ who("Richard")
YES SIR ? I'M RIGHT HERE

~ pause_after()

# Erwin

~ who("Erwin")
~ mood("think")
Let's go and ask him for the keys

-> content

=== end ===

-> END
