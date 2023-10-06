{ config, lib, pkgs, ...}:
{
  programs.home-manager.enable = true;
  home.username = "andrew";
  home.homeDirectory = "/home/andrew";
  home.packages = with pkgs; [
    # List of user-specific packages you want to install
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
