//Piston
include<DESceoUABCmaquetteParameters.scad>
include<lego.scad>;
include<cableTube.scad>;


/*<Written by Rodger Evans, Feb. 14, 2014>
this code describes the piston and its housing for a wave energy generator model based on a stewart/gough platform, to be used in the wave tank in UABC. This is part of the DESceo project, and will be used in the wave tank in UABC.

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

module PistonRun(res){
difference(){//get rid of the fills
union(){//U2
difference(){//to get rid of the cylinder from going outside the hull. D1
union(){//U1, these are the cylinders and post bases (solid)
	translate([PistCentX,0,-dCirPist/2]) cylinder(h=Ph+dCirPist, r=rPistTubeOUT, center=true,$fn=res);//right piston cylinder
	translate([-PistCentX,0,-dCirPist/2]) cylinder(h=Ph+dCirPist, r=rPistTubeOUT, center=true,$fn=res);//left piston cylinder 
translate([0,holX,Ph/2-PostBaseH/2])//the base for the y+ve post holes on cableRun
union(){
	rotate([0,0,90+pistAng]) translate([0,+cabRun*3/2+axisHolderThick/2,0]) rotate([0,0,90]) axisPostBase(PostBaseH);
	rotate([0,0,90+pistAng]) translate([0,-cabRun*3/2-axisHolderThick/2,0]) rotate([0,0,90]) axisPostBase(PostBaseH);
}
translate([0,-holX,Ph/2-PostBaseH/2])//the base for the y-ve post holes on cableRun
union(){
	rotate([0,0,90+pistAng]) translate([0,+cabRun*3/2+axisHolderThick/2,0]) rotate([0,0,90]) axisPostBase(PostBaseH);
	rotate([0,0,90+pistAng]) translate([0,-cabRun*3/2-axisHolderThick/2,0]) rotate([0,0,90]) axisPostBase(PostBaseH);
}
translate([xR,-yR,Ph/2-PostBaseH/2])//the base for the y-ve post holes on Piston
union(){
	rotate([0,0,90+pistAng]) translate([0,+cabRun*3/2+axisHolderThick/2,0]) rotate([0,0,90]) axisPostBase(PostBaseH);
	rotate([0,0,90+pistAng]) translate([0,-cabRun*3/2-axisHolderThick/2,0]) rotate([0,0,90]) axisPostBase(PostBaseH);
}
translate([-xR,yR,Ph/2-PostBaseH/2])//the base for the y+ve post holes on Piston
union(){
	rotate([0,0,90+pistAng]) translate([0,+cabRun*3/2+axisHolderThick/2,0]) rotate([0,0,90]) axisPostBase(PostBaseH);
	rotate([0,0,90+pistAng]) translate([0,-cabRun*3/2-axisHolderThick/2,0]) rotate([0,0,90]) axisPostBase(PostBaseH);
}
}//end U1.
translate([0,0,-Ph/2])//this is to remove the excess that comes out of the hull
rotate_extrude(convexity = 100, $fn = 50)
rotate([0,180,90])
difference(){
		translate([0,-2*rr])square ([2*rr,2*rr]);
		translate([0,+drr-pistWgg])circle(r = rr-pistWgg, $fn = 50);
}
/*difference(){//this is to remove the excess going outside the curved hull
cylinder(r = rr-pistWgg, h=Ph*2,center=true);
cylinder(r=P+pistWgg, h=Ph*2.1,center=true);
}*/
}//end difference D1
translate([0,0,-dCirCab/2]) cableTubes(res);//add in the cable tubes
}//end of the positives; union U2, now to remove the holes.
translate([0,holX,0])rotate([0,0,pistAng])cube([cabRun*2,2*cabRun,Ph+2],center=true);//bigger square so the band can go in.
translate([0,-holX,0])rotate([0,0,pistAng])cube([cabRun*2,2*cabRun,Ph+2],center=true);//bigger square so the band can go in.

translate([PistCentX,0,-dCirPist/2]) cylinder(h=Ph+dCirPist+1, r=rPistTubeINN, center=true,$fn=res);//piston hole
translate([-PistCentX,0,-dCirPist/2]) cylinder(h=Ph+dCirPist+1, r=rPistTubeINN, center=true,$fn=res);

translate([0,holX,Ph/2-PostBaseH/2+hullTH])//the hole for the y+ve post holes on cableRun
union(){
rotate([0,0,90+pistAng]) translate([0,+cabRun*3/2+axisHolderThick/2,0]) rotate([0,0,90]) axisPostHole(PostBaseH);
rotate([0,0,90+pistAng]) translate([0,-cabRun*3/2-axisHolderThick/2,0]) rotate([0,0,90]) axisPostHole(PostBaseH);
}
translate([0,-holX,Ph/2-PostBaseH/2+hullTH])//the hole for the y-ve post holes on cableRun
union(){
rotate([0,0,90+pistAng]) translate([0,+cabRun*3/2+axisHolderThick/2,0]) rotate([0,0,90]) axisPostHole(PostBaseH);
rotate([0,0,90+pistAng]) translate([0,-cabRun*3/2-axisHolderThick/2,0]) rotate([0,0,90]) axisPostHole(PostBaseH);
}
translate([xR,-yR,Ph/2-PostBaseH/2+hullTH])//the hole for the y-ve post holes on piston
union(){
rotate([0,0,90+pistAng]) translate([0,+cabRun*3/2+axisHolderThick/2,0]) rotate([0,0,90]) axisPostHole(PostBaseH);
rotate([0,0,90+pistAng]) translate([0,-cabRun*3/2-axisHolderThick/2,0]) rotate([0,0,90]) axisPostHole(PostBaseH);
}
translate([-xR,yR,Ph/2-PostBaseH/2+hullTH])//the hole for the y+ve post holes on piston
union(){
rotate([0,0,90+pistAng]) translate([0,+cabRun*3/2+axisHolderThick/2,0]) rotate([0,0,90]) axisPostHole(PostBaseH);
rotate([0,0,90+pistAng]) translate([0,-cabRun*3/2-axisHolderThick/2,0]) rotate([0,0,90]) axisPostHole(PostBaseH);
}
}
}

module Piston(res){//these are the weight boxes, to be filled with metal or other high-density material
union(){
difference(){
union(){//the out side of the piston
	translate([0,0,0])cylinder(r=rPist, h=pistH, center=true, $fn=res);
	translate([0,0,-pistH/2])sphere(r=rPist, center=true, $fn=res);	
}
union(){//removing the inside of the piston.
	translate([0,0,0])cylinder(r=rPist-pWall, h=pistH+1, center=true, $fn=res);
	translate([0,0,-pistH/2])sphere(r=rPist-pWall, center=true, $fn=res);	
}
}
translate([0,0,pistH/2-wCyln/2])//this is the belt connection
	difference(){
		union(){
			
			cube(size=[beltWidth*2+hullTH,(wCyln+pWall),wCyln],center=true);//the block that the belt goes though
			translate(v=[0,0,-wCyln/2])cube(size=[2*rPist,hullTH,2*wCyln],center=true);//the block making up the connection to the piston walls 
			}
		cube(size=[beltWidth+2*wiggle,2*beltThickness+1*wiggle,wCyln*1.2],center=true);//the hole for the belt to go through
		translate(v=[0,0,-wCyln])cube(size=[2*rPist-4*hullTH,1.1*hullTH,wCyln*1.1],center=true);//the cutout to make the connection above the entrance plane.
		}
	}
}
//distance from post to post, holX+yR.
module PistonPosts(res){
difference(){
union(){
	rotate([0,90,0])axisPost(PostBaseH+1 ,res);//the post on the x-axis
	translate([PostBaseH+.3,0,0])rotate([0,90,4.9])axisPost(Ph ,res);//the post on the x-axis
	translate([0,distPostCab,0])rotate([0,90,0])axisPost(Ph+PostBaseH ,res);//the post to the right
translate([Ph+PostBaseH-axisThicOuter/2-axisBorder/2+.4,-axisHolderThick/2,0])rotate([0,90,90])axisPost(distPostCab+axisHolderThick ,res);//adding the cross connector
}
translate([Ph+PostBaseH-axisThicOuter/2-axisBorder/2+.4,0,0])rotate([0,90,0])legoAxis(res);//removing the hole at the top of the piston posts
}
}

//render


//rotate([0,90,0])axisPost(Ph*2 ,res);
//PistonRun(res);
//translate([-PistCentX,0,+pistH/2]) rotate([0,0,0])Piston(res);//translate([-PistCentX,0,-dCirPist/2])  
//translate([PistCentX,0,+pistH/2]) rotate([0,0,0])Piston(res);//translate([+PistCentX,0,-dCirPist/2]) 

//PistonPosts(res);
//translate([Ph,distPostCab/2,0])rotate([0,0,180]) PistonPosts(res);

//translate([0,-holX,0])rotate([0,0,pistAng])translate([+cabRun*3/2+axisHolderThick/2,0,0])rotate([0,-90,0])PistonPosts(res);//translate([0,holX,0])rotate([0,0,180+pistAng]) translate([0,+cabRun*3/2+axisHolderThick/2,0])