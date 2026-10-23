# OS disk only. Data disks get their own config later.
# WARNING: nixos-anywhere wipes this disk completely.
{
  disko.devices.disk.main = {
    type = "disk";
    # Find the right name on the server with: ls -l /dev/disk/by-id/
    device = "/dev/disk/by-id/REPLACE_ME";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          size = "1G";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };
        root = {
          size = "100%";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        };
      };
    };
  };
}
