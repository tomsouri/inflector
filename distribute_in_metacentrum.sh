#!/bin/bash
#PBS -N distribute
#PBS -m ea
#PBS -l select=1:ncpus=1:mem=16gb:scratch_local=16gb
#PBS -l walltime=3:00:00

### in all home directories in metacentrum with enough quota (specified in TARGET_PATHS), create local directory
### /dp-local and copy requirements.txt, and data (UD data for inflection, specified in SOURCE_PATH) there (to `dp-local/data`)
### Also, in each of the dp-local directories, install .venv with given dependencies.

# Boolean variables to control behavior
resplit_data=false
distribute_data=false
#distribute_sig_data=true
reinstall_venv=false

export TMPDIR=$SCRATCHDIR

ROOTDIR="/storage/brno2/home/LOGIN/inflector"

# Define the source path and the list of target paths
SOURCE_PATH="storage-brno2:~/inflector/data/processed/ud-inflection/ud-treebanks-v2.14"
SRC_SIG="storage-brno2:~/inflector/data/processed"
SRC_SIG22=$SRC_SIG"/2022_SIGMORPHON_Inflection_ST"
SRC_SIG23=$SRC_SIG"/2023_SIGMORPHON_Inflection_ST"
#SOURCE_PATH="/storage/brno2/home/LOGIN/inflector/data/processed/ud-inflection/ud-treebanks-v2.14"
#SOURCE_STORAGE="storage-brno2"
#SOURCE_RELATIVE_PATH="~/inflector/data/processed/ud-inflection/ud-treebanks-v2.14/"

TARGET_PATHS=(
    "brno2"
    "brno12-cerit"
    "budejovice1"
    "plzen1"
    "vestec1-elixir"
    "praha2-natur"
#    "pruhonice1-ibot" # No my jobs run there
)

CORPORA=(
#   "cz-backtranslated-short"
#  "UD_Basque-BDT"
#  "UD_Breton-KEB"
#  "UD_Czech-PDT"
#  "UD_English-EWT"
#  "UD_Spanish-AnCora"
#  "UD_Slovak-SNK"
###  "UD_Portuguese-PetroGold" # NOT CANONICAL
###  "UD_German-HDT" # NOT CANONICAL
#    "UD_Afrikaans-AfriBooms"
#    "UD_Ancient_Greek-PROIEL"
#    "UD_Ancient_Hebrew-PTNK"
#    "UD_Arabic-PADT"
#    "UD_Armenian-ArmTDP"
#    "UD_Belarusian-HSE"
#    "UD_Bulgarian-BTB"
#    "UD_Catalan-AnCora"
#    "UD_Chinese-GSDSimp"
#    "UD_Classical_Armenian-CAVaL"
#    "UD_Classical_Chinese-Kyoto"
#    "UD_Coptic-Scriptorium"
#    "UD_Croatian-SET"
#    "UD_Danish-DDT"
#    "UD_Dutch-Alpino"
#    "UD_Erzya-JR"
#    "UD_Estonian-EDT"
#    "UD_Faroese-FarPaHC"
#    "UD_Finnish-TDT"
#    "UD_French-GSD"
#    "UD_Galician-TreeGal"
#    "UD_Georgian-GLC"
#    "UD_German-GSD"
#    "UD_Gothic-PROIEL"
#    "UD_Greek-GDT"
#    "UD_Hebrew-HTB"
#    "UD_Hindi-HDTB"
#    "UD_Hungarian-Szeged"
#    "UD_Icelandic-Modern"
#    "UD_Indonesian-GSD"
#    "UD_Irish-IDT"
#    "UD_Italian-ISDT"
#    "UD_Japanese-GSDLUW"
#    "UD_Korean-Kaist"
#    "UD_Kyrgyz-KTMU"
#    "UD_Latin-ITTB"
#    "UD_Latvian-LVTB"
#    "UD_Lithuanian-ALKSNIS"
#    "UD_Low_Saxon-LSDC"
#    "UD_Maghrebi_Arabic_French-Arabizi"
#    "UD_Maltese-MUDT"
#    "UD_Manx-Cadhan"
#    "UD_Marathi-UFAL"
#    "UD_Naija-NSC"
#    "UD_North_Sami-Giella"
#    "UD_Norwegian-Bokmaal"
#    "UD_Old_Church_Slavonic-PROIEL"
#    "UD_Old_East_Slavic-TOROT"
#    "UD_Old_French-PROFITEROLE"
#    "UD_Ottoman_Turkish-BOUN"
#    "UD_Persian-PerDT"
#    "UD_Polish-PDB"
#    "UD_Pomak-Philotis"
#    "UD_Portuguese-Bosque"
#    "UD_Romanian-RRT"
#    "UD_Russian-SynTagRus"
#    "UD_Sanskrit-Vedic"
#    "UD_Scottish_Gaelic-ARCOSG"
#    "UD_Slovenian-SSJ"
#    "UD_Swedish-Talbanken"
#    "UD_Tamil-TTB"
#    "UD_Telugu-MTG"
#    "UD_Turkish-BOUN"
#    "UD_Ukrainian-IU"
#    "UD_Urdu-UDTB"
#    "UD_Uyghur-UDT"
#    "UD_Vietnamese-VTB"
#    "UD_Welsh-CCG"
#    "UD_Western_Armenian-ArmTDP"
#    "UD_Wolof-WTB"
)

#SIG22_CORPORA=(
#	"ang"
#	"ara"
#	"asm"
#	"bra"
#	"ckt"
#	"evn"
#	"gml"
#	"goh"
#	"got"
#	"guj"
#	"heb"
#	"hsb"
#	"hsi"
#	"hun"
#	"itl"
#	"kat"
#	"ket"
#	"khk"
#	"kor"
#	"krl"
#	"lud"
#	"mag"
#	"nds"
#	"non"
#	"pol"
#	"poma"
#	"sjo"
#	"slk"
#	"tur"
#	"vep"
#)
#
#SIG23_CORPORA=(
#	"afb"
#	"amh"
#	"arz"
#	"bel"
#	"dan"
#	"deu"
#	"eng"
#	"fin"
#	"fra"
#	"grc"
#	"heb"
#	"heb_unvoc"
#	"hun"
#	"hye"
#	"ita"
#	"jap"
#	"kat"
#	"klr"
#	"mkd"
#	"nav"
#	"rus"
#	"san"
#	"sme"
#	"spa"
#	"sqi"
#	"swa"
#	"tmp"
#	"tur"
#)

REQUIREMENTS_FILE=$ROOTDIR"/requirements.txt"

module add python/python-3.10.4-intel-19.0.4-sc7snnf

if [ "$resplit_data" = true ]; then
    echo "Resplitting data in the root dir: $ROOTDIR"

    cd $ROOTDIR

    bash preprocess.sh "${CORPORA[@]}"
fi


# Loop through each target path
for TARGET_PATH in "${TARGET_PATHS[@]}"; do
    # Define the dp-local directory path
    DP_LOCAL_PATH_COPY="storage-${TARGET_PATH}:~/dp-local"
    DP_LOCAL_PATH="/storage/${TARGET_PATH}/home/LOGIN/dp-local"

    echo "Processing target: $TARGET_PATH"

        # Distribute data if distribute_data is true
    if [ "$distribute_data" = true ]; then
        echo "Distributing data to: $DP_LOCAL_PATH/data"

        # Create dp-local/data directory
        mkdir -p "${DP_LOCAL_PATH}/data"


        for CORPUS in "${CORPORA[@]}"; do
            echo "Copying data for corpus ${CORPUS}..."
            scp -r "${SOURCE_PATH}/${CORPUS}" "${DP_LOCAL_PATH_COPY}/data/"
        done

        # Copy the content of the source directory to dp-local/data
        #rsync -r "${SOURCE_PATH}/"* "${DP_LOCAL_PATH_COPY}/data/"
        #ssh $SOURCE_STORAGE "rsync ${SOURCE_RELATIVE_PATH} ${DP_LOCAL_PATH_COPY}/data/"
    fi

    # Distribute SIGMORPHON data if distribute_sig_data is true
#    if [ "$distribute_sig_data" = true ]; then
#        echo "Distributing data to: $DP_LOCAL_PATH/sig-data/22"
#
#        # Create dp-local/data directory
#        mkdir -p "${DP_LOCAL_PATH}/sig-data/22"
#
#
#        for CORPUS in "${SIG22_CORPORA[@]}"; do
#            echo "Copying data for corpus ${CORPUS}..."
#            scp -r "${SRC_SIG22}/${CORPUS}" "${DP_LOCAL_PATH_COPY}/sig-data/22/"
#        done
#
#        echo "Distributing data to: $DP_LOCAL_PATH/sig-data/23"
#
#        # Create dp-local/data directory
#        mkdir -p "${DP_LOCAL_PATH}/sig-data/23"
#
#
#        for CORPUS in "${SIG23_CORPORA[@]}"; do
#            echo "Copying data for corpus ${CORPUS}..."
#            scp -r "${SRC_SIG23}/${CORPUS}" "${DP_LOCAL_PATH_COPY}/sig-data/23/"
#        done
#
#
#
#        # Copy the content of the source directory to dp-local/data
#        #rsync -r "${SOURCE_PATH}/"* "${DP_LOCAL_PATH_COPY}/data/"
#        #ssh $SOURCE_STORAGE "rsync ${SOURCE_RELATIVE_PATH} ${DP_LOCAL_PATH_COPY}/data/"
#    fi




    # Reinstall virtual environment if reinstall_venv is true
    if [ "$reinstall_venv" = true ]; then
        echo "Setting up virtual environment for: $DP_LOCAL_PATH"

        # Ensure dp-local directory exists
        mkdir -p "${DP_LOCAL_PATH}"

        # Copy the requirements.txt to dp-local
        scp "${REQUIREMENTS_FILE}" "${DP_LOCAL_PATH_COPY}/"

        # Check if .venv already exists
        if [ -d "${DP_LOCAL_PATH}/.venv" ]; then
            echo "Virtual environment exists. Installing requirements..."
        else
            echo "Virtual environment does not exist. Creating..."
            python3 -m venv "${DP_LOCAL_PATH}/.venv"
            echo "Installing requirements..."
        fi

        # Install dependencies
        ${DP_LOCAL_PATH}/.venv/bin/pip install --upgrade pip
        ${DP_LOCAL_PATH}/.venv/bin/pip install --no-cache-dir -r "${DP_LOCAL_PATH}/requirements.txt"
    fi


    echo "Setup complete for: $TARGET_PATH"
done

echo "All targets processed successfully."
