//cableTube
include<DESceoUABCmaquetteParameters.scad>

/*<Written by Rodger Evans, Feb. 14, 2014>
This file describes the cable tube used for the wave energy converter model to be used in the wave tank in UABC. This is part of the DESceo project, and will be used in the wave tank in UABC.

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

module cableHole(res){
union(){
	difference(){
		translate([0,0,-Ph-rr/2-cabRun])cylinder(h=Ph*1.2, r=cabRun*2, center=true,$fn=res);
		translate([0,0,cabRun-Ph/2-rr/2])
		rotate_extrude(convexity = 30, $fn=res)
			translate([cabRun*2, 0, 0])
				circle(r = cabRun, $fn = res);
		}
	cylinder(h=Ph+rr, r=cabRun, center=true,$fn=res);
	}
}

module CableRun(res){
	translate(v=[r-P,-holX,-Ph/2]){
		cableHole(res);
	}
	translate(v=[r-P,holX,-Ph/2]) cableHole(res);
}

module cableTube(res){
	difference(){
	union(){
		translate([0,0,0]) cylinder(h=Ph+dCirCab, r=cabRun*3, center=true,$fn=res);
		translate([0,0,-(Ph+dCirCab)/2])
			rotate_extrude(convexity = 30, $fn=res)
				translate([cabRun*2, 0, 0])
					circle(r = cabRun, $fn = res);
	}
		translate([0,0,0]) cylinder(h=Ph+dCirCab+1, r=cabRun, center=true,$fn=res);
}
}

module cableTubes(res){
	translate(v=[0,-holX,0]) cableTube(res);//r-P
	translate(v=[0,holX,0]) cableTube(res);
}

//render
//cableTube(20);
//cableTubes(30);