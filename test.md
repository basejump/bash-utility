<!-- START generate_readme.sh generated SHDOC please keep comment here to allow auto update -->
<!-- DO NOT EDIT THIS SECTION, INSTEAD RE-RUN generate_readme.sh TO UPDATE -->
## Array

Functions for array operations and manipulations.

---

### array.contains()

Check if item exists in the given array.

#### 🔌 Arguments

- **$1** | (string) |  Item to search (needle).
- **$2** | (array) |  Array to be searched (haystack).

#### 💡 Return codes

- **0** 🎯 - If successful.
- **1** 💥 - If no match found in the array.
- **2** 💥 - Function missing arguments.

#### Example

```bash
 array=("a" "b" "c")
 array.contains "c" ${array[@]}
 #Output
 0
```

---

### array.dedupe()

Remove duplicate items from the array.

#### 🔌 Arguments

- **$1** | (array) |  Array to be deduped.

#### 💡 Return codes

- **0** 🎯 - If successful.
- **2** 💥 - Function missing arguments.

#### 🖨 Stdout output

-  Deduplicated array.

#### Example

```bash
 array=("a" "b" "a" "c")
 printf "%s" "$(array.dedupe ${array[@]})"
 #Output
 a
 b
 c
```

---

### array.is_empty()

Check if a given array is empty.

#### 🔌 Arguments

- **$1** | (array) |  Array to be checked.

#### 💡 Return codes

- **0** 🎯 - If the given array is empty.
- **2** 💥 - If the given array is not empty.

#### Example

```bash
  array=("a" "b" "c" "d")
  array.is_empty "${array[@]}"
```

---

### array.join()

Join array elements with a string.
the output is a string containing a string representation of all the array elements in the same order,
with the $2 glue string between each element.

#### 🔌 Arguments

- **$1** | (string) | String to join the array elements (glue).
- **$2** | (array) |  The array to be joined with glue string.

#### 💡 Return codes

- **0** 🎯 If successful.
- **2** 💥 Function missing arguments.

#### 🖨 Stdout output

-  string representation of all the array elements

#### Example

```bash
  array=("a" "b" "c" "d")
  printf "%s" "$(array.join "," "${array[@]}")"
  #Output
  a,b,c,d
  printf "%s" "$(array.join "" "${array[@]}")"
  #Output
  abcd
```

---

### array.reverse()

Return an array with elements in reverse order.

#### 🔌 Arguments

- **$1** | (array) |  The input array.

#### 💡 Return codes

- **0** 🎯  If successful.
- **2** 💥 Function missing arguments.

#### 🖨 Stdout output

-  The reversed array.

#### Example

```bash
  array=(1 2 3 4 5)
  printf "%s" "$(array.reverse "${array[@]}")"
  #Output
  5 4 3 2 1
```

---

### array.random_element()

Returns a random item from the array.

#### 🔌 Arguments

- **$1** | (array) |  The input array.

#### 💡 Return codes

- **0** 🎯 If successful.
- **2** 💥 Function missing arguments.

#### 🖨 Stdout output

-  Random item out of the array.

#### Example

```bash
  array=("a" "b" "c" "d")
  printf "%s\n" "$(array.random_element "${array[@]}")"
  #Output
  c
```

---

### array.sort()

Sort an array from lowest to highest.

#### 🔌 Arguments

- **$1** | (string) | array The input array.

#### 💡 Return codes

- **0** 🎯  If successful.
- **2** 💥 Function missing arguments.

#### 🖨 Stdout output

-  sorted array.

#### Example

```bash
  sarr=("a c" "a" "d" 2 1 "4 5")
  array.array_sort "${sarr[@]}"
  #Output
  1
  2
  4 5
  a
  a c
  d
```

---

### array.rsort()

Sort an array in reverse order (highest to lowest).

#### 🔌 Arguments

- **$1** | (string) | array The input array.

#### 💡 Return codes

- **0** 🎯  If successful.
- **2** 💥 Function missing arguments.

#### 🖨 Stdout output

-  reverse sorted array.

#### Example

```bash
  sarr=("a c" "a" "d" 2 1 "4 5")
  array.array_sort "${sarr[@]}"
  #Output
  d
  a c
  a
  4 5
  2
  1
```

---

### array.bsort()

Bubble sort an integer array from lowest to highest.
This sort does not work on string array.

#### 🔌 Arguments

- **$1** | (array) |  The input array.

#### 💡 Return codes

- **0** 🎯  If successful.
- **2** 💥 Function missing arguments.

#### 🖨 Stdout output

-  bubble sorted array.

#### Example

```bash
  iarr=(4 5 1 3)
  array.bsort "${iarr[@]}"
  #Output
  1
  3
  4
  5
```

---

### array.merge()

Merge two arrays.
Pass the variable name of the array instead of value of the variable.

#### 🔌 Arguments

- **$1** | (string) | string variable name of first array.
- **$2** | (string) | string variable name of second array.

#### 💡 Return codes

- **0** 🎯 - If successful.
- **2** 💥 - Function missing arguments.

#### 🖨 Stdout output

-  Merged array.

#### Example

```bash
  a=("a" "c")
  b=("d" "c")
  array.merge "a[@]" "b[@]"
  #Output
  a
  c
  d
  c
```


## Check

Helper functions.

---

### check.command_exists()

Check if the command exists in the system.

#### 🔌 Arguments

- **$1** | (string) | string Command name to be searched.

#### Example

```bash
check.command_exists "tput"
```

---

### check.is_sudo()

Check if the script is executed with sudo privilege.

*Function has no arguments.*

#### Example

```bash
check.is_sudo
```


## Collection

(Experimental) Functions to iterates over a list of elements, yielding each in turn to an iteratee function.

---

### collection::each()

Iterates over elements of collection and invokes iteratee for each element.
Input to the function can be a pipe output, here-string or file.

#### 🔌 Arguments

- **$1** | (string) | string Iteratee function.

#### 🖨 Stdout output

-  Output of iteratee function.

#### Example

```bash
test_func(){
   printf "print value: %s\n" "$1"
   return 0
 }
arr1=("a b" "c d" "a" "d")
printf "%s\n" "${arr1[@]}" | collection::each "test_func"
collection::each "test_func"  < <(printf "%s\n" "${arr1[@]}") #alternative approach
#output
 print value: a b
 print value: c d
 print value: a
 print value: d
```

#### Example

```bash
# If other function from this library is already used to process the array.
# Then following method could be used to pass the array to the function.
out=("$(array::dedupe "${arr1[@]}")")
collection::each "test_func"  <<< "${out[@]}"
```

---

### collection::every()

Checks if iteratee function returns truthy for all elements of collection. Iteration is stopped once predicate returns false.
Input to the function can be a pipe output, here-string or file.

#### 🔌 Arguments

- **$1** | (string) | string Iteratee function.

#### Example

```bash
arri=("1" "2" "3" "4")
printf "%s\n" "${arri[@]}" | collection::every "variable::is_numeric"
```

---

### collection::filter()

Iterates over elements of array, returning all elements where iteratee returns true.
Input to the function can be a pipe output, here-string or file.

#### 🔌 Arguments

- **$1** | (string) | string Iteratee function.

#### 🖨 Stdout output

-  array values matching the iteratee function.

#### Example

```bash
arri=("1" "2" "3" "a")
printf "%s\n" "${arri[@]}" | collection::filter "variable::is_numeric"
#output
1
2
3
```

---

### 

Iterates over elements of collection, returning the first element where iteratee returns true.
Input to the function can be a pipe output, here-string or file.

#### Example

```bash
arr=("1" "2" "3" "a")
check_a(){
    [[ "$1" = "a" ]]
}
---

### collection::find()

#### 🔌 Arguments

- **$1** | (string) | string Iteratee function.

#### 🖨 Stdout output

-  first array value matching the iteratee function.

printf "%s\n" "${arr[@]}" | collection::find "check_a"
#Output
a
```

---

### collection::invoke()

Invokes the iteratee with each element passed as argument to the iteratee.
Input to the function can be a pipe output, here-string or file.

#### 🔌 Arguments

- **$1** | (string) | string Iteratee function.

#### 🖨 Stdout output

-  Output from the iteratee function.

#### Example

```bash
opt=("-a" "-l")
printf "%s\n" "${opt[@]}" | collection::invoke "ls"
```

---

### 

Creates an array of values by running each element in array through iteratee.
Input to the function can be a pipe output, here-string or file.

#### Example

```bash
arri=("1" "2" "3")
add_one(){
  i=${1}
  i=$(( i + 1 ))
  printf "%s\n" "$i"
}
---

### collection::map()

#### 🔌 Arguments

- **$1** | (string) | string Iteratee function.

#### 🖨 Stdout output

-  Output result of iteratee on value.

printf "%s\n" "${arri[@]}" | collection::map "add_one"
```

---

### collection::reject()

The opposite of filter function; this method returns the elements of collection that iteratee does not return true.
Input to the function can be a pipe output, here-string or file.

#### 🔌 Arguments

- **$1** | (string) | string Iteratee function.

#### 🖨 Stdout output

-  array values not matching the iteratee function.

#### Example

```bash
arri=("1" "2" "3" "a")
printf "%s\n" "${arri[@]}" | collection::reject "variable::is_numeric"
#Ouput
a
```

#### See also

- [collection::filter](#collectionfilter)

---

### collection::some()

Checks if iteratee returns true for any element of the array.
Input to the function can be a pipe output, here-string or file.

#### 🔌 Arguments

- **$1** | (string) | string Iteratee function.

#### Example

```bash
arr=("a" "b" "3" "a")
printf "%s\n" "${arr[@]}" | collection::reject "variable::is_numeric"
```


## Date

Functions for manipulating dates.

---

### date::now()

Get current time in unix timestamp.

*Function has no arguments.*

#### 🖨 Stdout output

-  current timestamp.

#### Example

```bash
echo "$(date::now)"
#Output
1591554426
```

---

### date::epoc()

convert datetime string to unix timestamp.

#### 🔌 Arguments

- **$1** | (string) | string date time in any format.

#### 🖨 Stdout output

-  timestamp for specified datetime.

#### Example

```bash
echo "$(date::epoc "2020-07-07 18:38")"
#Output
1594143480
```

---

### date::add_days_from()

Add number of days from specified timestamp.
If number of days not specified then it defaults to 1 day.

#### 🔌 Arguments

- **$1** | (string) | int unix timestamp.
- **$2** | (string) | int number of days (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::add_days_from "1594143480")"
#Output
1594229880
```

---

### date::add_months_from()

Add number of months from specified timestamp.
If number of months not specified then it defaults to 1 month.

#### 🔌 Arguments

- **$1** | (string) | int unix timestamp.
- **$2** | (string) | int number of months (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::add_months_from "1594143480")"
#Output
1596821880
```

---

### date::add_years_from()

Add number of years from specified timestamp.
If number of years not specified then it defaults to 1 year.

#### 🔌 Arguments

- **$1** | (string) | int unix timestamp.
- **$2** | (string) | int number of years (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::add_years_from "1594143480")"
#Output
1625679480
```

---

### date::add_weeks_from()

Add number of weeks from specified timestamp.
If number of weeks not specified then it defaults to 1 week.

#### 🔌 Arguments

- **$1** | (string) | int unix timestamp.
- **$2** | (string) | int number of weeks (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::add_weeks_from "1594143480")"
#Output
1594748280
```

---

### date::add_hours_from()

Add number of hours from specified timestamp.
If number of hours not specified then it defaults to 1 hour.

#### 🔌 Arguments

- **$1** | (string) | int unix timestamp.
- **$2** | (string) | int number of hours (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::add_hours_from "1594143480")"
#Output
1594147080
```

---

### date::add_minutes_from()

Add number of minutes from specified timestamp.
If number of minutes not specified then it defaults to 1 minute.

#### 🔌 Arguments

- **$1** | (string) | int unix timestamp.
- **$2** | (string) | int number of minutes (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::add_minutes_from "1594143480")"
#Output
1594143540
```

---

### date::add_seconds_from()

Add number of seconds from specified timestamp.
If number of seconds not specified then it defaults to 1 second.

#### 🔌 Arguments

- **$1** | (string) | int unix timestamp.
- **$2** | (string) | int number of seconds (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::add_seconds_from "1594143480")"
#Output
1594143481
```

---

### date::add_days()

Add number of days from current day timestamp.
If number of days not specified then it defaults to 1 day.

#### 🔌 Arguments

- **$1** | (string) | int number of days (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::add_days "1")"
#Output
1591640826
```

---

### date::add_months()

Add number of months from current day timestamp.
If number of months not specified then it defaults to 1 month.

#### 🔌 Arguments

- **$1** | (string) | int number of months (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::add_months "1")"
#Output
1594146426
```

---

### date::add_years()

Add number of years from current day timestamp.
If number of years not specified then it defaults to 1 year.

#### 🔌 Arguments

- **$1** | (string) | int number of years (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::add_years "1")"
#Output
1623090426
```

---

### date::add_weeks()

Add number of weeks from current day timestamp.
If number of weeks not specified then it defaults to 1 year.

#### 🔌 Arguments

- **$1** | (string) | int number of weeks (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::add_weeks "1")"
#Output
1592159226
```

---

### date::add_hours()

Add number of hours from current day timestamp.
If number of hours not specified then it defaults to 1 hour.

#### 🔌 Arguments

- **$1** | (string) | int number of hours (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::add_hours "1")"
#Output
1591558026
```

---

### date::add_minutes()

Add number of minutes from current day timestamp.
If number of minutes not specified then it defaults to 1 minute.

#### 🔌 Arguments

- **$2** | (string) | int number of minutes (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::add_minutes "1")"
#Output
1591554486
```

---

### date::add_seconds()

Add number of seconds from current day timestamp.
If number of seconds not specified then it defaults to 1 second.

#### 🔌 Arguments

- **$2** | (string) | int number of seconds (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::add_seconds "1")"
#Output
1591554427
```

---

### date::sub_days_from()

Subtract number of days from specified timestamp.
If number of days not specified then it defaults to 1 day.

#### 🔌 Arguments

- **$1** | (string) | int unix timestamp.
- **$2** | (string) | int number of days (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::sub_days_from "1594143480")"
#Output
1594057080
```

---

### date::sub_months_from()

Subtract number of months from specified timestamp.
If number of months not specified then it defaults to 1 month.

#### 🔌 Arguments

- **$1** | (string) | int unix timestamp.
- **$2** | (string) | int number of months (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::sub_months_from "1594143480")"
#Output
1591551480
```

---

### date::sub_years_from()

Subtract number of years from specified timestamp.
If number of years not specified then it defaults to 1 year.

#### 🔌 Arguments

- **$1** | (string) | int unix timestamp.
- **$2** | (string) | int number of years (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::sub_years_from "1594143480")"
#Output
1562521080
```

---

### date::sub_weeks_from()

Subtract number of weeks from specified timestamp.
If number of weeks not specified then it defaults to 1 week.

#### 🔌 Arguments

- **$1** | (string) | int unix timestamp.
- **$2** | (string) | int number of weeks (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::sub_weeks_from "1594143480")"
#Output
1593538680
```

---

### date::sub_hours_from()

Subtract number of hours from specified timestamp.
If number of hours not specified then it defaults to 1 hour.

#### 🔌 Arguments

- **$1** | (string) | int unix timestamp.
- **$2** | (string) | int number of hours (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::sub_hours_from "1594143480")"
#Output
1594139880
```

---

### date::sub_minutes_from()

Subtract number of minutes from specified timestamp.
If number of minutes not specified then it defaults to 1 minute.

#### 🔌 Arguments

- **$1** | (string) | int unix timestamp.
- **$2** | (string) | int number of minutes (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::sub_minutes_from "1594143480")"
#Output
1594143420
```

---

### date::sub_seconds_from()

Subtract number of seconds from specified timestamp.
If number of seconds not specified then it defaults to 1 second.

#### 🔌 Arguments

- **$1** | (string) | int unix timestamp.
- **$2** | (string) | int number of seconds (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::sub_seconds_from "1594143480")"
#Output
1594143479
```

---

### date::sub_days()

Subtract number of days from current day timestamp.
If number of days not specified then it defaults to 1 day.

#### 🔌 Arguments

- **$1** | (string) | int number of days (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::sub_days "1")"
#Output
1588876026
```

---

### date::sub_months()

Subtract number of months from current day timestamp.
If number of months not specified then it defaults to 1 month.

#### 🔌 Arguments

- **$1** | (string) | int number of months (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::sub_months "1")"
#Output
1559932026
```

---

### date::sub_years()

Subtract number of years from current day timestamp.
If number of years not specified then it defaults to 1 year.

#### 🔌 Arguments

- **$1** | (string) | int number of years (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::sub_years "1")"
#Output
1591468026
```

---

### date::sub_weeks()

Subtract number of weeks from current day timestamp.
If number of weeks not specified then it defaults to 1 week.

#### 🔌 Arguments

- **$1** | (string) | int number of weeks (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::sub_weeks "1")"
#Output
1590949626
```

---

### date::sub_hours()

Subtract number of hours from current day timestamp.
If number of hours not specified then it defaults to 1 hour.

#### 🔌 Arguments

- **$1** | (string) | int number of hours (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::sub_hours "1")"
#Output
1591550826
```

---

### date::sub_minutes()

Subtract number of minutes from current day timestamp.
If number of minutes not specified then it defaults to 1 minute.

#### 🔌 Arguments

- **$1** | (string) | int number of minutes (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::sub_minutes "1")"
#Output
1591554366
```

---

### date::sub_seconds()

Subtract number of seconds from current day timestamp.
If number of seconds not specified then it defaults to 1 second.

#### 🔌 Arguments

- **$1** | (string) | int number of seconds (optional).

#### 🖨 Stdout output

-  timestamp.

#### Example

```bash
echo "$(date::sub_seconds "1")"
#Output
1591554425
```

---

### date::format()

Format unix timestamp to human readable format.
If format string is not specified then it defaults to "yyyy-mm-dd hh:mm:ss" format.

#### 🔌 Arguments

- **$1** | (string) | int unix timestamp.
- **$2** | (string) | string format control characters based on `date` command (optional).

#### 🖨 Stdout output

-  formatted time string.

#### Example

```bash
echo echo "$(date::format "1594143480")"
#Output
2020-07-07 18:38:00
```


## Debug

Functions to facilitate debugging scripts.

---

### debug::print_array()

Prints the content of array as key value pair for easier debugging.
Pass the variable name of the array instead of value of the variable.

#### 🔌 Arguments

- **$1** | (string) | string variable name of the array.

#### 🖨 Stdout output

-  Formatted key value of array.

#### Example

```bash
array=(foo bar baz)
printf "Array\n"
printarr "array"
declare -A assoc_array
assoc_array=([foo]=bar [baz]=foobar)
printf "Assoc Array\n"
printarr "assoc_array"
#Output
Array
0 = foo
1 = bar
2 = baz
Assoc Array
baz = foobar
foo = bar
```

---

### debug::print_ansi()

Function to print ansi escape sequence as is.
This function helps debug ansi escape sequence in text by displaying the escape codes.

#### 🔌 Arguments

- **$1** | (string) | string input with ansi escape sequence.

#### 🖨 Stdout output

-  Ansi escape sequence printed in output as is.

#### Example

```bash
txt="$(tput bold)$(tput setaf 9)This is bold red text$(tput sgr0).$(tput setaf 10)This is green text$(tput sgr0)"
debug::print_ansi "$txt"
#Output
\e[1m\e[91mThis is bold red text\e(B\e[m.\e[92mThis is green text\e(B\e[m
```


## File

Functions for handling files.

---

### file::make_temp_file()

Create temporary file.
Function creates temporary file with random name. The temporary file will be deleted when script finishes.

*Function has no arguments.*

#### 🖨 Stdout output

-  file name of temporary file created.

#### Example

```bash
echo "$(file::make_temp_file)"
#Output
tmp.vgftzy
```

---

### file::make_temp_dir()

Create temporary directory.
Function creates temporary directory with random name. The temporary directory will be deleted when script finishes.

#### 🔌 Arguments

- **$1** | (string) | string Temporary directory prefix
- **$2** | (string) | string Flag to auto remove directory on exit trap (true)

#### 🖨 Stdout output

-  directory name of temporary directory created.

#### Example

```bash
echo "$(utility::make_temp_dir)"
#Output
tmp.rtfsxy
```

---

### file::name()

Get only the filename from string path.

#### 🔌 Arguments

- **$1** | (string) | string path.

#### 🖨 Stdout output

-  name of the file with extension.

#### Example

```bash
echo "$(file::name "/path/to/test.md")"
#Output
test.md
```

---

### file::basename()

Get the basename of file from file name.

#### 🔌 Arguments

- **$1** | (string) | string path.

#### 🖨 Stdout output

-  basename of the file.

#### Example

```bash
echo "$(file::basename "/path/to/test.md")"
#Output
test
```

---

### file::extension()

Get the extension of file from file name.

#### 🔌 Arguments

- **$1** | (string) | string path.

#### 🖨 Stdout output

-  extension of the file.

#### Example

```bash
echo "$(file::extension "/path/to/test.md")"
#Output
md
```

---

### file::dirname()

Get directory name from file path.

#### 🔌 Arguments

- **$1** | (string) | string path.

#### 🖨 Stdout output

-  directory path.

#### Example

```bash
echo "$(file::dirname "/path/to/test.md")"
#Output
/path/to
```

---

### file::full_path()

Get absolute path of file or directory.

#### 🔌 Arguments

- **$1** | (string) | string relative or absolute path to file/direcotry.

#### 🖨 Stdout output

-  Absolute path to file/directory.

#### Example

```bash
file::full_path "../path/to/file.md"
#Output
/home/labbots/docs/path/to/file.md
```

---

### file::mime_type()

Get mime type of provided input.

#### 🔌 Arguments

- **$1** | (string) | string relative or absolute path to file/directory.

#### 🖨 Stdout output

-  mime type of file/directory.

#### Example

```bash
file::mime_type "../src/file.sh"
#Output
application/x-shellscript
```

---

### file::contains_text()

Search if a given pattern is found in file.

#### 🔌 Arguments

- **$1** | (string) | string relative or absolute path to file/directory.
- **$2** | (string) | string search key or regular expression.

#### Example

```bash
file::contains_text "./file.sh" "^[ @[:alpha:]]*"
file::contains_text "./file.sh" "@file"
#Output
0
```


## Format

Functions to format provided input.

---

### format::human_readable_seconds()

Format seconds to human readable format.

#### 🔌 Arguments

- **$1** | (string) | int number of seconds.

#### 🖨 Stdout output

-  formatted time string.

#### Example

```bash
echo "$(format::human_readable_seconds "356786")"
#Output
4 days 3 hours 6 minute(s) and 26 seconds
```

---

### format::bytes_to_human()

Format bytes to human readable format.

#### 🔌 Arguments

- **$1** | (string) | int size in bytes.

#### 🖨 Stdout output

-  formatted file size string.

#### Example

```bash
echo "$(format::bytes_to_human "2250")"
#Output
2.19 KB
```

---

### format::strip_ansi()

Remove Ansi escape sequences from given text.

#### 🔌 Arguments

- **$1** | (string) | string Input text to be ansi stripped.

#### 🖨 Stdout output

-  Ansi stripped text.

#### Example

```bash
format::strip_ansi "\e[1m\e[91mThis is bold red text\e(B\e[m.\e[92mThis is green text.\e(B\e[m"
#Output
This is bold red text.This is green text.
```

---

### format::text_center()

Prints the given text to centre of terminal.

#### 🔌 Arguments

- **$1** | (string) | string Text to be printed.
- **$2** | (string) | string Filler symbol to be added to prefix and suffix of the text (optional). Defaults to space as filler.

#### 🖨 Stdout output

-  formatted text.

#### Example

```bash
format::text_center "This text is in centre of the terminal." "-"
```

---

### format::report()

Format String to print beautiful report.

#### 🔌 Arguments

- **$1** | (string) | string Text to be printed on the left.
- **$2** | (string) | string Text to be printed within the square brackets.

#### 🖨 Stdout output

-  formatted text.

#### Example

```bash
format::report "Initialising mission state" "Success"
#Output
Initialising mission state ....................................................................[ Success ]
```

---

### format::trim_text_to_term()

Trim given text to width of the terminal window.

#### 🔌 Arguments

- **$1** | (string) | string Text of first sentence.
- **$2** | (string) | string Text of second sentence (optional).

#### 🖨 Stdout output

-  trimmed text.

#### Example

```bash
format::trim_text_to_term "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat." "This is part of second sentence."
#Output
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod..This is part of second sentence.
```


## Interaction

Functions to enable interaction with the user.

---

### interaction::prompt_yes_no()

Prompt yes or no question to the user.

#### 🔌 Arguments

- **$1** | (string) | string The question to be prompted to the user.
- **$2** | (string) | string default answer \[yes/no\] (optional).

#### Example

```bash
interaction::prompt_yes_no "Are you sure to proceed" "yes"
#Output
Are you sure to proceed (y/n)? [y]
```

---

### interaction::prompt_response()

Prompt question to the user.

#### 🔌 Arguments

- **$1** | (string) | string The question to be prompted to the user.
- **$2** | (string) | string default answer (optional).

#### 🖨 Stdout output

-  User entered answer to the question.

#### Example

```bash
interaction::prompt_response "Choose directory to install" "/home/path"
#Output
Choose directory to install? [/home/path]
```


## Json

Simple json manipulation. These functions does not completely replace `jq` in any way.

---

### json::get_value()

Extract value from json based on key and position.
Input to the function can be a pipe output, here-string or file.

#### 🔌 Arguments

- **$1** | (string) | string id of the field to fetch.
- **$2** | (string) | int position of value to extract.Defaults to 1.(optional)

#### 🖨 Stdout output

-  string value of extracted key.

#### Example

```bash
json::get_value "id" "1" < json_file
json::get_value "id" <<< "${json_var}"
echo "{\"data\":{\"id\":\"123\",\"value\":\"name string\"}}" | json::get_value "id"
```


## Miscellaneous

Set of miscellaneous helper functions.

---

### misc::check_internet_connection()

Check if internet connection is available.

*Function has no arguments.*

#### Example

```bash
misc::check_internet_connection
```

---

### misc::get_pid()

Get list of process ids based on process name.

#### 🔌 Arguments

- **$1** | (string) | Name of the process to search.

#### 🖨 Stdout output

-  list of process ids.

#### Example

```bash
misc::get_pid "chrome"
#Ouput
25951
26043
26528
26561
```

---

### misc::get_uid()

Get user id based on username.

#### 🔌 Arguments

- **$1** | (string) | username to search.

#### 🖨 Stdout output

-  string uid for the username.

#### Example

```bash
misc::get_uid "labbots"
#Ouput
1000
```

---

### misc::generate_uuid()

Generate random uuid.

*Function has no arguments.*

#### 🖨 Stdout output

-  random generated uuid.

#### Example

```bash
misc::generate_uuid
#Ouput
65bc64d1-d355-4ffc-a9d9-dc4f3954c34c
```


## Operating System

Functions to detect Operating system and version.

---

### os::detect_os()

Identify the OS the function is run on.

*Function has no arguments.*

#### 🖨 Stdout output

-  Operating system name (linux, mac or windows).

#### Example

```bash
os::detect_os
#Output
linux
```

---

### os::detect_linux_distro()

Identify the distribution flavour of linux.

*Function has no arguments.*

#### 🖨 Stdout output

-  Linux OS distribution name (ubuntu, debian, suse, etc.,).

#### Example

```bash
os::detect_linux_distro
#Output
ubuntu
```

---

### os::detect_linux_version()

Identify the Linux version.

*Function has no arguments.*

#### 🖨 Stdout output

-  Linux OS version number (18.04, 20.04, etc.,).

#### Example

```bash
os::detect_linux_version
#Output
20.04
```

---

### os::detect_mac_version()

Identify the MacOS version.

*Function has no arguments.*

#### 🖨 Stdout output

-  MacOS version number (10.15.6, etc.,)

#### Example

```bash
os::detect_linux_version
#Output
10.15.7
```


## String

Functions for string operations and manipulations.

---

### string.trim()

Strip whitespace from the beginning and end of a string.

#### 🔌 Arguments

- **$1** | (string) | string The string to be trimmed.

#### 🖨 Stdout output

-  The trimmed string.

#### Example

```bash
echo "$(string::trim "   Hello World!   ")"
#Output
Hello World!
```

---

### string.split()

Split a string to array by a delimiter.

#### 🔌 Arguments

- **$1** | (string) | string The input string.
- **$2** | (string) | string The delimiter string.

#### 🖨 Stdout output

-  Returns an array of strings created by splitting the string parameter by the delimiter.

#### Example

```bash
array=( $(string::split "a,b,c" ",") )
printf "%s" "$(string::split "Hello!World" "!")"
#Output
Hello
World
```

---

### string.lstrip()

Strip characters from the beginning of a string.

#### 🔌 Arguments

- **$1** | (string) | string The input string.
- **$2** | (string) | string The characters you want to strip.

#### 🖨 Stdout output

-  Returns the modified string.

#### Example

```bash
echo "$(string::lstrip "Hello World!" "He")"
#Output
llo World!
```

---

### string.rstrip()

Strip characters from the end of a string.

#### 🔌 Arguments

- **$1** | (string) | string The input string.
- **$2** | (string) | string The characters you want to strip.

#### 🖨 Stdout output

-  Returns the modified string.

#### Example

```bash
echo "$(string::rstrip "Hello World!" "d!")"
#Output
Hello Worl
```

---

### string.to_lower()

Make a string lowercase.

#### 🔌 Arguments

- **$1** | (string) | string The input string.

#### 🖨 Stdout output

-  Returns the lowercased string.

#### Example

```bash
echo "$(string::to_lower "HellO")"
#Output
hello
```

---

### string::to_upper()

Make a string all uppercase.

#### 🔌 Arguments

- **$1** | (string) | string The input string.

#### 🖨 Stdout output

-  Returns the uppercased string.

#### Example

```bash
echo "$(string::to_upper "HellO")"
#Output
HELLO
```

---

### string::contains()

Check whether the search string exists within the input string.

#### 🔌 Arguments

- **$1** | (string) | string The input string.
- **$2** | (string) | string The search key.

#### Example

```bash
string::contains "Hello World!" "lo"
```

---

### string::starts_with()

Check whether the input string starts with key string.

#### 🔌 Arguments

- **$1** | (string) | string The input string.
- **$2** | (string) | string The search key.

#### Example

```bash
string::starts_with "Hello World!" "He"
```

---

### string::ends_with()

Check whether the input string ends with key string.

#### 🔌 Arguments

- **$1** | (string) | string The input string.
- **$2** | (string) | string The search key.

#### Example

```bash
string::ends_with "Hello World!" "d!"
```

---

### string::regex()

Check whether the input string matches the given regex.

#### 🔌 Arguments

- **$1** | (string) | string The input string.
- **$2** | (string) | string The search key.

#### Example

```bash
string::regex "HELLO" "^[A-Z]*$"
```


## Terminal

Set of useful terminal functions.

---

### terminal::is_term()

Check if script is run in terminal.

*Function has no arguments.*

---

### terminal::detect_profile()

Detect profile rc file for zsh and bash of current script running user.

*Function has no arguments.*

#### 🖨 Stdout output

-  path to the profile file.

---

### terminal::clear_line()

Clear the output in terminal on the specified line number.
This function clears line only on terminal.

#### 🔌 Arguments

- **$1** | (string) | Line number to clear. Defaults to 1. (optional)

#### 🖨 Stdout output

-  clear line ansi code.


## Validation

Functions to perform validation on given data.

---

### validation::email()

Validate whether a given input is a valid email address or not.

#### 🔌 Arguments

- **$1** | (string) | string input email address to validate.

#### Example

```bash
test='test@gmail.com'
validation::email "${test}"
echo $?
#Output
0
```

---

### validation::ipv4()

Validate whether a given input is a valid IP V4 address.

#### 🔌 Arguments

- **$1** | (string) | string input IPv4 address.

#### Example

```bash
ips='
     4.2.2.2
     a.b.c.d
     192.168.1.1
     0.0.0.0
     255.255.255.255
     255.255.255.256
     192.168.0.1
     192.168.0
     1234.123.123.123
     0.192.168.1
     '
for ip in $ips; do
   if validation::ipv4 $ip; then stat='good'; else stat='bad'; fi
   printf "%-20s: %s\n" "$ip" "$stat"
done
#Output
4.2.2.2             : good
a.b.c.d             : bad
192.168.1.1         : good
0.0.0.0             : good
255.255.255.255     : good
255.255.255.256     : bad
192.168.0.1         : good
192.168.0           : bad
1234.123.123.123    : bad
0.192.168.1         : good
```

---

### validation::ipv6()

Validate whether a given input is a valid IP V6 address.

#### 🔌 Arguments

- **$1** | (string) | string input IPv6 address.

#### Example

```bash
ips='
     2001:db8:85a3:8d3:1319:8a2e:370:7348
     fe80::1ff:fe23:4567:890a
     fe80::1ff:fe23:4567:890a%eth2
     2001:0db8:85a3:0000:0000:8a2e:0370:7334:foo:bar
     fezy::1ff:fe23:4567:890a
     ::
     2001:db8::
     '
for ip in $ips; do
  if validation::ipv6 $ip; then stat='good'; else stat='bad'; fi
  printf "%-50s= %s\n" "$ip" "$stat"
done
#Output
2001:db8:85a3:8d3:1319:8a2e:370:7348              = good
fe80::1ff:fe23:4567:890a                          = good
fe80::1ff:fe23:4567:890a%eth2                     = good
2001:0db8:85a3:0000:0000:8a2e:0370:7334:foo:bar   = bad
fezy::1ff:fe23:4567:890a                          = bad
::                                                = good
2001:db8::                                        = good
```

---

### validation::alpha()

Validate if given variable is entirely alphabetic characters.

#### 🔌 Arguments

- **$1** | (string) | string Value of variable to validate.

#### Example

```bash
test='abcABC'
validation::alpha "${test}"
echo $?
#Output
0
```

---

### validation::alpha_num()

Check if given variable contains only alpha-numeric characters.

#### 🔌 Arguments

- **$1** | (string) | string Value of variable to validate.

#### Example

```bash
test='abc123'
validation::alpha_num "${test}"
echo $?
#Output
0
```

---

### validation::alpha_dash()

Validate if given variable contains only alpha-numeric characters, as well as dashes and underscores.

#### 🔌 Arguments

- **$1** | (string) | string Value of variable to validate.

#### Example

```bash
test='abc-ABC_cD'
validation::alpha_dash "${test}"
echo $?
#Output
0
```

---

### validation::version_comparison()

Compares version numbers and provides return based on whether the value in equal, less than or greater.

#### 🔌 Arguments

- **$1** | (string) | string Version number to check (eg: 1.0.1)

#### Example

```bash
test='abc-ABC_cD'
validation::version_comparison "12.0.1" "12.0.1"
echo $?
#Output
0
```


## Variable

Functions for handling variables.

---

### variable::is_array()

Check if given variable is array.
Pass the variable name instead of value of the variable.

#### 🔌 Arguments

- **$1** | (string) | string name of the variable to check.

#### Example

```bash
arr=("a" "b" "c")
variable::is_array "arr"
#Output
0
```

---

### variable::is_numeric()

Check if given variable is a number.

#### 🔌 Arguments

- **$1** | (string) | mixed Value of variable to check.

#### Example

```bash
variable::is_numeric "1234"
#Output
0
```

---

### variable::is_int()

Check if given variable is an integer.

#### 🔌 Arguments

- **$1** | (string) | mixed Value of variable to check.

#### Example

```bash
variable::is_int "+1234"
#Output
0
```

---

### variable::is_float()

Check if given variable is a float.

#### 🔌 Arguments

- **$1** | (string) | mixed Value of variable to check.

#### Example

```bash
variable::is_float "+1234.0"
#Output
0
```

---

### variable::is_bool()

Check if given variable is a boolean.

#### 🔌 Arguments

- **$1** | (string) | mixed Value of variable to check.

#### Example

```bash
variable::is_bool "true"
#Output
0
```

---

### variable::is_true()

Check if given variable is a true.

#### 🔌 Arguments

- **$1** | (string) | mixed Value of variable to check.

#### Example

```bash
variable::is_true "true"
#Output
0
```

---

### variable::is_false()

Check if given variable is false.

#### 🔌 Arguments

- **$1** | (string) | mixed Value of variable to check.

#### Example

```bash
variable::is_false "false"
#Output
0
```

---

### variable::is_empty_or_null()

Check if given variable is empty or null.

#### 🔌 Arguments

- **$1** | (string) | mixed Value of variable to check.

#### Example

```bash
test=''
variable::is_empty_or_null $test
#Output
0
```

<!-- END generate_readme.sh generated SHDOC please keep comment here to allow auto update -->
