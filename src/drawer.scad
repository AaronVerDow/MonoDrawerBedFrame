include <common.scad>
use <caster.scad>

drawer_x_gap=wood*2;
drawer_top_gap=wood*2;
drawer_base_gap=wood*2;
drawer_x=bed_x-leg_x*2-drawer_x_gap-overhang*2;
drawer_z=bed_z-bed_wood-two-drawer_top_gap;

// c=a/h
drawer_face=(drawer_z-neato)/cos(leg_angle);

caster_lane=caster_x*1.5;
caster_edge=caster_y;
caster_front=leg_y(wheel_z)-caster_edge;
caster_back=caster_edge;
caster_mid=(caster_back-caster_front)/2+caster_front;

// RENDER svg
module drawer_side() {
	hull() {
		translate([drawer_z-wheel_z,0])
		square([zero,leg_y(drawer_z)]);
		square([zero,leg_y(wheel_z)]);
	}
	square([neato-wheel_z,leg_y]);
}

// RENDER svg
module drawer_back() {
	square([drawer_x,drawer_z-wheel_z]);
}

module drawer_base() {
	difference() {
		square([drawer_x,leg_y(wheel_z)]);
	}
}

module drawer_face() {
	square([drawer_x,drawer_face]);
}


module drawer() {
	translate([-drawer_x/2,0,wheel_z])
	wood()
	drawer_base();

	dirror_x()
	translate([drawer_x/2,0,wheel_z])
	rotate([0,-90])
	wood()
	drawer_side();

	translate([-drawer_x/2,wood,wheel_z])
	rotate([90,0])
	wood()
	drawer_back();

	translate([-drawer_x/2,leg_y,neato])
	rotate([90-leg_angle,0])
	wood()
	drawer_face();

	dirror_x()
	translate([drawer_x/2-caster_lane,caster_front])
	caster();

	dirror_x()
	translate([drawer_x/2-caster_lane*2,caster_back])
	caster();

	dirror_x()
	translate([drawer_x/2-caster_lane*3,caster_mid])
	caster();

	translate([0,(caster_mid-caster_front)/2+caster_front])
	caster();

	translate([0,(caster_mid-caster_back)/2+caster_back])
	caster();
}

translate([0,wood+bed_x*0])
drawer();
