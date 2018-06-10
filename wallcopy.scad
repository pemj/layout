//variant with simpler wall calculations
bed_width = 82;
computer_corner = 59.5;
closet_corner = 25.5;
bass_height = 45; 
wallLength = bed_width+computer_corner+closet_corner;
ceiling = 91.25;
door_height = ceiling - 12.75;
closet = [27.25, 67.5,ceiling];
bathroom_doorway = [35.5, 2, ceiling];
bathroom_door = [28, 2.5, door_height+1];
main_doorway = [39, 2, ceiling];
outerwall = 64+54.5;
opposite_wall = 155;
other_doorway = [39, 2, ceiling];

far_closet_width = 46.5;
far_closet_depth = 21.75;
opposite_to_closet = 102.6;
far_to_door = 16.25;

//Wall Art
//art(39+24+6, 8, FifteenNow);
//squareish
Fish = [9, 9];
SEIU = [10, 10];
FifteenNow = [12, 12];
Album = [12.375, 12.375];
//rectangle
GearWoman = [9.5, 11.5];
SpaceCommunism = [9.5, 13];
Avionics = [14.25, 16.25];
LittleFalkov = [14.625, 17.625];
GTFF = [11, 17];
LuchaPor = [13, 20];
BigFalkov = [19.125, 23.25];
Strike = [16, 24];
GrandTheft = [18, 24];
Hobbit = [18,24];
Goths = [18, 24];
Bandanna = [22, 22];
UnclesAcid = [24, 36];
//the big architecture one
arch = [46, 24]; //interior: 35.25 * 11.75
// tentative map frame:
map = [31.5, 31.5]; //interior: 20 * 20
//outside art


module painting (width, height){
}

module regular_polygon(order, r=1){
    angles=[ for (i = [0:order-1]) i*(360/order) ];
    coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
    translate([0,1,0]) rotate([0,360/12,0]) rotate([90,0,0]) polygon(coords);
}

module stud (distance){            
    translate([distance,-3,0]) cube([1,3,100]);
}
module studs(){
    stud(0);
    stud(10.25);
    stud(26.125);
    stud(42.5);
    stud(53.5);
    stud(70.5);
    stud(75);
    stud(90.5);    
    stud(106);
    stud(wallLength - 44.25);
    stud(wallLength - 28.5);
    stud(wallLength - 12);
    stud(wallLength);
}


module art(vert, horiz, wh){    
    thickness = .5;
    translate([horiz,1,vert]) cube([wh.x, thickness, wh.y]);
}

module brace(vert, horiz){    
    l = 1;
    w = 9;
    h = 6.5;
    translate([horiz,1,vert-h]){        
        polyhedron(
           points=[[0,0,0], [l,0,0], [0,0,h], [l,0,h], [0,w,h], [l,w,h]],
           faces=[[0,2,4],[1,3,5], [0,1,5,4],[3,4,5],[4,2,3]]
        );
    }; 
}
module monitors(){   
    translate([wallLength-22,9,39]) rotate([0,0,15]) cube([22.5, 2, 14]);
    translate([wallLength-46+2,19,39]) rotate([0,0,-25]) cube([22.5, 2, 14]);   
}
module shelf(vert, horiz, depth, width){    
    translate([horiz,1,vert]) cube([width, depth, 1]); 
    brace(vert, horiz);
    brace(vert, horiz+width-1);
}
module wall(){
   cube([bed_width+60+25, 1, ceiling]);
}
module bed(){
    translate([25,0,0]) cube([bed_width, 92, 24]);
    translate([25,1,0]) cube([bed_width, 2, 40]);
}

//outer wall and windowsill
difference(){
    translate([wallLength,0,0]) cube([1,outerwall,ceiling]);
    translate([wallLength-1,27.75,34.75]) cube([3,58.5,46.25]);
};
translate([wallLength-1.5,27.75-1,34.75-1]) cube([2,60.5,1]);
translate([wallLength-.25,27.75-1,34.75-2.5]) cube([.25,60.5,1.5]);

//opposite wall
difference(){
    union(){
        translate([wallLength - opposite_wall,outerwall,0]) cube([opposite_wall,1,ceiling]);
        translate([wallLength-opposite_to_closet-far_closet_width-1, outerwall+1,0]) cube([far_closet_width+2,far_closet_depth,door_height+1]);
    }
    translate([wallLength - 102.6 - far_closet_width,outerwall-1,-1]) cube([far_closet_width,far_closet_depth+1,door_height+1]);
}
translate([wallLength-opposite_wall,outerwall,0]) rotate([0,0,134]) translate([0,-1,0]) cube([far_to_door,1,ceiling]);
//translate([wallLength-opposite_wall-15,outerwall+12,0]) rotate([0,0,0]) cube(main_doorway);
//far_to_door;


//computer
//translate([0,2,31]) rotate(90,0,0) cube([9,22.5,21]);

studs();
wall();
bed();
translate([-2,2,0]) monitors();

//floor
translate([bed_width+25,2,-.25]) cube([21,88,.25]);
translate([4,2,-.25]) cube([21,88,.25]);


//desk
shelf(30, wallLength -40,20,40);
translate([wallLength-2,19,0,]) cube([2,2,30]);
translate([wallLength-40,19,0,]) cube([2,2,30]);
brace(30, wallLength -28);
brace(30, wallLength -12);

//big shelf
shelf(80,26,11,bed_width);
brace(80,42); 
brace(80,90.5);

//left bedside
shelf(14, bed_width+25+1,16,16);
shelf(24, bed_width+25+1,11,16);
shelf(39, bed_width+25+1,11,16);
//right bedside
shelf(14, 08,16,16);
shelf(24, 08,11,16);
shelf(39, 08,11,16);

//lamps
translate([16,5,40]) cube([5, 5, 24]);
translate([25+bed_width+6,5,40]) cube([5, 5, 24]);

//paintings
translate([25,1,48]) cube([12, 1, 24]);
translate([25+bed_width-12,1,48]) cube([12, 1, 24]);

//big damn frame
art(48, 25+17.5, arch);


translate([140,0,70]) regular_polygon(6, r=6.125);
translate([wallLength,outerwall-30,65]) rotate([0,45,90]) cube([20,1,20]);

art(39+24+2, 25/2-Goths.x/2, Goths);
art(39+24+2, 25+bed_width+25/2-GrandTheft.x/2, GrandTheft);

//closet
difference(){
    translate([0,closet.y,0]) rotate([0,0,180]) cube(closet);
    translate([1,closet.y-4.5,-1]) rotate([0,0,180]) cube([closet.x-1,closet.y-10,closet.z - 12.75+1]);
}

//bathroom door
difference(){
    translate([-closet.x,closet.y,0]) rotate([0,0,90]) cube(bathroom_doorway);
    translate([-closet.x+.25,closet.y+3,-1]) rotate([0,0,90]) cube(bathroom_door);
}
//main door
translate([-closet.x,closet.y+bathroom_doorway.x,0]){
    rotate([0,0,44]){
        difference(){
            cube(main_doorway);
            translate([8,-.25,-1]) cube(bathroom_door);
        }
    }
}

