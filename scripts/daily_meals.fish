
function dailyMeals    
    # Get current date in YYYY-MM-DD format
    set -l today (date +"%Y-%m-%d")
    set -l today_str (date +"%B %d")
    set -l menu_file "$DATA_FOLDER/.daily_menu"

    # Check if we already have a menu for today
    if test -f $menu_file
        set -l saved_date (head -n 1 $menu_file)
        if test "$saved_date" = "$today"
            # If menu exists for today, display it
            tail -n +2 $menu_file
            return
        end
    end

    # If we get here, we need to generate a new menu
    set -l day (date +"%A")

    set -l breakfasts "Avocado Toast 🥑" "Pancakes 🥞" "French Toast 🍞" "Oatmeal 🥣" "Bagel with Cream Cheese 🥯" "Scrambled Eggs 🍳" "Yogurt with Berries 🍓" "Smoothie Bowl 🥝" "Fruit Salad 🍉"
    set -l lunches "Caesar Salad 🥗" "Burger!!! 🍔" "Sushi Rolls 🍣" "Margherita Pizza 🍕" "Chicken Wrap 🌯" "Poke Bowl 🍚" "Falafel Pita 🥙" "Ramen 🍜" "Chipotle Bowl 🥗" "Club Sandwich 🥪"
    set -l dinners "Grilled Salmon 🐟" "Pasta Carbonara 🍝" "Beef Stir Fry 🥩" "Apple Risotto 🍚" "Taco Night 🌮" "Butter Chicken 🍗" "Curry 🍛" "Steak with Potatoes 🥩" "Sushi Platter 🍣" "Enchiladas 🌶️"

    # Get random items
    set -l bf (random 1 (count $breakfasts))
    set -l lc (random 1 (count $lunches))
    set -l dn (random 1 (count $dinners))

    # Create menu with fixed-width columns
    set -l menu "🍽️ $(set_color yellow) $day's Menu$(set_color normal): $(set_color blue)$today_str$(set_color normal) 🍽️"
    set menu "$menu\n    » $(set_color cyan)Breakfast$(set_color normal):  $breakfasts[$bf]"
    set menu "$menu\n    » $(set_color cyan)Lunch$(set_color normal):      $lunches[$lc]"
    set menu "$menu\n    » $(set_color cyan)Dinner$(set_color normal):     $dinners[$dn]"
    
    # Save to file
    echo $today > $menu_file
    echo -e $menu >> $menu_file
    echo -e "$menu"
end
