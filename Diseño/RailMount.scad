//Rail mount

/*<Written by Rodger Evans, Feb. 14, 2014>
This is a program to generate a mounting fixture to hang items off the rail above the UABC wave tank. This is part of the DESceo project, and will be used in the wave tank in UABC.

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
*/

//parameters for the main bracket

PieceThickness=12;//thickness of the whole piece
cynRad=4;//radius of the corners; was 2
div=20;//resoultion
delta=0.2;//extra thickness to make subtractions easier

C1h=22;//cube 1 height,. was 25
C1w=10;//cube 1 width
C1cylR=cynRad;//radius of the cylinder of the rounded sides 

C2h=13;//cubo2 is the part above the upper part of the rail.was 15
C2w=4;

C3h=22;//cube 3 is the center top of the piece, was 22
C3w=12;

C4h=15;
C4w=12;

C5h=1;
C5w=12;

CyER=C4w;//external radius of the bottom cylinder
CyIR=6.5/2;//inner radius of the bottom cylinder

C7h=10;
C7w=36;
C6h=C7h+5;
C6w=C7h;
C67p=PieceThickness+10;
fit=0.5;//the space for cube6 to fit 
C7d=3;//distance from hole to C6

module cube1(){
hull(){
	translate([C3w/2+C2w+cynRad/2,C1h-cynRad/2,0]) cube([cynRad,cynRad,PieceThickness],center=true);
	translate([C3w/2+C2w+cynRad,cynRad,0]) cylinder(h=PieceThickness, r=cynRad, center=true,$fn=div);
	translate([C3w/2+C2w+C1w-cynRad,cynRad,0]) cylinder(h=PieceThickness, r=cynRad, center=true,$fn=div);
	translate([C3w/2+C2w+C1w-cynRad,C1h-cynRad,0]) cylinder(h=PieceThickness, r=cynRad, center=true,$fn=div);
	}
}

module cube2(){
	C2hh=(C2h+cynRad/2);
	difference(){
		translate([C3w/2+C2w/2,C3h-C2hh/2,0])cube([C2w,C2hh, PieceThickness],center=true);
		hull(){
			translate([C3w/2+cynRad/2,C1h-C2h-cynRad/2,0]) cylinder(h=PieceThickness+delta,r=cynRad/2,center=true, $fn=div);
			translate([C3w/2+C2w-cynRad/2,C1h-C2h-cynRad/2,0])	cylinder(h=PieceThickness+delta,r=cynRad/2,center=true, $fn=div);
		}
	}
}
module cube3(){
translate([0,C3h/2,0])cube([C3w,C3h,PieceThickness],center=true);
}

module cube4(){
	cy4Rad=PieceThickness/2;
	translate([0,-C4h/2,0])
	rotate([90,0,0])
	hull(){
	cylinder(h=C4h,r=cy4Rad, center=true,$fn=2*div);		translate([cy4Rad-cynRad/4,cy4Rad-cynRad/4,0])cube([cynRad/2,cynRad/2,C4h],center=true);
	translate([-cy4Rad+cynRad/4,-cy4Rad+cynRad/4,0])cube([cynRad/2,cynRad/2,C4h],center=true);
	}
}

module cube5(){
	difference(){
	union(){
	translate([0,-C4h-C5h/2,0])cube([C5w,C5h+CyER,PieceThickness],center=true);
			translate([0,-C4h-C5h-2/3*CyER,0])cylinder(h=PieceThickness,r=CyER,center=true,$fn=2*div);
			}
	translate([0,-C4h-C5h-2/3*CyER,0])cylinder(h=PieceThickness+delta,r=CyIR,center=true,$fn=2*div);
	}
}

module cube6(){
translate([-C4w/2-fit-C7d-C6w/2,-C6h,0]) cube([C6w,C6h,C67p],center=true);
difference(){
	translate([17/2,-C6h-C6h/2+C7h/2,0])cube([C7w,C7h,C67p],center=true);
	translate([0,-C6h-C6h/2+C7h/2,0])cube([C4w+2*fit,C7h+delta,C4w+2*fit],center=true);//the hole
	translate([C4w/2+fit+C7d+6,-C6h-C6h/2+C7h/2+3,0])cube([12,5,12],center=true);
	translate([C4w/2+fit+C7d+6,-C6h-C6h/2+C7h/2,0])rotate([90,0,0])cylinder(h=C4w+2*fit, r=6.5/2,center=true);
}
}
//*
union(){
cube1();
mirror([1,0,0])cube1();
cube2();
mirror([1,0,0])cube2();
cube3();
cube4();
cube5();
}
//*/
//rotate([90,0,0])cube6();