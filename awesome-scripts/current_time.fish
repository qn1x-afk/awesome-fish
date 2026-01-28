function currentTime
    # Get current time in 12-hour format with AM/PM
    set -l current_time (date +"%I:%M %p")
    set -l day (date +"%A")
    set -l date (date +"%B %d, %Y")
    
    # Display with some styling
    set_color -o blue
    echo -n "🕒 Current Time: "
    set_color -o yellow
    echo -n "$current_time"
    set_color normal
    echo -n " on "
    set_color -o green
    echo -n "$day"
    set_color normal
    echo -n ", "
    set_color -o cyan
    echo "$date"
    set_color normal
end
