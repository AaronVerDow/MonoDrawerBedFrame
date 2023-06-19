include <common.scad>
bed_wood=wood;

bed_x=1530;
bed_y=2030;
bed_z=12*in;
bed_r=5*in;

mattress_r=2*in;

module bed() {
	translate([-bed_x/2,0])
	corner(mattress_r)
	square([bed_x,bed_y]);
}

module top() {
	color("blue")
	translate([0,0,bed_z-bed_wood])
	wood(bed_wood)
	bed();
}

top();
