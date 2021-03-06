{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    exportConfiguration = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.wayland = true;
  };

  environment.systemPackages = with pkgs; [
    taffybar dmenu nitrogen alacritty rofi polybar
  ];
}
