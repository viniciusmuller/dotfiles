{ config, ... }:

{
  services.dunst = {
    enable = true;

    settings = {
      global = {
        monitor = 0;
        follow = "mouse";
        geometry = "300x5-30+27";
        progress_bar = true;
        progress_bar_height = 10;
        indicate_hidden = "yes";
        progress_bar_max_width = 300;
        progress_bar_min_width = 150;
        progress_bar_frame_width = 1;
        shrink = "no";
        transparency = 0;
        notification_height = 0;
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        text_icon_padding = 10;
        frame_width = 3;
        frame_color = "#0d0d0d";
        separator_color = "frame";
        idle_threshold = "120";
        sort = "yes";

        # Text
        font = "Monospace 8";
        line_height = 0;
        markup = "full";
        format = "<b>%s</b>\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = "60";
        word_wrap = "yes";
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = "yes";

        #Icons
        icon_position = "left";
        min_icon_size = 0;
        max_icon_size = 50;
      };

      urgency_critical = {
        background = "#d91e1e";
        foreground = "#ffffff";
        frame_color = "#9c0808";
        timeout = 0;
      };

      urgency_normal = {
        background = "#111111";
        foreground = "#ffffff";
        timeout = 10;
      };

      urgency_low = {
        background = "#111111";
        foreground = "#888888";
        timeout = 10;
      };
    };
  };
}
