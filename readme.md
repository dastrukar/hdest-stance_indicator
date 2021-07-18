# HDest Stance Indicator
A simple clientside addon for HDest that adds a "stance indicator" *(like the one you'd see in ARMA)*.

Thanks to PhysixCat for the idea.

![](https://cdn.discordapp.com/attachments/713246305392001055/856878292706525204/unknown.png)

---
Everything in this mod is configured through CVars,
because I can't be bothered to make custom menu stuff.
 
All of this is generated from
the readme.md provided with this addon.

So you can read that instead if you want.

## ====CVars====

## RENDERING

### [bool]
### hdstance_auto
If true, will automatically position
speed and braced indicator.

### [int]
### hdstance_scalex, hdstance_scaley
Determines the scale of
the indicators enabled and the box shadow.

### [float]
### hdstance_alpha
Determines the alpha transparency of
the stance and speed indicator.

### [bool]
### hdstance_showspeed
If true, will display a speed indicator
below the stance indicator.

### [bool]
### hdstance_showbraced
If true, will display a braced indicator
below the stance indicator.

### [bool]
### hdstance_drawshadowbox
If true, will display a shadow box
behind the stance indicator.

### [int]
### hdstance_boxsizex, hdstance_boxsizey
Determines the size of the shadow box.


## POSITIONING

### [int]
### hdstance_posx, hdstance_posx
Determines the position of the stance indicator.

### [int]
### hdstance_speedoffsetx, hdstance_speedoffsety
Determines the offset of
the speed indicator.
(ignored if hdstance_auto is true)

### [int]
### hdstance_bracedoffsetx, hdstance_bracedoffsety 
Determines the offset of
the braced indicator.
(ignored if hdstance_auto is true)

### [int]
### hdstance_boxoffsetx, hdstance_boxoffsety
Determines the offset of the shadow box.


## INDICATOR TEXT

### [string]
### hdstance_speedtext
The string used for indicating the speed.

### [string]
### hdstance_bracedtext
The string used for indicating if the weapon is braced.

### [int]
### hdstance_bracedtextrepeat
Determines how much hdstance_bracedtext
will be repeated when displayed.


## FLAGS

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
### hdstance_speedtextalign, hdstance_bracedtextalign
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
