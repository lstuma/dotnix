#!/usr/bin/env bash

color_1=$1
color_2=$2
percentage=$3

get-color() {
    hex=$1
    offset=$2
    printf "%d" 0x${hex:offset:2}
}
red() {
    get-color $1 1
}
green() {
    get-color $1 3
}
blue() {
    get-color $1 5
}
mix() {
    p=$3
    q=$((100-$3))
    sum=$(($1 * q + $2 * p))
    printf "%d" $(($sum / 100))
}
r_1=$(red $color_1)
g_1=$(green $color_1)
b_1=$(blue $color_1)
r_2=$(red $color_2)
g_2=$(green $color_2)
b_2=$(blue $color_2)

r_3=$(mix $r_1 $r_2 $percentage)
g_3=$(mix $g_1 $g_2 $percentage)
b_3=$(mix $b_1 $b_2 $percentage)

printf "#%02X%02X%02X\n" $r_3 $g_3 $b_3
