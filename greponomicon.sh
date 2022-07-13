#!/bin/bash

Target="target_filename"
Source="acronym_source_filename"
AcronymOut="acronomicon"
GrepOutFile="greponomicon_out"


# Generate an acronym list AcronymOut using regex
egrep -o '( |^)([A-Z]|[0-9])+[\.\-]?([A-Z]|[0-9])+( |$)' $Source | tr -d [:blank:] | sort -u > $AcronymOut
#           ^ Starts with space or line beginning   ^ Ends with either a space or line ending
#                    ^  Capital letters or numbers                     ^ Delete spaces
#			    ^ At least one of either followed by a single wildcard seperator (ex: PL2D-4R)
# For each acronym grep the target file and append results
Acronyms=$(cat $AcronymOut)
for Acronym in $Acronyms
do
	egrep -i -A 10 -B 10 $Acronym $Target >> $GrepOutFile
done
# The result is a strange file containing sections of the target file that mention acronyms found in the source file.

# I wrote this script to aid reasearch of technical manuals, for the case where you may have one document that is already
# well understood but need to search a wider pool of documents that may or may not contain the information you need.
# The way I use this is to edit the regex to filter for specific information I know document A contains which is related
# to information I expect document B to contain, then run the search and examine the results for sections of B which
# seem interesting. 
