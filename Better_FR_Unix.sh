#!/bin/bash

# Balatro French Translations
#
# Script d'installation du pack de langue FR pour Balatro (version SteamDeck/Linux/Mac)
# Fichier de langue et assets créés par la communauté Discord (Balatro FR - loc mod) : https://discord.gg/kQMdHTXB3Z
# Toutes les sources à jour sont disponibles ici : https://github.com/FrBmt-BIGetNouf/balatro-french-translations/
#
# Ce script utilise Balamod pour injecter les ressources au jeu (https://github.com/UwUDev/balamod)
#
#    ==================================
#    ==  PERDU(E) ? NE PANIQUEZ PAS  ==
#    ==================================
#    Revenez en arrière et CLIQUEZ-DROIT sur le lien qui vous a mené ici, puis "Enregistrer le lien sous...".
#    Double-cliquez ensuite sur le fichier téléchargé pour lancer l'installation.
#

color_reset=$'\033[0m'
ressources_folder=$'Balatro_Localization_Resources'
plateforme=linux

if [[ $OSTYPE == 'darwin'* ]]; then
  plateforme=mac
fi

# Initialisation
init() {
    echo "========================================="
    echo "==     Balatro French Translations     =="
    echo "==  Installation du pack de langue FR  =="
    echo "==        Traductions et images        =="
    echo "========================================="

    # Question utilisateur : Les images en Francais doivent-elles être utilisées ?
    echo ""
    echo ""
    echo "Voulez-vous utiliser les images en Français ? (O/N)"
    read -r download_assets

    if [[ "$download_assets" =~ ^[Oo]$ ]]; then
        echo "Les images seront ajoutées."
    elif [[ "$download_assets" =~ ^[Nn]$ ]]; then
        echo "Les images ne seront pas ajoutées."
    else
        download_assets="N"
        echo "Entrée non valide, les images ne seront pas ajoutées."
    fi
}

# Téléchargement de Balamod
download_balamod() {
    echo ""
    echo "Téléchargement de Balamod..."
    echo ""
    # On obtient les données de la dernière release via l'API Github.
    json_latest_release=$(curl -s "https://api.github.com/repos/UwUDev/balamod/releases/latest")

    # Recherche du nom du fichier linux ou mac dans la dernière release (valable tant que UwUDev laisse la plateforme dans le nom du fichier).
    balamod_file=$( echo $json_latest_release | perl -nle"print $& while m{\"name\": \"\K[^\"]+-$plateforme}g")
    echo ${balamod_file}

    # URL de téléchargement du fichier.
    file_url=$( echo $json_latest_release | perl -nle"print $& while m{\"browser_download_url\": \"\K[^\"]+-$plateforme}g")
    echo ${file_url}
    # Téléchargement si Balamod n'existe pas
    if [ ! -e "${ressources_folder}/${balamod_file}" ]; then
        curl --create-dirs -o "${ressources_folder}/${balamod_file}" -LJ "${file_url}"
        chmod +x "${ressources_folder}/${balamod_file}"
        
        # Désactive les vérifications de logiciel malveillant de macOS pour Balamod
        if [ "${plateforme}" = "mac" ]; then
            xattr -c "${ressources_folder}/${balamod_file}"
        fi

        echo "Téléchargement de Balamod terminé."
        echo ""
    fi
}

# Téléchargement du pack de langue FR
download_mod_fr() {
    echo ""
    echo "Téléchargement du mod FR..."
    echo ""

    fr_repository="https://raw.githubusercontent.com/FrBmt-BIGetNouf/balatro-french-translations/main/localization"
    fr_translation="${fr_repository}/fr.lua"
    fr_assets_boosters_1x="${fr_repository}/assets/1x/boosters.png"
    fr_assets_boosters_2x="${fr_repository}/assets/2x/boosters.png"
    fr_assets_tarots_1x="${fr_repository}/assets/1x/Tarots.png"
    fr_assets_tarots_2x="${fr_repository}/assets/2x/Tarots.png"
    fr_assets_vouchers_1x="${fr_repository}/assets/1x/Vouchers.png"
    fr_assets_vouchers_2x="${fr_repository}/assets/2x/Vouchers.png"
    fr_assets_icons_1x="${fr_repository}/assets/1x/icons.png"
    fr_assets_icons_2x="${fr_repository}/assets/2x/icons.png"
    fr_assets_BlindChips_1x="${fr_repository}/assets/1x/BlindChips.png"
    fr_assets_BlindChips_2x="${fr_repository}/assets/2x/BlindChips.png"
    fr_assets_Jokers_1x="${fr_repository}/assets/1x/Jokers.png"
    fr_assets_Jokers_2x="${fr_repository}/assets/2x/Jokers.png"
    fr_assets_ShopSignAnimation_1x="${fr_repository}/assets/1x/ShopSignAnimation.png"
    fr_assets_ShopSignAnimation_2x="${fr_repository}/assets/2x/ShopSignAnimation.png"

    curl --create-dirs -o "${ressources_folder}/fr.lua" -LJ "${fr_translation}"

    if [[ "$download_assets" =~ ^[Oo]$ ]]; then
        curl --create-dirs -o "${ressources_folder}/assets/1x/boosters.png" -LJ "${fr_assets_boosters_1x}"
        curl --create-dirs -o "${ressources_folder}/assets/2x/boosters.png" -LJ "${fr_assets_boosters_2x}"
        curl --create-dirs -o "${ressources_folder}/assets/1x/Tarots.png" -LJ "${fr_assets_tarots_1x}"
        curl --create-dirs -o "${ressources_folder}/assets/2x/Tarots.png" -LJ "${fr_assets_tarots_2x}"
        curl --create-dirs -o "${ressources_folder}/assets/1x/Vouchers.png" -LJ "${fr_assets_vouchers_1x}"
        curl --create-dirs -o "${ressources_folder}/assets/2x/Vouchers.png" -LJ "${fr_assets_vouchers_2x}"
        curl --create-dirs -o "${ressources_folder}/assets/1x/icons.png" -LJ "${fr_assets_icons_1x}"
        curl --create-dirs -o "${ressources_folder}/assets/2x/icons.png" -LJ "${fr_assets_icons_2x}"
        curl --create-dirs -o "${ressources_folder}/assets/1x/BlindChips.png" -LJ "${fr_assets_BlindChips_1x}"
        curl --create-dirs -o "${ressources_folder}/assets/2x/BlindChips.png" -LJ "${fr_assets_BlindChips_2x}"
        curl --create-dirs -o "${ressources_folder}/assets/1x/Jokers.png" -LJ "${fr_assets_Jokers_1x}"
        curl --create-dirs -o "${ressources_folder}/assets/2x/Jokers.png" -LJ "${fr_assets_Jokers_2x}"
        curl --create-dirs -o "${ressources_folder}/assets/1x/ShopSignAnimation.png" -LJ "${fr_assets_ShopSignAnimation_1x}"
        curl --create-dirs -o "${ressources_folder}/assets/2x/ShopSignAnimation.png" -LJ "${fr_assets_ShopSignAnimation_2x}"
    fi

    echo ""
    echo "Téléchargement du mod FR terminé."
    echo ""
}

# Injection du pack de langue FR
mod_injection() {
    echo ""
    echo "Installation du pack de langue..."
    echo ""

    ./$ressources_folder/$balamod_file -x -i $ressources_folder/fr.lua -o localization/fr.lua

    if [[ "$download_assets" =~ ^[Oo]$ ]]; then
        ./$ressources_folder/$balamod_file -x -i $ressources_folder/assets/1x/boosters.png -o resources/textures/1x/boosters.png
        ./$ressources_folder/$balamod_file -x -i $ressources_folder/assets/2x/boosters.png -o resources/textures/2x/boosters.png
        ./$ressources_folder/$balamod_file -x -i $ressources_folder/assets/1x/Tarots.png -o resources/textures/1x/Tarots.png
        ./$ressources_folder/$balamod_file -x -i $ressources_folder/assets/2x/Tarots.png -o resources/textures/2x/Tarots.png
        ./$ressources_folder/$balamod_file -x -i $ressources_folder/assets/1x/Vouchers.png -o resources/textures/1x/Vouchers.png
        ./$ressources_folder/$balamod_file -x -i $ressources_folder/assets/2x/Vouchers.png -o resources/textures/2x/Vouchers.png
        ./$ressources_folder/$balamod_file -x -i $ressources_folder/assets/1x/icons.png -o resources/textures/1x/icons.png
        ./$ressources_folder/$balamod_file -x -i $ressources_folder/assets/2x/icons.png -o resources/textures/2x/icons.png
        ./$ressources_folder/$balamod_file -x -i $ressources_folder/assets/1x/BlindChips.png -o resources/textures/1x/BlindChips.png
        ./$ressources_folder/$balamod_file -x -i $ressources_folder/assets/2x/BlindChips.png -o resources/textures/2x/BlindChips.png
        ./$ressources_folder/$balamod_file -x -i $ressources_folder/assets/1x/Jokers.png -o resources/textures/1x/Jokers.png
        ./$ressources_folder/$balamod_file -x -i $ressources_folder/assets/2x/Jokers.png -o resources/textures/2x/Jokers.png
        ./$ressources_folder/$balamod_file -x -i $ressources_folder/assets/1x/ShopSignAnimation.png -o resources/textures/1x/ShopSignAnimation.png
        ./$ressources_folder/$balamod_file -x -i $ressources_folder/assets/2x/ShopSignAnimation.png -o resources/textures/2x/ShopSignAnimation.png
    fi

    echo "${color_reset}"
    echo "Installation du pack de langue terminée."
}

download_cleanup() {
    rm -R $ressources_folder
    echo "Balatro a été mis à jour !"
}

init
download_balamod
download_mod_fr
mod_injection
download_cleanup
