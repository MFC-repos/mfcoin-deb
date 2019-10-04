#!/bin/sh

mkdir -p pack/usr/share/applications
mkdir -p pack/usr/share/icons
mkdir -p pack/opt/mfcoin

cp -r dist/bin dist/utxo_snapshot dist/genesis*.dat pack/opt/mfcoin
cp -r dist/include dist/lib dist/share pack/usr

cd pack/usr/share/man/man1
mans=$(ls | grep bitcoin)

bittomf() {
    echo "$1" | sed 's/bitcoin/mfcoin/'
}

for i in $mans; do
    mv "$i" $(bittomf "$i")
done

cd -
mkdir aur
git clone https://aur.archlinux.org/mfcoin-bin.git aur

mv aur/start pack/opt/mfcoin
mv aur/mfcoin.desktop pack/usr/share/applications
mv aur/mfcoin.svg pack/usr/share/icons

rm -rf aur

cp -r addons/* pack

dpkg-deb --build pack
