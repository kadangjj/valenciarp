#define MAX_PROJECTILE			(64)
#define INVALID_EXPLOSION_TYPE	(-1)
#define INVALID_SPREAD_COUNT	(-1)
#define MAX_EX_PER_SEQUENCE		(4)

// Item system compatibility
#if !defined INVALID_ITEM_TYPE
	#define INVALID_ITEM_TYPE (-1)
#endif

#if !defined ItemType
	#define ItemType: _:
#endif

#if !defined ITEM_SIZE_LARGE
	#define ITEM_SIZE_LARGE (1)
#endif

#if !defined ITEM_SIZE_SMALL
	#define ITEM_SIZE_SMALL (0)
#endif

enum E_FIREWORK_PROJECTILE_DATA
{
	fwk_object,
	fwk_sequence,
	fwk_index,
	bool:fwk_launched,
	fwk_trail_timer,
	fwk_smoke_objects[20],
	fwk_smoke_count
}

enum E_EXPLOSION_TYPE_DATA
{
	fwk_model[8],
	Float:fwk_elevation,
	Float:fwk_distance,
	fwk_spread
}

new
	fwk_Data[MAX_PROJECTILE][E_FIREWORK_PROJECTILE_DATA],
	Iterator:fwk_ProjectileIndex<MAX_PROJECTILE>;

new
	fireworkItemType = INVALID_ITEM_TYPE,
	fireworkLighterType = INVALID_ITEM_TYPE;

// ========== ENHANCED EXPLOSION TYPES (Spread lebih banyak!) ==========
new const
	fwk_ExplosionTypes[][E_EXPLOSION_TYPE_DATA] =
	{
		//	Models								Elevation	Distance	Spread
		{{345, -1, -1, -1, -1, -1, -1, -1},			60.0,		20.0,		8},		// Index 0: Increased 4->8
		{{18724, -1, -1, -1, -1, -1, -1, -1},		45.0,		50.0,		6},		// Index 1: Increased 3->6
		{{18688, -1, -1, -1, -1, -1, -1, -1},		45.0,		6.0,		8},		// Index 2: Increased 4->8
		{{18670, -1, -1, -1, -1, -1, -1, -1},		45.0,		6.0,		8},		// Index 3: Increased 4->8
		
		// ========== NEW TYPES (EXTRA MERIAH!) ==========
		{{18671, 18672, 18673, -1, -1, -1, -1, -1},	50.0,		15.0,		12},	// Index 4: Mixed colors
		{{18674, 18675, 18676, -1, -1, -1, -1, -1},	55.0,		25.0,		10},	// Index 5: Mixed colors
		{{18677, 18671, -1, -1, -1, -1, -1, -1},	60.0,		30.0,		16},	// Index 6: High spread
		{{345, 18724, 18688, -1, -1, -1, -1, -1},	40.0,		10.0,		20}		// Index 7: MASSIVE!
	},
	fwk_ExplosionSequences[][MAX_EX_PER_SEQUENCE] =
	{
		{3, -1, -1, -1},		// Simple
		{3, 1, 2, -1},			// Medium combo
		{1, 0, -1, -1},			// Standard
		
		// ========== NEW SEQUENCES (LEBIH SPEKTAKULER!) ==========
		{7, 4, 5, -1},			// MASSIVE -> Mixed -> Mixed
		{6, 3, 2, 1},			// Progressive (4 stages!)
		{7, 7, 7, -1},			// Triple massive (20 spread each!)
		{4, 5, 6, 7},			// Crescendo (12->10->16->20!)
		{0, 1, 2, 3}			// Full progression
	};

// Forward declarations
forward OnPlayerUseItemWithItem(playerid, itemid, withitemid);
forward FireworkTrail(projectileid);

CreateFireworkProjectile(model,
	Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz,
	Float:rotation, Float:elevation, Float:distance,
	sequence, index, bool:isInitialLaunch = false)
{
	new id = Iter_Free(fwk_ProjectileIndex);
	
	if(id == -1)
		return -1;

	new 
		Float:targetX,
		Float:targetY,
		Float:targetZ,
		Float:randomAngle = float(random(20) - 10),
		Float:speed;

	targetX = x + (distance * floatsin(rotation, degrees) * floatcos(elevation + randomAngle, degrees));
	targetY = y + (distance * floatcos(rotation, degrees) * floatcos(elevation + randomAngle, degrees));
	targetZ = z + (distance * floatsin(elevation + randomAngle, degrees));

	fwk_Data[id][fwk_object] = CreateDynamicObject(model, x, y, z, rx, ry, rz);
	
	if(isInitialLaunch)
	{
		speed = 25.0;
		fwk_Data[id][fwk_launched] = true;
		fwk_Data[id][fwk_trail_timer] = SetTimerEx("FireworkTrail", 100, true, "d", id);
	}
	else
	{
		speed = 15.0;
		fwk_Data[id][fwk_launched] = false;
		fwk_Data[id][fwk_trail_timer] = 0;
	}

	MoveDynamicObject(fwk_Data[id][fwk_object],
		targetX, targetY, targetZ,
		speed, rx, ry, rotation);

	fwk_Data[id][fwk_sequence] = sequence;
	fwk_Data[id][fwk_index] = index;

	Iter_Add(fwk_ProjectileIndex, id);
	return id;
}

public FireworkTrail(projectileid)
{
	if(!Iter_Contains(fwk_ProjectileIndex, projectileid))
	{
		KillTimer(fwk_Data[projectileid][fwk_trail_timer]);
		return 0;
	}

	if(!fwk_Data[projectileid][fwk_launched])
	{
		KillTimer(fwk_Data[projectileid][fwk_trail_timer]);
		return 0;
	}

	new Float:x, Float:y, Float:z;
	GetDynamicObjectPos(fwk_Data[projectileid][fwk_object], x, y, z);
	
	if(fwk_Data[projectileid][fwk_smoke_count] < 20)
	{
		new smokeid = CreateDynamicObject(18726, x, y, z - 1.0, 0.0, 0.0, 0.0);
		fwk_Data[projectileid][fwk_smoke_objects][fwk_Data[projectileid][fwk_smoke_count]] = smokeid;
		fwk_Data[projectileid][fwk_smoke_count]++;
		
		SetTimerEx("DestroySmokeObject", 2000, false, "d", smokeid);
	}
	
	return 1;
}

forward DestroySmokeObject(objectid);
public DestroySmokeObject(objectid)
{
	if(IsValidDynamicObject(objectid))
	{
		DestroyDynamicObject(objectid);
	}
	return 1;
}

DestroyFireworkProjectile(id)
{
	if(!Iter_Contains(fwk_ProjectileIndex, id))
		return 0;
	
	if(fwk_Data[id][fwk_trail_timer] != 0)
	{
		KillTimer(fwk_Data[id][fwk_trail_timer]);
		fwk_Data[id][fwk_trail_timer] = 0;
	}
	
	for(new i = 0; i < fwk_Data[id][fwk_smoke_count]; i++)
	{
		if(IsValidDynamicObject(fwk_Data[id][fwk_smoke_objects][i]))
		{
			DestroyDynamicObject(fwk_Data[id][fwk_smoke_objects][i]);
		}
		fwk_Data[id][fwk_smoke_objects][i] = INVALID_OBJECT_ID;
	}
	fwk_Data[id][fwk_smoke_count] = 0;
	
	DestroyDynamicObject(fwk_Data[id][fwk_object]);
	fwk_Data[id][fwk_object] = INVALID_OBJECT_ID;
	fwk_Data[id][fwk_sequence] = 0;
	fwk_Data[id][fwk_index] = 0;
	fwk_Data[id][fwk_launched] = false;

	Iter_Remove(fwk_ProjectileIndex, id);
	return 1;
}

public OnPlayerUseItemWithItem(playerid, itemid, withitemid)
{
	#if defined GetItemType
	if(GetItemType(itemid) == fireworkLighterType && GetItemType(withitemid) == fireworkItemType)
	#else
	if(itemid == fireworkLighterType && withitemid == fireworkItemType)
	#endif
	{
		ApplyAnimation(playerid, "BOMBER", "BOM_PLANT_IN", 4.0, 0, 0, 0, 0, 0);
		SendClientMessage(playerid, COLOR_YELLOW, "* Menyiapkan kembang api...");
		defer FireworkLaunch[4000](withitemid, playerid);
		return 1;
	}
	return 0;
}

timer FireworkLaunch[4000](itemid, playerid)
{
	new Float:x, Float:y, Float:z;

	#if defined GetItemPos
		GetItemPos(itemid, x, y, z);
	#else
		#pragma unused itemid
		GetPlayerPos(playerid, x, y, z);
	#endif
	
	CreateFireworkProjectile(345,
		x, y, z + 0.5, 90.0, 0.0, 0.0,
		0.0, 85.0, 30.0,
		random(sizeof(fwk_ExplosionSequences)), 0,
		true);
		
	SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* Kembang api meluncur ke udara dengan suara mendesing.");
}

// ========== ENHANCED OnDynamicObjectMoved (TRIPLE LAYER!) ==========
public OnDynamicObjectMoved(objectid)
{
	foreach(new i : fwk_ProjectileIndex)
	{
		if(objectid == fwk_Data[i][fwk_object])
		{
			new
				Float:x,
				Float:y,
				Float:z,
				sequence,
				index,
				extype,
				maxmodels,
				Float:angoffset;

			GetDynamicObjectPos(fwk_Data[i][fwk_object], x, y, z);

			sequence = fwk_Data[i][fwk_sequence];
			index = fwk_Data[i][fwk_index];
			
			// Sound effect ledakan
			if(index == 0 && fwk_Data[i][fwk_launched])
			{
				CreateExplosion(x, y, z, 0, 5.0);
			}
			else
			{
				CreateExplosion(x, y, z, 12, 3.0);
			}
			
			if(index >= MAX_EX_PER_SEQUENCE)
			{
				DestroyFireworkProjectile(i);
				return 1;
			}

			extype = fwk_ExplosionSequences[sequence][index];

			if(extype == -1)
			{
				DestroyFireworkProjectile(i);
				return 1;
			}

			maxmodels = 0;
			while(maxmodels < 8 && fwk_ExplosionTypes[extype][fwk_model][maxmodels] != -1)
				maxmodels++;

			DestroyFireworkProjectile(i);
			
			angoffset = float(random(360 / fwk_ExplosionTypes[extype][fwk_spread]));
			new spreadCount = fwk_ExplosionTypes[extype][fwk_spread];

			// ========== LAYER 1: OUTER RING (100% distance) ==========
			for(new j; j < spreadCount; j++)
			{
				CreateFireworkProjectile(
					fwk_ExplosionTypes[extype][fwk_model][random(maxmodels)],
					x, y, z, 90.0, 0.0, 0.0,
					float(j * (360 / spreadCount)) + angoffset,
					fwk_ExplosionTypes[extype][fwk_elevation],
					fwk_ExplosionTypes[extype][fwk_distance],
					sequence, index + 1,
					false);
			}
			
			// ========== LAYER 2: MIDDLE RING (70% distance) ==========
			for(new j; j < spreadCount; j++)
			{
				CreateFireworkProjectile(
					fwk_ExplosionTypes[extype][fwk_model][random(maxmodels)],
					x, y, z, 90.0, 0.0, 0.0,
					float(j * (360 / spreadCount)) + angoffset + (180.0 / float(spreadCount)),
					fwk_ExplosionTypes[extype][fwk_elevation] - 5.0,
					fwk_ExplosionTypes[extype][fwk_distance] * 0.7,
					sequence, index + 1,
					false);
			}
			
			// ========== LAYER 3: INNER BURST (50% distance) ==========
			for(new j; j < (spreadCount / 2); j++)
			{
				CreateFireworkProjectile(
					fwk_ExplosionTypes[extype][fwk_model][random(maxmodels)],
					x, y, z, 90.0, 0.0, 0.0,
					float(j * (720 / spreadCount)) + angoffset,
					fwk_ExplosionTypes[extype][fwk_elevation] + 10.0,
					fwk_ExplosionTypes[extype][fwk_distance] * 0.5,
					sequence, index + 1,
					false);
			}
			
			return 1;
		}
	}
	return 1;
}

LoadSequences()
{
	return 1;
}

// ========== ADMIN COMMANDS ==========

CMD:fwadmin(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		if(pData[playerid][pServerModerator] < 1)
			return PermissionError(playerid);

	new Float:x, Float:y, Float:z, Float:angle;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);
	
	ApplyAnimation(playerid, "BOMBER", "BOM_PLANT_IN", 4.0, 0, 0, 0, 0, 0);
	
	// Wave 1: Front cluster
	for(new i = 0; i < 8; i++)
	{
		new Float:offsetAngle = angle + float((i - 4) * 15);
		new Float:distance = 2.0 + float(i % 3);
		new Float:fX = x + (distance * floatsin(-offsetAngle, degrees));
		new Float:fY = y + (distance * floatcos(-offsetAngle, degrees));
		SetTimerEx("SpawnFirework", 500 * i, false, "dfff", playerid, fX, fY, z);
	}
	
	// Wave 2: Circle
	for(new i = 0; i < 12; i++)
	{
		new Float:circleAngle = float(i * 30);
		new Float:radius = 4.0;
		new Float:cX = x + (radius * floatsin(-circleAngle, degrees));
		new Float:cY = y + (radius * floatcos(-circleAngle, degrees));
		SetTimerEx("SpawnFirework", 7000 + (i * 400), false, "dfff", playerid, cX, cY, z);
	}
	
	// Wave 3: Spiral
	for(new i = 0; i < 20; i++)
	{
		new Float:spiralAngle = float(i * 18);
		new Float:spiralRadius = 1.5 + (float(i) * 0.15);
		new Float:sX = x + (spiralRadius * floatsin(-spiralAngle, degrees));
		new Float:sY = y + (spiralRadius * floatcos(-spiralAngle, degrees));
		SetTimerEx("SpawnFirework", 14000 + (i * 250), false, "dfff", playerid, sX, sY, z);
	}
	
	// Wave 4: Random barrage
	for(new i = 0; i < 25; i++)
	{
		new Float:randAngle = float(random(360));
		new Float:randRadius = 2.0 + float(random(30)) / 10.0;
		new Float:rX = x + (randRadius * floatsin(-randAngle, degrees));
		new Float:rY = y + (randRadius * floatcos(-randAngle, degrees));
		SetTimerEx("SpawnFirework", 20000 + (i * 150), false, "dfff", playerid, rX, rY, z);
	}
	
	// Grand finale
	for(new i = 0; i < 30; i++)
	{
		new Float:finalAngle = float(i * 12);
		new Float:finalRadius = 5.0;
		new Float:finX = x + (finalRadius * floatsin(-finalAngle, degrees));
		new Float:finY = y + (finalRadius * floatcos(-finalAngle, degrees));
		SetTimerEx("SpawnFirework", 25000 + (random(500)), false, "dfff", playerid, finX, finY, z);
	}
	
	return 1;
}

CMD:firework(playerid, params[])
{
	new Float:x, Float:y, Float:z, Float:angle;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);
	
	ApplyAnimation(playerid, "BOMBER", "BOM_PLANT_IN", 4.0, 0, 0, 0, 0, 0);
	
	x += (1.5 * floatsin(-angle, degrees));
	y += (1.5 * floatcos(-angle, degrees));
	
	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s memasang kembang api di tanah.", ReturnName(playerid));
	SetTimerEx("SpawnFirework", 4000, false, "dfff", playerid, x, y, z);
	return 1;
}

forward SpawnFirework(playerid, Float:x, Float:y, Float:z);
public SpawnFirework(playerid, Float:x, Float:y, Float:z)
{
	
	CreateFireworkProjectile(345,
		x, y, z + 0.5, 90.0, 0.0, 0.0,
		0.0, 85.0, 35.0,
		random(sizeof(fwk_ExplosionSequences)), 0,
		true);
		
	return 1;
}

#if defined CreateItem
CMD:addfirework(playerid, params[])
{
	new Float:x, Float:y, Float:z, Float:r;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, r);

	CreateItem(fireworkLighterType,
		x + (0.5 * floatsin(-r, degrees)),
		y + (0.5 * floatcos(-r, degrees)),
		z - 0.8568, .rz = r, .zoffset = 0.8568);

	CreateItem(fireworkItemType,
		x + (3.5 * floatsin(-r, degrees)),
		y + (3.5 * floatcos(-r, degrees)),
		z - 0.8568, .rz = r, .zoffset = 0.8568);

	return 1;
}
#endif