#!/usr/bin/env bash

# This file is part of RetroPie-Extra, a supplement to RetroPie.
# For more information, please visit:
#
# https://github.com/RetroPie/RetroPie-Setup
# https://github.com/Exarkuniv/RetroPie-Extra
#
# See the LICENSE file distributed with this source and at
# https://raw.githubusercontent.com/Exarkuniv/RetroPie-Extra/master/LICENSE
#

rp_module_id="fallout1"
rp_module_desc="Fallout Community Edition"
rp_module_licence="GNU https://raw.githubusercontent.com/alexbatalov/fallout1-ce/main/LICENSE.md"
rp_module_help="Copy over the master.dat, critter.dat, and data folder to ports/fallout1. EVERYTHING needs to be lower case or it will not work"
rp_module_section="prt"
rp_module_flags=""


function depends_fallout1() {
   getDepends libsdl2-2.0-0 xorg
}


function sources_fallout1() {
      gitPullOrClone "$md_build" https://github.com/alexbatalov/fallout1-ce.git main
}

function build_fallout1() {
    cd fallout1-ce
    mkdir build && cd build
    cmake ..
    cmake --build .
    md_ret_require="$md_build/build/fallout-ce"
}

function install_fallout1() {
    md_ret_files=(/build/fallout-ce
        )
}

function configure_fallout1() {
    mkRomDir "ports/$md_id"
    ln -snf "$romdir/ports/$md_id" "$md_inst"

    moveConfigDir "$romdir/ports/$md_id/data/savegame" "$md_conf_root/$md_id/save"
    local scriptcfg="$md_inst/fallout.cfg"
    local script="$md_inst/fallout1.sh"

    cat > "$scriptcfg" << _EOF_
#!/bin/bash
[sound]
music_path1=$md_id/data/sound/music/
music_path2=$md_id/data/sound/music/

[system]
critter_dat=$md_id/critter.dat
critter_patches=$md_id/data
master_dat=$md_id/master.dat
master_patches=$md_id/data
_EOF_

 cat > "$script" << _EOF_
#!/bin/bash
cd $md_inst && ./fallout-ce
_EOF_

    chmod +x "$script"
    addPort "$md_id" "fallout" "Fallout Community Edition" "$md_inst/fallout1.sh"

}