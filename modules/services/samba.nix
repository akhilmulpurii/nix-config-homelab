{ ... }:

{
  systemd.tmpfiles.rules = [
    "d /data   0775 akhil akhil -"
    "d /docker 0775 akhil akhil -"
  ];

  services.samba = {
    enable = true;
    openFirewall = true;

    settings = {
      global = {
        "server string" = "Servarr";
        "workgroup" = "WORKGROUP";
        "security" = "user";
        "map to guest" = "Bad User";
        "name resolve order" = "bcast host";
        "hosts allow" = "192.168.0.0/16 10.0.0.0/8 172.16.0.0/12";
        "hosts deny" = "0.0.0.0/0";

        # macOS / iOS compatibility
        "vfs objects" = "catia fruit streams_xattr";
        "fruit:nfs_aces" = "no";
        "fruit:zero_file_id" = "yes";
        "fruit:metadata" = "stream";
        "fruit:model" = "MacSamba";
      };

      data = {
        path = "/data";
        "force user" = "akhil";
        "force group" = "akhil";
        "create mask" = "0774";
        "force create mode" = "0774";
        "directory mask" = "0775";
        "force directory mode" = "0775";
        browseable = "yes";
        writable = "yes";
        "read only" = "no";
        "guest ok" = "no";
      };

      docker = {
        path = "/docker";
        "force user" = "akhil";
        "force group" = "akhil";
        "create mask" = "0774";
        "force create mode" = "0774";
        "directory mask" = "0775";
        "force directory mode" = "0775";
        browseable = "yes";
        writable = "yes";
        "read only" = "no";
        "guest ok" = "no";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}
