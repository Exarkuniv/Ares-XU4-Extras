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

rp_module_id="sorrv2"
rp_module_desc="Streets of Rage Remake useing engine by BennuGD"
rp_module_help="Please copy your SorR.dat file along with the mod and palettes folders into ports/sorr. Runs a slow in fullscreen, best to be in windowed mode"
rp_module_section="prt"
rp_module_flags="!x86 !x11 !mali"

function depends_sorrv2() {
    getDepends libsdl-mixer1.2 libpng++-dev libpng-dev xorg
}

function install_bin_sorrv2() {
    downloadAndExtract "https://github.com/Exarkuniv/bennugd-Rpi/raw/master/bgdi-354.zip" "$md_inst"
    chmod +x "$md_inst/bgdi-354"
}

function configure_sorrv2() {
    mkRomDir "ports/$md_id"
    local script="$md_inst/$md_id.sh"
    local config="$romdir/ports/$md_id/mod/system.txt"

    addPort "bgdi-354" "sorrv2" "Streets of Rage Remake" "XINIT:$script %ROM%" "./SorR.dat"
    [[ -f "$romdir/ports/$md_id/SorMaker.dat" || "$md_mode" == "remove" ]] && addPort "bgdi-354" "sorr" "SorMaker" "XINIT:$script %ROM%" "./SorMaker.dat"
    [[ "$md_mode" == "remove" ]] && return

    #create buffer script for launch
    cat > "$script" << _EOF_
#!/bin/bash
pushd "$romdir/ports/$md_id"
"$md_inst/bgdi-354" \$*
popd
_EOF_

    chmod +x "$script"
    if [[ -f "$config" ]]; then
        # set custom "system" for 5.1 (allows proper "exit" from game menu)
        sed -i 's/system = PC/system = PSP/' "$config"
        # set custom "full screen wide" mode for 5.2 (allows "windowed" and "vsync" options)
        sed -i 's/^BORDERLESS_SYNC/AUTO/' "$config"
    fi

}