const cfg = ($nu.config-path | path dirname)

source ($cfg | path join "alias.nu")
source ($cfg | path join "z.nu")
# source $"($nu.cache-dir)/carapace.nu"

use ($cfg | path join "earlgrey.nu")

let carapace_completer = {|spans|
  carapace $spans.0 nushell ...$spans | from json
}

const history_path = ($nu.data-dir | path join "history.txt")

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
mkdir $"($nu.cache-dir)"
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"

$env.config = {
  buffer_editor: "hx"
  color_config: (earlgrey)
  show_banner: false

  table: {
        mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
        index_mode: always # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
        show_empty: true # show 'empty list' and 'empty record' placeholders for command output
        padding: { left: 1, right: 1 } # a left right padding of each column in a table
        trim: {
            methodology: wrapping # wrapping or truncating
            wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
            truncating_suffix: "..." # A suffix used by the 'truncating' methodology
        }
        header_on_separator: false # show header text on separator/border line
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
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
fastfetch -c examples/8.jsonc

