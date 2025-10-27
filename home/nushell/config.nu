$env.PATH ++= [
  '~/.local/bin'
  '~/.cargo/bin'
  $"/etc/profiles/per-user/($env.USER)/bin"
  "/run/current-system/sw/bin"
  "/usr/local/bin"
  "/usr/bin"
  "/usr/sbin"
  "/bin"
]

$env.JAVA_HOME = "/home/crimson/.jdks/openjdk-25"
$env.LS_COLORS = (vivid generate rose-pine-dawn)

# ===========================================================================

const cfg = ($nu.config-path | path dirname)

source ($cfg | path join "alias.nu")
source ($cfg | path join "z.nu")
source ($cfg | path join "prompt.nu")
source $"($nu.cache-dir)/carapace.nu"

let carapace_completer = {|spans|
  carapace $spans.0 nushell ...$spans | from json
}

const history_path = ($nu.data-dir | path join "history.txt")

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
mkdir $"($nu.cache-dir)"
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"

$env.config = {
  buffer_editor: "hx"
  show_banner: false

  table: {
        mode: rounded
        index_mode: always
        show_empty: true
        padding: { left: 1, right: 1 }
        trim: {
            methodology: wrapping
            wrapping_try_keep_words: true
            truncating_suffix: "..."
        }
        header_on_separator: false
        # abbreviated_row_count: 10 # limit data rows from top and bottom after reaching a set point
    }

    error_style: "fancy"

    history: {
      max_size: 100_000
      sync_on_enter: true
      file_format: "plaintext"
    }

    completions: {
      case_sensitive: false
      quick: true
      partial: true
      algorithm: "fuzzy"
      external: {
        enable: true
        max_results: 100
        completer: $carapace_completer
      }
      use_ls_colors: true
    },
    hooks: {
      pre_prompt: [{ ||
        if (which direnv | is-empty) {
          return
        }

        direnv export json | from json | default {} | load-env
        if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
          $env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
        }
      }]
    }
}

const NU_PLUGIN_DIRS = [
  ($nu.current-exe | path dirname)
  ...$NU_PLUGIN_DIRS
]

mkdir ($nu.data-dir | path join "vendor/autoload")
fastfetch -c examples/8.jsonc

def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}
