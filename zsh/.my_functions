#!/bin/zsh

# Do 'curlGet foo' to curl 'http://localhost:8000/foo' 
function curlGet() {
# Do 'curlGet 8000 foo' to curl 'http://localhost:8000/foo' 
	curl http://localhost:$1/$2
}

# For some image 'foo', do dockerRunTest foo. Assumes you have a 'docker-compose.dev.yml' file.
function dockerRunTest() {
# For some image 'foo', do dockerRunTest foo. Assumes you have a 'docker-compose.dev.yml' file.
	docker compose -f docker-compose.dev.yml run $1 npm run test
}

# do 'aptInstall someApp'
function aptInstall() {
# do 'aptInstall someApp'
	sudo apt install $1
}

# git clone, e.g. 'gitClone LazyVim/starter'
function gitClone() {
# git clone, e.g. 'gitClone LazyVim/starter'
  git clone https://github.com/$1
}

function tmuxAttach() {
tmux attach-session -t $1
}

function tmux-resurrect-reset-last() {
    cd ~/.local/share/tmux/resurrect && \
        ln -f -s $(/bin/ls -t tmux_resurrect_*.txt | head -n 1) last && \
        /bin/ls -l last
}

function randomString() {
  node -e "console.log(require('crypto').randomBytes(48).toString('hex'))"
  # echo randomString
}

function nvimPaste() {
  if command -v win32yank.exe >/dev/null 2>/dev/null; then
    win32yank.exe -o --lf
  else
    powershell.exe Get-Clipboard | tr -d '\r' | sed -z '$ s/\n$//'
  fi
}
