#!/bin/sh

if [[ "$1" == "" ]] || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    echo "Usage: $0 <file.ifo> [dictionary_name]"
    echo "file.ifo has to have the associated .idx and .dict(.dz) in the same directory"
    echo "dictionary_name is an optional string to name the dictionary. If it is"
    echo "not present, the file's name is used."
    exit 1
fi

FILE_DIR=`dirname "$1"`
FILE_NAME_FULL=`basename "$1"`
FILE_NAME="${FILE_NAME_FULL%.*}"

if [[ "$2" == "" ]]; then
    DICT_NAME="$FILE_NAME"
else
    DICT_NAME="$2"
fi

if [[ "${FILE_NAME_FULL##*.}" != "ifo" ]]; then
    echo "The input has to be an IFO file."
    exit 1
fi

MDK_DIR=$(cd $(dirname "$0"); pwd)/mac-dictionary-kit
WORK_DIR=`mktemp -d`
function cleanup {
    rm -rf "$WORK_DIR"
}
trap cleanup EXIT

$MDK_DIR/sdconv/sdconv -m default "$1" "$WORK_DIR/Dictionary.xml" > /dev/null

sed -e "s/\$DICT_NAME/${DICT_NAME}/g" -e "s/\$DICT_ID/${DICT_NAME}/g" \
    < "$MDK_DIR/templates/DictInfo.plist" \
    > "$WORK_DIR/DictInfo.plist"

cd $WORK_DIR
$MDK_DIR/ddk/build_dict.sh "$DICT_NAME" \
    "$WORK_DIR/Dictionary.xml" \
    "$MDK_DIR/templates/Dictionary.css" \
    "$WORK_DIR/DictInfo.plist"

cp -r "./objects/$DICT_NAME.dictionary" "$HOME/Library/Dictionaries"
echo "Installed dictionary to $HOME/Library/Dictionaries"
