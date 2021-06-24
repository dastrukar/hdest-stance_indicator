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

## CVars
### [bool]
### hdstance_auto
If true, will automatically position
speed and braced indicator.

### [int]
### hdstance_posx, hdstance_posx
Determines the position of the stance indicator.

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

### [int]
### hdstance_speedoffsetx, hdstance_speedoffsety
Determines the offset of
the speed indicator.
(ignored if hdstance_auto is true)

### [string]
### hdstance_speedtext
The string used for indicating the speed.

### [bool]
### hdstance_showbraced
If true, will display a braced indicator
below the stance indicator.

### [int]
### hdstance_bracedoffsetx, hdstance_bracedoffsety 
Determines the offset of
the braced indicator.
(ignored if hdstance_auto is true)

### [string]
### hdstance_bracedtext
The string used for indicating if the weapon is braced.

### [bool]
### hdstance_drawshadowbox
If true, will display a shadow box
behind the stance indicator.

### [int]
### hdstance_boxsizex, hdstance_boxsizey
Determines the size of the shadow box.

### [int]
### hdstance_boxoffsetx, hdstance_boxoffsety
Determines the offset of the shadow box.

### [int]
### hdstance_screenflags XYZ
Determines what position flags will be used.
 
Syntax:
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
