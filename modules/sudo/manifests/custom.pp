# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

define sudo::custom (
    String $user,
    String $command,
    String $runas = 'root',
) {

    include sudo

    sudo::customfile { $title:
        content => "${user} ALL=(${runas}) NOPASSWD: ${command}\n";
    }
}
