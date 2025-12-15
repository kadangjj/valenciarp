#define OnPlayerShootVehicle					OnPlayerShotVehicle

forward OnPlayerShotVehicle(playerid,vehicleid,weaponid,Float:amount,bodypart);

//Hook: OnPlayerWeaponShot
public OnPlayerWeaponShot(playerid,weaponid,hittype,hitid,Float:fX,Float:fY,Float:fZ){
	if(hittype == BULLET_HIT_TYPE_VEHICLE){
		if(IsToggledVehicleBulletproof(hitid)) return 0;
		new Float:fHealth, bodypart = _:VEHICLE_BODYPART_UNKNOWN, Float:fDamage = EVF::WeaponDamage[GetPlayerWeapon(playerid)];
		GetVehicleHealth(hitid,fHealth);
		if(fHealth > 249.0){
			new fModelid = GetVehicleModel(hitid), Float:fOffSet[3], fUpdate;
			
			if(IsUnoccupiedDamageToggled(hitid)){
				//front wheels
				GetVehicleModelInfo(fModelid,VEHICLE_MODEL_INFO_WHEELSFRONT,fOffSet[0],fOffSet[1],fOffSet[2]);
				
				if(VectorSize(fX+fOffSet[0],fY-fOffSet[1],fZ-fOffSet[2]) <= 0.4){
					//left
					fUpdate = EVF::GetVehicleDamageStatus(hitid,VEHICLE_DAMAGE_TIRES) + 8;
					if(fUpdate > 15){
						EVF::UpdateVehicleDamageStatus(hitid,VEHICLE_DAMAGE_TIRES,fUpdate);
					}
					bodypart = _:VEHICLE_BODYPART_FL_WHEEL;
				} else if(VectorSize(fX-fOffSet[0],fY-fOffSet[1],fZ-fOffSet[2]) <= 0.4){
					//right
					fUpdate = EVF::GetVehicleDamageStatus(hitid,VEHICLE_DAMAGE_TIRES) + 2;
					if(fUpdate > 15){
						EVF::UpdateVehicleDamageStatus(hitid,VEHICLE_DAMAGE_TIRES,fUpdate);
					}
					bodypart = _:VEHICLE_BODYPART_FR_WHEEL;
				} else {
					//back wheels
					GetVehicleModelInfo(fModelid,VEHICLE_MODEL_INFO_WHEELSREAR,fOffSet[0],fOffSet[1],fOffSet[2]);
					if(VectorSize(fX+fOffSet[0],fY-fOffSet[1],fZ-fOffSet[2]) <= 0.4){
						//left
						fUpdate = EVF::GetVehicleDamageStatus(hitid,VEHICLE_DAMAGE_TIRES) + 4;
						if(fUpdate > 15){
							EVF::UpdateVehicleDamageStatus(hitid,VEHICLE_DAMAGE_TIRES,fUpdate);
						}
						bodypart = _:VEHICLE_BODYPART_BL_WHEEL;
					} else if(VectorSize(fX-fOffSet[0],fY-fOffSet[1],fZ-fOffSet[2]) <= 0.4){
						//right
						fUpdate = EVF::GetVehicleDamageStatus(hitid,VEHICLE_DAMAGE_TIRES) + 1;
						if(fUpdate > 15){
							EVF::UpdateVehicleDamageStatus(hitid,VEHICLE_DAMAGE_TIRES,fUpdate);
						}
						bodypart = _:VEHICLE_BODYPART_BR_WHEEL;
					}
				}
			}
			
			if(!bodypart){
				//petrolcap
				GetVehicleModelInfo(fModelid,VEHICLE_MODEL_INFO_PETROLCAP,fOffSet[0],fOffSet[1],fOffSet[2]);
				if(VectorSize(fX-fOffSet[0],fY-fOffSet[1],fZ-fOffSet[2]) <= 0.2){
					if(IsPetrolCapDestroyToggled(hitid)){
						if(IsUnoccupiedDamageToggled(hitid) || IsVehicleOccupied(hitid)){
							bodypart = _:VEHICLE_BODYPART_PETROLCAP;
							new Float:pos[3];
							GetVehiclePos(hitid,pos[0],pos[1],pos[2]);
							#if defined _3D_Tryg
								CreateDynamicExplosion(pos[0],pos[1],pos[2],3,25.0,GetVehicleVirtualWorld(hitid),GetVehicleInterior(hitid),-1,200.0);
							#else
								CreateExplosion(pos[0],pos[1],pos[2],3,25.0);
							#endif
							return SetVehicleToRespawn(hitid);
						}
					} else {
						fHealth -= fDamage;
						SetVehicleHealth(hitid,fHealth);
						switch(floatround(fHealth)){
							case 251..399: return EVF::UpdateVehicleDamage(hitid,VEHICLE_DAMAGE_DOORS);
							case 400..599: return EVF::UpdateVehicleDamage(hitid,VEHICLE_DAMAGE_PANELS);
							case 600..700: return EVF::UpdateVehicleDamage(hitid,VEHICLE_DAMAGE_LIGHTS);
						}
					}
				}
			}
			if(!bodypart){
				if(IsUnoccupiedDamageToggled(hitid)){
					fHealth -= fDamage;
					SetVehicleHealth(hitid,fHealth);
					switch(floatround(fHealth)){
						case 251..399: return EVF::UpdateVehicleDamage(hitid,VEHICLE_DAMAGE_DOORS);
						case 400..599: return EVF::UpdateVehicleDamage(hitid,VEHICLE_DAMAGE_PANELS);
						case 600..700: return EVF::UpdateVehicleDamage(hitid,VEHICLE_DAMAGE_LIGHTS);
					}
				}
			}
		}
		CallRemoteFunction("OnPlayerShotVehicle","dddfd",playerid,hitid,weaponid,fDamage,bodypart);
	}
	#if defined EVF_OnPlayerWeaponShot
		EVF::OnPlayerWeaponShot(playerid,weaponid,hittype,hitid,fX,fY,fZ);
	#endif
	return 1;
}

#if defined _ALS_OnPlayerWeaponShot
	#undef OnPlayerWeaponShot
#else
	#define _ALS_OnPlayerWeaponShot
#endif
#define OnPlayerWeaponShot EVF_OnPlayerWeaponShot
#if defined EVF_OnPlayerWeaponShot
	forward EVF_OnPlayerWeaponShot(playerid,weaponid,hittype,hitid,Float:fX,Float:fY,Float:fZ);
#endif