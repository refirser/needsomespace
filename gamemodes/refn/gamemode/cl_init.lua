include( "sh_enum.lua" );
include( "shared.lua" );
include( "sh_anim.lua" );
include( "sh_class.lua" );
include( "sh_entities.lua" );
include( "sh_i18.lua" );
include( "sh_powerups.lua" );
include( "sh_player.lua" );
include( "sh_state.lua" );
include( "sh_stats.lua" );
include( "sh_subsystems.lua" );
include( "cl_binds.lua" );
include( "cl_calcview.lua" );
include( "cl_entities.lua" );
include( "cl_gui.lua" );
include( "cl_hints.lua" );
include( "cl_hud.lua" );
include( "cl_map.lua" );
include( "cl_players.lua" );
include( "cl_powerups.lua" );
include( "cl_pp.lua" );
include( "cl_scoreboard.lua" );
include( "cl_skin.lua" );
include( "cl_state.lua" );
include( "cl_subsystems.lua" );
include( "cl_teams.lua" );
include( "cl_think.lua" );

local matBlurScreen = Material( "pp/blurscreen" );

function surface.BackgroundBlur( x, y, w, h, a )

	if( a == 0 ) then return end
	
	local Fraction = 1;

	DisableClipping( true );

	surface.SetMaterial( matBlurScreen );
	surface.SetDrawColor( 255, 255, 255, 255 * ( a or 1 ) );

	for i=0.33, 1, 0.33 do
		matBlurScreen:SetFloat( "$blur", 5 * i );
		matBlurScreen:Recompute();
		if( render ) then render.UpdateScreenEffectTexture() end -- Todo: Make this available to menu Lua
		surface.DrawTexturedRect( x * -1, y * -1, w, h );
	end

	DisableClipping( false );

end