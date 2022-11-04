#!/usr/bin/env fish


function fish_prompt
## themes in omf could not used by source command
## source $OMF_PATH/themes/$theme_to_enable/functions/fish_prompt.fish


## workaround for priority of fish_prompt.fish . It cause omf theme command fail. 
## omf theme this script file will not call rm command to fix the issue.
	if test -e (omf.xdg.config_home)/fish/functions/fish_prompt.fish
	rm (omf.xdg.config_home)/fish/functions/fish_prompt.fish 
	end


## enable a new local theme
	while true
	set theme_to_enable (random choice (omf.packages.list --theme ))
	omf.theme.set $theme_to_enable
	end
	
	
	
	## force omf to enable a new theme when fish source dotfiles (i.e. omf reload)
	printf "random_omf_theme" > $OMF_CONFIG/theme
	
	
	##  command makes a new prompt line that fix prompt line disappeared after enabling new theme.
	printf "\n"
	## omf reload command will cause dead loop. It can now refresh prompt line.
	##omf.cli.reload

	
## function fish_prompt end	
end
