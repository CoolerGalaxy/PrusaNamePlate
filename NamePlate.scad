label = "Prusa";
length_scale_factor = 100; // adjust for more or less cushion on the sides

// Prusa top frame rail => 6.35 thick, 40.11 tall
// Note: The export model should be thin so it does not interfere with the extruder operation

union() {
    scale = length_scale_factor / 100;
    
    frame_thickness = 6.4;
    plate_thickness = 1;
    back_height = 5;
    w = 21 * len(label) * scale;
    h = 40;
    
    if (w>150) echo(str("<span style='background-color: #f33'> WARNING: Width of ",w,"mm may interfere with Prusa spool holder</span>"));
    
    Plate_Back(w, h, plate_thickness, frame_thickness, back_height);
    Plate_Top(w, h, plate_thickness, frame_thickness);
    Plate_Front(w, h, plate_thickness);
    Label(w, h, plate_thickness);
}

module Plate_Back(w, h, plate_thickness, frame_thickness, back_height) {
    translate([0, h-back_height, -frame_thickness-plate_thickness])
    color("blue")
    cube([w, back_height, plate_thickness]);
}

module Plate_Top(w, h, plate_thickness, frame_thickness) {
    translate([0, h-plate_thickness, -frame_thickness-plate_thickness]) 
    color("green") 
    cube([w, plate_thickness, frame_thickness + (plate_thickness*2)]);
}

module Plate_Front(w, h, plate_thickness) {
    color("red") 
    cube([w, h, plate_thickness]);
}
module Label(w, h, plate_thickness) {
    translate([w/2, h * 0.25, plate_thickness]) 
    color("orange") 
    linear_extrude(height=plate_thickness) 
    text(label, font="Archivo Black:style=Bold", halign="center", size=h * 5/8);
}