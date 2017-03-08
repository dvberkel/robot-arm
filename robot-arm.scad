module arm_outline(shoulder_radius=5, elbow_radius=3, upper_arm_length=20, lower_arm_length=10, elbow_angle=45) {
    translate([0, 0, 0]); circle(r=shoulder_radius);
    translate([0, -elbow_radius, 0]) square([upper_arm_length, 2 * elbow_radius]);
    translate([upper_arm_length, 0, 0]) {
        circle(r=elbow_radius);
        rotate(elbow_angle) translate([0, -elbow_radius, 0]) square([lower_arm_length, 2 * elbow_radius]);
    }
}

module slot(hole_radius=1, extrude_height=5) {
    rotate([0, 90, 0]) translate([0, 0, -extrude_height/2]) linear_extrude(height=extrude_height) circle(hole_radius);
}

module arm(height=5, shoulder_radius=5, elbow_radius=3, upper_arm_length=20, lower_arm_length=10, elbow_angle=45, thickness=1, axle_radius=2, hole_radius=1) {
    difference() {
        union() {
            difference() {
                linear_extrude(height=height) arm_outline(shoulder_radius, elbow_radius,    upper_arm_length, lower_arm_length, elbow_angle);
                translate([0, 0, thickness]) linear_extrude(height=height) offset(r=-thickness) arm_outline(shoulder_radius, elbow_radius, upper_arm_length, lower_arm_length, elbow_angle); 
            }
            cylinder(h=height, r=axle_radius);
        }
        translate([upper_arm_length, 0, height/2]) rotate(elbow_angle) translate([lower_arm_length, 0, 0]) slot(hole_radius=hole_radius, extrude_height=4*thickness);
    }
}

arm();