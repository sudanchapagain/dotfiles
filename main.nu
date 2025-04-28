#!/usr/bin/env nu

export def main [
  command: string
#  ...args: string
] {
  match $command {
    "world" => {
      cat /etc/apk/world
    }
    "world-sync" => {
      cat /etc/apk/world | save -f ~/.dotfiles/system/data/chimera-worldfile
    }

  }
}
