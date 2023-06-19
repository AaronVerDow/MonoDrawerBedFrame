pad=0.1;
in=25.4;
zero=0.01;

wood=in/2;
// 2x4 actual dimensions
two=38;
four=90;

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
