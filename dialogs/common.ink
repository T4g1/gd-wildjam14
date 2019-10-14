VAR character_name = "Moriarty"
VAR character_mood = "normal"
VAR paused = 0


=== function who(value) ===
    ~ character_mood = "normal"
    ~ character_name = value


=== function mood(value) ===
    ~ character_mood = value


=== function pause_after() ===
    ~ paused = 1
