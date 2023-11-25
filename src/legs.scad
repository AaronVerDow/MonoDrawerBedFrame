include <common.scad>

edge=2*in;

leg_face=(bed_z-bed_wood-two-neato)/cos(leg_angle);

pump_x=10*in;
pump_y=18*in;
pump_z=6*in;
pump_ramp=pump_x-four-wood;
pump_center=bed_y/3;

leveler_gap=in/2;
leveler=leg_y(0)+pillowboard_y+wood+neato;

headboard_extra=pillowboard_y+wood+two;

// RENDER svg
module pump_shelf() {
	translate([0,-pump_y/2-pump_ramp,0])
	hull() {
		translate([pump_x-zero,pump_ramp])
		square([zero,pump_y]);
		square([leg_x,pump_y+pump_ramp*2]);
	}
}

module leg_face() {
	square([leg_x,leg_face]);
}


module leg_side_positive() {
	hull() {
		translate([0,-back_overhang])
		square([edge,bed_y+headboard_extra]);
		square([bed_z-neato,leg_y+headboard_extra]);
	}
	square([bed_z,leg_y+headboard_extra]);
}


module leg_side() {
	difference() {
		translate([0,-headboard_extra])
		leg_side_positive();

		translate([-pad,-wood-pillowboard_y])
		square([pillowboard_depth+pad,pillowboard_y+wood]);
	}
}


module outer_leg_side() {
	difference() {
		leg_side();
		translate([-pad,pump_center-pump_y/2,0])
		square([pump_z+bed_wood+two+pad,pump_y]);
	}
}

module legs() {

	color("cyan")
	dirror_x()
	translate([overhang-bed_x/2,leg_y,neato])
	rotate([90-leg_angle,0])
	wood()
	leg_face();

	color("gold")
	dirror_x()
	translate([bed_x/2-overhang-leg_x,back_overhang,bed_z])
	rotate([0,90])
	wood()
	leg_side();

	color("cyan")
	dirror_x()
	translate([bed_x/2-overhang-wood,back_overhang,bed_z])
	rotate([0,90])
	wood()
	outer_leg_side();

	dirror_x()
	translate([bed_x/2-overhang-leg_x,pump_center,bed_z-bed_wood-two-pump_z])
	wood()
	pump_shelf();

}

module leg_ribs() {
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

module leveler() {
	dirror_x()
	translate([overhang+wood-bed_x/2,-pillowboard_y-wood,leveler_gap])
	cube([four,leveler,two]);
}

module legs_handcut() {
	leg_ribs();
	leveler();
}

legs();
legs_handcut();
