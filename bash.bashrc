
#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ $DISPLAY ]] && shopt -s checkwinsize

PS1='\
\e[`shuf -n1 /opt/ass/resources/colours`m[\
\e[`shuf -n1 /opt/ass/resources/colours`m\u\
\e[`shuf -n1 /opt/ass/resources/colours`m@\
\e[`shuf -n1 /opt/ass/resources/colours`m$(hostname) \
`printf $(shuf -n1 /opt/ass/resources/emojis)` \
\e[`shuf -n1 /opt/ass/resources/colours`m\w\
\e[`shuf -n1 /opt/ass/resources/colours`m]\
\e[`shuf -n1 /opt/ass/resources/colours`m\$\
\e[39m'

#PS1='\
#\e[`shuf -n1 $RANDOMCOLOUR`m[\
#\e[`shuf -n1 $RANDOMCOLOUR`m\u\
#\e[`shuf -n1 $RANDOMCOLOUR`m@\
#\e[`shuf -n1 $RANDOMCOLOUR`m\H \
#`printf $(shuf -n1 $RANDOMEMOJI)` \
#\e[`shuf -n1 $RANDOMCOLOUR`m\w\
#\e[`shuf -n1 $RANDOMCOLOUR`m]\
#\e[`shuf -n1 $RANDOMCOLOUR`m\$\
#\e[39m'

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
  screen*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
esac

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

###########################################################################################################
# MY ALIASES

alias editaliases='nano /etc/bash.bashrc'
alias savealiases='source /etc/bash.bashrc'
alias usbin='mount /dev/sdb1 /mnt/usbstick; cd /mnt/usbstick; ls'
alias usbout='cd; umount /mnt/usbstick; echo "USB stick can now be removed.";tput reset'
usbcopy() { cp $1 /mnt/usbstick; }
alias suck='usbin;cp -R * /mnt/usbstick /home/Desktop/suck'
cd() { builtin cd "$@" && ls -ah --color=auto; }
alias ls='ls -ah --color=auto'
alias uptime='uptime -p'
alias idchange='/opt/ass/idchange.sh'
alias codecreate='/opt/ass/codecreate.sh'
alias codepromote='/opt/ass/codepromote.sh'
alias ipwifi='ip route list | grep default | cut -d " " -f 3'
alias renamepics='ls -v | cat -n | while read n f; do mv -n "$f" "$n.*"; done'
alias slideshow='~/Coding/Bash/slideshow.sh'
alias filerename='~/Coding/Bash/filerename.sh'
alias verticow='~/Coding/Bash/verticow.sh'
alias coding='cd ~/Coding'
alias tree='tree -dfuh --du --prune'
alias login-actions='nano ~/.bashrc'
alias logout-actions='nano ~/.bash_logout'
alias tip='echo && echo $(shuf -n1 /opt/ass/resources/tips) && echo '
alias cowtip='echo && cowsay $(shuf -n1 /opt/ass/resources/tips) && echo '
alias ip='curl ifconfig.me ; echo'
clock-digital() { while :;do printf '%s\r' "$(date +%r)"; sleep 1; done; }

# Change window title.
window-title() {
	if [[ -z "$ORIG" ]]; then 
		ORIG=$PS1
	fi
	TITLE="\[\e]2;$* `emoji-clockface-now`\a\]"
	PS1=${ORIG}${TITLE}
}

# Count lines in a file.
line-count () { wc -l $1 | cut -d ' ' -f 1; }

# Round time to nearest half hour and get corresponding clockface emoji.
emoji-clockface-now () { 
	file=/opt/ass/resources/clockface
	line=$(( $(date +%I) * 2))
	if [ $line -gt 24 ]
	then
		((line-=24))
	fi
	if [ $(date +%M) -gt 15 ] && [ $(date +%M) -lt 46 ]
	then 
		((line+=1))
	elif [ $(date +%M) -gt 45 ] 
	then
		((line+=2))
	fi
	printf `head -n $line $file | tail -n 1 | cut -d ',' -f 2`
}

# Extract random emojis of certain types.
emoji-random () { echo -e $(shuf -n1 /opt/ass/resources/emojis) | cut -d ',' -f 2; }
emoji-clockface-random () { echo -e $(shuf -n1 /opt/ass/resources/clockface) | cut -d ',' -f 2; }
emoji-moonphase-random () { echo -e $(shuf -n1 /opt/ass/resources/moonphase) | cut -d ',' -f 2; }
emoji-weather-random () { echo -e $(shuf -n1 /opt/ass/resources/weather) | cut -d ',' -f 2; }

# Magic 8-ball.
magic8ball () { echo -e $(shuf -n1 /opt/ass/resources/magic8ball ) ; }

#emoji-clockface-specific () {
#	targetline=24/$(date +%I)
#	sed "${targetline}q;d" ~/Coding/Resources/weather
#}

# Extract specific emojis of certain types.
get-emoji () {
case $1 in 
	1)
		emoji-random;;
	2)
		emoji-clockface-random;;
	3)
		emoji-moonphase-random;;
	4)
		emoji-weather-random;;
esac
}

#	if [[ -z $1 ]]; then;
#		`emoji-random`
#	elif [[ $1 == 1 ]]
#		case $2 in
#			`emoji-clockface-random` | cut -d "," -f2;
#	elif [[ $1 == 2 ]]
#		case $2 in
#			`emoji-moonphase-random`;
#	elif [[ $1 == 3 ]]
#		case $2 in
#			`emoji-weather-random`;
#	fi;
#}

# Coding and compiling
compilec() { gcc -Wall -o ${PWD##*/} $@ ; }
compilecpp() { g++ -g -Wall $@ -o ${PWD##*/} ; }
compilenasm() { nasm -felf64 $@ && ld ${PWD##*/}.o && ./a.out ; }
alias git-find='find / -name "*.git" -type d'

# Work: DVA
alias ssh-prod='ssh -p 443 admin.adam.webber@mezzo.altocloudlab.com'
alias ssh-test='ssh -p 443 admin.adam.webber@tenor.altocloudlab.com'
alias fluffyserversauron='ssh sauron@10.240.139.182'
alias fluffyservergit='ssh git@10.240.139.182'

##################################################
# AWESOME SCRIPT SYSTEM
##################################################

#write_log() {
#}

