pad=0.1;
in=25.4;
zero=0.01;

wood=in/2;
// 2x4 actual dimensions
two=38;
four=90;

neato=120;

pillowboard_y=4*in;
pillowboard_z=22*in;

bed_x=1530;
bed_y=2030+pillowboard_y;
bed_z=12*in;
bed_wood=wood;

overhang=10*in;
front_overhang=overhang-neato;

caster_x=20.5;
caster_y=42;
wheel_z=28;

leg_angle=atan(front_overhang/(bed_z-bed_wood-two-neato));
function leg_y(z)=bed_y-overhang+tan(leg_angle)*z-wood;
leg_x=four+wood*2;

mattress_r=2*in;

spine_end=0;
spines=6;
spine_gap=(bed_y-four-spine_end*2)/(spines-1);
back_overhang=0;
leg_y=bed_y-back_overhang-front_overhang;

module corner(r) {
	offset(r*2)
	offset(-r*2)
	children();
}

module wood(w=wood) {
	linear_extrude(height=w)
	children();
}

module dirror_y(y=0) {
	children();
	translate([0,y])
	mirror([0,1])
	children();

}

module dirror_x(x=0) {
	children();
	translate([x,0])
	mirror([1,0])
	children();

}
