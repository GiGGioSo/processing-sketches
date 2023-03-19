#!/usr/bin/env python
# -*- coding: utf-8 -*-
# make a font based on the IBM 029 Keypunch 5×7 matrix
# scruss - 2017-03
# (this is meant for Python 2.x, btw)

import json
import codecs
import fontforge
import math
import psMat

fnt_name = 'Keypunch029'

# dot radius
d = 0.1+600/7.0
r = d/2.0

# italic angle: 0.0 for none
# if you must, the value below gives a decent slant (~ 9.46°)
# italic=math.atan(1.0/6.0)*180.0/math.pi
italic=0.0

# bold?
bold=False

# dot shape: Square, Diamond or Star.
#  Anything else gets you plain old Round
shape='Round'

# not much to change after here
#  unless you want to break stuff
#################################

# coordinates of centres of dots:
#  eg lower left dot is at (328.571, 242.857)
xvals = ( 328.571, 414.285, 500.000, 585.714, 671.428 )
# yes, yvals counts down, for $REASONS
yvals = ( 757.143, 671.429, 585.714, 500.000, 414.286, 328.571, 242.857 )

# matrix translations:
# italic 1: shift LL corner to origin
mat_origin=psMat.translate(-xvals[0], -yvals[6])
# italic 2: skew by italic angle
mat_skew=psMat.skew(math.pi * italic / 180.0) # it likes radians
# italic 3: restore from origin to LL corner
mat_restore=psMat.translate(xvals[0], yvals[6])
# bold: double-strike shift is half point diameter
mat_bold=psMat.translate(r,0)
# translate refs (dunno why I have to do this)
mat_refshift=psMat.translate(46+194,0)

# a 'magic' value for approximating a circle with Bézier segments
magic = 4.0 / 3.0 * (math.sqrt(2) - 1)
# diamonds are just circles with relaxed control points, man
if (shape is "Diamond"):
    magic = magic / 2.0
# don't be tempted to make magic too large or you end up
#  with blocky yet frilly fonts that look disturbingly intestinal.

# parameters for stars
star=(3.0+math.sqrt(5))/2.0
inner=r/star
# segment angle (72°), radians
seg=math.pi * (360.0/5.0)/180.0

# read dot structure from JSON file
# resulting structure is a hash/dictionary of dot bitmap arrays
#  against unicode character

with open('Keypunch029.json') as data_file:
    chars = json.load(data_file)

font = fontforge.font(em=1000, encoding='UnicodeFull', ascent=800,
                      descent=200, design_size=12.0, is_quadratic=False,
                      fontname=fnt_name)

# try to make a glyph for every char in json
for uch in chars:
    uniname=fontforge.nameFromUnicode(ord(uch))
    # couple of glyphs this messes up on
    if (ord(uch) == 8364):
        uniname='Euro'
    if (ord(uch) == 8977):
        uniname='sqlozenge'
    glyph = font.createChar(ord(uch), uniname)
    pts=[]
    print '*** ', ord(uch), ': '
    yline = 0
    # go through glyph bitmap, placing dots where we find #s
    for li in chars[uch]:
        cy = yvals[yline]
        # only encode to prevent Python 2 from grousing about utf-8
        a_li = li.encode('ascii')
        xcol = 0
        for b in list(a_li):
            cx = xvals[xcol]
            if b == '#':
                # we have a pixel at cx, cy, so add it to the list
                pts.append(fontforge.point(cx,cy,False))
            xcol = xcol + 1
        yline = yline + 1

    # get the glyph's layer to draw on
    lyr = glyph.layers[glyph.activeLayer]
    # now transform the points and place contours in layer
    for p in pts:
        # italicize!
        if (italic > 0.0):
            p.transform(mat_origin)
            p.transform(mat_skew)
            p.transform(mat_restore)
        cx=p.x
        cy=p.y
        c = fontforge.contour()
        # draw a printer dot at (cx, cy) using chosen shape
        if (shape is "Square"):
            #
            # Draw a dot by drawing a square of side 2r
            #
            # move to start position
            c.moveTo(cx + r, cy + r)
            # draw the outline
            c.lineTo(cx + r, cy - r)
            c.lineTo(cx - r, cy - r)
            c.lineTo(cx - r, cy + r)
            c.lineTo(cx + r, cy + r)
        elif (shape is "Star"):
            #
            # Draw a 5 pointed star!
            #
            # move to start position (vertical; 90°)
            c.moveTo(cx, cy + r)
            for k in range(5):
                angle=math.pi/2 + (k+1)*seg
                inangle=angle-seg/2.0
                c.lineTo(cx + inner * math.cos(inangle),
                         cy + inner * math.sin(inangle))
                c.lineTo(cx + r * math.cos(angle),
                         cy + r * math.sin(angle))
            # I drew this anticlockwise, so fix it (ahem)
            c.reverseDirection()
        else:
            # Draw a printer dot by approximating a circle
            #  (default; also draws diamonds if magic is low)
            # move to start position
            c.moveTo(cx + r, cy)
            # cubic sector 1: from 0° to 270°, clockwise
            c.cubicTo((cx + r, cy - magic * r),
                      (cx + magic * r, cy - r),
                      (cx, cy - r))
            # cubic sector 2: from 270° to 180°, clockwise
            c.cubicTo((cx - magic * r, cy - r),
                      (cx - r, cy - magic * r),
                      (cx - r, cy))
            # cubic sector 3: from 180° to 90°, clockwise
            c.cubicTo((cx - r, cy + magic * r),
                      (cx - magic * r, cy + r),
                      (cx, cy + r))
            # cubic sector 4: from 90° to 0°, clockwise
            c.cubicTo((cx + magic * r, cy + r),
                      (cx + r, cy + magic * r),
                      (cx + r, cy))
        # ensure path is closed (important!)
        c.closed = True
        lyr += c
        
    # do double-strike effect on glyph if bold
    if (bold is True):
        new_lyr=lyr.dup()
        new_lyr.transform(mat_bold)
        lyr += new_lyr
    # update the glyph layers with our drawing
    glyph.layers[glyph.activeLayer] = lyr
    # some auto cleanups on each glyph to avoid manual work later
    # fix overlapping paths
    glyph.removeOverlap()
    # seems you have to set this too if you deliberately overlap
    glyph.unlinkRmOvrlpSave=True
    # add curve extrema (it's a font convention)
    glyph.addExtrema()
    # round all coordinates to integers
    glyph.round()
    # add PS hints, because we can
    glyph.autoHint()


# poor old space, always left to the end ...
space=font.createChar(ord(' '))
space.left_side_bearing = 47
space.right_side_bearing = 47
space.width = 522

# for all a..z, add references to A..Z glyphs since
#  we have no lower case
#  see addReference(glyph-name)
# lc glyphs are then unlinked because weirdness
for i in range(ord('a'), ord('z')+1):
    g=font.createChar(i)
    g.addReference(chr(ord('A')+i-ord('a')), mat_refshift)
    g.unlinkRef(chr(ord('A')+i-ord('a')))
    # gonna hafta manually shift all the glyph layers, as addReference doesn't
    lyr = g.layers[g.activeLayer]
    lyr.transform(mat_refshift)
    g.layers[g.activeLayer]=lyr
    # same cleanup as before, alas
    g.removeOverlap()
    g.unlinkRmOvrlpSave=True
    g.addExtrema()
    g.round()
    g.autoHint()

# one last blat through all the glyphs to set monospace parameters

for g in font.glyphs():
    g.left_side_bearing = 47
    g.right_side_bearing = 47
    g.width = 522
    
# some logic for font naming
fullname=[]
fullname.append(fnt_name)
variant=' '
if (shape is 'Square' or shape is 'Diamond' or shape is 'Star'):
    fullname.append(shape)
    
if (r<34):
    fullname.append('Light')
    font.weight='Light'
elif (r>=51):
    fullname.append('Heavy')
    font.weight='Heavy'
else:
    fullname.append('Regular')
    font.weight='Regular'

if (bold is True):
    fullname.append('Bold')
if (italic > 0.0):
    fullname.append('Italic')
flname=' '.join(fullname)

# these need to restated for some reason,
#  and even then they don't always stick in FontForge
font.encoding = 'UnicodeFull'
font.fontname = fnt_name
font.familyname=fnt_name
font.fullname=flname
font.design_size=12.0
# italic angle is negative for $reasons_i_dont_understand
font.italicangle=-italic

# save it and exit
font.save(flname+'.sfd')
