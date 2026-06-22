{ config, pkgs, lib, ... }:

{
    programs.firefox = {
        enable = true;

        profiles.default = {
            id = 0;
            isDefault = true;

            settings = {
                # Privacy
                "privacy.resistFingerprinting" = true;
                "privacy.trackingprotection.enabled" = true;

                # Telemetry and Data Collection
                "toolkit.telemetry.enabled" = false;
                "datareporting.healthreport.uploadEnabled" = false;
                "app.shield.optoutstudies.enabled" = false;

                # Pocket
                "extensions.pocket.enabled" = false;

                # URL Bar Suggestions
                "browser.urlbar.suggest.quicksuggest.sponsored" = false;
                "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;

                # DNS over HTTPS (Mullvad)
                "network.trr.mode" = 2;
                "network.trr.uri" = "https://dns.mullvad.net/dns-query";

                # Interface
                "browser.startup.homepage" = "about:blank";
                "browser.startup.page" = 3;
                "browser.newtabpage.enabled" = false;

                # Rendering
                "gfx.webrender.all" = true;
            };

    
            #extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            #    ublock-origin
            #   bitwarden
            #  multi-account-containers
            #];
        };
    };
}