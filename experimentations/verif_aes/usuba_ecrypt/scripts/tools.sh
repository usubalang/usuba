
# -----------------------------------------------------------------------------

verbosity="5:5";

tmpfile=$(pwd)/.tmpfile.$$;
touch $tmpfile;

trap "rm -rf $tmpfile; echo;" EXIT;

# -----------------------------------------------------------------------------

getstatus ()
{
    cat $tmpfile;
}

setstatus ()
{
    echo $1 > $tmpfile;
}

status ()
{
    [ "$1" -le "${verbosity%:*}" ] || return;

    status=$(getstatus);

    if [ "$status" = "busy" ]; then
	echo "done" >&2;
	setstatus idle;
    else
	[ "$status" = "idle" ] || echo >&2;

	echo -n " * $2 ... " >&2;
	setstatus busy;
    fi
}

info ()
{
    [ "$1" -le "${verbosity%:*}" ] || return;
    [ "$(getstatus)" = "info" ] || echo >&2;
    
    echo "$2" >&2;
    setstatus info;
}

error ()
{
    [ "$1" -le "${verbosity%:*}" ] || return;
    [ "$(getstatus)" = "error" ] || echo >&2;
    
    echo "error: $2" >&2;
    setstatus error;
}

warning ()
{
    [ "$1" -le "${verbosity%:*}" ] || return;
    [ "$(getstatus)" = "error" ] || echo >&2;
    
    echo "warning: $2" >&2;
    setstatus error;
}

question ()
{
    [ "$1" -le "${verbosity#*:}" ] || return;
    [ "$(getstatus)" = "question" ] || echo >&2;
    
    echo "$2" >&2;
    setstatus question;
}

ask ()
{
    if [ "$1" -le "${verbosity#*:}" ]; then
	status=$(getstatus);

	[ "$status" = "question" ] || [ "$status" = "ask" ] || echo >&2; 
    
	echo -n "$2 " >&2;
	setstatus ask;
	
	read answer;
	echo $answer;
    else
	echo "$3";
    fi
}

ask_list ()
{
    question $2 "Enter a comma-separated list of numbers to select $3";
    list=$(ask $2 "or press <return> to select everything:" "$4");

    if [ -n "$list" ]; then
	i=0;
	for item in $1; do i=$(expr $i + 1);
	    expr ",${list// /}," : ".*,$i," &> /dev/null && echo "$item";
	done
    else
	echo "$1";
    fi
}

# -----------------------------------------------------------------------------

relative ()
{
    dst=$(cd "$1" && pwd)/.; dst=${dst#/tmp_mnt};
    src=$(cd "$2" && pwd)/.; src=${src#/tmp_mnt};

    while [ "$src" != "." ]; do
	if [ "${dst%%/*}" = "${src%%/*}" ]; then
	    dst=${dst#*/};
	else
	    dst=../$dst;
	fi

	src=${src#*/};
    done

    echo "${dst%/.}";
}

# -----------------------------------------------------------------------------
