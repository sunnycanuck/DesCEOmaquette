//lego
include<DESceoUABCmaquetteParameters.scad>;

/*<Written by Rodger Evans, Feb. 14, 2014>
this code describes the lego mind-storm connectors used as a mechanical connection standard for a wave energy generator based on a stewart/gough platform, to be used in the wave tank in UABC. This is part of the DESceo project, and will be used in the wave tank in UABC.

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

module legoAxis(res){ //this is the holes to remove
union(){
	rotate(a=[0,90,0]) cylinder(r=axisInnerDIA/2, h=axisThicOuter, center=true,$fn=res);
	translate(v=[axisThicInner/2+1,0,0]) rotate(a=[0,90,0]) cylinder(r=axisOuterDIA/2, h=2, center=true,$fn=res);//changed h=1 from h=axisThicOuter
	translate(v=[-axisThicInner/2-1,0,0]) rotate(a=[0,90,0]) cylinder(r=axisOuterDIA/2, h=2, center=true,$fn=res);//same as above
	}
}
module axisPost(length,res){ //this is the actual lego piece with holes down its length
	num=floor((length-2*axisBorder)/axisHoleSpacing);//how many holes there are
	i=1;
	difference(){
	translate([0,0,length/2])cube([axisThicOuter,axisHolderThick,length],center=true);//the main post
		for(i=[1:num]){
			translate([0,0,length-axisBorder-axisOuterDIA/2-axisHoleSpacing*(i-1)]) legoAxis(res);//axisHoleSpacing*(i-1)+axisBorder+axisOuterDIA //removing the holes
		}
	}
}

module axisPostHole(length){//this is the hole where an axisPost can be inserted.
translate([0,0,0])cube([axisThicOuter+2*wiggle,axisHolderThick+2*wiggle,length+1],center=true);
}

module axisPostBase(length) {
translate([0,0,0])cube([axisThicOuter+2*hullTH,axisHolderThick+2*hullTH,length],center=true);
}

module lego(){//this is a lego piece used to connect on axisPost to another
	difference() {
		union() {
			cylinder (h = 0.375, r = 2.5, $fs = 1);
			cylinder (h = 16.6, r = 2.25, $fs = 1);
			translate([0,0,16.225]) 
			cylinder (h = .375, r = 2.5, $fs = 1);
			translate([0,0,7.55])
			cylinder(h = 1.6, r = 3.00, $fs = 1);
		}
		translate([0,0,-.05])
		cylinder (h = 16.7, r = 1.875, $fs = 1);
		cube([10,1,9], center = true);
		translate([0,0,16.6])
		cube([10,1,9], center = true);
		translate([0,0,8.3]) 
		cube([1,10,7], center = true);
	}
}

//render

//axisPost(30,30);
//translate([-4.2,0,16.8])rotate([0,90,0]) lego();