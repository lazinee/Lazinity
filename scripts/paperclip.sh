#!/usr/bin/env bash

# Copied from https://github.com/PaperMC/Paper/blob/d54ce6c17fb7a35238d6b9f734d30a4289886773/scripts/paperclip.sh
# License from Paper applies to this file

(
set -e
basedir="$(cd "$1" && pwd -P)"
workdir="$basedir/Airplane/Tuinity/Paper/work"
mcver=$(cat "$workdir/BuildData/info.json" | grep minecraftVersion | cut -d '"' -f 4)
paperjar="$basedir/Lazinity-Server/target/lazinity-$mcver.jar"
vanillajar="$workdir/Minecraft/$mcver/$mcver.jar"

(
    cd "$workdir/Paperclip"
    mvn --no-transfer-progress clean package "-Dmcver=$mcver" "-Dpaperjar=$paperjar" "-Dvanillajar=$vanillajar"
    echo "Build success!"
)
cp "$workdir/Paperclip/assembly/target/paperclip-${mcver}.jar" "$basedir/lazinity-paperclip.jar"
echo "Copied final jar to $(cd "$basedir" && pwd -P)/lazinity-paperclip.jar"
) || exit 1
