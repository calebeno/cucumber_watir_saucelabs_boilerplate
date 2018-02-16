
catchable_exit () {
    exit $1
}

git_hash_prefix () {
    local prefix_length=$1
    if [[ "$prefix_length" == "" ]]; then
        prefix_length=6
    fi
    echo $(git log -n 1 --pretty=format:"%H" | cut -c "1-$prefix_length")
}

annotation_size_for_image () {
    local image_filename="$1"
    local string="$2"

    local image_width=$(identify -format "%w" "$image_filename")
    local image_height=$(identify -format "%h" "$image_filename")
    local string_len=$(echo -n "$string" | wc -m)

    local y_pt_cand=$(echo "(50 * $image_height) / 235" | bc)
    local x_pt=$(echo "(200 * $image_width) / 235" | bc -l)
    local x_pt_cand=$(echo "(2 * $x_pt) / $string_len" | bc)

    local pt_size=$y_pt_cand
    if [[ $x_pt_cand -lt $y_pt_cand ]]; then
        pt_size=$x_pt_cand
    fi

    echo $pt_size
}

# WARNING: If you use this function, be sure to set UNSET_BRAND_MATTERS to something (doesn't matter what;
# just not a blank string) in your ci/ci-setenv.sh.  That's how this function knows, when BRAND is missing,
# whether to complain and quit or to default and keep going.
check_brand () {
    local default=$1
    if [[ "$BRAND" == "" ]]; then
        if [[ "$UNSET_BRAND_MATTERS" != "" ]]; then
            echo "BRAND environment variable is not set, but brand is required to continue.  Stopping..."
            catchable_exit 1
        else
            export BRAND="$default" # should execute only in development
        fi
    fi
}
