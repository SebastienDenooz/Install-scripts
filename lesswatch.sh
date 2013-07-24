#!/bin/bash                                                                     
# Detect changes in .less file and automatically compile into .css                 
[ "$2" ] || { echo "Specify both .less and .css files"; exit 1; }                  
inotifywait . -m -e close_write | while read x op f; do                            
    if [[ "$f" == *".less" ]]; then                                                
        echo "Change detected. Recompiling...";                                    
        lessc -x $1 > $2 && echo "`date`: COMPILED";                                                                                                                           
    fi                                                                             
done 