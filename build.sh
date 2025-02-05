#!/bin/bash
perl make-test.pl "hyph-ca-simple.tex" "hyph-ca-new.tex" <mots.txt > mots-separats.txt
echo "******** RESULTS ********"
cat resum-resultats.txt
echo "*************************"
if [[ $1 == release ]]
then
    echo "Converting patterns..."
    perl oneruleperline.pl hyph-ca-new.tex hyph-ca-new2.tex
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
    cp hyph_ca_ES.dic office/hyph_ca_ANY.dic
    cd office
    zip -r hyph-ca *
    mv hyph-ca.zip ../results/hyph-ca.oxt
    cd ..
    mv hyph_ca_ES.dic results/hyph_ca_ES.dic

    perl patterns-to-js.pl
    #sed -i 's/ *$//' ca.js

    echo "Done. Output: results/hyph_ca_ES.dic"
fi
