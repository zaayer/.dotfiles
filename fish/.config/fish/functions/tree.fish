function tree -w tree -d "Auto colors output from tree."
    if command -sq tree
        command tree -C $argv
    end
end
