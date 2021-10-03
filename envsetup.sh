# No hash bang to encourage users to source this script (otherwise it is useless)
# This script sets up the MARTe2 environment vars based on the script's own
# location. To use:
#
# $ . envsetup.sh
#  or
# $ source envsetup.sh
#  or
# $ source ../../../a/very/../long/path/to/the/script/still/works/envsetup.sh

if [ $BASH_LINENO -eq 0 ]
then
    echo "This script should be sourced using 'source envsetup.sh' or '. envsetup.sh'. See the script comment for more info."
    exit 1
fi

script_location="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export MARTe2_DIR=$script_location/MARTe2-dev
export MARTe2_Components_DIR=$script_location/MARTe2-components

echo Set up MARTe2_DIR and MARTe2_Components_DIR as:
echo $MARTe2_DIR
echo $MARTe2_Components_DIR
