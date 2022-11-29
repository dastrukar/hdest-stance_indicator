# HDest Stance Indicator
A simple clientside addon for HDest that adds a "stance indicator" *(like the one you'd see in ARMA)*.

Thanks to PhysixCat for the idea, FDA for making the player skin edit of Stance Indicator, and prettyFist for the strip indicator idea.

![](https://cdn.discordapp.com/attachments/713246305392001055/856878292706525204/unknown.png)

---
Everything in this mod is configured through CVars,
because I can't be bothered to make custom menu stuff.
 
All of this is generated from
the readme.md provided with this addon.

So you can read that instead if you want.

## General CVars

### [int]
### hdstance_scalex, hdstance_scaley
Determines the scale of
the indicators enabled and the box shadow.

### [float]
### hdstance_alpha
Determines the alpha transparency of
the all indicators.

### [int]
### hdstance_posx, hdstance_posx
Determines the position of the stance indicator.

### [bool]
### hdstance_usestencil
If true, the stance icon will be rendered with a single colour.
(similar to how the default stance icon is shown)

### [bool]
### hdstance_useplayercol
(REQUIRES hdstance_usestencil TO BE TRUE)
If true, the stance icon will use the player's colour.


## Speed Indicator CVars

### [bool]
### hdstance_showspeed
If true, will display an indicator
that shows whether you're walking, jogging, or running.

### [int]
### hdstance_speedoffsetx, hdstance_speedoffsety
Determines the offset of
the speed indicator.

### [string]
### hdstance_speedtext
The string used for indicating the speed.


## Brace Indicator CVars

### [bool]
### hdstance_showbraced
If true, will display an indicator
that shows if your weapon is braced.

### [int]
### hdstance_bracedoffsetx, hdstance_bracedoffsety 
Determines the offset of
the braced indicator.

### [string]
### hdstance_bracedtext
The string used for indicating if the weapon is braced.

### [int]
### hdstance_bracedtextrepeat
Determines how much hdstance_bracedtext
will be repeated when displayed.


## Strip Indicator CVars

### [bool]
### hdstance_showstrip
If true, will display an indicator
that shows the StripTime.

### [int]
### hdstance_stripoffsetx, hdstance_stripoffsety 
Determines the offset of
the strip indicator.

### [bool]
### hdstance_stripusetic
If true, strip indicator will use Tics
instead of converting it to seconds.

### [bool]
### hdstance_stripalwaysshow
If true, strip indicator will always be visible
when the time is 0.


## Shadow Box CVars

### [bool]
### hdstance_drawshadowbox
If true, will display a shadow box
behind the stance indicator.

### [int]
### hdstance_boxoffsetx, hdstance_boxoffsety
Determines the offset of the shadow box.

### [float]
### hdstance_boxalpha
Determines the alpha transparency of
the shadow box.

### [int]
### hdstance_boxsizex, hdstance_boxsizey
Determines the size of the shadow box.


## Skinned CVars

### [bool]
### hdstance_skinned
If true, the stance icon will use the player's skin.

### [bool]
### hdstance_animate
(REQUIRES hdstance_skinned TO BE TRUE)
If true, the stance icon will follow the player's actions.

### [int]
### hdstance_angle
(REQUIRES hdstance_skinned TO BE TRUE)
Sets the player's stance angle to face.
Valid values are 1-8.

### [bool]
### hdstance_useplayerangle
(REQUIRES hdstance_skinned TO BE TRUE)
If true, the stance icon will use the player's angle.

### hdstance_compass
(REQUIRES hdstance_useplayerangle TO BE TRUE)
If true, will use old rotation calculations.

### [bool]
### hdstance_speen
(REQUIRES hdstance_skinned TO BE TRUE)
SPEEN

### [bool]
### hdstance_speenrate
(REQUIRES hdstance_skinned TO BE TRUE)
Determines how fast the player's stance will speen.
(the lower the value, the faster it'll speen)


## Flag CVars

### [int]
### hdstance_screenflags
Determines what position flags will be used.
 
Syntax: XYZ
```
- X -
1: NONE
2: BOTTOM
3: TOP
- Y -
1: NONE
2: CENTER
3: VCENTER
4: HCENTER
- Z -
1: NONE
2: LEFT
3: RIGHT
```

### [int]
### hdstance_speedtextalign, hdstance_bracedtextalign, hdstance_striptextalign
Determines how the text will be aligned.

Syntax: XY
```
- X -
1: HORIZONTAL
2: VERTICAL
- Y -
1: LEFT
2: CENTER
3: RIGHT

(if X = VERTICAL)
1: TOP
2: CENTER
3: BOTTOM
```


## Compatibility CVars

### [bool]
### hdstance_enablehhelmetcompat
(Requires Hideous Helmet)
If enabled, will hide the stance indicator
when the player isn't wearing a helmet.
