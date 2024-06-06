{ config, pkgs, ... }:
{
    services.dunst = {
        enable = true;

        # settings = pkgs.lib.importTOML ./dunstrc;
        # configFile = ./dunstrc;

        iconTheme = {
            name = "papirus";
            package = pkgs.papirus-icon-theme;
            size = "64x64";
        };

        settings = {
            "global"= {
                "alignment"= "left";
                "always_run_script"= true;
                "browser"= "${pkgs.firefox}/bin/firefox -new-tab";
                "class"= "Dunst";
                "ellipsize"= "middle";
                "enable_recursive_icon_lookup"= true;
                "follow"= "none";
                "font"= "JetBrains Mono Nerd Font Medium 13";
                "format"= "<b>%a</b> - %s\\n%b";
                "frame_color"= "#4A5057";
                "frame_width"= 0;
                "hide_duplicate_count"= false;
                "history_length"= 20;
                "horizontal_padding"= 10;
                "icon_path"= "${pkgs.papirus-icon-theme}/64x64";
                "icon_position"= "left";
                "icon_theme"= "Papirus, Adwaita";
                "ignore_dbusclose"= false;
                "ignore_newline"= "no";
                "indicate_hidden"= false;
                "line_height"= 1;
                "markup"= "full";
                "max_icon_size"= 50;
                "min_icon_size"= 0;
                "monitor"= 0;
                "mouse_left_click"= "do_action, close_current";
                "mouse_middle_click"= "do_action, close_current";
                "mouse_right_click"= "close_all";
                "notification_limit"= 0;
                "offset"= "35x35";
                "origin"= "bottom-right";
                "padding"= 8;
                "progress_bar"= true;
                "progress_bar_frame_width"= 1;
                "progress_bar_height"= 10;
                "progress_bar_max_width"= 400;
                "progress_bar_min_width"= 150;
                "separator_color"= "frame";
                "separator_height"= 2;
                "show_age_threshold"= 60;
                "show_indicators"= "yes";
                "shrink"= "no";
                "sort"= "yes";
                "stack_duplicates"= true;
                "sticky_history"= "yes";
                "text_icon_padding"= 0;
                "title"= "Dunst";
                "vertical_alignment"= "center";
                "width"= 370;
                "word_wrap"= "yes";
            };

            "log_notifs"= {
                "script"= "~/bin/dunst_logger";
            };

            "urgency_critical"= {
                "background"= "#11121D";
                "foreground"= "#EE6D85";
                "timeout"= 15;
            };

            "urgency_low"= {
                "background"= "#11121D";
                "foreground"= "#A0A8CD";
                "timeout"= 5;
            };

            "urgency_normal"= {
                "background"= "#11121D";
                "foreground"= "#A0A8CD";
                "timeout"= 10;
            };
        };
    };
}