screenWidthAndHeight = 24.5;

boxTopWidth = 60;
boxBottomWidth = 40;
boxBottomHeight = 43;
boxHeight = 55;
boxDepth = 10;
thickness = 1;
cornerRadius = 1.25;

usbWidth = 8.1;
usbHeight = 4;

renderPart = "top"; // bottom, top, or all
enableMockup = false;

$fn=100;

module screenCutOut() {
	cylinder(10, d=screenWidthAndHeight, center = true);
}

module mainBox() {
	difference() {
		union() {
			minkowski() {
				cylinder(boxDepth, d=boxTopWidth, center = true);
				sphere(r=cornerRadius);
			}

			translate([35 + 2.4, 0, 0])
			minkowski() {
				cube([boxBottomHeight, boxBottomWidth, boxDepth], center = true);
				sphere(r=cornerRadius);
			}
		}

		translate([32.5 + 2.4, 0, 0])
		cube([boxBottomHeight + 5, boxBottomWidth, boxDepth - thickness], center = true);

		cylinder(boxDepth - thickness, d = boxTopWidth - thickness, center = true);
	}
}

module buttonCutout() {
	translate([0, 0, 8])
	cube([8, 20, 10], center = true);
}

module usbCutOut() {
	cube([thickness * 10, usbWidth, usbHeight], center = true);
}

module standoff() {
	cylinder(h=5, r=0.75);
}

module tallStandoff() {
	translate([0, 0, -5])
	union() {
		cylinder(h=10, r=0.75);
		cylinder(h=7, r=1.75);
	}
}

module pcbStandOffs() {
	translate([-21.7, 8.9, -6])
	standoff();
	translate([-21.7, -8.9, -6])
	standoff();
	translate([24.5, -8.9, -6])
	standoff();
	translate([24.5, 8.9, -6])
	standoff();
}

module screenStandOffs() {
	translate([0, 0, 0])
	tallStandoff();

	translate([0, 33.1, 0])
	tallStandoff();

	translate([33.4, 0, 0])
	tallStandoff();

	translate([33.4, 33.1, 0])
	tallStandoff();
}

module buttonPcbStandOffs() {
	translate([0, 0, 0])
	tallStandoff();

	translate([0, 27.7, 0])
	tallStandoff();

	translate([34.8, 0, 0])
	tallStandoff();

	translate([34.8, 27.7, 0])
	tallStandoff();
}

difference() {
	color("black")
	mainBox();

	translate([0, 0, 5])
	screenCutOut();

	translate([27, 0, 0])
	buttonCutout();

	translate([27 + 12, 0, 0])
	buttonCutout();

	translate([27 + (12 * 2), 0, 0])
	buttonCutout();

	translate([58, 0, -2])
	usbCutOut();

	topPartHeight = 1.8;

	if (renderPart == "top") {
		translate([0, 0, -topPartHeight])
		cube([boxHeight + cornerRadius * 2 + 200, boxTopWidth + cornerRadius * 2, boxDepth + cornerRadius * 2], center = true);
	} else if (renderPart == "bottom") {
		translate([0, 0, boxDepth + (cornerRadius * 2) - topPartHeight])
		cube([boxHeight + cornerRadius * 2 + 200, boxTopWidth + cornerRadius * 2, boxDepth + cornerRadius * 2], center = true);
	}
}

if (renderPart != "top") {
	translate([22 + 10, 0, 0])
	pcbStandOffs();

	translate([20, -13.75, 0])
	buttonPcbStandOffs();

	translate([-22, -17, 0])
	screenStandOffs();
}

if (enableMockup) {
	if (renderPart != "top") {
		color("red")
		rotate([0, 0, 180])
		translate([-52 - 10, -8, -4.7 + thickness])
		import("vendor/Adafruit_Feather_Bluefruit_LE_32u4_wo_header.stl");

		translate([36.5, 0, 2.5])
		cube([44.5, 38.9, 1.65], center = true);
	}
}