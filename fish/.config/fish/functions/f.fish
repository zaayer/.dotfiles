function f -w fff -d "Shortcut to fff and cd on exit."
    command fff $argv
    cd (command cat $XDG_CACHE_HOME/fff/.fff_d)
end
