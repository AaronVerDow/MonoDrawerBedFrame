include <common.scad>

wheel_hole=5*in;
wheel_z=28;
wheel=in;
wheel_d=13;
caster_hole=4;
caster_gap=32;
caster_x=20.5;
caster_y=42;
caster_wall=in/16;

module caster() {
	axle=wheel/2;

	translate([0,0,wheel_z]) {
		color("silver")
		translate([0,0,-caster_wall])
		linear_extrude(height=caster_wall)
		difference() {
			square([caster_x,caster_y],center=true);
			dirror_y()
			translate([0,caster_gap/2])
			circle(d=caster_hole);
		}

		color("silver")
		dirror_x()
		translate([-caster_x/2,0])
		hull() {
			translate([0,-caster_y/2,-caster_wall])
			cube([caster_wall,caster_y,caster_wall]);
			translate([0,0,-wheel_z+wheel/2])
			rotate([0,90,0])
			cylinder(d=axle,h=caster_wall);
		}

		translate([0,0,wheel/2-wheel_z])
		rotate([0,90])
		color("#555555")
		cylinder(d=wheel,h=wheel_d,center=true);
	}
}

caster();

