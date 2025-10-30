def main [] {
    print "usage:"
    print "    flatpaks.nu setup: to setup flathub as a repo"
    print "    flatpaks.nu run: to install all programs in programs array"
    print "    flatpaks.nu clean: to clean up"
}

def "main setup" [] {
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
}

def "main run" [] {
    let programs = [
        "app.zen_browser.zen"
        "com.viber.Viber"
        "io.anytype.anytype"
        "org.telegram.desktop"
    ]

    for $p in ($programs | enumerate) {
        flatpak install -y $p.item;
    }
}

def "main clean" [] {
    flatpak uninstall --unused -y
    flatpak remove --delete-data --unused -y
    flatpak repair -y
}
