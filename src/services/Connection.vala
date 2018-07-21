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
using App.Structs;

namespace App.Connection {

     /**
     * The {@code AppConnection} class.
     *
     * @since 1.0.0
     */
    public class AppConnection {

        public AppConnection() {

        }

        public List<string> api_connection() {
            var session = new Soup.Session ();
            string uri = Constants.API_UNSPLASH +
                         "photos/random/?client_id=" +
                         Constants.ACCESS_KEY_UNSPLASH +
                         Constants.API_PARAMS;
            var message = new Soup.Message ("GET", uri);

            /* send a sync request */
            session.send_message (message);
            message.response_headers.foreach ((name, val) => {
                stdout.printf ("Name: %s -> Value: %s\n", name, val);
            });

            //stdout.printf ("Message length: %lld\n%s\n", message.response_body.length, cadenas(message));
            return get_images(message);
        }

        public List<Photo> get_images(Soup.Message message) {
            List<Photo> list_thumbs = new List<Photo> ();
            var parser = new Json.Parser ();
            try {
                parser.load_from_data ((string) message.response_body.flatten ().data, -1);
                var node = parser.get_root ();
                unowned Json.Array array = node.get_array ();

                var link = "Vacio";
                foreach (unowned Json.Node item in array.get_elements ()) {
                    var obj_res = item.get_object().get_object_member ("urls");
                    link = obj_res.get_string_member ("thumb");
                    list_thumbs.append(link);
	            }
            } catch (Error e) {
                print ("Unable to parse the string: %s\n", e.message);
                return list_thumbs;
            }

            return list_thumbs;
        }
    }
}
