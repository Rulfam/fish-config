function sudoedit --wraps='doas vim' --description 'alias sudoedit doas vim'
    doas vim $argv
end
