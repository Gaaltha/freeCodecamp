def find_minutes_period(time):
    # parse the time string
    period = None
    if "M" in time:
        period = time[time.find("M")-1:]
        time = time[:time.find("M")-1]

    hours = int(time[:time.find(":")])
    minutes = int(time[time.find(":") + 1:])

    total_minutes = hours*60 + minutes
   
    return (total_minutes, period)



def add_time(start, duration, day=None):
    # the list of days in a week
    week = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    # find total minutes and period for each parameter
    start_mn, start_period = find_minutes_period(start)[0], find_minutes_period(start)[1]
    duration_mn = find_minutes_period(duration)[0]

    # add the total of minutes
    # Format the new_time
    new_time_mn = start_mn + duration_mn 
    new_time = f"{new_time_mn//60%12}:{new_time_mn%60:02d}"

    # Change 00:00 to 12:00
    if new_time[0] == "0":
        new_time = "12" + new_time[1:]
        # Transition from 12:59PM to 00:00AM
        if start_period == "PM":
            duration_mn += 1440
    days_later = duration_mn // 1440
    r_days_later = duration_mn / 1440
    

    # AM or PM
    # Count the number of half days added
    new_time_period = ""
    if start_period == "PM":
        # An uneven number of half days means new_time and start are in different periods
        if new_time_mn//720%2 != 0:
            new_time_period = "AM"
            new_time += " " + new_time_period
        else:
            new_time += " " + start_period
    # If start_period is AM
    else:
        if new_time_mn//720%2 != 0:
            new_time_period = "PM"
            new_time += " " + new_time_period
        else:
            new_time += " " + start_period

    
    
    # Name of the new day 
    new_day_name = ""
    if day:
        day_index = week.index(day.title())
        try:
            new_index = days_later + day_index
            new_day_name = week[new_index]
        # If index out of range, use negative indices
        except IndexError:
            r_index = r_days_later + day_index
            new_index = -(r_index%len(week))//1
            new_day_name = week[int(new_index)]
        new_time += ", " +  new_day_name
    


    # Count days passed
    day_counter = ""
    if days_later < 1:
        if start_period == "PM" and new_time_period == "AM":
            day_counter =  "(next day)"
    elif days_later == 1:
        day_counter = "(next day)"
    elif days_later > 1:
        day_counter = f"({round(days_later)} days later)"
        if round(r_days_later, 2) > days_later:
            day_counter = f"({int(-(-r_days_later//1))} days later)"
    new_time += " " + day_counter
        

    return new_time.strip()



print(add_time('3:30 PM', '2:12'))
print(add_time('11:55 AM', '3:12'))
print(add_time('2:59 AM', '24:00'))
print(add_time('11:59 PM', '24:05'))
print(add_time('8:16 PM', '466:02'))
print(add_time('3:30 PM', '2:12', 'Monday'))
print(add_time('2:59 AM', '24:00', 'saturDay'))
print(add_time('11:59 PM', '24:05', 'Wednesday'))

# fixed week index, solution in ugly
print(add_time('8:16 PM', '466:02', 'tuesday'))

# test for the 12th hour
test = add_time('11:59 PM', '0:01')
test_2 = add_time("11:59 AM", "0:01")
print(test)
print(test_2)

