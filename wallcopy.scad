 wallLength = 82+60+25;

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
   cube([82+60+25, 1, 91.25]);
}
module bed(){
    translate([25,0,0]) cube([82, 92, 24]);
    translate([25,1,0]) cube([82, 2, 40]);
}

//outer wall
outerwall = 64+54.5;
difference(){
    translate([wallLength,0,0]) cube([1,outerwall,91.25]);
    translate([wallLength-1,27.75,34.75]) cube([3,58.5,46.25]);
};
translate([wallLength-1.5,27.75-1,34.75-1]) cube([2,60.5,1]);
translate([wallLength-.25,27.75-1,34.75-2.5]) cube([.25,60.5,1.5]);

//opposite wall
translate([wallLength - 103,outerwall,0]) cube([103,1,91.25]);
//computer
translate([wallLength,2,31]) rotate(90,0,0) cube([9,22.5,21]);

studs();
wall();
bed();
translate([-2,2,0]) monitors();

//floor
translate([82+25,2,-.25]) cube([21,88,.25]);
translate([4,2,-.25]) cube([21,88,.25]);

//des

//desk
shelf(30, wallLength -40,20,40);
brace(30, wallLength -28);
brace(30, wallLength -12);

//big shelf
shelf(80,26,11,82);
brace(80,42);
brace(80,90.5);

//left bedside
shelf(14, 82+25+1,16,16);
shelf(24, 82+25+1,11,16);
shelf(39, 82+25+1,11,16);
//right bedside
shelf(14, 08,16,16);
shelf(24, 08,11,16);
shelf(39, 08,11,16);

//lamps
translate([16,5,40]) cube([5, 5, 24]);
translate([25+82+6,5,40]) cube([5, 5, 24]);

//paintings
translate([25,1,48]) cube([12, 1, 24]);
translate([25+82-12,1,48]) cube([12, 1, 24]);

//big damn frame
translate([25+17.5,1,48]) cube([46, 1, 24]);
