#!/bin/bash

lines_changed_for_staging=$(git diff master HEAD *.env.staging | grep '^[+-][^+-]' | wc -l)
lines_changed_for_production=$(git diff master HEAD *.env.production  | grep '^[+-][^+-]' | wc -l)
[ $lines_changed_for_staging == $lines_changed_for_production ]
