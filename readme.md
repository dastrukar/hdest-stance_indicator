# HDest Stance Indicator
A simple clientside addon for HDest that adds a "stance indicator" *(like the one you'd see in ARMA)*.

Thanks to PhysixCat for the idea.

![](https://cdn.discordapp.com/attachments/713246305392001055/856878292706525204/unknown.png)

---
Everything in this mod is configured through CVars,
because I can't be bothered to make custom menu stuff.
/
All of this is generated from
the readme.md provided with this addon.

So you can read that instead if you want.

## CVars
### hdstance_posx, hdstance_posx
Determines the position of the stance indicator.

### hdstance_scalex, hdstance_scaley
Determines the scale of
the stance and speed indicator.

### hdstance_offsetx, hdstance_offsety
Determines the offset of
the speed and braced indicator.

### hdstance_alpha
Determines the alpha transparency of
the stance and speed indicator.

### hdstance_showspeed
If true, will display a speed indicator
below the stance indicator.

### hdstance_speedtext
The string used for indicating the speed.

### hdstance_showbraced
If true, will display a braced indicator
below the stance indicator.

### hdstance_bracedtext
The string used for indicating if the weapon is braced.

### hdstance_drawshadowbox
If true, will display a shadow box
behind the stance indicator.

### hdstance_screenflags XYZ
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
