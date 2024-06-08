{ config, pkgs, ... }:
{
    services.dunst = {
        enable = true;

        iconTheme = {
            name = "Papirus";
            package = pkgs.papirus-icon-theme;
            size = "64x64";
        };

        settings = {
            global = {
                monitor = 0;
                follow = "none";
                width = 450;
                offset = "35x35";
                origin = "bottom-right";
                progress_bar = true;
                progress_bar_height = 10;
                progress_bar_frame_width = 2;
                progress_bar_min_width = 150;
                progress_bar_max_width = 400;
                indicate_hidden = false;
                notification_limit = 0;
                shrink = "no";
                separator_height = 2;
                padding = 8;
                horizontal_padding = 10;
                text_icon_padding = 0;
                frame_width = 0;
                frame_color = "#7c8ac5";
                # corner_radius = 12;
                separator_color = "frame";
                sort = "yes";
                font = "MonoLisa Medium 12";
                line_height = 1;
                markup = "full";
                format = "<b>%a</b>\\n%s\\n%b";
                alignment = "left";
                vertical_alignment = "center";
                show_age_threshold = 60;
                word_wrap = "yes";
                ellipsize = "middle";
                ignore_newline = "no";
                stack_duplicates = true;
                hide_duplicate_count = false;
                show_indicators = "yes";
                icon_position = "left";
                min_icon_size = 50;
                max_icon_size = 50;
                enable_recursive_icon_lookup = true;
                sticky_history = "yes";
                history_length = 20;
                always_run_script = true;
                title = "Dunst";
                class = "Dunst";
                ignore_dbusclose = false;
                mouse_left_click = "do_action, close_current";
                mouse_middle_click = "do_action, close_current";
                mouse_right_click = "close_all";
                browser = "${pkgs.firefox}/bin/firefox -new-tab";
            };

            urgency_low = {
                background = "#11121D";
                foreground = "#A0A8CD";
                timeout = 5;
            };

            urgency_normal = {
                background = "#11121D";
                foreground = "#6cd3d3";
                timeout = 10;
            };

            urgency_critical = {
                background = "#11121D";
                foreground = "#EE6D85";
                timeout = 15;
            };

            log_notifs = {
                script = "~/bin/dunst_logger";
            };
        };
    };
}