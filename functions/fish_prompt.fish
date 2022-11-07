#!/usr/bin/env fish


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
	## use high level functions for compatibility
	omf theme "$theme_to_enable"
	

	echo  (omf::em)"  ✔ $theme_to_enable successfully enabled.  "(omf::off) 	
	

	## force omf to enable a new theme when fish source dotfiles (i.e. omf reload)
	echo "random" > "$OMF_CONFIG"/theme
	
	
	## prompt line disappears after enabling new theme. That may be a bug of fish shell.
	## The new theme will be enabled after a command returns.
	## make a fake prompt line for end users.
	pwd
	echo '>'


## function fish_prompt end	
end
