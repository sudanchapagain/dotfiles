{ lib, config, pkgs, ... }:
{
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  users.users = {
    # password: temp a
    root.initialHashedPassword = "$6$FRmKgElD/80xQiXn$aF.tKv0VOLj9D3aUJjoYsj3AzSj1rq5fVooE7tgtNuTawt8ZWgaRyUUxsikX5whbna4jrzXrDZmVFqik.kyc2/";

    crimson = {
      isNormalUser = true;
      description = "red";
      shell = pkgs.zsh;
      extraGroups = [ "networkmanager" "wheel" "flatpak" "audio" "video" "root" ];
      # password: temp b
      initialHashedPassword = "$6$iLmo7C9VoAnJZ6v1$qCSORkbiY44IbcrrF1DcTnJtpOkqeD2tGgUoaDgtzPdFqKWKJ28AhJqmuOf8IWoSNu2DQJM.QlWO1Ok05kFgp0";
    };
  };
}
