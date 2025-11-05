def _last_command_duration [raw=null] {
    let ms = ($raw | default ($env.CMD_DURATION_MS? | default 0) | into int)
    if $ms >= 1000 {
        let secs = ($ms / 1000 | math floor)
        $"($secs)s"
    } else {
        ""
    }
}

def _cwd [duration_raw=null] {
    let pwd = ($env.PWD | path basename)
    let duration = (_last_command_duration $duration_raw)
    let bold_dir = $"(ansi bo)(ansi blue)($pwd)(ansi reset)"

    if $duration != "" {
        $"($bold_dir) took (ansi yellow)($duration)(ansi reset)"
    } else {
        $"($bold_dir)"
    }
}

def _prompt_line [] {
    let last_status = ($env.CMD_STATUS? | default 0)
    # , λ, ❯, >, $, ˃
    let arrow = $"(ansi magenta)λ(ansi reset)"
    $"\n(_cwd ($env.CMD_DURATION_MS? | default null))\n($arrow) "
}

$env.PROMPT_COMMAND = { || (_prompt_line) }
$env.TRANSIENT_PROMPT_COMMAND = { || (_prompt_line) }

$env.PROMPT_COMMAND_RIGHT = { || "" }
$env.PROMPT_INDICATOR = { || "" }
$env.TRANSIENT_PROMPT_INDICATOR = { || "" }
