#!/usr/bin/env fish


function fish_prompt
## themes in omf could not used by source command
## source $OMF_PATH/themes/$theme_to_enable/functions/fish_prompt.fish


## workaround for priority of fish_prompt.fish . It causes omf theme command failing. 
## omf theme this script file will not call rm command to fix the issue.
	if test -e (omf.xdg.config_home)/fish/functions/fish_prompt.fish
	rm (omf.xdg.config_home)/fish/functions/fish_prompt.fish 
	end


## pickup a new local theme
	while true
	set theme_to_enable (random choice (omf.packages.list --theme))
	
		if test "random" != "$theme_to_enable"
			if test "random_omf_theme" != "$theme_to_enable"
			break
			end
		end
        end

        ## enable the theme
        omf.theme.set "$theme_to_enable"
	
	
	## force omf to enable a new theme when fish source dotfiles (i.e. omf reload)
	printf "random" > "$OMF_CONFIG"/theme
	
	
	##  command makes a new prompt line that fix prompt line disappeared after enabling new theme.
	printf " \r "
	## When random theme is enabled, omf reload command will cause dead loop.
	## prompt line appears without theme after enabling a new theme.
	## The new theme will be enabled after a command returns.
	## omf.cli.reload

	
## function fish_prompt end	
end
