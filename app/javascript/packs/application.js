// app/javascript/packs/application.js

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bulma";
import "script.js"


Rails.start()
Turbolinks.start()
ActiveStorage.start()



