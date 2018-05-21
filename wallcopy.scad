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
    translate([horiz,1,vert-6]) cube([1, 6, 6]); 
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


studs();
wall();
bed();
monitors();

//desk
shelf(30, wallLength -40,20,40);
brace(30, wallLength -28);
brace(30, wallLength -12);

//big shelf
shelf(80,26,11,82);
brace(80,42);
brace(80,90.5);

//left bedside
shelf(22, 82+25+1,11,16);
shelf(12, 82+25+1,11,16);
shelf(39, 82+25+1,11,16);
//right bedside
shelf(22, 08,11,16);
shelf(12, 08,11,16);
shelf(39, 08,11,16);

//lamps
translate([16,5,39]) cube([5, 5, 24]);
translate([25+82+6,5,39]) cube([5, 5, 24]);

//paintings
translate([25,1,42]) cube([12, 1, 24]);
translate([25+82-12,1,42]) cube([12, 1, 24]);

//big damn frame
translate([25+18
,1,50]) cube([46, 1, 24]);