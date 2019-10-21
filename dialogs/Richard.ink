INCLUDE common.ink

-> start
=== start ===

# Richard
~ who("Richard")

Monsieur que se passe-t-il ? Il y a eu un tremblement et un personnage noir est parti avec vos clefs en fermant derrière lui.

# Erwin
~ who("Erwin")
Mais il m’a enfermé en plus ce … ? Bon donnez-moi vos clefs alors.

# Richard
~ who("Richard")
Je… Je ne sais pas où elles sont.

# Erwin
~ who("Erwin")
Quoi ? Mais vous n’oubliez mais ne perdez jamais rien d’habitude.

# Richard
~ who("Richard")
Je ne sais pas monsieur. Depuis le tremblement de terre je ne me sens pas bien et j’ai pleins de trou de mémoire monsieur.

~ switch_realm()

# Erwin
~ who("Erwin")
~ mood("think")
Wow encore ? Mais ? C’est mon ombre ça ?

# Richard's Shadow
~ who("Richard's Shadow")
T’es qui toi ? Qu’est-ce que tu fiches ici dans le manoir de cet abruti d’Erwin ?

# Erwin
~ who("Erwin")
* Bah peut-être car Erwin c’est moi ? Et puis un peu de politesse merde !
    # Richard's Shadow
    ~ who("Richard's Shadow")
    ça m’étonnerait beaucoup, vous lui ressemblez un peu mais vous ne semblez pas être un aussi gros nul que lui.

* C’est toi Richard ?
    # Richard's Shadow
    ~ who("Richard's Shadow")
    Comment tu sais comment je m’appelle ? Tu as l’air moins abruti que celui pour qui je travaille.

-

# Erwin
~ who("Erwin")
~ mood("think")
D’accord, ça doit être l’ombre de Richard mais il semble avoir le caractère opposé, comme ma propre ombre.  Ça explique pourquoi il est exécrable.

~ who("")
Dans le monde des ombres, les personnages ont un comportement opposé à leur alter ego humain, servez-vous en pour identifier à l’ombre de qui vous parlez via le menu de personnalités

# Erwin
~ who("Erwin")
Oubliez tout ça. Vous ne savez pas où sont les clefs de l’entrée ?

# Richard's Shadow
~ who("Richard's Shadow")
Non je les trouve plus, de toute façon je perds toujours tout. Puis je vois pas pourquoi je vous les donnerais en fait.

# Erwin
~ who("Erwin")
~ mood("think")
Peut-être qu’ils perdent des morceaux de souvenir dans la séparation. Je devrais essayer de les réunir. Peut-être qu’en superposant les plans ?...

~ who("")
Pour réunir un individu et son ombre vous devez faire en sorte que les deux fassent exactement la même chose au même moment sur les deux plans

~ switch_realm()

# Erwin
~ who("Erwin")
Je vais gerber si ça continue, mais je crois que j’ai compris le principe.

~ who("")
Appuyez sur *input* pour basculer d’un plan à l’autre

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
