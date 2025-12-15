/*******************************************************************************/
//
//  Author:                     NewGreen © 2015
//  Name:                       ForceYourActorsToMove
//  Version:                    0.2 beta
//  Release date:               12.05.2015
//  Last Update                 12.05.2015
//  License:                    https://creativecommons.org/licenses/by-sa/3.0/
//  Requirements:               Sa-mp 0.3.7 RC6 and over
//
/*******************************************************************************/
 
#define IsActorMoving(%0) actorMoving[%0]
 
new actorTimers[MAX_ACTORS];
new bool:actorMoving[MAX_ACTORS];
enum animData {
    animation[10],
    Float:speed
}
new animAndSpeed[2][animData] = {
    {"WALK_civi",1.5357},
    {"RUN_civi",3.7}    
};
 
forward MoveActorToPos(actorid,Float:x,Float:y,Float:z,action);
forward StopMoveActorToPos(actorid,Float:x,Float:y,Float:z);
 
stock Float:GetDistanceFromActorToPoint(actorid,Float:x,Float:y,Float:z) // Get the distance between an actor and specified coordinates
{
    new Float:ax,Float:ay,Float:az;
    GetActorPos(actorid,ax,ay,az);
    return floatsqroot(floatpower(ax - x,2) + floatpower(ay - y,2) + floatpower(az - z,2));
    
}
 
stock IsActorInCube(actorid, Float:x, Float:y, Float:z, Float:edge) // Additional function to check an actor position to point, currently no need
{
    new Float:tx,Float:ty,Float:tz;
    GetActorPos(actorid,tx,ty,tz);
    tx = (tx-x);
    ty = (ty-y);
    tz = (tz-z);
    if(((tx <= edge) && (tx >= -edge)) && ((ty <= edge) && (ty >= -edge)) && ((tz <= edge) && (tz >= -edge)))
    {
        return true;
    }
    return false;
}
 
stock SetActorFacingPos(actorid, Float:x, Float:y) // This function allows you to change the actor's face turn to the coordinates
{
    if(!floatcmp(x, 0.0) && !floatcmp(y, 0.0)) return 0;
    static Float:ax, Float:ay, Float:az;
    GetActorPos(actorid, ax, ay, az);
    az = atan2((y-ay), (x-ax)) + 270.0;
    if(az>360.0)az-=360.0;
    return SetActorFacingAngle(actorid, az);
}  
 
public MoveActorToPos(actorid,Float:x,Float:y,Float:z,action) // This function allows you to move the actor's to the new position
{
    if(0 > action > 1) return print("Error, incorrect value in the function MoveActorToPos argument action");
    KillTimer(actorTimers[actorid]);
    ClearActorAnimations(actorid);
    actorMoving[actorid] = true;
    SetActorFacingPos(actorid, x,y);    
    ApplyActorAnimation(actorid, "ped", animAndSpeed[action][animation], 4.1, 1, 1, 1, 0, 0);
    actorTimers[actorid] = SetTimerEx("StopMoveActorToPos", floatround((GetDistanceFromActorToPoint(actorid,x,y,z)/animAndSpeed[action][speed])*918), false, "ifff", actorid,x,y,z);
    return false;           
}
 
public StopMoveActorToPos(actorid,Float:x,Float:y,Float:z) {
    KillTimer(actorTimers[actorid]);
    SetActorPos(actorid,x,y,z-0.1);
    ClearActorAnimations(actorid);
    actorMoving[actorid] = false;   
    return false;
}