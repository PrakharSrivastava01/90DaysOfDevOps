#!/bin/bash
Localuser () {

        local x=10
        echo "Inside function x= $x"

}
Localuser
echo "Outside function x= $x"
globaluser () {

        y=20
        echo "Inside function y= $y"

}
globaluser
echo "Outside function y= $y"