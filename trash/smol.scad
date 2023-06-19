include <common.scad>
bed_wood=wood;

bed_x=1530;
bed_y=2030;
bed_z=12*in;
bed_r=5*in;

pillowboard_x=58*in;
pillowboard_y=4*in;
pillowboard_z=22*in;
pillowboard_depth=bed_wood+two;
pillowboard_border=in*3;

mattress_z=230;
mattress_r=2*in;

overhang=10*in;
back_overhang=0;

pillow_x=59*in;
pillow_z=20*in;
pillow_y=3*in;

pillow_angle=20;

wedge_x=60*in;
wedge_z=10*in;
wedge_y=6*in;
wedge_board_z=8*in;
wedge_board_x=wedge_x-100;

// s=o/h c=a/h t=o/a
wedge_angle=atan(wedge_y/wedge_z);

wedge_board_height=wedge_board_z/cos(wedge_angle);
wedge_board_offset=wood;

radiator_offset=pillowboard_y+wood+two;
radiator_x=1370;
radiator_y=290;
radiator_z=545;
radiator_legs=[100-bed_x/2,0,bed_x/2-100];

radiator_center=70;
radiator_center_h=530;
neato=120;

back_x=bed_x-overhang*2;
back_z=bed_z-neato;

leg_x=four+wood*2;

spine=3*in;
spines=6;

wheel_hole=5*in;
wheel_z=28;
wheel=in;
wheel_d=13;
caster_hole=4;
caster_gap=32;
caster_x=20.5;
caster_y=42;
caster_wall=in/16;

edge=2*in;
inner=bed_z;
total_leg_x=bed_x-overhang*2;

tip=two;
leg_y=bed_y-overhang-back_overhang;
leg_z=bed_z;

// t=o/a
leg_angle=atan(overhang/(bed_z-bed_wood-two));

leg_face=(bed_z-bed_wood-two)/cos(leg_angle);

pump_x=10*in;
pump_y=18*in;
pump_z=6*in;
pump_ramp=pump_x-four-wood;

leveler_gap=in/2;

spine_end=0;
spine_gap=(bed_y-four-spine_end*2)/(spines-1);

caster_lane=caster_x*1.5;
caster_edge=caster_y;
caster_front=leg_y(wheel_z)-caster_edge;
caster_back=caster_edge;
caster_mid=(caster_back-caster_front)/2+caster_front;
middle_wheel=bed_y/2-wheel_hole/2;

leveler=leg_y(0)+pillowboard_y+wood;

pump_center=bed_y/3;

shelf_z=1*in;
shelf_y=6*in;

backstop_z=shelf_z*2+wood;

function leg_y(z)=bed_y-overhang+tan(leg_angle)*z-wood;

module back() {
	translate([-back_x/2,bed_z-back_z])
	square([back_x,back_z]);

	translate([-pillowboard_x/2+pillowboard_border,bed_z-pillowboard_depth])
	square([pillowboard_x-pillowboard_border*2,pillowboard_z-pillowboard_border]);
	
}

module bed() {
	translate([-bed_x/2,0])
	corner(mattress_r)
	square([bed_x,bed_y]);
}

module end_cap() {
	cap_z=bed_z+pillowboard_z-pillowboard_depth-pillowboard_border-radiator_z;
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

module pillowboard_base() {
	translate([-bed_x/2+overhang,0])
	square([bed_x-overhang*2,pillowboard_y]);
}

module end_edge() {
	hull() {
		translate([-total_leg_x/2,0])
		square([total_leg_x,edge]);
		translate([-tip-total_leg_x/2,0])
		square([total_leg_x+tip*2,bed_wood]);
	}
}

module side_edge() {
	hull() {
		square([leg_y,edge]);
		square([leg_y+tip,bed_wood]);
	}
}


module spine() {
	cube([bed_x-four*2,four,two]);
}

module plywood_spine() {
	translate([overhang-bed_x/2,0])
	square([bed_x-overhang*2,spine]);

	dirror_x()
	translate([bed_x/2-overhang-leg_x,0])
	square([leg_x,leg_z]);

	dirror_x()
	translate([bed_x/2-overhang-leg_x,0])
	hull() {
		square([leg_x,inner]);
		square([leg_x+overhang,edge]);
	}
}

module preview() {
	#translate([0,0,bed_z+pad])
	linear_extrude(height=mattress_z)
	bed();

	translate([-pillowboard_x/2,-pillowboard_y,bed_z-pillowboard_depth])
	#cube([pillowboard_x,pillowboard_y,pillowboard_z]);

	*#translate([-radiator_x/2,-radiator_y-radiator_offset])
	cube([radiator_x,radiator_y,radiator_z]);
}

module assembled() {
	color("blue")
	translate([0,0,bed_z-bed_wood])
	wood(bed_wood)
	bed();

	color("gold")
	dirror_x()
	translate([bed_x/2-overhang-leg_x,back_overhang,bed_z])
	cube([four,bed_y,two]);

	color("magenta")
	translate([0,0,bed_z-bed_wood-two])
	linear_extrude(height=two)
	dirror_x()
	intersection() {
		bed();
		translate([bed_x/2-four,-pad])
		square([four,bed_y+pad*2]);
	}


	*dirror_x()
	translate([bed_x/2,back_overhang,bed_z])
	rotate([-90,0,90])
	wood()
	side_edge();

	*dirror_y(bed_y)
	translate([0,0,bed_z])
	rotate([-90,0])
	wood()
	end_edge();
	
	translate([0,-pillowboard_y,0])
	rotate([90,0])
	wood()
	back();

	translate([0,-pillowboard_y,bed_z-pillowboard_depth+pillowboard_z-wood-pillowboard_border-shelf_z])
	wood()
	shelf();

	dirror_x()
	color("lime")
	translate([-bed_x/2+overhang+wood,-pillowboard_y-wood-two])
	cube([four,two,bed_z-pillowboard_depth+pillowboard_z-pillowboard_border-shelf_z-wood-four]);

	color("green")
	translate([pillowboard_border-pillowboard_x/2+wood,-pillowboard_y-wood-two,bed_z-pillowboard_depth+pillowboard_z-pillowboard_border-shelf_z-wood-four])
	cube([pillowboard_x-pillowboard_border*2-wood*2,two,four]);


	translate([0,-pillowboard_y-shelf_y+wood,bed_z-pillowboard_depth+pillowboard_z-pillowboard_border-backstop_z])
	rotate([90,0])
	wood()
	backstop();
		
	dirror_x()
	translate([pillowboard_x/2-pillowboard_border-wood,-pillowboard_y,bed_z+pillowboard_z-pillowboard_depth-pillowboard_border])
	rotate([-90,0,-90])
	wood()
	end_cap();
		
	dirror_x()
	translate([-wood/2,-pillowboard_y,bed_z+pillowboard_z-pillowboard_depth-pillowboard_border])
	rotate([-90,0,-90])
	wood()
	middle_cap();


	dirror_x()
	translate([overhang+wood-bed_x/2,-pillowboard_y-wood,leveler_gap])
	#cube([four,leveler,two]);

	translate([0,-pillowboard_y,bed_z-pillowboard_depth-wood])
	wood()
	pillowboard_base();

}

assembled();
preview();
