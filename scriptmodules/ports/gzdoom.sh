#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="gzdoom"
rp_module_desc="GZDoom - Yes the real GZDoom on Pi, running in GLES"
rp_module_licence="GPL3 https://raw.githubusercontent.com/drfrag666/gzdoom/master/LICENSE"
rp_module_section="prt"
rp_module_flags=""

function depends_gzdoom() {
     getDepends g++ make cmake libsdl2-dev git zlib1g-dev libbz2-dev libjpeg-dev libfluidsynth-dev libgme-dev libopenal-dev libmpg123-dev libsndfile1-dev libgtk-3-dev timidity nasm libgl1-mesa-dev tar libsdl1.2-dev libglew-dev libvpx-dev libvulkan-dev

}

function sources_gzdoom() {
    gitPullOrClone "$md_build" https://github.com/Exarkuniv/gzdoom-Pi.git master
}

function build_gzdoom() {
      if [ ! -f "/usr/lib/arm-linux-gnueabihf/libzmusic.so" ]; then
	gitPullOrClone "$md_build/zmusic" https://github.com/coelckers/ZMusic.git
    cd $md_build/zmusic
    mkdir build
    cd build
    cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr 
    make
    make install
    rm -r $md_build/zmusic

    fi

    mkdir build
    cd build
    c="$(lscpu -p | grep -v '#' | sort -u -t , -k 2,4 | wc -l)" ; [ "$c" -eq 0 ] && c=1
    rm -f output_sdl/liboutput_sdl.so &&
    if [ -d ../fmodapi44464linux ]; then
    f="-DFMOD_LIBRARY=../fmodapi44464linux/api/lib/libfmodex${a}-4.44.64.so \
    -DFMOD_INCLUDE_DIR=../fmodapi44464linux/api/inc"; else
    f='-UFMOD_LIBRARY -UFMOD_INCLUDE_DIR'; fi &&
    cmake .. -DCMAKE_BUILD_TYPE=Release
    make -j4

}


function install_gzdoom() {
    md_ret_files=(
        'build/brightmaps.pk3'
        'build/gzdoom'
        'build/gzdoom.pk3'
        'build/lights.pk3'
        'build/game_support.pk3'
	'build/soundfonts'
        'build/game_widescreen_gfx.pk3'
        'README.md'
    )
}

function add_games_gzdoom() {
    local params=("+fullscreen 1")
    local launcher_prefix="DOOMWADDIR=$romdir/ports/doom"

    _add_games_lr-prboom "$launcher_prefix $md_inst/$md_id +set vid_preferbackend 3 -iwad %ROM%"
}

function configure_gzdoom() {
    mkRomDir "ports/doom"
    moveConfigDir "$home/.config/$md_id" "$md_conf_root/doom"

    [[ "$md_mode" == "install" ]] && game_data_lr-prboom

    add_games_${md_id}
}