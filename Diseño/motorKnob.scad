//motor knob

/*<Written by Rodger Evans, Feb. 14, 2014>
this is a program to generate a knob for a motor controller. This is part of the DESceo project, and will be used in the wave tank in UABC.

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
use <numbers.scad>;// a library with numbers that can be printed

//Parameters
PostR1=6.3/2;//post radius /mm RE02, changed from 6.3
PostR2=4/2;//post short side Radius / from D cut, RE02, from 4
PostA=11;//post height, altura
NutA=3.8;//the height of the nut
wiggle=.2;//free space to fit well

MarkR1=11.4;//Radius to inner markings , RE02 10.5
MarkR2=16.5;//Radius to outer of markings, RE02 15.5
MarkR3=5;//length of markings

RimTH=1.5;//thickness of flat spont on rim
knobH1=PostA+2+RimTH;//height of the number part of the dial
knobH2=PostA+2;//height of the finger grip of the knob
knobR1=MarkR1+MarkR3*2/3;//radius of the knob

AngleHeight=knobH1-RimTH;//height of the angled part of the knob
AngleInRad=knobR1-RimTH;//inner radius of angled part of knob, RE02 *2/3

fingerHeight=knobH2;
fingerRad=PostR1+RimTH;
angleH=AngleHeight;
angleRUN=knobR1-AngleInRad;
angleLength=sqrt(pow(angleH,2)+pow(angleRUN,2));
angleAngle=atan(angleH/angleRUN);
div=72;//resolution

phi=0;//angle of cut relative to horizontal, the idea is to use the 50 mark at the top as our guide. 

lineOUT=.6;//the amount that the lines stick out

//parameters for the numbers
scaleX=0.4;
scaleY=0.4;
scaleZ=.5;

xOnes=10.3;//the top row, RE02 6.5
xTens=7.8;//second row, RE02 5.2
xCens=5.3;//thrird row, RE02 3.9
yNum=-2.2;//the y shift
zNum=knobH1-scaleZ/4;//the z shift, set to leave some of the number in the dial
//use is[-1,6.5,knobH1] to [yNum,xOnes,zNum] 
// [-1,5,knobH1] to [yNum,xTens,zNum]
// [-1,3.5,knobH1] to [yNum,xCens,zNum]

//translate([yNum,xTens,zNum]) resize(newsize=[1,2,.4]) two();

//the lines
module tick(thick){
	union(){
		translate([0,knobR1+thick,(RimTH+thick)/2]) cube([thick,2*thick,RimTH+thick], center=true);//the vertical tics
		translate([-thick/2,AngleInRad,knobH1-thick])rotate([-angleAngle,0,0])cube([thick,angleLength,2*thick],center=false);//the angled ticks knobR1*2/3 to AngleInRad
	}
}

module pointer(){
difference(){
	translate([0,0,RimTH]) cylinder(h=fingerHeight+RimTH,r=fingerRad, center=false,$fn=div);//the knob
	translate([0,0,-.1])cylinder(h=NutA,r1=AngleInRad,r2=fingerRad, center=false, $fn=div);//the space underneith
	rotate([0,0,90]) difference(){
		cylinder(h=knobH2-1.5,r=PostR1+wiggle/2,center=false);
		translate([-13/2,PostR2/2+wiggle,-.2])cube([13,13,knobH2*2],center=false);
	}
}
translate([0,knobR1/3-.45,RimTH+AngleHeight])polyhedron
    (points = [
			[-2,0,0], [2,0,0], [0,knobR1*2/5,0], [0,0,fingerHeight-AngleHeight+RimTH]
		],
	triangles = [
			[0,3,1],[0,2,3],[1,3,2],[0,1,2]
		]
	);
}
//[1,2,3],[1,3,2],[2,3,0],[0,1,2],[0,3,1]
module markings(){
union(){
rotate([0,0,0]){translate([yNum,xOnes,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}

//*
rotate([0,0,10]){translate([yNum,xOnes,zNum]) scale([scaleX,scaleY,scaleZ]) one();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
//*/
rotate([0,0,20]){translate([yNum,xOnes,zNum])scale([scaleX,scaleY,scaleZ]) two();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
//*
rotate([0,0,30]){translate([yNum,xOnes,zNum])scale([scaleX,scaleY,scaleZ]) three();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
//*/
rotate([0,0,40]){translate([yNum,xOnes,zNum])scale([scaleX,scaleY,scaleZ]) four();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
//*
rotate([0,0,50]){translate([yNum,xOnes,zNum])scale([scaleX,scaleY,scaleZ]) five();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
//*/
rotate([0,0,60]){translate([yNum,xOnes,zNum])scale([scaleX,scaleY,scaleZ]) six();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
//*
rotate([0,0,70]){translate([yNum,xOnes,zNum])scale([scaleX,scaleY,scaleZ]) seven();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
//*/
rotate([0,0,80]){translate([yNum,xOnes,zNum])scale([scaleX,scaleY,scaleZ]) eight();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
//*
rotate([0,0,90]){translate([yNum,xOnes,zNum])scale([scaleX,scaleY,scaleZ]) nine();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
//*/
rotate([0,0,100]){translate([yNum,xOnes,zNum])scale([scaleX,scaleY,scaleZ]) one();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	translate([yNum,xCens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	tick(lineOUT);
	////rotate([0,0,5])tick(lineOUT/2);
	}
//*
rotate([0,0,110]){translate([yNum,xOnes,zNum])scale([scaleX,scaleY,scaleZ]) one();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) one();
	translate([yNum,xCens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
//*/
rotate([0,0,120]){translate([yNum,xOnes,zNum])scale([scaleX,scaleY,scaleZ]) one();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) two();
	translate([yNum,xCens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
//*
rotate([0,0,130]){translate([yNum,xOnes,zNum])scale([scaleX,scaleY,scaleZ]) one();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) three();
	translate([yNum,xCens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
//*/
rotate([0,0,140]){translate([yNum,xOnes,zNum])scale([scaleX,scaleY,scaleZ]) one();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) four();
	translate([yNum,xCens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
//*
rotate([0,0,150]){translate([yNum,xOnes,zNum])scale([scaleX,scaleY,scaleZ]) one();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) five();
	translate([yNum,xCens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
//*/
rotate([0,0,160]){translate([yNum,xOnes,zNum])scale([scaleX,scaleY,scaleZ]) one();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) six();
	translate([yNum,xCens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
//*
rotate([0,0,170]){translate([yNum,xOnes,zNum])scale([scaleX,scaleY,scaleZ]) one();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) seven();
	translate([yNum,xCens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
//*/
rotate([0,0,180]){translate([yNum,xOnes,zNum])scale([scaleX,scaleY,scaleZ]) one();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) eight();
	translate([yNum,xCens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
//*
rotate([0,0,190]){translate([yNum,xOnes,zNum])scale([scaleX,scaleY,scaleZ]) one();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) nine();
	translate([yNum,xCens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();	
	tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
//*/
rotate([0,0,200]){translate([yNum,xOnes,zNum])scale([scaleX,scaleY,scaleZ]) two();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	translate([yNum,xCens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
//*
rotate([0,0,210]){translate([yNum,xOnes,zNum])scale([scaleX,scaleY,scaleZ]) two();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) one();
	translate([yNum,xCens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
//*/
rotate([0,0,220]){translate([yNum,xOnes,zNum])scale([scaleX,scaleY,scaleZ]) two();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) two();
	translate([yNum,xCens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
//*
rotate([0,0,230]){translate([yNum,xOnes,zNum])scale([scaleX,scaleY,scaleZ]) two();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) three();
	translate([yNum,xCens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
//*/
rotate([0,0,240]){translate([yNum,xOnes,zNum])scale([scaleX,scaleY,scaleZ]) two();
	translate([yNum,xTens,zNum]) scale([scaleX,scaleY,scaleZ]) four();
	translate([yNum,xCens,zNum]) scale([scaleX,scaleY,scaleZ]) zero();
	tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
 //pointer();
	}
}

module knob(){
difference(){
	union(){
		cylinder(h=RimTH, r=knobR1, center=false,$fn=div);//flat cylinder
		translate([0,0,RimTH]) cylinder(h=AngleHeight, r1=knobR1,r2=AngleInRad, center=false,$fn=div*2);//the angled rim
		//translate([0,0,RimTH]) cylinder(h=fingerHeight,r=fingerRad, center=false,$fn=div);//the knob
	}
translate([0,0,RimTH+.01]) cylinder(h=fingerHeight,r=fingerRad, center=false,$fn=div);//the knob
	translate([0,0,-.1])cylinder(h=NutA,r1=AngleInRad,r2=fingerRad, center=false, $fn=div);//the space underneith
//rotate([0,0,90]) difference(){
		//cylinder(h=knobH2-1.5,r=PostR1+wiggle/2,center=false);
		//translate([-13/2,PostR2/2+wiggle,-.2])cube([13,13,knobH2*2],center=false);
	//}
	//markings();
//pointer();
//tick(lineOUT);
	//rotate([0,0,5])tick(lineOUT/2);
	}
}	


knob();
//markings();
//pointer();