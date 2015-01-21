#!/bin/bash
perl make-test.pl <mots.txt > mots-separats.txt
perl oneruleperline.pl hyph-ca-new.tex hyph-ca-new2.tex
echo "******** RESULTS ********"
cat resum-resultats.txt
echo "*************************"
echo "Converting patterns..."
perl substrings.pl hyph-ca-new2.tex output.dic > substrings-results.txt
#Converteix a format DOS / UTF-8
iconv -f ISO-8859-1 -t UTF-8 output.dic > output-utf8.dic
sed -i 's/$/\r/' output-utf8.dic
#Afegeix la capçalera
cat hyph_ca_ES-header.dic output-utf8.dic > hyph_ca_ES.dic
#Elimina fitxers intermedis
rm hyph-ca-new2.tex
rm output.dic
rm output-utf8.dic
echo "Done. Output: hyph_ca_ES.dic"
