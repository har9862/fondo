/*
* Copyright (C) 2018  Calo001 <calo_lrc@hotmail.com>
* 
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Affero General Public License as published
* by the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
* 
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Affero General Public License for more details.
* 
* You should have received a copy of the GNU Affero General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
* 
*/
using App.Views;

namespace App.Widgets {

    /**
     * The {@code HeaderBar} class is responsible for displaying top bar. Similar to a horizontal box.
     *
     * @see Gtk.HeaderBar
     * @since 1.0.0
     */
    public class HeaderBar : Gtk.HeaderBar {

        /**
         * Constructs a new {@code HeaderBar} object.
         *
         * @see App.Configs.Properties
         * @see icon_settings
         */
        public HeaderBar () {
            this.set_title ("Fondo");
            this.show_close_button = true;

            get_style_context ().add_class ("transition");
            get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
            get_style_context ().add_class ("output-header");
            get_style_context ().add_class ("default-decoration");

            var gtk_settings = Gtk.Settings.get_default ();

            var mode_switch = new ModeSwitch (
                "display-brightness-symbolic",
                "weather-clear-night-symbolic"
            );

            mode_switch.margin_end = 6;
            mode_switch.primary_icon_tooltip_text = _("Light background");
            mode_switch.secondary_icon_tooltip_text = _("Dark background");
            mode_switch.valign = Gtk.Align.CENTER;
            mode_switch.bind_property ("active", gtk_settings, "gtk_application_prefer_dark_theme");

            var context = get_style_context ();
            mode_switch.notify["active"].connect (() => {
                detect_dark_mode (gtk_settings, context);
            });

            App.Application.settings.bind ("use-dark-theme", mode_switch, "active", GLib.SettingsBindFlags.DEFAULT);
            
            var img = new Gtk.Image.from_icon_name ("camera-photo-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            var unsplash_link = "https://unsplash.com/?utm_source=Fondo&utm_medium=referral";
            var unsplash_text = _(" By Unsplash");
            var link_unsplash = new Gtk.LinkButton.with_label(unsplash_link, unsplash_text);
            link_unsplash.get_style_context ().remove_class ("link");
            link_unsplash.get_style_context ().remove_class ("button");
            link_unsplash.get_style_context ().add_class ("flat");
            link_unsplash.get_style_context ().add_class ("unsplash_btn");
            link_unsplash.valign = Gtk.Align.CENTER;
            link_unsplash.has_tooltip = false;
            link_unsplash.set_image (img);
            link_unsplash.set_always_show_image (true);

            this.pack_start(link_unsplash);
            this.pack_end (mode_switch);
        }

        public void detect_dark_mode (Gtk.Settings gtk_settings, Gtk.StyleContext context) {
            if (gtk_settings.gtk_application_prefer_dark_theme) {
                App.Configs.Settings.get_instance ().use_dark_theme = true;
                context.add_class ("dark");
            } else {
                App.Configs.Settings.get_instance ().use_dark_theme = false;
                context.remove_class ("dark");
            }
        }
    }
}
