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
    monitor=,highres,auto,1
    exec-once = waybar
    exec-once = swaybg -i /home/andrew/Downloads/eberhard-grossgasteiger-LmqySFs3TQQ-unsplash.jpg -m fill
    exec-once = wlsunset -t 3000 -s 21:00
    misc {
    disable_hyprland_logo = true
    enable_swallow = true
    swallow_regex = ^(kitty)$
    }
    gestures {
    workspace_swipe = true
    workspace_swipe_fingers = 3
    }
    general {
    gaps_out = 1
    }
    decoration {
    rounding = 3
    }
    $mod = SUPER
    bind = $mod, T, exec, kitty
    bind = $mod, W, exec, qutebrowser
    bind = , Print, exec, grimblast copy area
    bind = $mod, R, exec, rofi -show drun -show-icons
    bind = $mod, B, exec, bitwarden
    bind = $mod, M, exec, rhythmbox
    bind = $mod, Q, killactive
    bind = $mod, F, fullscreen
    bind = $mod, Space, togglefloating
    bind = $mod, left, movefocus, l
    bind = $mod, right, movefocus, r
    bind = $mod, up, movefocus, u
    bind = $mod, down, movefocus, d
    bind = $mod SHIFT, right, movewindow, r
    bind = $mod SHIFT, up, movewindow, u
    bind = , xf86monbrightnessup, exec, brightnessctl set 5%+
    bind = , xf86monbrightnessdown, exec, brightnessctl set 5%-
    bind = , xf86audioraisevolume, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%+
    bind = , xf86audiolowervolume, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%-
    bind = , xf86audiomute, exec, wpctl set-mute @DEFAULT_SINK@ toggle
    bind = $mod SHIFT, c, exec, wlogout
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
  programs.git = {
     enable = true;
     userName = "Andrew Noonan";
     userEmail = "Andrewnoonan@mailbox.org";
     };
  programs.home-manager.enable = true;
  home.username = "andrew";
  home.homeDirectory = "/home/andrew/";
  programs.fish.enable = true;
  programs.waybar.enable = true;
  programs.waybar.settings = 
  {
  mainBar = {
  layer = "top";
  position = "top";
  exclusive = true;
  passthrough = false;
  gtk-layer-shell = true;
  height = 30;
  width = 1920;
  output = "eDP-1";
  "modules-left" = ["hyprland/workspaces"];
  "modules-center" = ["clock" "hyprland/window" ];
  "modules-right" = ["pulseaudio" "network" "cpu" "memory" "backlight"];
  "clock" = {
        "timezone" = "America/New_York";
        "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        "format-alt" = "{:%Y-%m-%d}";
    };
  };
};
programs.kitty =
{
enable = true;
settings ={
background_opacity = "0.4";
};
};
gtk = {
  enable = true;
  theme = {
  name = "Materia-dark";
  package = pkgs.materia-theme;
  };
  };
  home.stateVersion = "23.11";  # Use the NixOS version you're running.
}

