module arm(height=5, shoulder_radius=5, elbow_radius=3, upper_arm_length=20, lower_arm_length=10, elbow_angle=45) {
    translate([0, 0, 0]) cylinder(h=height, r=shoulder_radius);
    translate([0, -elbow_radius, 0]) cube([upper_arm_length, 2 * elbow_radius, height]);
    translate([upper_arm_length, 0, 0]) {
        cylinder(h=height, r=elbow_radius);
        rotate(elbow_angle) translate([0, -elbow_radius, 0]) cube([lower_arm_length, 2 * elbow_radius, height]);
    }
}

arm();