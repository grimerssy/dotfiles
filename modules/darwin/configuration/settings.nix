{ ... }:
{
  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 60.0;
      mru-spaces = false;
      wvous-bl-corner = 10;
      static-only = true;
    };
    finder = {
      AppleShowAllExtensions = true;
      CreateDesktop = false;
      FXPreferredViewStyle = "clmv";
      ShowStatusBar = true;
    };
    loginwindow = {
      GuestEnabled = false;
      SHOWFULLNAME = true;
    };
    screencapture = {
      disable-shadow = true;
      type = "png";
    };
    trackpad = {
      Clicking = true;
      FirstClickThreshold = 0;
      SecondClickThreshold = 0;
    };
    universalaccess.reduceMotion = true;
    NSGlobalDomain = {
      AppleEnableSwipeNavigateWithScrolls = false;
      AppleICUForce24HourTime = false;
      AppleInterfaceStyle = "Dark";
      AppleMeasurementUnits = "Centimeters";
      AppleTemperatureUnit = "Celsius";
      InitialKeyRepeat = 10;
      KeyRepeat = 1;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticWindowAnimationsEnabled = false;
      NSDisableAutomaticTermination = true;
      NSDocumentSaveNewDocumentsToCloud = false;
      NSUseAnimatedFocusRing = false;
      _HIHideMenuBar = true;
    };
    CustomUserPreferences = {
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.AdLib".allowApplePersonalizedAdvertising = false;
    };
    CustomSystemPreferences = {
      "/Library/Preferences/FeatureFlags/Domain/UIKit".redesigned_text_cursor.Enabled = false;
    };
  };
}
