//OpenBeam components
include<DESceoUABCmaquetteParameters.scad>
/*<Written by Rodger Evans, Feb. 14, 2014>
this code describes the OpenBeam components for a wave energy generator based on a stewart/gough platform, to be used in the wave tank in UABC. This is part of the DESceo project, and will be used in the wave tank in UABC.

Information on OpenBeam can be found here: http://www.openbeamusa.com/about/

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

/////////////////////////////
//modules
///////////////////////////
module OpenBeam(length){
 linear_extrude(height=length)
import("openbeam.dxf");
}

module OpenBeamHole(length,Xtra,div){//this is to make a hole to fit the beam through. It can work with any object. It displaces it Xtra in all directons, with div divisions in the full circle. div=4 will give four displacements, up left, up right, down L, down R. etc.. there is a 45degree phase start, called phi.
deltaTheta=floor(360/div);
phi=45;
union(){
	for(i=[1:div]){
	translate([Xtra*sin(i*deltaTheta+phi),Xtra*cos(i*deltaTheta+phi),0]) OpenBeam(length);
	}
translate([0,OBstep/2,length/2]) cube([OBchannel,OBcubeBlock,length], center=true);
}
}

module M3screw(length,res){
cylinder(r=1.5, h=length, $fn=res, center=true);
}

module M3ScrewGroup(length,res){//these are holes for 4-40 screws
	translate([0,-P/3,Ph/2]) M3screw(Ph,res);
	translate([0,-P/3,Ph/2-OBchannel/2])cube([OBchannel,OBchannel,OBchannel],center=true);//the cube makes a space for a 4-40 nut
	translate([0,-P*2/3,Ph/2]) M3screw(Ph,res);
	translate([0,-P*2/3,Ph/2-OBchannel/2])cube([6.4,6.4,6.4],center=true);
}

lckBlkX=8;//the block sides
lckBlcZ=4;//the block depth`
lckRad=2.5;//the radius of the spindle
lckSpRad=4;//the radius of the raised edge of the spindle 
lckSpZ=1;//the depth of the raised edge of the spindle 
lckBush=2;//the depth of the bushings
lckSpoolZ=13;//the depth of the spool
lckKnobZ=10;//the depth of the knobs
lckKnobRad=4;//the radius of the knob 
lckCyn1Z=lckBlcZ+lckBush+lckSpoolZ;//the depth of the first cylinder section
lckCyn2Z=lckBlcZ+lckBush+pistWgg;//the depth of the second cylinder section 
lckSpPos1=2*lckBlcZ+lckBush+pistWgg+lckSpZ*3/2; 
lckSpPos2=2*lckBlcZ+lckBush+lckSpoolZ/2+pistWgg+lckSpZ/2; 
lckSpPos3=2*lckBlcZ+lckBush+lckSpoolZ; 
lckHolePos1=lckSpPos2-lckSpoolZ/4;
//2*lckBlcZ+lckBush+lckSpoolZ*1/4;
lckHolePos2=lckSpPos2+lckSpoolZ/4;//2*lckBlcZ+lckBush+lckSpoolZ*3/4;
lckRingWall=4*nipHole;
lckRingSetX=3;//the thickness for the set screw
lckRingZ=lckBlcZ+lckBush-wiggle;
lckRingX=OBchannel+2*lckBlkX+4*lckRingWall+2*lckRingSetX;
lckRingY=lckBlkX+2*lckRingWall;
lcxRingAxisX=lckBlcZ/2+OBchannel+lckRingWall;
lckRingPos1=lckRingZ/2+wiggle;
lckRingPos2=lckRingZ/2+lckSpoolZ+2*lckBlcZ+lckBush+wiggle;
lckSledBaseY=OBchannelDepth+lckRingWall;//the thickness of the sled base
lckSledBaseZ=lckRingPos2+2*lckRingZ;
SpaceScale=(lckRad+pistWgg/2)/lckRad;
SledPosY=lckSledBaseY/2+lckRingY/2;//lckRingY/2+lckRingWall+
squareHolePY=lckRingY/2+OBchannelDepth/2+lckRingWall+wiggle;//the Y position of the square cutout in the bottom of the sled.
ScrewHoleLckTP=lckBlkX+2*lckRingWall+2*wiggle;//the length of the screw hole on the top block

module SpLip(){
translate([0,0,lckSpZ]) cylinder(r2=lckRad , r1=lckSpRad, h=lckSpZ,center=true,$fn=res);//the spindle cylinder lock P1
translate([0,0,0]) cylinder(r=lckSpRad, h=lckSpZ,center=true,$fn=res);//the spindle cylinder lock P1
translate([0,0,-lckSpZ]) cylinder(r1=lckRad , r2=lckSpRad, h=lckSpZ,center=true,$fn=res);//the spindle cylinder lock P1
}

module lockAxis(){
difference(){
union(){
translate([0,0,-lckBlcZ/2]) cube([lckBlkX,lckBlkX,lckBlcZ],center=true);//first block 
translate([0,0,-lckSpPos1])SpLip();
translate([0,0,-lckSpPos2]) SpLip();
translate([0,0,-lckSpPos3]) SpLip();
translate([0,0,-lckBlcZ-lckCyn1Z/2]) cylinder(r=lckRad, h=lckCyn1Z,center=true,$fn=res);//the cylinder with the spool 
translate([0,0,-lckBlcZ-lckCyn1Z-lckBlcZ/2]) cube([lckBlkX,lckBlkX,lckBlcZ],center=true);//the second block
translate([0,0,-2*lckBlcZ-lckCyn1Z-lckCyn2Z/2]) cylinder(r=lckRad, h=lckCyn2Z,center=true,$fn=res);//the second cylinder 
translate([0,0,-2*lckBlcZ-lckCyn1Z-lckCyn2Z]) cylinder(r1=lckKnobRad , r2=lckRad, h=lckSpZ,center=true,$fn=6);
translate([0,0,-2*lckBlcZ-lckCyn1Z-lckCyn2Z-lckKnobZ/2-lckSpZ/2]) cylinder(r=lckKnobRad, h=lckKnobZ,center=true, $fn=6);//the gripper 
}
translate([0,0,-lckHolePos1]) rotate([0,90,0])cylinder(r=0.5, h=2.3*lckRad, center=true, $fn=res);
translate([0,0,-lckHolePos2]) rotate([90,0,0]) cylinder(r=0.5, h=2.3*lckRad, center=true, $fn=res);
}
}

module lockRingTp(){
difference(){//removing the spindle and the mounting screws 

union(){//the two bottom pieces
translate([0,0,-lckRingPos1]) cube([lckRingX,lckRingY,lckRingZ], center=true);
//translate([0,0,-lckRingPos2]) cube([lckRingX,lckRingY,lckRingZ], center=true);
}
translate([lcxRingAxisX,0,0]) scale([SpaceScale,SpaceScale,1])lockAxis();
translate([-lcxRingAxisX,0,0]) scale([SpaceScale,SpaceScale,1])lockAxis();
translate([-lcxRingAxisX,lckRingY/4+wiggle,-lckRingPos1]) cube([lckBlkX+2*pistWgg,lckRingY/2+wiggle, lckRingZ+wiggle],center=true);
translate([lcxRingAxisX,lckRingY/4+wiggle,-lckRingPos1]) cube([lckBlkX+2*pistWgg,lckRingY/2+wiggle, lckRingZ+wiggle],center=true);
//translate([-lcxRingAxisX,lckRingY/4+wiggle,-lckRingPos2]) cube([lckBlkX+2*pistWgg,lckRingY/2+wiggle, lckRingZ+wiggle],center=true);
//translate([lcxRingAxisX,lckRingY/4+wiggle,-lckRingPos2]) cube([lckBlkX+2*pistWgg,lckRingY/2+wiggle, lckRingZ+wiggle],center=true);
translate([lcxRingAxisX+lckSledBaseY/2+lckBlkX/2,0,-lckBlcZ/2-pistWgg]) rotate([0,90,0]) M3screw(lckSledBaseY+wiggle,res);
translate([-(lcxRingAxisX+lckSledBaseY/2+lckBlkX/2),0,-lckBlcZ/2-pistWgg]) rotate([0,90,0]) M3screw(lckSledBaseY+wiggle,res);
translate([0,-lckRingY/2+ScrewHoleLckTP/2-wiggle,-(lckBush+lckBlcZ)/2]) rotate([90,0,0]) M3screw(ScrewHoleLckTP,res);//this is the top screw hole
//translate([0,lckRingY/2+lckRingWall-wiggle,-lckRingPos2]) rotate([90,0,0]) M3screw(lckBlkX+2*lckRingWall+wiggle,res);//this is the bottom screw hole
}
}

module lockRingBttm(){
difference(){
union(){
translate([-lcxRingAxisX,lckRingY/4+wiggle,-lckRingPos1]) cube([lckBlkX+pistWgg,lckRingY/2, lckRingZ],center=true);
translate([lcxRingAxisX,lckRingY/4+wiggle,-lckRingPos1]) cube([lckBlkX+pistWgg,lckRingY/2, lckRingZ],center=true);
translate([-lcxRingAxisX,lckRingY/4+wiggle,-lckRingPos2]) cube([lckBlkX+pistWgg,lckRingY/2, lckRingZ],center=true);
translate([lcxRingAxisX,lckRingY/4+wiggle,-lckRingPos2]) cube([lckBlkX+pistWgg,lckRingY/2, lckRingZ],center=true);
translate([0,SledPosY,-lckSledBaseZ/2]) cube([lckRingX,lckSledBaseY,lckSledBaseZ],center=true);//the sled base
}
translate([lcxRingAxisX,0,0]) scale([SpaceScale,SpaceScale,1])lockAxis();
translate([-lcxRingAxisX,0,0]) scale([SpaceScale,SpaceScale,1])lockAxis();
translate([0,lckSledBaseY+OBoutside/2+lckRingY/2-OBslotDepth+lckRingWall/2,-lckSledBaseZ])OpenBeamHole(lckSledBaseZ+wiggle,wiggle,8);
translate([0,lckRingY/2+lckRingWall-wiggle,-lckSledBaseZ/2]) rotate([90,0,0]) M3screw(lckSledBaseY+2*lckRingWall+wiggle,res);//the hole to fix the sled to the beam 
translate([0,lckRingY/2+lckRingWall-wiggle,-(lckBush+lckBlcZ)/2]) rotate([90,0,0]) M3screw(lckSledBaseY+wiggle,res);//this is the top screw hole
translate([0,squareHolePY,-(lckBush+lckBlcZ)/2]) cube([OBchannel,OBchannelDepth,OBnutHeight],center=true);
translate([0,lckRingY/2+lckRingWall-wiggle,-lckRingPos2]) rotate([90,0,0]) M3screw(lckSledBaseY+wiggle,res);//this is the bottom screw hole
translate([0,squareHolePY,-lckRingPos2]) cube([OBchannel,OBchannelDepth,OBnutHeight],center=true);
}
}

lockRingTp();
translate([0,0,-lckRingPos2+lckRingPos1])lockRingTp();
lockRingBttm();
translate([lcxRingAxisX,0,0]) lockAxis();
translate([-lcxRingAxisX,0,lckBlcZ+wiggle]) lockAxis();
