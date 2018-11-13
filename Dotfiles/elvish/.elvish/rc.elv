fn ls [@a]{ e:ls --color $@a }
edit:completion:matcher[argument] = [seed]{ edit:match-prefix $seed &smart-case=$true }

# install packages if necessary
use epm
epm:install github.com/zzamboni/elvish-modules &silent-if-installed=$true
epm:install github.com/xiamaz/elvish-themes &silent-if-installed=$true
epm:install github.com/xiamaz/elvish-pyvenv &silent-if-installed=$true

# enable aliases in elvish
use github.com/zzamboni/elvish-modules/alias
-exports- = (alias:export)

# manage virtualenvs
use github.com/xiamaz/elvish-pyvenv/pyvenv
fn pa { pyvenv:activate .env }
fn pd { pyvenv:deactivate }
fn pmk {
  if ?(test -d .env) {
    echo ".env already exists."
  } else {
    python3 -m venv .env
  }
  pa
}
fn pmks {
  if ?(test -d .env) {
    echo ".env already exists."
  } else {
    python3 -m venv .env --system-site-packages
  }
  pa
}
fn pdep { pip install -r requirements.txt }
fn pfreeze {
  sed 's/[<> ]//g' requirements.txt | awk -F "=" '{print "^" $1 "="}' > frozenargs
  pip freeze | grep -i -f frozenargs
  rm frozenargs
}

# backupfunction
fn backupdir [dir]{
  if (not ?(test -d $dir)) {
    echo "Directory "$dir" not found."
    return
  }
  ssh home mkdir -p Data/Backups/$dir
  rsync -a --info=progress2 $dir/ home:Data/Backups/$dir/(date -I)
}

# prompt theme
use github.com/xiamaz/elvish-themes/chain
# chain:glyph["chain"] = " "
chain:glyph["git-branch"] = ""
chain:glyph["git-dirty"] = "±"
chain:glyph["git-ahead"] = "↑"
chain:glyph["git-behind"] = "↓"
chain:glyph["git-staged"] = "✓"
chain:glyph["su"] = "#"
chain:prompt-segments = [
  "\n"
  su
  {
    if (not-eq $E:VIRTUAL_ENV "") {
      chain:prompt-segment [ inverse cyan ] venv
    }
  }
  {
    if (not-eq $E:SSH_CONNECTION "") {
      chain:prompt-segment [ cyan ] (hostname)
    }
  }
  dir
  git-branch
  git-combined
  "\n"
  arrow
]

# fix navigation mode crash
edit:navigation:binding["Ctrl-N"] = $nop~
