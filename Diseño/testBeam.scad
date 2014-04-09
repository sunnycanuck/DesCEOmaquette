module OpenBeam(length){
//rotate([90,0,0])
 linear_extrude(height=length)
import("openbeam.dxf");
}

module OpenBeamHole(length,Xtra,div){
deltaTheta=floor(360/div);
phi=45;
union(){
for(i=[1:div]){
translate([Xtra*sin(i*deltaTheta+phi),Xtra*cos(i*deltaTheta+phi),0]) OpenBeam(length);
}
}
}
OpenBeam(r-RailCenter);
#OpenBeamHole(20,1,4);