{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      command_timeout = 1000;
      format = "$directory$git_branch$git_state$git_status$git_commit$fill$cmd_duration$line_break$character";

      fill = {
        symbol = " ";
      };

      directory = {
        style = "bold blue";
        read_only = "";
        truncation_length = 4;
        truncate_to_repo = false;
      };

      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vicmd_symbol = "[❮](green)";
      };

      git_branch = {
        symbol = "";
        format = "[$symbol $branch]($style) ";
        style = "bright-black";
      };

      git_status = {
        format = "[$all_status$ahead_behind]($style)";
        style = "cyan";
      };

      git_commit = {
        commit_hash_length = 4;
      };

      cmd_duration = {
        format = "[$duration]($style)";
        style = "yellow";
      };
    };
  };
}
