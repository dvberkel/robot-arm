module arm_outline(shoulder_radius=5, elbow_radius=3, upper_arm_length=20, lower_arm_length=10, elbow_angle=45) {
    translate([0, 0, 0]); circle(r=shoulder_radius);
    translate([0, -elbow_radius, 0]) square([upper_arm_length, 2 * elbow_radius]);
    translate([upper_arm_length, 0, 0]) {
        circle(r=elbow_radius);
        rotate(elbow_angle) translate([0, -elbow_radius, 0]) square([lower_arm_length, 2 * elbow_radius]);
    }
}

module slot_outline(hole_radius=1, slot_width=1, slot_height=1) {
    union() {
        circle(hole_radius);
        scale([slot_height, slot_width]) polygon(points=[[0, 0], [-1, 1], [-1, -1]], paths=[[0, 1, 2]]);
    }
}

module slot(hole_radius=1, slot_width=1, slot_height=1, extrude_height=5) {
    rotate([0, 90, 0]) translate([0, 0, -extrude_height/2]) linear_extrude(height=extrude_height) slot_outline(hole_radius=hole_radius, slot_width=slot_width, slot_height=slot_height);
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
        translate([upper_arm_length, 0, height/2]) rotate(elbow_angle) translate([lower_arm_length, 0, 0]) slot(hole_radius=hole_radius, slot_width=elbow_radius, slot_height=height, extrude_height=4*thickness);
    }
}

arm();