{ lib, config, pkgs, ...}:
{
  services = {
  syncthing = {
    enable = true;
    user = "crimson";
    dataDir = "/home/crimson/Documents";
    configDir = "/home/crimson/Documents/.config/syncthing";
    #overrideDevices = true;
    #overrideFolders = true;
    settings = {
      devices = {
        "device1" = { id = "7S23D45-XNJ3K32-AZDT5SO-W4K57YC-WHGIHAH-GATIQSK-HZNNE6S-QDCH4AE"; };
      };
      folders = {
        "Documents" = {
          path = "/home/crimson/Documents";
          devices = [ "device1" ];
        };
      };
    };
  };
};
}
