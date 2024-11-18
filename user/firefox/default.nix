{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.sondli.settings = {
      # Disable telemetry      
      "browser.newtabpage.activity-stream.feeds.telemetry" = false;
      "browser.ping-centre.telemetry" = false;
      "browser.tabs.crashReporting.sendReport" = false;
      "devtools.onboarding.telemetry.logged" = false;
      "toolkit.telemetry.enabled" = false;
      "toolkit.telemetry.unified" = false;
      "toolkit.telemetry.server" = "";

      # Disable Pocket
      "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
      "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
      "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
      "browser.newtabpage.activity-stream.showSponsored" = false;
      "extensions.pocket.enabled" = false;

      # Harden SSL 
      "security.ssl.require_safe_negotiation" = true;
    };
  };
}
