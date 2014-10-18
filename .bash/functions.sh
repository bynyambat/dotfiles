
# Create a new directory and enter it
function md {
	mkdir -p "$@" && cd "$@"
}

# Find shorthand
function f {
	find . -name "$1"
}

# Git snapshot
function g-snapshot {
	local post_commit=~/.git/hooks/post-commit
	local post_commit_local=`pwd`"/.git/hooks/post-commit"

	if [ -e $post_commit_local ] && [ $post_commit -nt $post_commit_local ]; then
		rm -f $post_commit_local
	fi

	[ ! -e $post_commit_local ] && cp $post_commit $post_commit_local
}

# Git commit and snapshot
function g-commit {
	g-snapshot

	git commit -am "$@"
}

# Git commit rewrite history and snapshot
function g-amend {
	g-snapshot

	git commit -a --amend -C HEAD "$@"
}

# Git submodule add in your ~/vim/bundle
# later update more ...
# maybe git.sh for own functionality
function g-vim-plugin-add-module {
	if [ -z $1 ] || [ -z $2 ]; then
		echo "ARG1 = git repo and ARG2 = plugin name required!"
	else
		git submodule add $1 ".vim/bundle/${2}.git"
	fi
}

function g-submodule {
	git submodule status
}

# Wifi adapter's mac change for wifi hacking
function mac {
	local wlan1=$(airmon-ng | grep wlan1)
	if [ -z wlan1 ]; then
		ifconfig wlan1 down; macchanger -m 00:11:22:33:44:55 wlan1; ifconfig wlan1 up
	else
		echo "First plug usb wifi card you stupid! and happy hacking :)"
	fi
}

# Create a blank RequireJS template file
function requirejs {
	bash ~/.bash/templates/javascript/requirejs.sh "$@"
}

# # Let's toss an image onto my server and pbcopy that bitch.
# function scpp() {
#     scp "$1" aurgasm@aurgasm.us:~/paulirish.com/i;
#     echo "http://paulirish.com/i/$1" | pbcopy;
#     echo "Copied to clipboard: http://paulirish.com/i/$1"
# }

# # cd into whatever is the forefront Finder window.
# cdf() {  # short for cdfinder
# 	cd "`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`"
# }



# # Start an HTTP server from a directory, optionally specifying the port
# function server() {
# 	local port="${1:-8000}"
# 	open "http://localhost:${port}/"
# 	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
# 	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
# 	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
# }

# # git log with per-commit cmd-clickable GitHub URLs (iTerm)
# function gf() {
#   local remote="$(git remote -v | awk '/^origin.*\(push\)$/ {print $2}')"
#   [[ "$remote" ]] || return
#   local user_repo="$(echo "$remote" | perl -pe 's/.*://;s/\.git$//')"
#   git log $* --name-status --color | awk "$(cat <<AWK
#     /^.*commit [0-9a-f]{40}/ {sha=substr(\$2,1,7)}
#     /^[MA]\t/ {printf "%s\thttps://github.com/$user_repo/blob/%s/%s\n", \$1, sha, \$2; next}
#     /.*/ {print \$0}
# AWK
#   )" | less -F
# }


# # Copy w/ progress
# cp_p () {
#   rsync -WavP --human-readable --progress $1 $2
# }


# # Test if HTTP compression (RFC 2616 + SDCH) is enabled for a given URL.
# # Send a fake UA string for sites that sniff it instead of using the Accept-Encoding header. (Looking at you, ajax.googleapis.com!)
# function httpcompression() {
# 	encoding="$(curl -LIs -H 'User-Agent: Mozilla/5 Gecko' -H 'Accept-Encoding: gzip,deflate,compress,sdch' "$1" | grep '^Content-Encoding:')" && echo "$1 is encoded using ${encoding#* }" || echo "$1 is not using any encoding"
# }

# # Syntax-highlight JSON strings or files
# function json() {
# 	if [ -p /dev/stdin ]; then
# 		# piping, e.g. `echo '{"foo":42}' | json`
# 		python -mjson.tool | pygmentize -l javascript
# 	else
# 		# e.g. `json '{"foo":42}'`
# 		python -mjson.tool <<< "$*" | pygmentize -l javascript
# 	fi
# }


# # take this repo and copy it to somewhere else minus the .git stuff.
# function gitexport(){
# 	mkdir -p "$1"
# 	git archive master | tar -x -C "$1"
# }



# # get gzipped size
# function gz() {
# 	echo "orig size    (bytes): "
# 	cat "$1" | wc -c
# 	echo "gzipped size (bytes): "
# 	gzip -c "$1" | wc -c
# }

# # All the dig info
# function digga() {
# 	dig +nocmd "$1" any +multiline +noall +answer
# }

# # Escape UTF-8 characters into their 3-byte format
# function escape() {
# 	printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
# 	echo # newline
# }

# # Decode \x{ABCD}-style Unicode escape sequences
# function unidecode() {
# 	perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
# 	echo # newline
# }

# # Extract archives - use: extract <file>
# # Based on http://dotfiles.org/~pseup/.bashrc
# function extract() {
# 	if [ -f "$1" ] ; then
# 		local filename=$(basename "$1")
# 		local foldername="${filename%%.*}"
# 		local fullpath=`perl -e 'use Cwd "abs_path";print abs_path(shift)' "$1"`
# 		local didfolderexist=false
# 		if [ -d "$foldername" ]; then
# 			didfolderexist=true
# 			read -p "$foldername already exists, do you want to overwrite it? (y/n) " -n 1
# 			echo
# 			if [[ $REPLY =~ ^[Nn]$ ]]; then
# 				return
# 			fi
# 		fi
# 		mkdir -p "$foldername" && cd "$foldername"
# 		case $1 in
# 			*.tar.bz2) tar xjf "$fullpath" ;;
# 			*.tar.gz) tar xzf "$fullpath" ;;
# 			*.tar.xz) tar Jxvf "$fullpath" ;;
# 			*.tar.Z) tar xzf "$fullpath" ;;
# 			*.tar) tar xf "$fullpath" ;;
# 			*.taz) tar xzf "$fullpath" ;;
# 			*.tb2) tar xjf "$fullpath" ;;
# 			*.tbz) tar xjf "$fullpath" ;;
# 			*.tbz2) tar xjf "$fullpath" ;;
# 			*.tgz) tar xzf "$fullpath" ;;
# 			*.txz) tar Jxvf "$fullpath" ;;
# 			*.zip) unzip "$fullpath" ;;
# 			*) echo "'$1' cannot be extracted via extract()" && cd .. && ! $didfolderexist && rm -r "$foldername" ;;
# 		esac
# 	else
# 		echo "'$1' is not a valid file"
# 	fi
# }


# # animated gifs from any video
# # from alex sexton   gist.github.com/SlexAxton/4989674
# gifify() {
#   if [[ -n "$1" ]]; then
#     if [[ $2 == '--good' ]]; then
#       ffmpeg -i $1 -r 10 -vcodec png out-static-%05d.png
#       time convert -verbose +dither -layers Optimize -resize 600x600\> out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > $1.gif
#       rm out-static*.png
#     else
#       ffmpeg -i $1 -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > $1.gif
#     fi
#   else
#     echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
#   fi
# }
