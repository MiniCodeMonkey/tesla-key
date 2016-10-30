screenWidthAndHeight = 24.5;

boxTopWidth = 63.75;
boxBottomWidth = 40;
boxBottomHeight = 43;
boxHeight = 55;
boxDepth = 18;
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

		translate([34.9, 0, 0])
		cube([boxBottomHeight + 5, boxBottomWidth, boxDepth - thickness], center = true);

		cylinder(boxDepth - thickness, d = boxTopWidth - thickness, center = true);

		keychainCutout();
	}
}

module keychainCutout() {
	translate([-28, 0, -5])
	cube([1.25, 5, 20], center=true);

	translate([-25, 0, -5])
	cube([1.25, 5, 20], center=true);
}

module buttonCutout() {
	translate([0, 0, 8])
	cube([8, 20, 10], center = true);
}

module usbCutOut() {
	cube([thickness * 10, usbWidth, usbHeight], center = true);
}

module standoff() {
	cylinder(h=7, r=0.75);
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

module singleScreenStandOff() {
	translate([0, 0, -5])
	union() {
		cylinder(h=12, r=0.9);
		cylinder(h=9, r=1.75);
	}
}

module screenStandOffs() {
	translate([0, 0, 0])
	singleScreenStandOff();

	translate([0, 33.1, 0])
	singleScreenStandOff();

	translate([33.4, 0, 0])
	singleScreenStandOff();

	translate([33.4, 33.1, 0])
	singleScreenStandOff();
}

module singleButtonPcbStandOff() {
	translate([0, 0, -5])
	union() {
		cylinder(h=11, r=0.9);
		cylinder(h=8, r=1.75);
	}
}

module buttonPcbStandOffs() {
	translate([0, 0, 0])
	singleButtonPcbStandOff();

	translate([0, 27.7, 0])
	singleButtonPcbStandOff();

	translate([34.8, 0, 0])
	singleButtonPcbStandOff();

	translate([34.8, 27.7, 0])
	singleButtonPcbStandOff();
}

module snapFitWalls() {
	snapFitTolerance = 0.75;
	wallThickness = 1;

	difference() {
		union() {
			// Outer
			translate([34.9, 0, 9])
			cube([boxBottomHeight + 5 - snapFitTolerance, boxBottomWidth - snapFitTolerance, thickness * 2], center = true);

			translate([0, 0, 9])
			cylinder(thickness * 2, d = boxTopWidth - thickness - snapFitTolerance, center = true);
		}

		union() {
			// Inner
			translate([34.9, 0, 9])
			cube([boxBottomHeight + 5 - wallThickness - snapFitTolerance, boxBottomWidth - wallThickness - snapFitTolerance, thickness * 3], center = true);

			translate([0, 0, 9])
			cylinder(thickness * 3, d = boxTopWidth - thickness - wallThickness - snapFitTolerance, center = true);
		}
	}
}

difference() {
	color("black")
	translate([0, 0, 2.5])
	mainBox();

	translate([-3.75, 0, 8])
	screenCutOut();

	translate([27, 0, 0])
	buttonCutout();

	translate([27 + 12, 0, 0])
	buttonCutout();

	translate([27 + (12 * 2), 0, 0])
	buttonCutout();

	translate([58, 0, -2 + 1.4])
	usbCutOut();

	topPartHeight = 1.8;

	if (renderPart == "top") {
		translate([0, 0, -topPartHeight])
		cube([boxHeight + cornerRadius * 2 + 200, boxTopWidth + cornerRadius * 2, 5 + boxDepth + cornerRadius * 2], center = true);
	} else if (renderPart == "bottom") {
		translate([0, 0, boxDepth + (cornerRadius * 2) - topPartHeight])
		cube([boxHeight + cornerRadius * 2 + 200, boxTopWidth + cornerRadius * 2, boxDepth + cornerRadius * 2], center = true);
	}
}

if (renderPart != "top") {
	translate([31.5, 0, 0])
	pcbStandOffs();

	translate([20, -13.75, 0])
	buttonPcbStandOffs();

	translate([-22, -17, 0])
	screenStandOffs();
}

if (renderPart == "top") {
	snapFitWalls();
}

if (enableMockup) {
	if (renderPart != "top") {
		color("red")
		rotate([0, 0, 180])
		translate([-61.5, -8, -4.7 + thickness])
		import("vendor/Adafruit_Feather_Bluefruit_LE_32u4_wo_header.stl");

		translate([36.5, 0, 2.5])
		cube([44.5, 38.9, 1.65], center = true);
	}
}