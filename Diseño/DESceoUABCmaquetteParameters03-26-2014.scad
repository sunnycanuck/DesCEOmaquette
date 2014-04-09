/*<Written by Rodger Evans, Feb. 14, 2014>
This file is a list of the parameter used for the wave energy converter model to be used in the wave tank in UABC. This is part of the DESceo project, and will be used in the wave tank in UABC.

    Copyright (C) <2014>  <Rodger Evans, revans@cicese.edu.mx>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

Coments and mods

*/
nipHole=0.4;//size of nipple hole in the 3D printer
wiggle=.2;//wiggle room
pistWgg=.5;//wiggle room for the piston
minThic=2*nipHole;//a minimum thickness for wall thickness

//LEGO standards
axisInnerDIA=4.84;//inner axis diameter
axisOuterDIA=3.00*2+wiggle;//Axis outer diameter (Lego standards)
axisThicOuter=7.85;//thickness of axis
axisThicInner=axisThicOuter-2*.87;//inside axis thickness
axisHoleSpacing=32.23/4;//distance between adjecent holes
axisBorder=2*nipHole;//the plastic around the holes; was =2
axisHolderThick=2*axisBorder+axisOuterDIA;

//Device sizes
wCyln=4;//the length of the cylinder to fix the weight
//wH=Ph/2;//the pontoon height
hullTH=5*nipHole;//thickness of the pontoon hull
sq3=sqrt(3);
rel=5.5;//relation of P to L. The larger this number, the smaller the pontoons are relative to the total size. 
L=240;//the length of each side of the upper platform. The wave tank is 280mm in width +-12mm
P=L/rel;// the diameter of the pontoons
echo("The pontoon radius is P=", P);
Ph=70;//pontoon height
echo("The pontoon height is Ph=", Ph);
Wh=Ph;
cabRun=3;//cable run diameter, this is the tube for the cable to run up the inside of the pontoon.
r=L/sq3;//this is the radius of the circle in which is inscribed the triangle with length L 
echo("The circle encompassing the whole system has radius r=", r);
h=3/2*r;//not sure what this is
nn=4;//this is how pointed the shape is. nn=1 means spherical, n=2 is more pointed.
rr=P*nn;//this is the radius of the trunked circle that makes the pointed shape
drr=P*(nn-1);//this is the displacement of the truncated circle center relative to the pontoon center
dCir=sqrt(pow(rr,2)-pow(drr,2));//this is the height of the truncated circle at the pontoon center

//wt=2;//thickness of walls between weights and cables
//weightT=meetY-3/2*wt-cabRun;//weight thickness; in y
//wC=(weightT+wt)/2;//center in y of the weight hole
//wSpace=.5;//space around the weight and hole
//

//strutt dimensions
Mx=L/2*cos(30)-r;//height above the origin of the center of the bar
My=L/4;
thic=Ph/4;//the minimum thickness of the strutt connector in the z-directon
strr=(Ph-thic)/2;//the circle being removed to the rotation
scalee=3;//the relation between the height an width of the strutt (min thickness is then thic/scalee)
xStrut=thic/scalee;//this is the thickness of the strut 
yStrut=strr/scalee;//the thickness in the y=direction of the strutt
difStrut=xStrut/2;//this is the difference in length of the inner part of the strut to the outer (at one end)
Cdist=sq3*P;//this is the cord that goes from the upper center intersec of the circle and a triangle to the intersect at one of the bottoms 
struttDIST=L-2*Cdist-difStrut;//this is the distance from one pontoon to the other.
struttLGTH=struttDIST/2;//this is the half distance from one pontoon to the other.
fit=axisHolderThick;//the fitting piece for the strutts
Ct=thic/scalee;//the thickness of the connecting pieces was =5


//piston dimensions
beltWidth = 3.4;
beltThickness = 0.65;
wiggle=.2;//wiggle room
pistWgg=.5;//wiggle room for the piston
pistH=Ph/2;// this is the height of the pistons
pWall=3*nipHole;//wall thickness of the piston
meetY=(P-Ct)/sq3;//P-Ct/2*cos(60); this is the distance from the center of the pontoon to where the cables come through (the intersect of the center of the pontoon and the arms coming from the neighbouring pontoon.
holX=meetY;
dCirCab=sqrt(pow(rr,2)-pow(-drr-holX,2))+3*cabRun;//this is the height of the cable run cylinder
rPistTubeINN=(P-hullTH*3/2-pistWgg)*.34;//this is the radius of the weights (or piston)
echo("the radius of the weights is rPist=",rPist);
rPist=rPistTubeINN-1*pistWgg;//inner piston tube wall
rPistTubeOUT=rPistTubeINN+hullTH;//outer piston tube wall
dCirPist=sqrt(pow(rr-hullTH,2)-pow(drr+2*rPistTubeINN,2));//this is the height of the piston cylinder
PistCentX=rPistTubeINN+hullTH/2;//x location of the piston center
pistAng=atan((rPistTubeINN+hullTH/2)/holX);//this is the angle from the center of the cable tubes to the piston center
pistCent=rPistTubeINN+hullTH/2;//center of the pistons in x-direction
strutLength=L-2.5*P;
delX=PistCentX;// run from cable run to piston center
delY=holX;//rise from cable run to piston center
hBase=rPistTubeOUT+axisHolderThick/2;//the distance from the center of the piston to the axisPostBase 
yR=(hBase*delY)/sqrt(pow(delX,2)+pow(delY,2));//the x location of the axisPostBase at the piston
xR=delX*(1+yR/delY);//the y location of the axisPostBase at the piston
distPostCab=sqrt(pow(xR,2)+pow(yR+holX,2));
PostBaseH=Ph/4;//height of the post bases

//bottom platform
relB=1;//relation of Pb to P
PbTH=nipHole*4;//thickness of bottom pontoon tank's walls.
Pb=P/relB;
relBh=1;//relation of Pbh to Ph
Pbh=Ph/relB;//the height of the bottom pontoon cylinder
PbhC=Pbh/2;//the height of the bottom pontoon cylinder cone 
PbhD=Pbh/4;//the size of the cone bottom disk for the hole exit.
PbhH=PbhD-2*PbTH;//the size of the hole radius on the bottom of the bottomPontoon.

//bottom platform rail
//riser
Rrth=5;//the half thickness of the rail riser
Rrh=5;//the height of the rail riser
//angle, this may not be needed
Rath=5;//the thickness of the angle
Rah=5;//the height of the angle
//body
Rth=13;//the half thickness of the rail
Rh=8;//the height of the rail

Rl=r; //the rail length
//these are the points in the rail, going around counter clockwis, starting in Q1
pp1x=Rrth;
pp1y=Rrh;
pp2x=Rth;
pp2y=Rrh+Rah;
pp3x=Rth;
pp3y=Rrh+Rah+Rh;

bottomRailL=r-P/3;
echo("Bottom Rail length=",bottomRailL);

res=80;