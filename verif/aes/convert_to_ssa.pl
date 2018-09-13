#!perl -p

BEGIN{$%=8}s|(xmm\d+) = (.*)|$@=$1;$;=($2=~s!xmm\d+!$%{$&}//$&!rge);$%{$@}=xmm.$%++;"DATATYPE $%{$@} = $;"|ge||s{xmm\d+}{$%{$&}//$&}ge
