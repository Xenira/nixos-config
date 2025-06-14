{ pkgs, config, lib, secrets, ... }:

let
  cfg = config.pi.programs;
  auth_cfg = with secrets.nheko; if config.pi.work.enable then work else personal;
  auth_cfg_valid = auth_cfg.access_token != null && auth_cfg.access_token != "";
in {

  options.pi.programs.nheko = {
    enable = lib.mkEnableOption "Enable Nheko configuration";
  };

  config = lib.mkIf (cfg.enable && cfg.nheko.enable) {
    nixpkgs.config.permittedInsecurePackages = [
      "olm-3.2.16"
    ];

    home-manager.users.ls.programs.nheko = {
      enable = true;
      package = pkgs.nheko;
      settings = {
        general.disable_certificate_validation = false;
        auth = lib.mkIf auth_cfg_valid auth_cfg;
        settings.scale_factor = 1;

        user = {
          alert_on_notification=true;
          animate_images_on_hover=true;
          automatically_share_keys_with_trusted_users=false;
          avatar_circles=true;
          bubbles_enabled=false;
          decrypt_notifications=true;
          decrypt_sidebar=true;
          desktop_notifications=true;
          disable_swipe=true;
          emoji_font_family="emoji";
          expired_events_background_maintenance=false;
          expose_dbus_api=false;
          fancy_effects=true;
          font_size=9;
          group_view=true;
          invert_enter_key=false;
          markdown_enabled=true;
          minor_events=false;
          mobile_mode=false;
          muted_tags="global";
          online_key_backup=true;
          only_share_keys_with_verified_users=false;
          open_image_external=false;
          open_video_external=false;
          presence="AutomaticPresence";
          privacy_screen=true;
          privacy_screen_timeout=10;
          read_receipts=false;
          reduced_motion=false;
          ringtone="Default";
          screen_share_frame_rate=10;
          screen_share_hide_cursor=false;
          screen_share_pip=true;
          screen_share_remote_video=false;
          scrollbars_in_roomlist=true;
          "sidebar\community_list_width"=39;
          "sidebar\room_list_width"=183;
          small_avatars_enabled=false;
          sort_by_alphabet=false;
          sort_by_unread=false;
          space_background_maintenance=true;
          space_notifications=true;
          theme="dark";
          "timeline\buttons"=true;
          "timeline\enlarge_emoji_only_msg"=true;
          "timeline\max_width"=0;
          "timeline\message_hover_highlight"=true;
          typing_notifications=false;
          use_identicon=true;
          "window\start_in_tray"=false;
          "window\tray"=true;
        };
      };
    };
  };
}
