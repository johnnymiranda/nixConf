{
  config,
  lib,
  pkgs,
  ...
}: {
  options.network-debug.enable = lib.mkEnableOption "Enable networking debugging suite";

  config = lib.mkIf config.network-debug.enable {
    users.users.john = {
      packages = builtins.attrValues {
        inherit
	  (pkgs)
	  wireshark
	  traceroute
	  nettools
	  dig
	  nmap
	  ;
       };
     };
   };
}
