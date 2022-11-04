#!/usr/bin/env fish


function fish_prompt
## themes in omf could not used by source command
## source $OMF_PATH/themes/$theme_to_enable/functions/fish_prompt.fish


## workaround for priority of fish_prompt.fish . It cause omf theme command fail. 
## omf theme this script file will not call rm command to fix the issue.
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
	omf.theme.set $theme_to_enable
	

	## force omf to enable a new theme when fish source dotfiles (i.e. omf reload)
	printf "random_omf_theme" > $OMF_CONFIG/theme
	
	
	## pwd command makes a new prompt line that fix prompt line disappeared after enabling new theme.
	pwd
	## omf reload command will cause dead loop. It can now refresh prompt line.
	##omf.cli.reload

	
## function fish_prompt end	
end
