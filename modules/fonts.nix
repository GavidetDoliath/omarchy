{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "FiraMono"
      ];
    })
    font-awesome
    liberation_ttf
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = ["JetBrains Mono Nerd Font" "FiraMono Nerd Font"];
      sansSerif = ["Noto Sans"];
      serif = ["Noto Serif"];
    };
  };

  home.file.".config/fontconfig/fonts.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <!-- Default fonts -->
      <alias>
        <family>monospace</family>
        <prefer>
          <family>JetBrains Mono Nerd Font</family>
        </prefer>
      </alias>

      <!-- Antialiasing -->
      <match target="font">
        <edit name="antialias" mode="assign">
          <bool>true</bool>
        </edit>
        <edit name="hinting" mode="assign">
          <bool>true</bool>
        </edit>
        <edit name="hintstyle" mode="assign">
          <const>hintslight</const>
        </edit>
        <edit name="rgba" mode="assign">
          <const>rgb</const>
        </edit>
      </match>
    </fontconfig>
  '';
}
