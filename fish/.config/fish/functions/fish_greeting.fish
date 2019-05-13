function fish_greeting -d "Greeting when shell is started."
    # # print out the current version of Fish at start-up
    # set_color cyan
    # echo "Welcome to Fish $version."
    # printf '\n'

    # if the neofetch command exists, then run it
    if command -sq neofetch
        set_color normal
        neofetch
        printf '\n'
    end

    # if the fortune command exists, then provide a fortune
    if command -sq fortune
        set_color yellow
        fortune -sa
        printf '\n'
    end

    set_color normal
end
