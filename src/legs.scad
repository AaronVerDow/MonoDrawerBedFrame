include <common.scad>
bed_wood=wood;

bed_x=1530;
bed_y=2030;
bed_z=12*in;

pillowboard_y=4*in;
pillowboard_depth=bed_wood+two;

overhang=10*in;
back_overhang=0;

leg_x=four+wood*2;
edge=2*in;
inner=bed_z;

leg_y=bed_y-overhang-back_overhang;

// t=o/a
leg_angle=atan(overhang/(bed_z-bed_wood-two));

leg_face=(bed_z-bed_wood-two)/cos(leg_angle);

pump_x=10*in;
pump_y=18*in;
pump_z=6*in;
pump_ramp=pump_x-four-wood;
pump_center=bed_y/3;

function leg_y(z)=bed_y-overhang+tan(leg_angle)*z-wood;

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

module leg_side() {
	difference() {
		translate([0,-pillowboard_y-wood-two])
		hull() {
			translate([0,-back_overhang])
			square([edge,bed_y+pillowboard_y+wood+two]);
			square([inner,leg_y+pillowboard_y+wood+two]);
		}

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
	translate([overhang-bed_x/2,bed_y-overhang])
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

legs();
