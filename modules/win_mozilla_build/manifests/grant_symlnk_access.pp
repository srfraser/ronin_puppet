# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class win_mozilla_build::grant_symlnk_access {

    require win_mozilla_build::hg_install
    $hg_exe     = "\"${win_mozilla_build::program_files}\\mercurial\\hg.exe\""
    $carbon_dir = "${win_mozilla_build::tempdir}\\carbon"
    $system32   = $win_mozilla_build::system32

    exec { 'carbonclone':
        command => "${hg_exe} clone --insecure https://bitbucket.org/splatteredbits/carbon ${carbon_dir}",
        creates => "${carbon_dir}\\readme.md",
    }
    file { "${system32}\\WindowsPowerShell\\v1.0\\Modules\\Carbon":
        source  => "${carbon_dir}\\carbon",
        recurse => true,
    }
    exec { 'grant_symlnk_access':
        command     => file('win_mozilla_build/grant_symlnk_access.ps1'),
        provider    => powershell,
        subscribe   => File["${system32}\\WindowsPowerShell\\v1.0\\Modules\\Carbon"],
        refreshonly => true,
    }
}
