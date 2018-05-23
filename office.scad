PillarToWindow= 7.5;
WindowToWindow= 39.25;
WindowToOtherWindow= 34.5;
WallToSandesh = 65;
WallHeight = 110;
DeskDim = [30,72,36];
WindowHeight = 66.5;
WindowWidth = 79;
WindowDepth = 12;
TableRadius = 18;
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
JoshCornerToPillar = 115;
MarginOfError = JoshCornerToPillar - CornerToFocus - FocusToWall - DoorWidth - CornerWhiteboardToG;

LeftCorner = [WallBehindJosh+HallwayWidth+HallToZone+DoorWidth+ZoneToFocusCorner+FocusCornerToWhiteboard, 0, 0];
RightCorner = [0, 0, 0];
BackCorner = [LeftCorner.x, FocusDepth+CornerWhiteboardToG+PillarDepth+PillarToPillar+PillarDepth, 0];
FrontCorner = [0, BackCorner.y, 0];

module megaWall(length){
    cube([length, 10, WallHeight]);    
}

module wall(length){
    cube([length, 1, WallHeight]);
}

module sidewall(length){
    rotate([0,0,90]) wall(length);    
}

module pillar(){
    translate ([0,0,WallHeight/2]) cube(size = [PillarDiameter,PillarDiameter,WallHeight], center=true);
}

module window(x, y){ 
    translate([x, y-1, 33]) cube([WindowWidth,WindowDepth,WindowHeight]);   
}

module desk(x, y){
    translate([x,y,0]){
        rotate([180,270,0]) cube([DeskDim.z, DeskDim.y, DeskDim.x]);
    }
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

translate([LeftCorner.x, LeftCorner.y+FocusDepth+CornerWhiteboardToG+PillarDepth, LeftCorner.z]){
    pillar();
}

translate(BackCorner){
    pillar();
}


translate(FrontCorner){
    pillar();
}

translate([FrontCorner.x, LeftCorner.y+FocusDepth+CornerWhiteboardToG+PillarDepth, FrontCorner.Z]){
    pillar();
}

sidewall(FrontCorner.y-PillarDepth);

//rear wall
//windows are fucked up, need to take some more exact measurements.
difference(){
    translate([FrontCorner.x, FrontCorner.y+PillarDepth, FrontCorner.z]){
        megaWall(BackCorner.x);
    }
    window(FrontCorner.x+PillarDepth+PillarToWindow, FrontCorner.y+PillarDepth);
    window(FrontCorner.x+PillarDepth+PillarToWindow+WindowWidth+WindowToWindow, FrontCorner.y+PillarDepth);
    window(FrontCorner.x+PillarDepth+PillarToWindow+WindowWidth+WindowToWindow+WindowWidth+WindowToOtherWindow, FrontCorner.y+PillarDepth);
    
}

desk(FrontCorner.x+WallToSandesh, FrontCorner.y + 5);
desk(FrontCorner.x+PillarDepth+PillarToWindow+WindowWidth+WindowToWindow-20, FrontCorner.y+5);
desk(FrontCorner.x+PillarDepth+PillarToWindow+WindowWidth+WindowToWindow+WindowWidth-3, FrontCorner.y+5);
desk(FrontCorner.x+PillarDepth+PillarToWindow+WindowWidth+WindowToWindow+WindowWidth+DeskDim.x+3, FrontCorner.y+5);

desk(FrontCorner.x+WallToSandesh, FrontCorner.y - DeskDim.y);
desk(FrontCorner.x+PillarDepth+PillarToWindow+WindowWidth+WindowToWindow-20, FrontCorner.y - DeskDim.y);
desk(FrontCorner.x+PillarDepth+PillarToWindow+WindowWidth+WindowToWindow+WindowWidth-3, FrontCorner.y - DeskDim.y);
desk(FrontCorner.x+PillarDepth+PillarToWindow+WindowWidth+WindowToWindow+WindowWidth+DeskDim.x+3, FrontCorner.y - DeskDim.y);


desk(FrontCorner.x+WallToSandesh, FrontCorner.y - DeskDim.y - DeskDim.y - 5);
desk(FrontCorner.x+PillarDepth+PillarToWindow+WindowWidth+WindowToWindow-20, FrontCorner.y - DeskDim.y - DeskDim.y - 5);

translate([FrontCorner.x+PillarDepth+PillarToWindow+WindowWidth+WindowToWindow+WindowWidth+DeskDim.x+3+DeskDim.x, FrontCorner.y - DeskDim.y - DeskDim.y-5,0]){
    rotate([0,0,-90])desk(0,0);
}


translate([DeskDim.y+10, DeskDim.x+20,0]){
    rotate([0,0,-90])desk(0,0);
}

translate([WallBehindJosh+HallwayWidth+18,60,0]){
    cylinder(h=45, r = TableRadius);
}