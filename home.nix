{ config, lib, pkgs, ... }:

let
  flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
  hyprland = (import flake-compat {
    src = builtins.fetchTarball "https://github.com/hyprwm/Hyprland/archive/master.tar.gz";
  }).defaultNix;
in {
  imports = [
    hyprland.homeManagerModules.default
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig = ''
    exec-once = waybar
    $mod = SUPER
    bind = $mod, T, exec, kitty
    bind = $mod, W, exec, librewolf
    bind = , Print, exec, grimblast copy area
    bind = $mod, R, exec, rofi -show drun -show-icons
    bind = $mod, Q, killactive
    bind = $mod, F, fullscreen
    bind = $mod, Space, togglefloating
    bind = $mod, left, movefocus, l
    bind = $mod, right, movefocus, r
    bind = $mod, up, movefocus, u
    bind = $mod, down, movefocus, d
    bind = $mod SHIFT, right, movewindow, r
    bind = $mod SHIFT, up, movewindow, u
    # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
    ${builtins.concatStringsSep "\n" (builtins.genList (
        x: let
          ws = let
            c = (x + 1) / 10;
          in
            builtins.toString (x + 1 - (c * 10));
        in ''
          bind = $mod, ${ws}, workspace, ${toString (x + 1)}
          bind = $mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
        ''
      )
      10)}
    # ...
    '';
  };

  programs.home-manager.enable = true;
  home.username = "andrew";
  home.homeDirectory = "/home/andrew/";
  programs.fish.enable = true;
  home.packages = with pkgs; [
    # List of user-specific packages you want to install
    bemenu
    neovim
    firefox
    librewolf
    thunderbird
    bitwarden
    gnome-podcasts
    mpv
    yt-dlp
    ani-cli
    jdk17
    pipx
    neovim
    blackbox-terminal
    distrobox
    shortwave
    powertop
    intel-gpu-tools
    papirus-icon-theme
    adw-gtk3
    gnome.gnome-tweaks
    gradience
    gnome-extension-manager
    gnomeExtensions.dash-to-dock
    gnomeExtensions.blur-my-shell
    gnomeExtensions.appindicator
    gnomeExtensions.freon
    lm_sensors
    fish
    gnomeExtensions.weather-oclock
    gnomeExtensions.tiling-assistant
    gnome.gedit
    git
  ];  

  home.stateVersion = "23.05";  # Use the NixOS version you're running.
}

