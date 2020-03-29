#!/bin/bash

O1="     ___      "
O2="  /       \\   "
O3=" |         |  "
O4=" |         |  "
O5="  \\  ___  /   "

X1="  \\       /   "
X2="    \\   /     "
X3="      \\       "
X4="    /   \\     "
X5="  /       \\   "

emp1="              "
emp2="              "
emp3="              "
emp4="              "
emp5="              "
hline="|--------------|--------------|--------------|"

draw_grid() {
    local tl1=${tl}1 tm1=${tm}1 tr1=${tr}1
    local tl2=${tl}2 tm2=${tm}2 tr2=${tr}2
    local tl3=${tl}3 tm3=${tm}3 tr3=${tr}3
    local tl4=${tl}4 tm4=${tm}4 tr4=${tr}4
    local tl5=${tl}5 tm5=${tm}5 tr5=${tr}5

    local ml1=${ml}1 mm1=${mm}1 mr1=${mr}1
    local ml2=${ml}2 mm2=${mm}2 mr2=${mr}2
    local ml3=${ml}3 mm3=${mm}3 mr3=${mr}3
    local ml4=${ml}4 mm4=${mm}4 mr4=${mr}4
    local ml5=${ml}5 mm5=${mm}5 mr5=${mr}5

    local bl1=${bl}1 bm1=${bm}1 br1=${br}1
    local bl2=${bl}2 bm2=${bm}2 br2=${br}2
    local bl3=${bl}3 bm3=${bm}3 br3=${br}3
    local bl4=${bl}4 bm4=${bm}4 br4=${br}4
    local bl5=${bl}5 bm5=${bm}5 br5=${br}5

    echo $hline
    echo "|${!tl1}|${!tm1}|${!tr1}|"
    echo "|${!tl2}|${!tm2}|${!tr2}|"
    echo "|${!tl3}|${!tm3}|${!tr3}|"
    echo "|${!tl4}|${!tm4}|${!tr4}|"
    echo "|${!tl5}|${!tm5}|${!tr5}|"
    echo $hline
    echo "|${!ml1}|${!mm1}|${!mr1}|"
    echo "|${!ml2}|${!mm2}|${!mr2}|"
    echo "|${!ml3}|${!mm3}|${!mr3}|"
    echo "|${!ml4}|${!mm4}|${!mr4}|"
    echo "|${!ml5}|${!mm5}|${!mr5}|"
    echo $hline
    echo "|${!bl1}|${!bm1}|${!br1}|"
    echo "|${!bl2}|${!bm2}|${!br2}|"
    echo "|${!bl3}|${!bm3}|${!br3}|"
    echo "|${!bl4}|${!bm4}|${!br4}|"
    echo "|${!bl5}|${!bm5}|${!br5}|"
    echo $hline
}

pick(){
    while true
    do
        echo "Hello :) Please pick your symbol (X or O):"
        read symbol1
        echo
        if [ $symbol1 != "X" ] && [ $symbol1 != "O" ]
        then
            echo "$symbol1 is not a valid symbol1. Try X or O instead."
            echo
        else
            if [ $symbol1 == "X" ]
            then
                symbol2="O"
                echo "Player1 takes $symbol1."
                echo "Player2 gets $symbol2."
                echo
            else
                symbol2="X"
                echo "Player1 takes $symbol1."
                echo "Player2 gets $symbol2."
                echo
            fi
            break
        fi
    done
}

victory() {
    [ "$tl" = "$tm" -a "$tl" = "$tr" -a "$tl" != "emp" ]; con1=$?
    [ "$ml" = "$mm" -a "$ml" = "$mr" -a "$ml" != "emp" ]; con2=$?
    [ "$bl" = "$bm" -a "$bl" = "$br" -a "$bl" != "emp" ]; con3=$?

    [ "$tl" = "$ml" -a "$tl" = "$bl" -a "$tl" != "emp" ]; con4=$?
    [ "$tm" = "$mm" -a "$tm" = "$bm" -a "$tm" != "emp" ]; con5=$?
    [ "$tr" = "$mr" -a "$tr" = "$br" -a "$tr" != "emp" ]; con6=$?

    [ "$tl" = "$mm" -a "$tl" = "$br" -a "$tl" != "emp" ]; con7=$?
    [ "$tr" = "$mm" -a "$tr" = "$bl" -a "$tr" != "emp" ]; con8=$?

    [ "$con1" = "0" -o "$con2" = "0" -o "$con3" = "0" -o "$con4" = "0" -o "$con5" = "0" -o "$con6" = "0" -o "$con7" = "0" -o "$con8" = "0" ]
    return $?
}

full(){
    [ "$tl" != "emp" -a "$tm" != "emp" -a "$tr" != "emp" -a "$ml" != "emp" -a "$mm" != "emp" -a "$mr" != "emp" -a "$bl" != "emp" -a "$bm" != "emp" -a "$br" != "emp" ]
    return $?
}

tl="emp"
tm="emp"
tr="emp"
ml="emp"
mm="emp"
mr="emp"
bl="emp"
bm="emp"
br="emp"

name1="player1"
name2="player2"
cur_name=$name1

pick 
cur_symbol=$symbol1

while true
do
    draw_grid $tl $tm $tr $ml $mm $mr $br $bm $br
    while true
    do
        echo "Choose your move $cur_name"
        echo "Type in one of the following choices:"
        echo "|----|----|----|"
        echo "| tl | tm | tr |"
        echo "|----|----|----|"
        echo "| ml | mm | mr |"
        echo "|----|----|----|"
        echo "| br | bm | br |"
        echo "|----|----|----|"
        echo
        read choice
        echo
        if [ $choice != "tl" -a $choice != "tm" -a $choice != "tr" -a $choice != "ml" -a $choice != "mm" -a $choice != "mr" -a $choice != "bl" -a $choice != "bm" -a $choice != "br" ]
        then
            echo "This is not a valid choice"
        elif [ "${!choice}" != "emp" ]
        then
            echo "This field is already occupied. Please choose again."
        else
            clear
            eval "$choice"="$cur_symbol"
            break
        fi
    done

    if victory
    then
        draw_grid $tl $tm $tr $ml $m $mr $br $bm $br
        echo
        echo "Congratulations $cur_name. You won! "
        echo
        break
    fi

    if full
    then
        draw_grid $tl $tm $tr $ml $m $mr $br $bm $br
        echo
        echo "It's a tie!"
        echo
        break
    fi

    if [ $cur_name = "player1" ]
    then
        cur_name="${name2}"
        cur_symbol="${symbol2}"
    else
        cur_name="${name1}"
        cur_symbol="${symbol1}"
    fi
done
