{ config, ... }:
{
  networking.computerName = config.networking.hostName;
}
