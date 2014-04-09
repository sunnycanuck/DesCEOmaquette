//BasicGeometryDesign
use <Write.scad>
include<DESceoUABCmaquetteParameters.scad>
include<lego.scad>;
include<cableTube.scad>;
include<strutt.scad>;
include<Piston.scad>;
include<OpenBeamComponenst.scad>;

/*<Written by Rodger Evans, Feb. 14, 2014>
this code describes a wave energy generator based on a stewart/gough platform, to be used in the wave tank in UABC. This is part of the DESceo project, and will be used in the wave tank in UABC.

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

module Phull(res){//this is the hull of the pontoon. It is made by rotating a truncated circle
difference(){
union(){//add in the pontoon connectors
	translate([P,0,0])rotate([0,0,30])translate([-struttLGTH-sqrt(3)*P-difStrut/2,0,Ph/2]) PontoonConnect(res);//the pontoon connector
	translate([P,0,0])rotate([0,0,-30])translate([-struttLGTH-sqrt(3)*P-difStrut/2,0,Ph/2]) PontoonConnect(res);
	writesphere(text="DesCEO-LEARS-CICESE", where=[0,0,3/4*Ph], size=50,radius=P,t=2,h=10, font = "Letters.dxf", east=90);//this is the logo
}//remove the center of the pontoon from the connectors
translate([0,0,Ph/2])cylinder(r=P-hullTH/2,h=Ph+1, center=true);
}
difference(){//this takes all the circles, and trunkates them, adds a rectangle, and then rotates it all about an axis to make the hull.
rotate_extrude(convexity = 100, $fn = res)
union(){
	translate([P-hullTH,0,0,])square([hullTH,Ph]);
	rotate([0,0,90]){
	difference(){
			translate([0,drr])circle(r = rr, $fn = 2*res);//off center circle
			translate([0,drr])circle(r = rr-hullTH, $fn = 2*res);//removing the center of the circle
			translate([0,-rr])square([2*rr,2*rr]);//removing the part above the x-axis.
			translate([-rr,0])square([2*rr,2*rr]);//the other side of the axis of rotation
			}//-rr
		}
	}//the below removes the holes for the cables to pass through the hull; the cable tubes are included in the Piston file.
	translate([0,-holX,-Ph/2]) cylinder(h=Ph+dCir+1, r=cabRun , center=true,$fn=res);
	translate([0,holX,-Ph/2]) cylinder(h=Ph+dCir+1, r=cabRun, center=true,$fn=res);
	}
}

module pontoon(res){//this is the pontoon made up of its component pieces
	translate(v=[0,0,-Ph/2]) Phull(res);//r-P
	//translate([-P/2,-sq3/2*P,0])rotate([0,0,30]) translate([-struttLGTH-difStrut/2,0,0])finalTopStrutt(res);//move the tip to the center, rotate, then readjust to meet at the edge.
	//translate([-P/2,-sq3/2*P,0])rotate([0,0,30]) translate([-struttLGTH-difStrut/2,0,0])finalBttmStrutt(res);
	PistonRun(res);//this is the inside of the pontoon with the cylinders etc.. comment out to make the render quicker
}

module holder(res,rot){
rotate(a=[90,0,rot]){
difference(){
	cylinder(h=wCyln/2, r=(wCyln+wWall)/2,center=true,$fn=res);
	cylinder(h=wCyln, r=wWall/2,center=true,$fn=res);
}
}
}
module bottomPontoonBase(br,bh,bhc,bhD,res){
union(){
	cylinder(r=br, h=bh+wiggle, $fn=res, center=true);
	translate([0,0,-(bhc+bh)/2])cylinder(r1=bhD, r2=br, h=bhc, $fn=res, center=true);
}
}

/*module OpenBeam(length){
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

module M3ScrewGroup(length,res){
	translate([0,-P/3,Ph/2]) M3screw(Ph,res);
	translate([0,-P/3,Ph/2])cube([6.4,6.4,6.4],center=true);
	translate([0,-P*2/3,Ph/2]) M3screw(Ph,res);
	translate([0,-P*2/3,Ph/2])cube([6.4,6.4,6.4],center=true);
}
//translate([0,-RailCenter,RailSink]) rotate([90,0,0]) OpenBeam(r-P/3);
// M3ScrewGroup(Ph,res);
*/
module bottomPontoon(res){
union(){
difference(){
	bottomPontoonBase(Pb,Pbh,PbhC,PbhD,res);//this is the main pontoon outer form
	translate([0,0,-2*hullTH])bottomPontoonBase(Pb-PbTH,Pbh-PbTH-OBchannel-OBstep-3*hullTH,PbhC-PbTH,PbhH,res);//remove the center to make it hollow.
	translate([0,0,-PbhC+(-Pbh+PbTH)/2])cylinder(r=PbhH, h=10*(PbTH+wiggle), $fn=res,center=true);//this is to open the bottel mouth
	
	//there will be three sets of this. Removing the screw holes and the beam hole 
	translate([0,-RailCenter,RailSink]) rotate([90,0,0]) OpenBeamHole(OBlength,0.3,8);
	M3ScrewGroup(Ph,res);//adding in the 4-40 screw holes
	
	rotate([0,0,120])translate([0,-RailCenter,RailSink]) rotate([90,0,0]) OpenBeamHole(OBlength,0.3,8);
	rotate([0,0,120]) M3ScrewGroup(Ph,res);
	
	rotate([0,0,240])translate([0,-RailCenter,RailSink]) rotate([90,0,0]) OpenBeamHole(OBlength,0.3,8);
	rotate([0,0,240])  M3ScrewGroup(Ph,res);

}
translate([0,0,-Ph]) writesphere(text="DesCEO-LEARS-CICESE", where=[0,0,3/4*Ph], size=50,radius=P,t=2,h=10, font = "Letters.dxf", east=90);//this is the logo
}
}

module system(res){
	union(){
		translate([r-P,0,0]) pontoon(res);
		rotate(a=[0,0,120]) translate([r-P,0,0]) pontoon(res);
		rotate(a=[0,0,-120]) translate([r-P,0,0]) pontoon(res);
		//translate(v = [-Mx,My,0] ) rotate(a=[0,0,-30]) ConnectingStrut(strutLength,Ct,Ch);
		//translate(v = [-Mx,-My,0] ) rotate(a=[0,0,30]) ConnectingStrut(strutLength,Ct,Ch);
		//translate(v = [-r/2,0,0] ) rotate(a=[0,0,90]) ConnectingStrut(strutLength,Ct,Ch);
}
//translate(v=[0,0,-PBh*4]) bottomPontoon(res);
		//WeightSupport();
		//rotate(a=[0,0,120]) WeightSupport();
		//rotate(a=[0,0,-120]) WeightSupport();

	//}
	//CableRun();
//	WeightHole();
	//rotate(a=[0,0,120]) CableRun();
	//rotate(a=[0,0,-120]) CableRun();
	//translate(v=[r-P,-holX,0]) CableRun();
	//translate(v=[r-P,holX,0]) CableRun();
}

/////////////////////////////////
//render
/////////////////////////////
//Weight(0,10);
//ConnectingStrut(strutLength,Ct,Ch);
//rotate(a=[0,0,120]) Weight(5,20);
//rotate(a=[0,0,-120]) Weight(25,10);
//rotate([0,180,0])pontoon(res);
//translate([-PistCentX,0,+pistH/2]) Piston(res);
//PistonRun(res);
//translate([0,-strr,0])finalTopStrutt(res);//
//rotate([180,0,0]) translate([0,-strr,0]) finalBttmStrutt(res);// 
//PontoonConnect(res);

translate([0,0,0]) bottomPontoon(res);//-2*r
//rotate([0,0,90])translate([0,Rl/2,Pbh/4+pp3y])rotate([90,0,0])rail(res);
//system(60);//res=150 is high, 30 is low
//rotate([0,0,-30])translate([0,Rl/2,Pb/2])rotate([90,0,0])rail(res);
//rotate([0,0,-150])translate([0,Rl/2,Pb/2])rotate([90,0,0])rail(res);
//WeightSupport();
//5WeightHole();
//rotate(a=[0,0,120]) translate(v=[r-P,0,0]) cylinder(h=Ph, r=P, center=true);
//rotate(a=[0,0,-120]) translate(v=[r-P,0,0]) cylinder(h=Ph, r=P, center=true);
//cylinder(h=Ph, r=P, center=true);
//system(res);
//rotate([0,180,0])pontoon(res);
//PistonPosts(res);
//translate([Ph,distPostCab/2+10,0])rotate([0,0,180]) PistonPosts(res);
//translate([-PistCentX,0,+pistH/2]) rotate([0,0,0])Piston(res);//translate([-PistCentX,0,-dCirPist/2])  
//translate([PistCentX,0,+pistH/2]) rotate([0,0,0])Piston(res);
//translate([0,10,0]) rotate([0,0,0])finalTopStrutt(res);//
//translate([0,-10,0]) rotate([0,180,0])finalBttmStrutt(res);
//OpenBeam(OBlength);
//OpenBeamHole(OBlength-wiggle,wiggle,15);