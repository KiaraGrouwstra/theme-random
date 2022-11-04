#!/usr/bin/env fish


# name: random


function fish_prompt
## themes in omf could not used by source command
## source $OMF_PATH/themes/$theme_to_enable/functions/fish_prompt.fish


## workaround for priority of fish_prompt.fish . It cause omf theme command fail.

	if test -e (omf.xdg.config_home)/fish/functions/fish_prompt.fish
	rm (omf.xdg.config_home)/fish/functions/fish_prompt.fish 
	end


## pickup a theme_to_enable from omf official repo
	while true
	set theme_to_enable (random choice (omf.index.query --type=theme ))
	if test "random" != $theme_to_enable
		if test "random_omf_theme" != $theme_to_enable
		break
		end
	end
	end


## enable new theme
	omf.cli.theme $theme_to_enable


## fix prompt disappeared after enabling new theme.  
	omf.cli.reload
end