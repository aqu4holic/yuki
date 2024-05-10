{ pkgs, ... }:

# terminals

let
    font = "JetBrainsMono Nerd Font";
in
{
    programs.kitty = {
        enable = true;
        settings = {
            background_opacity = "0.7";
            scrollback_lines = 10000;

            # font
            font_family = font;
            bold_font = "auto";
            italic_font = "auto";
            bold_italic_font = "auto";

            font_size = 14;

            cursor =  "#f530ff";

            cursor_shape = "beam";
            cursor_beam_thickness = "1.5";
            cursor_blink_interval = "0.25";

            scrollback_indicator_opacity = 1;

            url_color = "#0087bd";
            url_style = "curly";
            show_hyperlink_targets = "yes";

            strip_trailing_spaces = "smart";

            foreground = "#dddddd";
            background = "#180204";

            repaint_delay = 5;

            remember_window_size = "yes";
            # initial_window_width = 640;
            # initial_window_height = 400;

            # tab bar
            tab_bar_edge = "top";
            # tab_bar_style = "slant";
            tab_bar_style = "powerline";
            tab_powerline_style = "angled";
            tab_bar_min_tabs = 1;
            tab_title_template = "({index}) {title}";

            active_tab_foreground = "#00b2b9";
            active_tab_background = "#170081";
            active_tab_font_style = "bold-italic";
            inactive_tab_foreground = "#005053";
            inactive_tab_background = "#05001e";
            inactive_tab_font_style = "normal";
        };
    };
}