{ ... }:

{
    # Define a user account.
    # Don't forget to set a password with `passwd`.
    users.users = {
        crimson = {
            isNormalUser = true;
            description = "crimson";
            extraGroups = [
                "networkmanager"
                "wheel"
                "flatpak"
                "audio"
                "video"
                "root"
            ];
        };
    };
}
