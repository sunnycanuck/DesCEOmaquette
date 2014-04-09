include<DESceoUABCmaquetteParameters.scad>
include<lego.scad>;
include<custom-chopper.scad>;

/*<Written by Rodger Evans, Feb. 14, 2014>
This program generates the encoder sensor holder for the wave generator model made to be used in the vwave tank in UABC. This is part of the DESceo project, and will be used in the wave tank in UABC.

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

RE01-Rodger Evans, made 01-12-2014, changing for new chopper wheel.
RE02-R. Evans, made 02-26-2014, new mods

*/


sWidth=4.31;//width of sensor
sThick=1.47;//thickness of sensor
sHeight=5.73; //height of sensor
contactWd=0.2;
contactThick=0.3;
contactLength=14.56;
contactDiff=2.9;


sphereRad=1.45;


//width of rings
R_WIDTH=R_OUTER-R_INNER;

cFtop=0.8;
cFside=1.92;
cynH=15;//height of cylinder thickness
wiggleRm=.5;
yDIST=3;
WasherSpacing=2.6;//spacing between encoder wheel and axis holder made by washers
shThick=sThick+wiggleRm;//thickness of hole for sensor
shWidth=sWidth+wiggleRm;// sensor hole width
THICKNESS=3;// the thickness of the encoder wheel
encoderFree=1.5;//the free space left on the sides of the encoder wheel
encoderSpace=2*encoderFree+THICKNESS;//the space for the encoder wheel
wireHrad=2;//radius of hole for wires to fit.	

legoLength=axisHoleSpacing*4.5;//length of the lego piece on the side
postLength=71;
postRad=4.86/2;
sideTHickness=sThick*5;//the thickness of the area holding the sensor
//from axis holder x=axisThicOuter,y=axisHolderThick
wholeTHickness=sideTHickness*2+encoderSpace;//thickness of the sides of the encoder piece.



module legoSrtHole(){
	//rotate([90,0,0]) cylinder([h=1, r=1]);
}

//translate([0,6.1,-2*axisHoleSpacing]) rotate([0,0,90]) legoAxis(20);

module sensor(){
	color([ 100/255, 150/255, 50/255 ]) union(){
		cube(size=[sWidth,sThick,sHeight],center=true);
		translate([0,sThick/2,sHeight/2-cFtop-sphereRad/2]) sphere(sphereRad/2,center=true,$fn=50);
}
	translate([contactDiff/2,0,-contactLength/2-sHeight/2]) cube(size=[contactWd,contactThick,contactLength],center=true);
	translate([-contactDiff/2,0,-contactLength/2-sHeight/2]) cube(size=[contactWd,contactThick,contactLength],center=true);
}

//translate([0,yDIST,-R_INNER+sWidth*1.5]) rotate([180,90,0]) sensor();
//translate([0,yDIST,-R_OUTER+sWidth*1.5]) rotate([180,90,0]) sensor();
//translate([0,-yDIST-THICKNESS-wiggleRm*2,-R_INNER+sWidth*1.5]) rotate([180,90,0]) sensor();
//translate([0,-yDIST-THICKNESS-wiggleRm*2,-R_OUTER+sWidth*1.5]) rotate([180,90,0]) sensor();
//translate([-5,yDIST-WasherSpacing/2-sThick/2-sphereRad/4,-R_INNER+R_WIDTH/2]) rotate([0,90,0]) cylinder(r=sphereRad/2,h=10);


module opticalHolder(){
difference(){
	union(){//main piece
		translate([0,(sideTHickness+encoderSpace)/2	,-axisHoleSpacing-R_INNER2]) cube(size=[cynH/2.5,sideTHickness,axisHoleSpacing*3],center=true);//mounting side piece, RE01, 2.6->3, removed 1.6 from -axisHoleSpacing*1.6; RE02 removed +WasherSpacing
		translate([0,0,-axisHoleSpacing-R_INNER2-axisHoleSpacing*1.3]) cube(size=[cynH/2.5,wholeTHickness,sideTHickness],center=true);//bottom piece RE01 2.6->3, removed 1.6 from -axisHoleSpacing*1.6
		translate([0,-(sideTHickness+encoderSpace)/2,-axisHoleSpacing-R_INNER2]) cube(size=[cynH/2.5,sideTHickness,axisHoleSpacing*3],center=true);//side piece,RE01, 2.6->3, removed 1.6 from -axisHoleSpacing*1.6, RE02; removed -2*wiggleRm
		translate([0,sideTHickness+(encoderSpace+axisThicOuter)/2,-legoLength+axisHoleSpacing/2+.1]) rotate([0,0,90]) axisPost(legoLength,res);
		//translate([0,16.8,-2*axisHoleSpacing]) rotate([90,0,0]) lego();
		//translate([0,16.8,-3*axisHoleSpacing]) rotate([90,0,0]) lego();
		//translate([]) cube(size=[axisThicOuter,axisHolderThick,length]);//
	}
	translate([0,shThick*3/2+encoderSpace/2,-R_INNER+R_WIDTH/2]) cube(size=[3*sHeight,shThick,shWidth],center=true); // inner front sensor; RE01 removed *.45, ADDED R_WIDTH/2
	translate([0,shThick*3/2+encoderSpace/2,-R_OUTER+R_WIDTH/2]) cube(size=[3*sHeight,shThick,shWidth],center=true); // outer front sensor, RE01 added *2/3, ADDED R_WIDTH/2
	translate([0,-shThick*3/2-encoderSpace/2,-R_INNER+R_WIDTH/2]) cube(size=[3*sHeight,shThick,shWidth],center=true); //inner back sensor hole, RE01 removed *.45
	translate([0,-shThick*3/2-encoderSpace/2,-R_OUTER+R_WIDTH/2]) cube(size=[3*sHeight,shThick,shWidth],center=true); //outer back sensor hole,RE01 added *2/3
	translate([0,0,-R_OUTER+R_WIDTH/2]) cube(size=[cynH/3.5,encoderSpace+2*sThick+wiggleRm,sphereRad],center=true);//outer hole for light,RE01 added *2/3
	translate([0,0,-R_INNER+R_WIDTH/2]) cube(size=[cynH/3.5,encoderSpace+2*sThick+wiggleRm,sphereRad],center=true); //inner hole for light; RE01 removed *.45
	translate([-5,shThick+encoderSpace/2,-R_INNER+R_WIDTH/2]) rotate([0,90,0]) cylinder(r=sphereRad/2,h=10);//cylindrical cut, inner back//added RE01
	translate([-5,shThick+encoderSpace/2,-R_OUTER+R_WIDTH/2]) rotate([0,90,0]) cylinder(r=sphereRad/2,h=10);//cylindrical cut, outer back//added RE01
	translate([-5,-shThick-encoderSpace/2,-R_INNER+R_WIDTH/2]) rotate([0,90,0]) cylinder(r=sphereRad/2,h=10);//cylindrical cut, inner front//added RE01
	translate([-5,-shThick-encoderSpace/2,-R_OUTER+R_WIDTH/2]) rotate([0,90,0]) cylinder(r=sphereRad/2,h=10);//cylindrical cut, outer front //added RE01
	
	translate([0,-3*shThick-encoderSpace/2,-R_INNER+R_WIDTH/2+contactDiff/2]) rotate([0,90,0]) cylinder(r=contactThick*2,h=3*sHeight, center=true);//these are the holes used to run the sensor wires through
	translate([0,-3*shThick-encoderSpace/2,-R_INNER+R_WIDTH/2-contactDiff/2]) rotate([0,90,0]) cylinder(r=contactThick*2,h=3*sHeight, center=true);	
	
	translate([0,-3*shThick-encoderSpace/2,-R_OUTER+R_WIDTH/2+contactDiff/2]) rotate([0,90,0]) cylinder(r=contactThick*2,h=3*sHeight, center=true);//these are the holes used to run the sensor wires through
	translate([0,-3*shThick-encoderSpace/2,-R_OUTER+R_WIDTH/2-contactDiff/2]) rotate([0,90,0]) cylinder(r=contactThick*2,h=3*sHeight, center=true);	
	
	translate([0,3*shThick+encoderSpace/2,-R_INNER+R_WIDTH/2+contactDiff/2]) rotate([0,90,0]) cylinder(r=contactThick*2,h=3*sHeight, center=true);//these are the holes used to run the sensor wires through
	translate([0,3*shThick+encoderSpace/2,-R_INNER+R_WIDTH/2-contactDiff/2]) rotate([0,90,0]) cylinder(r=contactThick*2,h=3*sHeight, center=true);	
	
	translate([0,3*shThick+encoderSpace/2,-R_OUTER+R_WIDTH/2+contactDiff/2]) rotate([0,90,0]) cylinder(r=contactThick*2,h=3*sHeight, center=true);//these are the holes used to run the sensor wires through
	translate([0,3*shThick+encoderSpace/2,-R_OUTER+R_WIDTH/2-contactDiff/2]) rotate([0,90,0]) cylinder(r=contactThick*2,h=3*sHeight, center=true);	
	
	
	/*
	translate([0,6.1,-2*axisHoleSpacing]) rotate([0,0,90]) difference(){ 
		legoAxis(20);
	translate([-8.3,0,0]) cube([10,10,10],center=true);
	}
	translate([0,6.1,-3*axisHoleSpacing]) rotate([0,0,90]) difference(){ 
		legoAxis(20);
	translate([-8.3,0,0]) cube([10,10,10],center=true);
	}*/
}
}

module post(){ //the post that the wheel and belt pully are mounted on.
	union(){
		cylinder(r=postRad,h=postLength, center=true);
		translate([0,0,-postLength/2]) cylinder(r=postRad*2,h=5, center=true);
	}
}

//post();
//translate([-1.5,-shThick*3/2-encoderSpace/2,-19.5]) rotate([0,90,0]) sensor();
//translate([0,-15,0]) rotate([90,0,0]) post();
//translate([0,13.4,-47.2]) rotate([0,0,90]) axisPost(Ph,res);
opticalHolder();
//translate([0,-THICKNESS/2,0]) wheel();//axisHoleSpacing*2.3

//translate([0,16.8,-2*axisHoleSpacing]) rotate([90,0,0]) lego();
//translate([0,16.8,-3*axisHoleSpacing]) rotate([90,0,0]) lego();

//rotate([90,0,0]) encoder3d(NUM_SECTIONS,R_INNER,R_INNER2,R_OUTER,R_HOLE,R_MOUNT,BORDER,INT_MODIFIER,THICKNESS,THICKNESS_MOUNT);