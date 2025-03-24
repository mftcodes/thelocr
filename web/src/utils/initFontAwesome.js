import { library } from "@fortawesome/fontawesome-svg-core";
import { faCopyright, faUser, faPowerOff } from "@fortawesome/free-solid-svg-icons";

function initFontAwesome() {
  library.add(faCopyright);
  library.add(faUser);
  library.add(faPowerOff);
}

export default initFontAwesome;
