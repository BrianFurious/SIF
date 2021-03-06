/*==============================================================================

Southclaw's Interactivity Framework (SIF) (Formerly: Adventure API)

	Version: 1.2.0


	SIF/Overview
	{
		SIF is a collection of high-level include scripts to make the
		development of interactive features easy for the developer while
		maintaining quality front-end gameplay for players.
	}

	SIF/Button/Description
	{
		A simple framework using streamer areas and key checks to give
		the in-game effect of physical buttons that players must press instead
		of using a command. It was created as an alternative to the default
		GTA:SA spinning pickups for a few reasons:

			1. A player might want to stand where a pickup is but not use it
			(if the	pickup is a building entrance or interior warp, he might
			want to stand in the doorway without being teleported.)

			2. Making hidden doors or secrets that can only be found by walking
			near the button area and seeing the textdraw. (or spamming F!)

			3. Spinning objects don't really add immersion to a role-play
			environment!
	}

	SIF/Button/Dependencies
	{
		Streamer Plugin
		YSI\y_hooks
		YSI\y_timers
		md-sort
	}

	SIF/Button/Credits
	{
		SA:MP Team						- Amazing mod!
		SA:MP Community					- Inspiration and support
		Incognito						- Very useful streamer plugin
		Y_Less							- YSI framework
		Slice							- Multidimensional Array Sorting
	}

	SIF/Button/Constants
	{
		These can be altered by defining their values before the include line.

		BTN_MAX
			Maximum amount of buttons that can be created.

		BTN_MAX_TEXT
			Maximum string length for labels and action-text strings.

		BTN_DEFAULT_STREAMDIST
			Default maximum stream range for button label text.

		BTN_MAX_INRANGE
			Maximum amount of buttons to load into the list of buttons that the
			player is in range of when they press the interact key.

		BTN_STREAMER_AREA_IDENTIFIER
			A value to identify streamer object EXTRA_ID data array type.
	}

	SIF/Button/Core Functions
	{
		The functions that control the core features of this script.

		native -
		native - SIF/Button/Core
		native -

		native CreateButton(Float:x, Float:y, Float:z, text[], world = 0, interior = 0, Float:areasize = 1.0, label = 0, labeltext[] = "", labelcolour = 0xFFFF00FF, Float:streamdist = BTN_DEFAULT_STREAMDIST)
		{
			Description:
				Creates an interactive button players can activate by pressing F.

			Parameters:
				<x>, <y>, <z> (float)
					X, Y and Z world position.

				<text> (string)
					Message box text for when the player approaches the button.

				<world>	(int)
					The virtual world to show the button in.

				<interior> (int)
					The interior world to show the button in.

				<areasize> (float)
					Size of the button's detection area.

				<label> (boolean)
					Determines whether a 3D Text Label should be at the button.

				<labeltext> (string)
					The text that the label should show.

				<labelcolour> (int)
					The colour of the label.

				<streamdist> (float)
					Stream distance of the label.


			Returns:
				(int, buttonid)
					Button ID handle of the newly created button.

				INVALID_BUTTON_ID
					If another button cannot be created due to BTN_MAX limit.
		}

		native DestroyButton(buttonid)
		{
			Description:
				Destroys a button.

			Parameters:
				<buttonid> (int, buttonid)
					The button handle ID to delete.

			Returns:
				1
					If destroying the button was successful

				0
					If <buttonid> is an invalid button ID handle.
		}
	
		native LinkTP(buttonid1, buttonid2)
		{
			Description:
				Links two buttons to be teleport buttons, if a user presses
				<buttonid1> he will be teleported to the position of <buttonid2>
				and vice versa, the buttonids require no particular order.
	
			Parameters:
				<buttonid1> (int, buttonid)
					The first button ID to link.

				<buttonid2> (int, buttonid)
					The second button ID to link <buttonid1> to.

			Returns:
				1
					If the link was successful
				0
					If either of the button IDs are invalid.
		}
	
		native UnLinkTP(buttonid1, buttonid2)
		{
			Description:
				Un-links two linked buttons
	
			Parameters:
				<buttonid1> (int, buttonid)
					The first button ID to un-link, must be a linked button.

				<buttonid2> (int, buttonid)
					The second button ID to un-link, must be a linked button.

			Returns:
				0
					If either of the button IDs are invalid.

				-1
					If either of the button IDs are not linked.

				-2
					If both buttons are linked, but not to each other.
		}
	}

	SIF/Button/Events
	{
		Events called by player actions done by using features from this script.

		native -
		native - SIF/Button/Callbacks
		native -

		native OnButtonPress(playerid, buttonid)
		{
			Called:
				When a player presses the F/Enter key while at a button.

			Parameters:
				<playerid> (int)
					The ID of the player who pressed the button.

				<buttonid> (int, buttonid)
					The ID handle of the button he pressed.

			Returns:
				0
					To allow a linked button teleport.

				1
					To deny a linked button teleport.
		}

		native OnButtonRelease(playerid, buttonid)
		{
			Called:
				When a player releases the F/Enter key after pressing it while
				at a button.

			Parameters:
				<playerid> (int)
					The ID of the player who originally pressed the button.

				<buttonid> (int, buttonid)
					The ID handle of the button he was at when he originally
					pressed the F/Enter key.

			Returns:
				(none)
		}

		native OnPlayerEnterButtonArea(playerid, buttonid)
		{
			Called:
				When a player enters the dynamic streamed area of a button.

			Parameters:
				<playerid> (int)
					The ID of the player who entered the button area.

				<buttonid> (int, buttonid)
					The ID handle of the button.

			Returns:
				(none)
		}

		native OnPlayerLeaveButtonArea(playerid, buttonid)
		{
			Called:
				When a player leaves the dynamic streamed area of a button.

			Parameters:
				<playerid> (int)
					The ID of the player who left the button area.

				<buttonid> (int, buttonid)
					The ID handle of the button.

			Returns:
				(none)
		}
	}

	SIF/Button/Interface Functions
	{
		Functions to get or set data values in this script without editing
		the data directly. These include automatic ID validation checks.

		native -
		native - SIF/Button/Interface
		native -

		native IsValidButton(buttonid)
		{
			Description:
				Checks if <buttonid> is a valid button ID handle.

			Parameters:
				<buttonid> (int, buttonid)
					The button ID handle to check.

			Returns:
				1
					If the button ID handle <buttonid> is valid.

				0
					If the button ID handle <buttonid> is invalid.
		}

		native GetButtonPos(buttonid, &Float:x, &Float:y, &Float:z)
		{
			Description:

			Parameters:
				<buttonid> (int, buttonid)
					The ID handle of the button to get the position of.

				<x, y, z> (float)
					The X, Y and Z values of the button's position in the world.

			Returns:
				1
					If the position was obtained successfully.

				0
					If <buttonid> is an invalid button ID handle.
		}

		native SetButtonPos(buttonid, Float:x, Float:y, Float:z)
		{
			Description:
				Sets the world position for a button area and 3D Text label
				if it exists.

			Parameters:
				<buttonid> (int, buttonid)
					The ID handle of the button to set the position of.

				<x, y, z> (float)
					The X, Y and Z position values to set the button to.

			Returns:
				1
					If the position was set successfully.

				0
					If <buttonid> is an invalid button ID handle.
		}

		native GetButtonSize(buttonid)
		{
			Description:
				Returns the size of the specified button's dynamic area.

			Parameters:
				-

			Returns:
				0.0
					If the specified button ID handle is invalid.
		}

		native SetButtonSize(buttonid, Float:size)
		{
			Description:
				Sets a button's detection area size.

			Parameters:
				<size> (float)
					The size of the button area.

			Returns:
				1
					If the size was set successfully.

				0
					If <buttonid> is an invalid button ID handle.
		}

		native GetPlayerButtonArea(playerid)
		{
			Description:
				Returns the ID of the button which <playerid> is within the area
				of if any.

			Parameters:
				<playerid> (int)
					The player you want to retreive the button area of.

			Returns:
				(int)
					Button ID handle of the button area that the player is in.

				INVALID_BUTTON_ID
					If the player isn't in a button's area.
		}

		native GetButtonLinkedID(buttonid)
		{
			Description:
				Returns the linked button of <buttonid>.

			Parameters:
				<buttonid> (int, buttonid)
					The button ID handle to get the linked button from.

			Returns:
				(int, buttonid)
					The button ID handle that <buttonid> is linked to

				INVALID_BUTTON_ID
					If the button isn't linked to another button.
		}

		native SetButtonMessage(buttonid, msg[])
		{
			Description:
				Sets the button's on-screen message text for when a player
				enters the button's area.

			Parameters:
				<buttonid> (int, buttonid)
					The button ID handle to set the message text of.

				<msg> (string)
					The text to set the message to.

			Returns:
				1
					If the message text was set successfully.

				0
					If <buttonid> is an invalid button ID handle.
		}

		native SetButtonLabel(buttonid, text[], colour = 0xFFFF00FF, Float:range = BTN_DEFAULT_STREAMDIST)
		{
			Description:
				Creates a 3D Text Label at the specified button ID handle, if
				a label already exists it updates the text, colour and range.

			Parameters:
				<buttonid> (int, buttonid)
					The button ID handle to set the label of.

				<text> (string)
					The text to display in the label.

				<colour> (int)
					The colour of the label.

				<range> (float)
					The stream range of the label.

			Returns:
				0
					If the button ID handle is invalid

				1
					If the label was created successfully.

				2
					If the label already existed and was updated successfully.
		}

		native DestroyButtonLabel(buttonid)
		{
			Description:
				Removes the label from a button.

			Parameters:
				<buttonid>
					The button ID handle to remove the label from.

			Returns:
				0
					If the button ID handle is invalid

				-1
					If the button does not have a label to remove.
		}
		stock GetPlayerAngleToButton(playerid, buttonid)
		{
			Description:
				-

			Parameters:
				-

			Returns:
				-
		}
		stock GetButtonAngleToPlayer(playerid, buttonid)
		{
			Description:
				-

			Parameters:
				-

			Returns:
				-
		}

	}

	SIF/Button/Internal Functions
	{
		Internal events called by player actions done by using features from
		this script.
	
		Internal_OnButtonPress(playerid, buttonid)
		{
			Description:
				Called to handle linked button teleports, 
		}
	}

	SIF/Button/Hooks
	{
		Hooked functions or callbacks, either SA:MP natives or from other
		scripts or plugins.

		SAMP/OnPlayerKeyStateChange
		{
			Reason:
				To detect player key inputs to allow players to press the
				default F/Enter keys to operate buttons and call OnButtonPress
				or OnButtonRelease.
		}

		Streamer/OnPlayerEnterDynamicArea
		{
			Reason:
				To detect if a player enters a button's area and call
				OnPlayerEnterButtonArea.
		}

		Streamer/OnPlayerLeaveDynamicArea
		{
			Reason:
				To detect if a player leaves a button's area and call
				OnPlayerLeaveButtonArea.
		}
	}




==============================================================================*/


#if !defined _SIF_DEBUG_INCLUDED
	#include <SIF/Debug.pwn>
#endif

#if !defined _SIF_CORE_INCLUDED
	#include <SIF/Core.pwn>
#endif

#include <YSI\y_iterate>
#include <YSI\y_timers>
#include <YSI\y_hooks>
#include <streamer>
#include <md-sort>

#define _SIF_BUTTON_INCLUDED


/*==============================================================================

	Setup

==============================================================================*/


#if !defined BTN_MAX
	#define BTN_MAX			(8192)
#endif

#if !defined BTN_MAX_TEXT
	#define BTN_MAX_TEXT	(128)
#endif

#if !defined BTN_DEFAULT_STREAMDIST
	#define BTN_DEFAULT_STREAMDIST	(4.0)
#endif

#if !defined BTN_MAX_INRANGE
	#define BTN_MAX_INRANGE	(8)
#endif

#if !defined BTN_STREAMER_AREA_IDENTIFIER
	#define BTN_STREAMER_AREA_IDENTIFIER (100)
#endif


#define INVALID_BUTTON_ID	(-1)


enum E_BTN_DATA
{
			btn_area,
Text3D:		btn_label,
Float:		btn_posX,
Float:		btn_posY,
Float:		btn_posZ,
Float:		btn_size,
			btn_world,
			btn_interior,
			btn_link,
			btn_text[BTN_MAX_TEXT],

			btn_exData
}

enum e_button_range_data
{
			btn_buttonId,
Float:		btn_distance
}


new
			btn_Data[BTN_MAX][E_BTN_DATA],
Iterator:	btn_Index<BTN_MAX>;

static
			btn_CurrentlyNear[MAX_PLAYERS][BTN_MAX_INRANGE],
Iterator:	btn_CurrentlyNearIndex[MAX_PLAYERS]<BTN_MAX_INRANGE>,
			btn_CurrentlyPressing[MAX_PLAYERS];


forward OnButtonPress(playerid, buttonid);
forward OnButtonRelease(playerid, buttonid);
forward OnPlayerEnterButtonArea(playerid, buttonid);
forward OnPlayerLeaveButtonArea(playerid, buttonid);


/*==============================================================================

	Zeroing

==============================================================================*/


#if defined FILTERSCRIPT
hook OnFilterScriptInit()
#else
hook OnGameModeInit()
#endif
{
	sif_debug(SIF_DEBUG_LEVEL_CALLBACKS, "[OnInit]");
	Iter_Init(btn_CurrentlyNearIndex);

	for(new i; i < MAX_PLAYERS; i++)
	{
		btn_CurrentlyPressing[i] = INVALID_BUTTON_ID;
	}
}

hook OnPlayerConnect(playerid)
{
	sif_debug(SIF_DEBUG_LEVEL_CALLBACKS, "[OnPlayerConnect]", playerid);
	Iter_Clear(btn_CurrentlyNearIndex[playerid]);
	btn_CurrentlyPressing[playerid] = INVALID_BUTTON_ID;
}


/*==============================================================================

	Core Functions

==============================================================================*/


stock CreateButton(Float:x, Float:y, Float:z, text[], world = 0, interior = 0, Float:areasize = 1.0, label = 0, labeltext[] = "", labelcolour = 0xFFFF00FF, Float:streamdist = BTN_DEFAULT_STREAMDIST)
{
	sif_debug(SIF_DEBUG_LEVEL_CORE, "[CreateButton]");
	new id = Iter_Free(btn_Index);

	if(id == -1)
	{
		print("ERROR: BTN_MAX reached, please increase this constant!");
		return INVALID_BUTTON_ID;
	}

	btn_Data[id][btn_area]				= CreateDynamicSphere(x, y, z, areasize, world, interior);

	strcpy(btn_Data[id][btn_text], text, BTN_MAX_TEXT);
	btn_Data[id][btn_posX]				= x;
	btn_Data[id][btn_posY]				= y;
	btn_Data[id][btn_posZ]				= z;
	btn_Data[id][btn_size]				= areasize;
	btn_Data[id][btn_world]				= world;
	btn_Data[id][btn_interior]			= interior;
	btn_Data[id][btn_link]				= INVALID_BUTTON_ID;

	if(label)
		btn_Data[id][btn_label] = CreateDynamic3DTextLabel(labeltext, labelcolour, x, y, z, streamdist, _, _, 1, world, interior, _, streamdist);

	else
		btn_Data[id][btn_label] = Text3D:INVALID_3DTEXT_ID;

	new data[2];

	data[0] = BTN_STREAMER_AREA_IDENTIFIER;
	data[1] = id;

	Streamer_SetArrayData(STREAMER_TYPE_AREA, btn_Data[id][btn_area], E_STREAMER_EXTRA_ID, data, 2);

	Iter_Add(btn_Index, id);

	return id;
}
stock DestroyButton(buttonid)
{
	sif_debug(SIF_DEBUG_LEVEL_CORE, "[DestroyButton]");
	if(!Iter_Contains(btn_Index, buttonid))
		return 0;

	foreach(new i : Player)
	{
		if(IsPlayerInDynamicArea(i, btn_Data[buttonid][btn_area]))
			process_LeaveDynamicArea(i, btn_Data[buttonid][btn_area]);
	}

	DestroyDynamicArea(btn_Data[buttonid][btn_area]);

	if(IsValidDynamic3DTextLabel(btn_Data[buttonid][btn_label]))
		DestroyDynamic3DTextLabel(btn_Data[buttonid][btn_label]);

	btn_Data[buttonid][btn_area]		= -1;
	btn_Data[buttonid][btn_label]		= Text3D:INVALID_3DTEXT_ID;

	btn_Data[buttonid][btn_posX]		= 0.0;
	btn_Data[buttonid][btn_posY]		= 0.0;
	btn_Data[buttonid][btn_posZ]		= 0.0;
	btn_Data[buttonid][btn_size]		= 0.0;
	btn_Data[buttonid][btn_world]		= 0;
	btn_Data[buttonid][btn_interior]	= 0;
	btn_Data[buttonid][btn_link]		= INVALID_BUTTON_ID;
	btn_Data[buttonid][btn_text][0]		= EOS;

	Iter_Remove(btn_Index, buttonid);

	return 1;
}

stock LinkTP(buttonid1, buttonid2)
{
	sif_debug(SIF_DEBUG_LEVEL_CORE, "[LinkTP]");
	if(!Iter_Contains(btn_Index, buttonid1) || !Iter_Contains(btn_Index, buttonid2))
		return 0;

	btn_Data[buttonid1][btn_link] = buttonid2;
	btn_Data[buttonid2][btn_link] = buttonid1;

	return 1;
}

stock UnLinkTP(buttonid1, buttonid2)
{
	sif_debug(SIF_DEBUG_LEVEL_CORE, "[UnLinkTP]");
	if(!Iter_Contains(btn_Index, buttonid1) || !Iter_Contains(btn_Index, buttonid2))
		return 0;

	if(btn_Data[buttonid1][btn_link] == INVALID_BUTTON_ID || btn_Data[buttonid1][btn_link] == INVALID_BUTTON_ID)
		return -1;

	if(btn_Data[buttonid1][btn_link] != buttonid2 || btn_Data[buttonid2][btn_link] != buttonid1)
		return -2;

	btn_Data[buttonid1][btn_link] = INVALID_BUTTON_ID;
	btn_Data[buttonid2][btn_link] = INVALID_BUTTON_ID;

	return 1;
}


/*==============================================================================

	Internal Functions and Hooks

==============================================================================*/


hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	sif_debug(SIF_DEBUG_LEVEL_CALLBACKS, "[OnPlayerKeyStateChange]", playerid);
	if(newkeys & 16)
	{
		if(!IsPlayerInAnyVehicle(playerid) && Iter_Count(btn_CurrentlyNearIndex[playerid]) > 0)
		{
			if(!IsPlayerInAnyDynamicArea(playerid))
			{
				printf("[WARNING] Player %d is not in areas but list isn't empty. Purging list.", playerid);
				Iter_Clear(btn_CurrentlyNearIndex[playerid]);
			}

			new
				id,
				Float:x,
				Float:y,
				Float:z,
				Float:distance,
				list[BTN_MAX_INRANGE][e_button_range_data],
				index;

			GetPlayerPos(playerid, x, y, z);

			foreach(new i : btn_CurrentlyNearIndex[playerid])
			{
				if(index >= BTN_MAX_INRANGE)
					break;

				id = btn_CurrentlyNear[playerid][i];

				distance = sif_Distance(x, y, z, btn_Data[id][btn_posX], btn_Data[id][btn_posY], btn_Data[id][btn_posZ]);

				if(distance < btn_Data[id][btn_size])
				{
					list[index][btn_buttonId] = id;
					list[index][btn_distance] = distance;

					index++;
				}
			}

			SortDeepArray(list, btn_distance);

			for(new i = BTN_MAX_INRANGE - index; i < BTN_MAX_INRANGE; i++)
			{
				if(btn_Data[list[i][btn_buttonId]][btn_posZ] - btn_Data[list[i][btn_buttonId]][btn_size] <= z <= btn_Data[list[i][btn_buttonId]][btn_posZ] + btn_Data[list[i][btn_buttonId]][btn_size])
				{
					if(Internal_OnButtonPress(playerid, list[i][btn_buttonId]))
						break;
				}
			}
		}

		if(oldkeys & 16)
		{
			if(btn_CurrentlyPressing[playerid] != INVALID_BUTTON_ID)
			{
				CallLocalFunction("OnButtonRelease", "dd", playerid, btn_CurrentlyPressing[playerid]);
				btn_CurrentlyPressing[playerid] = INVALID_BUTTON_ID;
			}
		}
	}
	return 1;
}

Internal_OnButtonPress(playerid, buttonid)
{
	sif_debug(SIF_DEBUG_LEVEL_INTERNAL, "[Internal_OnButtonPress]", playerid);
	if(!Iter_Contains(btn_Index, buttonid))
		return 0;

	new id = btn_Data[buttonid][btn_link];

	if(Iter_Contains(btn_Index, id))
	{
		if(CallLocalFunction("OnButtonPress", "dd", playerid, buttonid))
			return 1;

		TogglePlayerControllable(playerid, false);
		defer btn_Unfreeze(playerid);

		Streamer_UpdateEx(playerid,
			btn_Data[id][btn_posX], btn_Data[id][btn_posY], btn_Data[id][btn_posZ],
			btn_Data[id][btn_world], btn_Data[id][btn_interior]);

		SetPlayerVirtualWorld(playerid, btn_Data[id][btn_world]);
		SetPlayerInterior(playerid, btn_Data[id][btn_interior]);
		SetPlayerPos(playerid, btn_Data[id][btn_posX], btn_Data[id][btn_posY], btn_Data[id][btn_posZ]);
	}
	else
	{
		btn_CurrentlyPressing[playerid] = buttonid;

		if(CallLocalFunction("OnButtonPress", "dd", playerid, buttonid))
			return 1;
	}

	return 0;
}

timer btn_Unfreeze[1000](playerid)
{
	TogglePlayerControllable(playerid, true);
}

public OnPlayerEnterDynamicArea(playerid, areaid)
{
	sif_debug(SIF_DEBUG_LEVEL_CALLBACKS, "[OnPlayerEnterDynamicArea]", playerid);
	if(!IsPlayerInAnyVehicle(playerid) && Iter_Count(btn_CurrentlyNearIndex[playerid]) < BTN_MAX_INRANGE)
	{
		sif_debug(SIF_DEBUG_LEVEL_CALLBACKS_DEEP, "[OnPlayerEnterDynamicArea] player is valid", playerid);
		new data[2];

		Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, data, 2);

		// Due to odd streamer behavior reversing data arrays:
		new tmp = data[0];
		data[0] = data[1];
		data[1] = tmp;
		// end

		if(data[0] == BTN_STREAMER_AREA_IDENTIFIER)
		{
			sif_debug(SIF_DEBUG_LEVEL_CALLBACKS_DEEP, "[OnPlayerEnterDynamicArea] area is valid", playerid);
			if(Iter_Contains(btn_Index, data[1]))
			{
				sif_debug(SIF_DEBUG_LEVEL_CALLBACKS_DEEP, "[OnPlayerEnterDynamicArea] in index", playerid);
				new cell = Iter_Free(btn_CurrentlyNearIndex[playerid]);

				btn_CurrentlyNear[playerid][cell] = data[1];
				Iter_Add(btn_CurrentlyNearIndex[playerid], cell);

				ShowActionText(playerid, btn_Data[data[1]][btn_text]);
				CallLocalFunction("OnPlayerEnterButtonArea", "dd", playerid, data[1]);
			}
		}
	}

	sif_debug(SIF_DEBUG_LEVEL_CALLBACKS_DEEP, "[OnPlayerEnterDynamicArea] end", playerid);

	#if defined btn_OnPlayerEnterDynamicArea
		return btn_OnPlayerEnterDynamicArea(playerid, areaid);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnPlayerEnterDynamicArea
	#undef OnPlayerEnterDynamicArea
#else
	#define _ALS_OnPlayerEnterDynamicArea
#endif
#define OnPlayerEnterDynamicArea btn_OnPlayerEnterDynamicArea
#if defined btn_OnPlayerEnterDynamicArea
	forward btn_OnPlayerEnterDynamicArea(playerid, areaid);
#endif


public OnPlayerLeaveDynamicArea(playerid, areaid)
{
	process_LeaveDynamicArea(playerid, areaid);

	#if defined btn_OnPlayerLeaveDynamicArea
		return btn_OnPlayerLeaveDynamicArea(playerid, areaid);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnPlayerLeaveDynamicArea
	#undef OnPlayerLeaveDynamicArea
#else
	#define _ALS_OnPlayerLeaveDynamicArea
#endif
#define OnPlayerLeaveDynamicArea btn_OnPlayerLeaveDynamicArea
#if defined btn_OnPlayerLeaveDynamicArea
	forward btn_OnPlayerLeaveDynamicArea(playerid, areaid);
#endif

process_LeaveDynamicArea(playerid, areaid)
{
	sif_debug(SIF_DEBUG_LEVEL_CALLBACKS, "[OnPlayerLeaveDynamicArea]", playerid);
	if(!IsPlayerInAnyVehicle(playerid) && Iter_Count(btn_CurrentlyNearIndex[playerid]) > 0)
	{
		sif_debug(SIF_DEBUG_LEVEL_CALLBACKS_DEEP, "[OnPlayerLeaveDynamicArea] player is valid", playerid);
		new data[2];

		Streamer_GetArrayData(STREAMER_TYPE_AREA, areaid, E_STREAMER_EXTRA_ID, data, 2);

		// Due to odd streamer behavior reversing data arrays:
		new tmp = data[0];
		data[0] = data[1];
		data[1] = tmp;
		// end

		if(data[0] == BTN_STREAMER_AREA_IDENTIFIER)
		{
			sif_debug(SIF_DEBUG_LEVEL_CALLBACKS_DEEP, "[OnPlayerLeaveDynamicArea] area is valid", playerid);
			if(Iter_Contains(btn_Index, data[1]))
			{
				sif_debug(SIF_DEBUG_LEVEL_CALLBACKS_DEEP, "[OnPlayerLeaveDynamicArea] in index", playerid);
				HideActionText(playerid);
				CallLocalFunction("OnPlayerLeaveButtonArea", "dd", playerid, data[1]);

				foreach(new i : btn_CurrentlyNearIndex[playerid])
				{
					sif_debug(SIF_DEBUG_LEVEL_LOOPS, "[OnPlayerLeaveDynamicArea] looping player list", playerid);
					// ^ Add when debug supports format strings
					if(btn_CurrentlyNear[playerid][i] == data[1])
					{
						sif_debug(SIF_DEBUG_LEVEL_CALLBACKS_DEEP, "[OnPlayerLeaveDynamicArea] removing from player list", playerid);
						Iter_Remove(btn_CurrentlyNearIndex[playerid], i);
						break;
					}
				}
			}
		}
	}
}


/*==============================================================================

	Interface Functions

==============================================================================*/


stock IsValidButton(buttonid)
{
	sif_debug(SIF_DEBUG_LEVEL_INTERFACE, "[IsValidButton]");
	if(!Iter_Contains(btn_Index, buttonid))
		return 0;

	return 1;
}
// btn_area
stock GetButtonArea(buttonid)
{
	sif_debug(SIF_DEBUG_LEVEL_INTERFACE, "[GetButtonWorld]");
	if(!Iter_Contains(btn_Index, buttonid))
		return -1;

	return btn_Data[buttonid][btn_area];
}
stock SetButtonArea(buttonid, areaid)
{
	sif_debug(SIF_DEBUG_LEVEL_INTERFACE, "[GetButtonWorld]");
	if(!Iter_Contains(btn_Index, buttonid))
		return 0;

	btn_Data[buttonid][btn_area] = areaid;

	return 1;
}


// btn_label
stock SetButtonLabel(buttonid, text[], colour = 0xFFFF00FF, Float:range = BTN_DEFAULT_STREAMDIST)
{
	sif_debug(SIF_DEBUG_LEVEL_INTERFACE, "[SetButtonLabel]");
	if(!Iter_Contains(btn_Index, buttonid))
		return 0;

	if(IsValidDynamic3DTextLabel(btn_Data[buttonid][btn_label]))
	{
		UpdateDynamic3DTextLabelText(btn_Data[buttonid][btn_label], colour, text);
		return 2;
	}

	btn_Data[buttonid][btn_label] = CreateDynamic3DTextLabel(text, colour,
		btn_Data[buttonid][btn_posX],
		btn_Data[buttonid][btn_posY],
		btn_Data[buttonid][btn_posZ],
		range, _, _, 1,
		btn_Data[buttonid][btn_world], btn_Data[buttonid][btn_interior], _, range);

	return 1;
}
stock DestroyButtonLabel(buttonid)
{
	sif_debug(SIF_DEBUG_LEVEL_INTERFACE, "[DestroyButtonLabel]");
	if(!Iter_Contains(btn_Index, buttonid))
		return 0;

	if(!IsValidDynamic3DTextLabel(btn_Data[buttonid][btn_label]))
		return -1;

	DestroyDynamic3DTextLabel(btn_Data[buttonid][btn_label]);
	btn_Data[buttonid][btn_label] = INVALID_3DTEXT_ID;

	return 1;
}

// btn_posX
// btn_posY
// btn_posZ
stock GetButtonPos(buttonid, &Float:x, &Float:y, &Float:z)
{
	sif_debug(SIF_DEBUG_LEVEL_INTERFACE, "[GetButtonPos]");
	if(!Iter_Contains(btn_Index, buttonid))
		return 0;

	x = btn_Data[buttonid][btn_posX];
	y = btn_Data[buttonid][btn_posY];
	z = btn_Data[buttonid][btn_posZ];

	return 1;
}
stock SetButtonPos(buttonid, Float:x, Float:y, Float:z)
{
	sif_debug(SIF_DEBUG_LEVEL_INTERFACE, "[SetButtonPos]");
	if(!Iter_Contains(btn_Index, buttonid))
		return 0;

	Streamer_SetFloatData(STREAMER_TYPE_AREA, btn_Data[buttonid][btn_area], E_STREAMER_X, x);
	Streamer_SetFloatData(STREAMER_TYPE_AREA, btn_Data[buttonid][btn_area], E_STREAMER_Y, y);
	Streamer_SetFloatData(STREAMER_TYPE_AREA, btn_Data[buttonid][btn_area], E_STREAMER_Z, z);

	if(IsValidDynamic3DTextLabel(btn_Data[buttonid][btn_label]))
	{
		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, btn_Data[buttonid][btn_label], E_STREAMER_X, x);
		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, btn_Data[buttonid][btn_label], E_STREAMER_Y, y);
		Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, btn_Data[buttonid][btn_label], E_STREAMER_Z, z);
	}

	btn_Data[buttonid][btn_posX] = x;
	btn_Data[buttonid][btn_posY] = y;
	btn_Data[buttonid][btn_posZ] = z;

	return 1;
}

// btn_size
stock Float:GetButtonSize(buttonid)
{
	sif_debug(SIF_DEBUG_LEVEL_INTERFACE, "[GetButtonSize]");
	if(!Iter_Contains(btn_Index, buttonid))
		return 0.0;

	return btn_Data[buttonid][btn_size];
}
stock SetButtonSize(buttonid, Float:size)
{
	sif_debug(SIF_DEBUG_LEVEL_INTERFACE, "[SetButtonSize]");
	if(!Iter_Contains(btn_Index, buttonid))
		return 0;

	Streamer_SetFloatData(STREAMER_TYPE_AREA, btn_Data[buttonid][btn_area], E_STREAMER_SIZE, size);
	btn_Data[buttonid][btn_size]y = size;

	return 1;
}

// btn_world
stock GetButtonWorld(buttonid)
{
	sif_debug(SIF_DEBUG_LEVEL_INTERFACE, "[GetButtonWorld]");
	if(!Iter_Contains(btn_Index, buttonid))
		return -1;

	return btn_Data[buttonid][btn_world];
}
stock SetButtonWorld(buttonid, world)
{
	sif_debug(SIF_DEBUG_LEVEL_INTERFACE, "[SetButtonWorld]");
	if(!Iter_Contains(btn_Index, buttonid))
		return 0;

	Streamer_SetFloatData(STREAMER_TYPE_AREA, btn_Data[buttonid][btn_area], E_STREAMER_WORLD, world);

	if(IsValidDynamic3DTextLabel(btn_Data[buttonid][btn_label]))
	{
		Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, btn_Data[buttonid][btn_label], E_STREAMER_WORLD, world);
	}

	btn_Data[buttonid][btn_world] = world;

	return 1;
}

// btn_interior
stock GetButtonInterior(buttonid)
{
	sif_debug(SIF_DEBUG_LEVEL_INTERFACE, "[GetButtonInterior]");
	if(!Iter_Contains(btn_Index, buttonid))
		return -1;

	return btn_Data[buttonid][btn_interior];
}
stock SetButtonInterior(buttonid, interior)
{
	sif_debug(SIF_DEBUG_LEVEL_INTERFACE, "[SetButtonInterior]");
	if(!Iter_Contains(btn_Index, buttonid))
		return 0;

	Streamer_SetFloatData(STREAMER_TYPE_AREA, btn_Data[buttonid][btn_area], E_STREAMER_INTERIOR_ID, interior);

	if(IsValidDynamic3DTextLabel(btn_Data[buttonid][btn_label]))
	{
		Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, btn_Data[buttonid][btn_label], E_STREAMER_INTERIOR_ID, interior);
	}

	btn_Data[buttonid][btn_interior] = interior;

	return 1;
}

// btn_link
stock GetButtonLinkedID(buttonid)
{
	sif_debug(SIF_DEBUG_LEVEL_INTERFACE, "[GetButtonLinkedID]");
	if(!Iter_Contains(btn_Index, buttonid))
		return INVALID_BUTTON_ID;

	return btn_Data[buttonid][btn_link];
}

// btn_text
stock GetButtonText(buttonid, text[])
{
	sif_debug(SIF_DEBUG_LEVEL_INTERFACE, "[GetButtonText]");
	if(!Iter_Contains(btn_Index, buttonid))
		return 0;

	text[0] = EOS;
	strcat(text, btn_Data[buttonid][btn_text], BTN_MAX_TEXT);

	return 1;
}
stock SetButtonText(buttonid, text[])
{
	sif_debug(SIF_DEBUG_LEVEL_INTERFACE, "[SetButtonText]");
	if(!Iter_Contains(btn_Index, buttonid))
		return 0;

	btn_Data[buttonid][btn_text][0] = EOS;
	strcat(btn_Data[buttonid][btn_text], text, BTN_MAX_TEXT);

	return 1;
}

// btn_exData
stock SetButtonExtraData(itemid, data)
{
	if(!Iter_Contains(btn_Index, itemid))
		return 0;

	btn_Data[itemid][btn_exData] = data;

	return 1;
}
stock GetButtonExtraData(itemid)
{
	if(!Iter_Contains(btn_Index, itemid))
		return 0;

	return btn_Data[itemid][btn_exData];
}

// btn_CurrentlyPressing
stock GetPlayerPressingButton(playerid)
{
	sif_debug(SIF_DEBUG_LEVEL_INTERFACE, "[GetPlayerPressingButton]", playerid);
	if(!(0 <= playerid < MAX_PLAYERS))
		return -1;

	return btn_CurrentlyPressing[playerid];
}

stock GetPlayerButtonID(playerid)
{
	sif_debug(SIF_DEBUG_LEVEL_INTERFACE, "[GetPlayerButtonID]", playerid);
	foreach(new i : btn_Index)
	{
		if(IsPlayerInDynamicArea(playerid, btn_Data[i][btn_area]))
		{
			return i;
		}
	}

	return INVALID_BUTTON_ID;
}

stock SetButtonMessage(buttonid, msg[])
{
	sif_debug(SIF_DEBUG_LEVEL_INTERFACE, "[SetButtonMessage]");
	if(!Iter_Contains(btn_Index, buttonid))
		return 0;

	btn_Data[buttonid][btn_text][0] = EOS;
	strcpy(btn_Data[buttonid][btn_text], msg);

	foreach(new i : Player)
		if(IsPlayerViewingMsgBox(i))
			ShowActionText(i, btn_Data[i][btn_text]);

	return 1;
}

stock Float:GetPlayerAngleToButton(playerid, buttonid)
{
	sif_debug(SIF_DEBUG_LEVEL_INTERFACE, "[GetPlayerAngleToButton]", playerid);
	if(!Iter_Contains(btn_Index, buttonid))
		return 0.0;

	if(!IsPlayerConnected(playerid))
		return 0.0;

	new
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos(playerid, x, y, z);

	return sif_GetAngleToPoint(x, y, btn_Data[buttonid][btn_posX], btn_Data[buttonid][btn_posY]);
}

stock Float:GetButtonAngleToPlayer(playerid, buttonid)
{
	sif_debug(SIF_DEBUG_LEVEL_INTERFACE, "[GetButtonAngleToPlayer]", playerid);
	if(!Iter_Contains(btn_Index, buttonid))
		return 0.0;

	if(!IsPlayerConnected(playerid))
		return 0.0;

	new
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos(playerid, x, y, z);

	return sif_GetAngleToPoint(btn_Data[buttonid][btn_posX], btn_Data[buttonid][btn_posY], x, y);
}
