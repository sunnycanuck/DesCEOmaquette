//Strutt
include<DESceoUABCmaquetteParameters.scad>;
include<lego.scad>;

/*<Written by Rodger Evans, Feb. 14, 2014>
this code describes the connecting strutts for a wave energy generator model based on a stewart/gough platform, to be used in the wave tank in UABC. This is part of the DESceo project, and will be used in the wave tank in UABC.

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
/*
this is how the struts are used.
translate([-P/2,-sq3/2*P,0])rotate([0,0,30]) translate([-struttLGTH-difStrut/2,0,0])finalTopStrutt(res);//
translate([-P/2,-sq3/2*P,0])rotate([0,0,30]) translate([-struttLGTH-difStrut/2,0,0])finalBttmStrutt(res);
*/


module strutt(res){// this is the basic strutt form with out any connecting pieces etc...
rotate([0,90,0])scale([1,1/scalee,1])//scaling the result so that it is skinnier on the y axis
	rotate_extrude(convexity = 30, $fn=res)
		difference(){
			translate([0,-struttLGTH,0]) square([strr+thic/2,2*struttLGTH]);//the basic square
			translate([strr+thic/2, 0,0]) scale([strr,struttLGTH,1])circle(r = 1, $fn = res);//the elipse that is being remove from the square
		}
}

module endConnect(res){//this is the connection on the end of the struts
	translate([struttLGTH-fit/2+wiggle,0,strr/2+3/2*axisThicOuter])cube([fit,strr,axisThicOuter+strr],center=true);//the upper block; removed +axisThicInner/2+axisThicOuter/4, z=strr
	translate([struttLGTH-fit/2+wiggle,-thic/2-axisHolderThick/2,+axisThicInner/2+axisThicOuter/4])cube([fit,thic,wiggle+strr],center=true);//side cut
	translate([struttLGTH-fit/2+wiggle,thic/2+axisHolderThick/2,+axisThicInner/2+axisThicOuter/4])cube([fit,thic,wiggle+strr],center=true);
	translate([struttLGTH+difStrut/2,0,0])rotate([0,0,-30]) translate([P/2,sq3/2*P,0])cylinder(r=P, h=Ph, $fn=res,center=true);//This is the pontoon that needs to be taken off the flares at the ends. P/2,sq3/2*P,0,struttLGTH+difStrut/2,0,0
	translate([struttLGTH-axisOuterDIA/2-minThic,0,axisThicOuter/2])rotate([0,90,0])legoAxis(res);//the connection to main body hole, strr/2; z=strr/2-axisInnerDIA
	translate([struttLGTH-axisOuterDIA*3/2-1.5*minThic,0,-axisInnerDIA+1])rotate([0,90,0])legoAxis(res);//the connecting pice from top to bottom
	translate([struttLGTH-axisOuterDIA*3/2-1.5*minThic,0,+axisInnerDIA-1])rotate([0,90,0])legoAxis(res);//the connecting pice from bottom to top
}

module finalTopStrutt(res){//the top part of the strutt
difference(){
	strutt(res);
	endConnect(res);
	mirror([1,0,0]) endConnect(res);//rotate([0,0,180])
	translate([0,0,-strr])cube([2*struttLGTH+wiggle,2*strr,2*strr],center=true);//to remove the bottom half

}
}

module finalBttmStrutt(res){//the bottom part of the strutt
difference(){
	strutt(res);
	endConnect(res);
	mirror([1,0,0]) endConnect(res);//rotate([0,0,180]) 
	translate([0,0,strr])cube([2*struttLGTH+wiggle,2*strr,2*strr],center=true);//remove the top part of the strutt
	}
}

module PontoonConnect(res){//the is the counter part of the struts that is part of the pontoon
difference(){
	union(){
		difference(){//this is the upper part that is a cube with two eliptical cylinders cut out
			translate([struttLGTH+fit*1/2,0,Ph/4])cube([3*fit,(strr+thic/2)*2/scalee,Ph/2],center=true);//the center top part of the connection
			translate([0,strr/scalee+thic/(2*scalee),Ph/4]) scale([struttLGTH,strr/scalee,1]) cylinder(r=1,h=Ph/2+1,center=true, $fn=res);//removing two cylinders, this is the right part
			translate([0,-strr/scalee-thic/(2*scalee),Ph/4]) scale([struttLGTH,strr/scalee,1]) cylinder(r=1,h=Ph/2+1,center=true,$fn=res);//... and the left part
			
			difference(){
				translate([fit/2,0,Ph/4])cube([2*struttLGTH-2*fit,strr,Ph/2+1],center=true);
				translate([struttLGTH,0,Ph/4])scale([1,1.2,1])cylinder(r=fit, h=Ph/2+2, $fn=res,center=true);
			//add in a cutter that takes out a cyliner form.
			}
		}
		strutt(res);//add in the strutt to get the bottom part
		//%translate([struttLGTH+fit,0,Ph/4])cube([2*fit,(strr+thic/2)*2/scalee,Ph/2],center=true);
		translate([struttLGTH+fit,0,0])rotate([0,90,0])scale([1,1/scalee,1])cylinder(r=Ph/2, h=2*fit,center=true, $fn=res);//this is an eliptical cylinder to match the strutt to the pontoon.
	}
	cube([2*struttLGTH-2*fit,strr,2*strr],center=true);//chopping off the center
	translate([-struttLGTH,0,0])cube([2*struttLGTH,strr,3*strr],center=true);//chopping off the back
	translate([struttLGTH-axisOuterDIA/2-minThic,0,axisThicOuter*3/2])rotate([0,90,0])legoAxis(res);//the connection to main body hole
	translate([struttLGTH-fit/2,0,-strr/2+axisThicOuter])cube([wiggle+fit,axisHolderThick+2*wiggle,strr],center=true);//removing the center
	translate([struttLGTH-fit/2,0,-3/2*strr+axisThicInner/2+axisThicOuter/4])cube([wiggle+fit,2*strr,2*strr],center=true);
	}
}

//render
//strutt(res);
//endConnect(30);
//translate([0,10,0]) rotate([0,0,0])finalTopStrutt(res);//
//translate([0,-10,0]) rotate([0,180,0])finalBttmStrutt(res);
//translate([0,0,0])rotate([180,0,0])PontoonConnect(30);//Ph/2