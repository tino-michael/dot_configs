# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="[%n@%M %3~]$ "

# Disable ctrl-s to freeze terminal.
stty stop undef
# Basic auto/tab complete:
autoload -U compinit && compinit
zstyle ':completion:*' menu select

# partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# Include hidden files.
_comp_options+=(globdots)

# enable optional case-insensitive globbing
setopt extendedglob

# History in cache directory:
HISTFILE=~/.cache/zsh/history
HISTSIZE=10000000
SAVEHIST=10000000

# Change cursor shape for different vi modes.
function zle-keymap-select ()
{
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init()
{
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# turn CTRL+z into a toggle switch
ctrlz()
{
  if [[ $#BUFFER == 0 ]]; then
    fg >/dev/null 2>&1 && zle redisplay
  else
    zle push-input
  fi
}
zle -N ctrlz
bindkey '^Z' ctrlz


# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

[ -f "${XDG_CONFIG_HOME}/shell/aliasrc" ] && . "${XDG_CONFIG_HOME}/shell/aliasrc"


typeset -g -A key
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
# [[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete
[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word


# history search with up key
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search


# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi



# do NOT source conda and activate conda env when X is not yet running
# only do so, when starting new graphical terminal (i.e. X is running)
# this prevents polluting e.g. rofi with conda python packages,
# not using system ones and failing on version missmatch
if [[ $(xset -q 2&> /dev/null) && $EUID -ne 0 ]]
then
    source ~/software/miniconda3/etc/profile.d/conda.sh
    conda activate py310
fi

# Window title
case $TERM in
    alacritty|st*|termite|*xterm*|rxvt*|(t|k|E)term)
        precmd () { print -Pn "\e]0;%n@%M %~\a" }
        preexec () { print -Pn "\e]0;%n@%M %~ $ $1\a" }
        ;;
    screen|screen-256color)
        precmd () {
            print -Pn "\e]83;title \"$1\"\a"
            print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a"
        }
        preexec () {
            print -Pn "\e]83;title \"$1\"\a"
            print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a"
        }
        ;;
esac


for F in \
    /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
    ~/.local/share/foot/shell_int.zsh \
    /usr/share/fzf/completion.zsh \
    /usr/share/fzf/key-bindings.zsh
do
    [ -f "$F" ] && source "$F"
done

eval "$(starship init zsh)"
