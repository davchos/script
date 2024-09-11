#! /bin/bash


set -e

echo "Creating a tmux session with 2 windows"

SESSION=`tmux list-sessions | grep $1 | awk '{print $1}' | tr -d ':'`


if [ -z $2 ]
then
	dir=.
else
	dir=$2
fi

#echo $SESSION
if [ -z "$SESSION" ]
then	
	echo "$1 session not found"
	echo "Creating session $1"
	cd $dir && tmux new-session -d -s$1
	tmux rename-window -t 0 "Main"
	tmux send-keys -t $1:0 'nvim' C-m
	cd $dir && tmux new-window -t $1:1  - n shell
	tmux attach-session -t $1:0
else
	tmux attach-session -t $1:0

fi
