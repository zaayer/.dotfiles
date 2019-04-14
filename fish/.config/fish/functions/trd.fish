function trd -w tree -d "Auto colors output from tree and only shows directories."
    if command -sq tree
        command tree -Cd $argv
    end
end
