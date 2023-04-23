wheel_color="#00D5FF"; // default: "#00D5FF"
axle_color="#D53963"; // default: "#D53963"
body_color="#FFD500"; // default: "#FFD500"
eye_color="#000000"; // default: "#000000
beak_color="#FF3C00"; // default: "#FF0000
opacity=1; // default: 1

wheel_radius=32; // default: 32
wheel_width=32; // default: 8
wheel_margin=16; // default: 16
axle_radius=8; // default: 8
body_width=32; // default: 32
body_length=128; // default: 128
body_height=64; // default: 64
head_radius=body_height; // default: body_height
eye_radius=8; // default: 8

// Raeder
color(wheel_color, opacity) 
    translate([wheel_margin, -wheel_width/2, 0]) 
    rotate([90, 0, 0]) 
    cylinder(h=wheel_width, r=wheel_radius, center=true);
color(wheel_color, opacity) 
    translate([body_length - wheel_margin, -wheel_width/2, 0]) 
    rotate([90, 0, 0]) 
    cylinder(h=wheel_width, r=wheel_radius, center=true);
color(wheel_color, opacity) 
    translate([wheel_margin, body_width + wheel_width/2, 0]) 
    rotate([90, 0, 0]) 
    cylinder(h=wheel_width, r=wheel_radius, center=true);
color(wheel_color, opacity) 
    translate([body_length - wheel_margin, body_width + wheel_width/2, 0]) 
    rotate([90, 0, 0]) 
    cylinder(h=wheel_width, r=wheel_radius, center=true);

// Achsen
color(axle_color, opacity) 
    translate([wheel_margin, body_width/2, 0]) 
    rotate([90, 0, 0]) 
    cylinder(h=body_width + 2*wheel_width + axle_radius/2, r=axle_radius, center=true);
color(axle_color, opacity)
    translate([body_length - wheel_margin, body_width/2, 0]) 
    rotate([90, 0, 0]) 
    cylinder(h=body_width + 2*wheel_width + axle_radius/2, r=axle_radius, center=true);


// Koerper
union() {
    difference() {
        color (body_color, opacity) 
            cube([body_length, body_width, body_height]);
        color (body_color, opacity)
            translate([body_length/2, body_width/2, body_height+body_length-body_length/8])
            rotate([90, 0, 0])
            cylinder(r=body_length, h=body_width * 2, center=true);
    }
    color(body_color, opacity) 
        translate([0, body_width/2, 0]) 
        rotate([90, 0, 0]) 
        linear_extrude(height=body_width, center=true, convexity=10)
        polygon(points=[[body_length/2, 0], [body_length, 0], [body_length+16, body_height+16]]);
    color(body_color, opacity) 
        translate([0, body_width/2, 0]) 
        rotate([90, 0, 0]) 
        linear_extrude(height=body_width, center=true, convexity=10)
        polygon(points=[[0, body_height/2], [body_length/2, 0], [-body_length/8, body_height+body_height/4]]);
}


// Kopf
color(body_color, opacity) 
    translate([body_length, body_width / 2, body_height +  body_height -16]) 
    rotate([90, 0, 0]) 
    cylinder(h=body_width, r=head_radius, center=true);
color(eye_color, opacity)
    translate([body_length + head_radius/2, body_width/2, body_height+body_height/2]) 
    rotate([90, 0, 0]) 
    cylinder(h=body_width + eye_radius/2, r=eye_radius, center=true);

// Schnabel
color(beak_color, opacity) 
    translate([body_length+head_radius-head_radius/2, body_width/2, body_height+head_radius]) 
    rotate([90, 90, 0]) 
    linear_extrude(height=body_width-2, center=true, convexity=10)
    polygon(points=[[0, 0], [body_height, 0], [body_height, body_height]]);
