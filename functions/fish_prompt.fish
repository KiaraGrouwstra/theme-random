#!/usr/bin/env fish


## themes in omf could not used by source command
## source $OMF_PATH/themes/$theme_to_enable/functions/fish_prompt.fish


function fish_prompt
	## workaround for priority of fish_prompt.fish . It blocks random theme enabling. 
	if test -e (omf.xdg.config_home)/fish/functions/fish_prompt.fish
	mv -f (omf.xdg.config_home)/fish/functions/fish_prompt.fish (omf.xdg.config_home)/fish/functions/fish_prompt.fish.old
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


        ## enable the new theme
	## use low level functions for performance
        ## omf.theme.set "$theme_to_enable"
	## use high level functions for compatibility
	omf theme "$theme_to_enable"
		
	
	## prompt line appears without theme after enabling a new theme.
	## The new theme will be enabled after a command returns.
	## printf " \n $theme_to_enable theme is enabled. \r "
	echo -e (omf::em)" \n ✔ $theme_to_enable successfully enabled. \r "(omf::off) 
		

	# Load target theme's functions files to try to fix prompt line disappearing. Failed.
	## set target_theme "$theme_to_enable"
	## for target_theme_function in {$OMF_CONFIG,$OMF_PATH}/themes*/$target_theme{,/functions}/*.fish
    	## source $target_theme_function
  	## end
	## prompt line disappears after enabling new theme. That may be a bug of fish shell.
	

	## When random theme is enabled, omf reload command will cause dead loop.
	## omf.cli.reload
	
	
	## force omf to enable a new theme when fish source dotfiles (i.e. omf reload)
	printf "random" > "$OMF_CONFIG"/theme
	

## function fish_prompt end	
end
