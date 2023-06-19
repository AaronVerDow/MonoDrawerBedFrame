include <common.scad>
bed_wood=wood;

bed_x=1530;
bed_y=2030;
bed_z=12*in;

pillowboard_x=58*in;
pillowboard_y=4*in;
pillowboard_z=22*in;
pillowboard_depth=bed_wood+two;
pillowboard_border=in*3;

mattress_r=2*in;

overhang=10*in;

spines=6;

// t=o/a
leg_angle=atan(overhang/(bed_z-bed_wood-two));

leveler_gap=in/2;

spine_end=0;
spine_gap=(bed_y-four-spine_end*2)/(spines-1);

leveler=leg_y(0)+pillowboard_y+wood;

shelf_z=1*in;

function leg_y(z)=bed_y-overhang+tan(leg_angle)*z-wood;

module bed_ribs() {
	module rib(n=0) {
		dirror_x()
		translate([-bed_x/2+overhang+wood,four/2-two/2+spine_gap*n,two+leveler_gap])
		color("magenta")
		cube([four,two,bed_z-bed_wood-two*2-leveler_gap]);
	}

	rib();
	rib(3);
	rib(4);
}

module bed() {
	translate([-bed_x/2,0])
	corner(mattress_r)
	square([bed_x,bed_y]);
}

module leg_ribs() {
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

module headboard_post() {
	dirror_x()
	color("lime")
	translate([-bed_x/2+overhang+wood,-pillowboard_y-wood-two])
	cube([four,two,bed_z-pillowboard_depth+pillowboard_z-pillowboard_border-shelf_z-wood-four]);
}

module headboard_brace() {
	color("green")
	translate([pillowboard_border-pillowboard_x/2+wood,-pillowboard_y-wood-two,bed_z-pillowboard_depth+pillowboard_z-pillowboard_border-shelf_z-wood-four])
	cube([pillowboard_x-pillowboard_border*2-wood*2,two,four]);
}

module leveler() {
	dirror_x()
	translate([overhang+wood-bed_x/2,-pillowboard_y-wood,leveler_gap])
	cube([four,leveler,two]);
}

module handcut() {
	bed_ribs();
	leg_ribs();
	side_rails();
	headboard_post();
	headboard_brace();
	leveler();
}

handcut();
