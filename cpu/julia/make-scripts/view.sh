#!/bin/bash
OUT=julia

# increase the memory size to 8g! (4 was not enough)
hpcviewer -jh 8g ${OUT}.d 
