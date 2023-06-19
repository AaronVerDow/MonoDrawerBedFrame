include <common.scad>
bed_wood=wood;

bed_x=1530;
bed_y=2030;
bed_z=12*in;
bed_r=5*in;

mattress_r=2*in;

overhang=10*in;
spines=6;
spine_end=0;
spine_gap=(bed_y-four-spine_end*2)/(spines-1);


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

module bed_ribs() {
	color("red")
	//for(y=[back_overhang:spine_gap:bed_y-overhang])
	for(y=[spine_end+wood:spine_gap:bed_y-spine_end])
	translate([four-bed_x/2,y-wood,bed_z-bed_wood-two])
	cube([bed_x-four*2,four,two]);
}

module side_rails() {
	color("magenta")
	translate([0,0,bed_z-bed_wood-two])
	linear_extrude(height=two)
	dirror_x()
	intersection() {
		bed();
		translate([bed_x/2-four,-pad])
		square([four,bed_y+pad*2]);
	}
}

module top_handcut() {
	bed_ribs();
	side_rails();
}

top();
top_handcut();
