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
using App.Configs;
namespace App.Popover {

    /**
     * The {@code MenuPopover} class is responsible for displaying a popup menu content.
     *
     * @since 1.3.0
     */
    public class MenuPopover : Gtk.Popover {
        public MenuPopover(Gtk.Widget relative_to) {
            Object (
                relative_to: relative_to
            );          
            get_style_context ().add_class ("pop-menu");
            set_modal (true);

            var grid = new Gtk.Grid ();
            var unsplash_link = "https://unsplash.com/?utm_source=Fondo&utm_medium=referral";
            var content_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 3);
            var logo = new Gtk.Image.from_resource ("/com/github/calo001/fondo/images/unsplashlogo.svg");
            var lbl_powered = new Gtk.Label (S.POWERED_BY);
            var button_visit = new Gtk.LinkButton.with_label (unsplash_link, S.VISIT_WEB_SITE);;
            
            button_visit.get_style_context ().remove_class ("link");
            button_visit.get_style_context ().remove_class ("flat");
            button_visit.get_style_context ().add_class ("menu-btn");
            button_visit.has_tooltip = false;
            lbl_powered.margin_top = 8;
            content_box.add (lbl_powered);
            content_box.add (logo);
            grid.margin = 0;
            grid.row_spacing = 0;

            content_box.tooltip_text = S.UNSPLASH_DESCRIPTION;
            grid.attach(content_box, 0, 1, 1, 1);
            grid.attach(button_visit, 0, 2, 1, 1);
            grid.show_all();
            add (grid);
        }
    }
}
