export def main [] {
    return {
        binary:  '#808080'
        block:   '#808080'
        cell-path: '#505050'
        closure: '#808080'
        custom:  '#808080'
        duration:'#808080'
        float:   '#808080'
        glob:    '#505050'
        int:     '#808080'
        list:    '#808080'
        nothing: '#505050'
        range:   '#808080'
        record:  '#808080'
        string:  '#a6a6a6'

        bool: {|| if $in { '#a6a6a6' } else { '#505050' } }

        date: {|| (date now) - $in |
            if $in < 1day { '#a6a6a6' } 
            else if $in < 1wk { '#808080' }
            else { '#505050' }
        }

        filesize: {|e|
            if $e == 0b {
                '#505050'
            } else if $e < 1mb {
                '#808080'
            } else { '#a6a6a6' }
        }

        shape_and:            '#808080'
        shape_binary:          '#808080'
        shape_block:           '#808080'
        shape_bool:            '#808080'
        shape_closure:         '#808080'
        shape_custom:          '#808080'
        shape_datetime:        '#808080'
        shape_directory:       '#808080'
        shape_external:        '#808080'
        shape_external_resolved:'#808080'
        shape_externalarg:     '#808080'
        shape_filepath:        '#808080'
        shape_flag:            '#808080'
        shape_float:           '#808080'
        shape_garbage:         { fg: '#f0f0f0' bg: '#3e3e3e' }
        shape_glob_interpolation:'#808080'
        shape_globpattern:     '#808080'
        shape_int:             '#808080'
        shape_internalcall:    '#808080'
        shape_keyword:         '#808080'
        shape_list:            '#808080'
        shape_literal:         '#a6a6a6'
        shape_match_pattern:   '#808080'
        shape_matching_brackets:{ attr: 'u' }
        shape_nothing:         '#505050'
        shape_operator:        '#808080'
        shape_or:              '#808080'
        shape_pipe:            '#808080'
        shape_range:           '#808080'
        shape_raw_string:      '#808080'
        shape_record:          '#808080'
        shape_redirection:     '#808080'
        shape_signature:       '#808080'
        shape_string:          '#a6a6a6'
        shape_string_interpolation:'#808080'
        shape_table:           '#808080'
        shape_vardecl:         { fg: '#e29eca' attr: 'u' }
        shape_variable:        '#e29eca'

        foreground: '#a6a6a6'
        background: '#101010'
        cursor:     '#e29eca'

        empty:      '#505050'
        header:     { fg: '#a6a6a6' attr: 'b' }
        hints:      '#505050'
        row_index:  { fg: '#808080' }
        separator:  '#3e3e3e'
        search_result: { fg: '#101010' bg: '#e29eca' }
    }
}

export def --env "set color_config" [] {
    $env.config.color_config = (main)
}

export def "update terminal" [] {
    let theme = (main)
    let osc_screen_foreground_color = '10;'
    let osc_screen_background_color = '11;'
    let osc_cursor_color = '12;'
    $"
    (ansi -o $osc_screen_foreground_color)($theme.foreground)(char bel)
    (ansi -o $osc_screen_background_color)($theme.background)(char bel)
    (ansi -o $osc_cursor_color)($theme.cursor)(char bel)
    "
    | str replace --all "\n" ''
    | print -n $"($in)\r"
}

export module activate {
    export-env {
        set color_config
        update terminal
    }
}

use activate
