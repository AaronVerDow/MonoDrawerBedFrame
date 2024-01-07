include <common.scad>

pillowboard_x=58*in;
pillowboard_z=22*in;
pillowboard_border=in*3;

radiator_z=545;

neato=120;

back_x=bed_x-overhang*2;
back_z=bed_z-neato;

shelf_z=1*in;
shelf_y=6*in;

backstop_z=shelf_z*2+wood;

module back() {
	translate([-back_x/2,bed_z-back_z])
	square([back_x,back_z]);

	translate([-pillowboard_x/2+pillowboard_border,bed_z])
	square([pillowboard_x-pillowboard_border*2,pillowboard_z-pillowboard_border]);
	
}

module end_cap() {
	cap_z=bed_z+pillowboard_z-pillowboard_border-radiator_z;
	cap_extra=cap_z/2;

	square([two+wood,pillowboard_z-pillowboard_border]);
	hull() {
		square([two+wood,cap_z]);

		translate([shelf_y,0])
		square([zero,backstop_z]);
	}
}

module middle_cap() {
	difference() {
		end_cap();
		translate([-pad,-pad])
		square([shelf_y+pad*2,shelf_z+pad]);
		square([two,four+shelf_z]);
	}
}

module shelf() {
	translate([pillowboard_border-pillowboard_x/2,-shelf_y])
	square([pillowboard_x-pillowboard_border*2,shelf_y]);
}

module backstop() {
	translate([-pillowboard_x/2+pillowboard_border,0])
	square([pillowboard_x-pillowboard_border*2,backstop_z]);
}

module headboard() {
	rotate([90,0])
	wood()
	back();

	translate([0,0,bed_z+pillowboard_z-wood-pillowboard_border-shelf_z])
	wood()
	shelf();

	translate([0,-shelf_y+wood,bed_z+pillowboard_z-pillowboard_border-backstop_z])
	rotate([90,0])
	wood()
	backstop();
		
	dirror_x()
	translate([pillowboard_x/2-pillowboard_border-wood,0,bed_z+pillowboard_z-pillowboard_border])
	rotate([-90,0,-90])
	wood()
	end_cap();
		
	dirror_x()
	translate([-wood/2,0,bed_z+pillowboard_z-pillowboard_border])
	rotate([-90,0,-90])
	wood()
	middle_cap();
}

module headboard_post() {
	dirror_x()
	color("lime")
	translate([-bed_x/2+overhang+wood,-wood-two])
	cube([four,two,bed_z+pillowboard_z-pillowboard_border-shelf_z-wood-four]);
}

module headboard_brace() {
	color("green")
	translate([pillowboard_border-pillowboard_x/2+wood,-wood-two,bed_z+pillowboard_z-pillowboard_border-shelf_z-wood-four])
	cube([pillowboard_x-pillowboard_border*2-wood*2,two,four]);
}

module headboard_handcut() {
	headboard_post();
	headboard_brace();
}

headboard();
headboard_handcut();
