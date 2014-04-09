include<BasicGeometryDesign.scad>;
include<custom-chopper.scad>;
include<encoderSensors.scad>;


//struttLGTH=(L-4*P)/2;//this q
scalee=3;//the relation between the height an width of the strutt (min thickness is then thic/scalee)
xStrut=thic/scalee;//this is the thickness of the strut 
yStrut=strr/scalee;//the thickness in the y=direction of the strutt
difStrut=sqrt(3)*xStrut;//this is the difference in length of the inner part of the strut to the outer (at one end)
struttDIST=L-4*P-2*difStrut;//this is the distance from one pontoon to the other.
struttLGTH=struttDIST/2;//this is the half distance from one pontoon to the other.
fit=axisHolderThick;//the fitting piece for the strutts

module strutt(res){
rotate([0,90,0])scale([1,1/scalee,1])
rotate_extrude(convexity = 30, $fn=res)
difference(){
	translate([0,-struttLGTH,0]) square([strr+thic/2,2*struttLGTH]);
	translate([strr+thic/2, 0,0]) scale([strr,struttLGTH,1])circle(r = 1, $fn = res);
}
}

module endConnect(res){
translate([struttLGTH-fit/2+wiggle,0,strr])cube([fit,strr,strr],center=true);//the upper block; removed +axisThicInner/2+axisThicOuter/4
translate([struttLGTH-fit/2+wiggle,-thic/2-axisHolderThick/2,+axisThicInner/2+axisThicOuter/4])cube([fit,thic,wiggle+strr],center=true);
translate([struttLGTH-fit/2+wiggle,thic/2+axisHolderThick/2,+axisThicInner/2+axisThicOuter/4])cube([fit,thic,wiggle+strr],center=true);
translate([struttLGTH-axisOuterDIA/2-wiggle,0,strr/2-axisInnerDIA])rotate([0,90,0])legoAxis(res);//the connection to main body hole, strr/2
translate([struttLGTH-axisOuterDIA*3/2-wiggle,0,-axisInnerDIA+1])rotate([0,90,0])legoAxis(res);//the connecting pice from top to bottom
translate([struttLGTH-axisOuterDIA*3/2-wiggle,0,+axisInnerDIA-1])rotate([0,90,0])legoAxis(res);//the connecting pice from bottom to top
}

module finalTopStrutt(res){
difference(){
strutt(res);
endConnect(res);
rotate([0,0,180]) endConnect(res);
translate([0,0,-strr])cube([2*struttLGTH+wiggle,2*strr,2*strr],center=true);

}
}

module finalBttmStrutt(res){
difference(){
strutt(res);
endConnect(res);
rotate([0,0,180]) endConnect(res);
translate([0,0,strr])cube([2*struttLGTH+wiggle,2*strr,2*strr],center=true);

}
}


module PontoonConnect(res){
difference(){
union(){
difference(){
translate([struttLGTH-fit/2,0,Ph/4])cube([fit,(strr+thic)*2/scalee,Ph/2],center=true);
translate([0,yStrut/2+thic/4,Ph/4]) scale([2*struttLGTH,2*yStrut,1]) cylinder(r=.5,h=Ph/2+1,center=true);
translate([0,-yStrut/2-thic/4,Ph/4]) scale([2*struttLGTH,2*yStrut,1]) cylinder(r=.5,h=Ph/2+1,center=true);
translate([struttLGTH,strr-yStrut/2,3/2*strr-1])cube([2*struttLGTH,strr,3*strr],center=true);
translate([struttLGTH,-strr+yStrut/2,3/2*strr-1])cube([2*struttLGTH,strr,3*strr],center=true);
}
strutt(res);
translate([struttLGTH+fit,0,Ph/4])cube([2*fit,(thic+2*yStrut)/2,Ph/2],center=true);
translate([struttLGTH+fit,0,0])rotate([0,90,0])scale([1,1/scalee,1])cylinder(r=Ph/2, h=2*fit,center=true);
}
cube([2*struttLGTH-2*fit,strr,2*strr],center=true);//chopping off the center
translate([-struttLGTH,0,0])cube([2*struttLGTH,strr,3*strr],center=true);//chopping off the back
translate([struttLGTH-axisOuterDIA/2-wiggle,0,strr/2+axisInnerDIA-1])rotate([0,90,0])legoAxis(res);//the connection to main body hole
translate([struttLGTH-fit/2,0,-strr/2])cube([wiggle+fit,axisHolderThick+2*wiggle,2*strr],center=true);//removing the center
translate([struttLGTH-fit/2,0,-3/2*strr+axisThicInner/2+axisThicOuter/4])cube([wiggle+fit,2*strr,2*strr],center=true);
}
}
res=80;
translate([0,-strr,0])finalTopStrutt(res);//
rotate([180,0,0]) translate([0,-strr,0])finalBttmStrutt(res);// 
//finalTopStrutt(res);//
//finalBttmStrutt(res);
//PontoonConnect(res);
//axisPost(30,res);
// translate([struttLGTH,0,0])lego();
//translate([struttLGTH-fit/2+wiggle,thic/2+axisHolderThick,0])axisPost(30,20);
//translate([struttLGTH-fit/2+wiggle,0,strr/2-axisThicInner/2-axisThicOuter/2])rotate([0,90,0])legoAxis(20);