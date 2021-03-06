{ config, pkgs, ... }:

{
  networking.hostName = "sezrix";
  networking.wireless.enable = false;
  networking.networkmanager = {
    enable = true;
    wifi.macAddress = "random";
    ethernet.macAddress = "random";
  };
  users.groups."networkmanager".members = [ "sezrienne" ];

  systemd.services.clashClient = {
    description = "Clash client service";
    wantedBy = [ "multi-user.target" ]; 
    after = [ "network.target" ];
    serviceConfig = {
      Type = "simple";
      User = "sezrienne";
      ExecStart = "${pkgs.clash}/bin/clash -f /home/sezrienne/.config/clash/config.yaml";
      Restart = "on-failure";
      RestartPreventExitStatus = "23";
    };
  };

  networking.proxy.default = "http://127.0.0.1:7890"; 

  programs.proxychains = {
    enable = true;
    proxies."clash" = {
      enable = true;
      type = "http";
      host = "127.0.0.1";
      port = 7890;
    };
  };

  environment.systemPackages = with pkgs; [
    clash
  ];
  
  services.openssh.enable = true;

  # nix.settings.substituters = [ "https://mirror.tuna.tsinghua.edu.cn/nix-channels/store" ];

}
