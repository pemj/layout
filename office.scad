DeskDim = [30,72,36];
//todo: toss these values in an array, add up the previous values as part of the operation to more easily add more wall? ehhh.
WallBehindJosh = 114;
HallwayWidth = 7*12;
BinDepth = 25;
BinHeight = 32;
BinLength = 48;
HallToZone = 38.5;
DoorWidth = 36;
ZoneToFocusCorner = 6;
CornerToFocus = 19;
FocusToWall = 10;
FocusDepth = CornerToFocus + DoorWidth + FocusToWall;
FocusCornerToWhiteboard = 58;
CornerWhiteboardToG = 53.5;
PillarDepth = 9;
PillarDiameter = 18;
PillarToPillar = 206;
PillarToWindow = 15;
JoshCornerToPillar = 115;
MarginOfError = JoshCornerToPillar - CornerToFocus - FocusToWall - DoorWidth - CornerWhiteboardToG;

LeftCorner = [WallBehindJosh+HallwayWidth+HallToZone+DoorWidth+ZoneToFocusCorner+FocusCornerToWhiteboard, 0, 0];
RightCorner = [0, 0, 0];
BackCorner = [LeftCorner.x, FocusDepth+CornerWhiteboardToG+PillarDepth+PillarToPillar+PillarDepth, 0];
FrontCorner = [0, BackCorner.y, 0];


module wall(length){
    cube([length, 1, 65]);
}

module sidewall(length){
    rotate([0,0,90]) wall(length);    
}

module pillar(){
    cube([PillarDiameter,PillarDiameter,90]);
}

module window(){ 
    translate([0,-2,33]) cube([78,4,66.5]);   
}


wall(WallBehindJosh);

translate ([WallBehindJosh,-120,0]) sidewall(120);

translate ([WallBehindJosh+HallwayWidth, -120, 0]) sidewall(120);

translate([WallBehindJosh+HallwayWidth, 0, 0]) wall(HallToZone);

//recycling/compost/trash bins
translate([WallBehindJosh+HallwayWidth-BinDepth,-BinLength, 0]){ 
    cube([BinDepth, BinLength, BinHeight]);
}
translate([WallBehindJosh+HallwayWidth+HallToZone+DoorWidth, 0, 0]){ 
    wall(ZoneToFocusCorner);
}
translate([WallBehindJosh+HallwayWidth+HallToZone+DoorWidth+ZoneToFocusCorner, 1, 0]){
    sidewall(CornerToFocus);
}
translate([-FocusCornerToWhiteboard, CornerToFocus+DoorWidth, 0]){
    translate(LeftCorner) sidewall(FocusToWall);
}

translate([-FocusCornerToWhiteboard, CornerToFocus+DoorWidth+FocusToWall-1, 0]){
    translate(LeftCorner) wall(FocusCornerToWhiteboard);
}

translate([LeftCorner.x, FocusDepth, LeftCorner.z]){
    sidewall(CornerWhiteboardToG);
}

translate([LeftCorner.x-PillarDepth, LeftCorner.y+FocusDepth+CornerWhiteboardToG, LeftCorner.z]){
    pillar();
}

translate([BackCorner.x-PillarDepth, BackCorner.y-PillarDepth, BackCorner.z]){
    pillar();
}


translate([FrontCorner.x-PillarDepth, FrontCorner.y-PillarDepth, FrontCorner.z]){
    pillar();
}



translate([FrontCorner.x-PillarDepth, LeftCorner.y+FocusDepth+CornerWhiteboardToG, 0]){
    pillar();
}

sidewall(FrontCorner.y);

//rear wall
translate([FrontCorner.x, FrontCorner.y+PillarDepth, FrontCorner.z]){
    wall(BackCorner.x);
}

translate([0,0,0]) rotate([0,0,90]) cube(DeskDim);

