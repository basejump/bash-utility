#!/usr/bin/awk -f

# Varibles
# style = readme or doc
# toc = true or false
BEGIN {
    if (! style) {
        style = "doc"
    }

    if (! toc) {
        toc = 0
    }

    styles["empty", "from"] = ".*"
    styles["empty", "to"] = ""

    styles["h1", "from"] = ".*"
    styles["h1", "to"] = "# &"

    styles["h2", "from"] = ".*"
    styles["h2", "to"] = "## &"

    styles["h3", "from"] = ".*"
    styles["h3", "to"] = "### &"

    styles["h4", "from"] = ".*"
    styles["h4", "to"] = "#### &"

    styles["h5", "from"] = ".*"
    styles["h5", "to"] = "##### &"

    styles["code", "from"] = ".*"
    styles["code", "to"] = "```&"

    styles["/code", "to"] = "```"

    styles["argN", "from"] = "^(\\$[0-9])[ -]*\\(?+(\\w+)\\)?+"
    styles["argN", "to"] = "**\\1** | (\\2) |"
    # styles["argN", "to"] = "**\\1** | (\\2) | "

    styles["arg@", "from"] = "^\\$@ (\\S+)"
    styles["arg@", "to"] = "**...** (\\1):"

    styles["li", "from"] = ".*"
    styles["li", "to"] = "- &"
    # styles["li", "to"] = "&"

    styles["i", "from"] = ".*"
    styles["i", "to"] = "*&*"

    styles["anchor", "from"] = ".*"
    styles["anchor", "to"] = "[&](#&)"

    styles["exitcode", "from"] = "([>!]?[1-9]{1,3}) (.*)"
    styles["exitcode", "to"] = "**\\1** 💥 \\2"

    styles["exitcode0", "from"] = "([>!]?[0]{1}) (.*)"
    styles["exitcode0", "to"] = "**0** 🎯 \\2"

    styles["h_rule", "to"] = "---"

    styles["comment", "from"] = ".*"
    styles["comment", "to"] = "<!-- & -->"


    output_format["readme", "h1"] = "h2"
    output_format["readme", "h2"] = "h3"
    output_format["readme", "h3"] = "h4"
    output_format["readme", "h4"] = "h5"

    output_format["bashdoc", "h1"] = "h1"
    output_format["bashdoc", "h2"] = "h2"
    output_format["bashdoc", "h3"] = "h3"
    output_format["bashdoc", "h4"] = "h4"

    output_format["webdoc", "h1"] = "empty"
    output_format["webdoc", "h2"] = "h3"
    output_format["webdoc", "h3"] = "h4"
    output_format["webdoc", "h4"] = "h5"

}

function render(type, text) {
    if((style,type) in output_format){
        type = output_format[style,type]
    }
    return gensub( \
        styles[type, "from"],
        styles[type, "to"],
        "g",
        text \
    )
}

function render_list(item, anchor) {
    return "- [" item "](#" anchor ")"
}

function generate_anchor(text) {
    # https://github.com/jch/html-pipeline/blob/master/lib/html/pipeline/toc_filter.rb#L44-L45
    text = tolower(text)
    gsub(/[^[:alnum:]_ -]/, "", text)
    gsub(/ /, "-", text)
    return text
}

function reset() {
    has_example = 0
    has_args_heading = 0
    has_exitcode = 0
    has_stdout = 0

    content_desc = ""
    content_example  = ""
    content_args = ""
    content_exitcode = ""
    content_seealso = ""
    content_stdout = ""
}

function description_start() {
    in_description = 1
    in_example = 0
    reset()
    docblock = ""
}

/^[[:space:]]*# @internal/ {
    is_internal = 1
}

/^[[:space:]]*# @file/ {
    sub(/^[[:space:]]*# @file /, "")

    filedoc = "\n" render("h1", $0) "\n"
    if(style == "webdoc"){
        filedoc = filedoc render("comment", "file=" $0) "\n"
    }

}

/^[[:space:]]*# @brief/ {
    sub(/^[[:space:]]*# @brief /, "")
    if(style == "webdoc"){
        filedoc = filedoc render("comment", "brief=" $0) "\n"
    }
    filedoc = filedoc "\n" $0
}

# Description
/^[[:space:]]*# @description/ {
    description_start()
}

# Description start with #---
/^[[:space:]]*#\s*-{3}/ {
    description_start()
}

# Description start with ##
/^[[:space:]]*#\s?#/ {
    description_start()
}

in_description {
    # any one of these will stop the decription flow.
    # not a `# `, any `# @` thats not a @desc, any `# example` and any line thats not a `# ` comment
    if (/^[^[[:space:]]*#]/ || /^[[:space:]]*# @[^d]/ || /^[[:space:]]*# example/ || /^[[:space:]]*[^#]/) {
        if (!match(content_desc, /\n$/)) {
            content_desc = content_desc "\n"
        }
        in_description = 0
    } else {
        sub(/^[[:space:]]*# @description /, "")
        sub(/^\s*#\s*-{3,}[[:space:]]*/, "")
        sub(/^[[:space:]]*# /, "")
        sub(/^[[:space:]]*#\s?#/, "")
        sub(/^[[:space:]]*#$/, "")

        content_desc = content_desc "\n" $0
    }
}

in_example {

    if (! /^[[:space:]]*#[ ]{3}/) {

        in_example = 0

        content_example = content_example "\n" render("/code") "\n"

    } else {
        sub(/^[[:space:]]*#[ ]{3}/, "")

        content_example = content_example "\n" $0
    }
}

# Example @example
/^[[:space:]]*# @?example/ {
    in_example = 1
    content_example = content_example "\n" render("h3", "Example")
    content_example = content_example "\n\n" render("code", "bash")
}

/^[[:space:]]*# @arg/ {
    do_args = 1
}

# args in form # $1 -
/^[[:space:]]*# \$[1-9]/ {
    do_args = 1
}

do_args {
    if (!has_args_heading) {
        has_args_heading = 1
        content_args = content_args "\n" render("h3", "🔌 Arguments") "\n\n"
    }
    sub(/^[[:space:]]*#\s*@arg\s*/, "")
    sub(/^[[:space:]]*# /, "")
    $0 = render("argN", $0)
    # $0 = render("arg@", $0)
    content_args = content_args render("li", $0) "\n"
    do_args = 0
}


/^[[:space:]]*# @noargs/ {
    content_args = content_args "\n" render("i", "Function has no arguments.") "\n"
}

in_exitcodes {

    # for any line thats a pound and a number `# 0-9`
    if (/^[[:space:]]*#\s*[0-9]/) {
        sub(/^[[:space:]]*#\s*/, "")
        $0 = render("exitcode0", $0)
        $0 = render("exitcode", $0)
        content_exitcode = content_exitcode render("li", $0) "\n"
    } else {
        # break out on anything else
        in_exitcodes = 0
    }
}

/^[[:space:]]*# exitcodes/ {
    if (!has_exitcode) {
        has_exitcode = 1
        content_exitcode = content_exitcode "\n" render("h3", "💡 Exit codes") "\n\n"
    }
    in_exitcodes = 1
    # sub(/^[[:space:]]*# @exitcode /, "")

    # $0 = render("exitcode0", $0)
    # $0 = render("exitcode", $0)

    # content_exitcode = content_exitcode render("li", $0) "\n"
}

/^[[:space:]]*# @exitcode/ {
    if (!has_exitcode) {
        has_exitcode = 1

        content_exitcode = content_exitcode "\n" render("h3", "💡 Exit codes") "\n\n"
    }

    sub(/^[[:space:]]*# @exitcode /, "")

    $0 = render("exitcode0", $0)
    $0 = render("exitcode", $0)

    content_exitcode = content_exitcode render("li", $0) "\n"
}

/^[[:space:]]*# @see/ {
    sub(/[[:space:]]*# @see /, "")
    anchor = generate_anchor($0)
    $0 = render_list($0, anchor)

    content_seealso = content_seealso "\n" render("h3", "See also") "\n\n" $0 "\n"
}

/^[[:space:]]*# [@stdout|stdout:]/ {
    has_stdout = 1

    sub(/^[[:space:]]*# @stdout /, "")
    sub(/^[[:space:]]*# stdout: /, "")

    content_stdout = content_stdout "\n" render("h3", "🖨 Stdout output")
    content_stdout = content_stdout "\n\n" render("li", $0) "\n"
}

{
    docblock = content_desc content_args content_exitcode content_stdout content_example content_seealso
    if(style == "webdoc"){
        docblock = docblock "\n" render("h_rule") "\n"
    }
}

/^[ \t]*(function([ \t])+)?([a-zA-Z0-9_:-]+)([ \t]*)(\(([ \t]*)\))?[ \t]*\{/ && docblock != "" && !in_example {
    if (is_internal) {
        is_internal = 0
    } else {
        func_name = gensub(\
            /^[ \t]*(function([ \t])+)?([a-zA-Z0-9_:-]+)[ \t]*\(.*/, \
            "\\3()", \
            "g" \
        )
        doc = doc "\n---\n" #hr sep
        doc = doc "\n" render("h2", func_name) "\n" docblock
        if (toc) {
            url = generate_anchor(func_name)

            content_idx = content_idx "\n" "- [" func_name "](#" url ")"
        }
    }

    docblock = ""
    reset()
}

END {
    if (filedoc != "") {
        print filedoc
    }

    if (toc) {
        print ""
        print render("h2", "Table of Contents")
        print content_idx
        print ""
        print render("h_rule")
    }

    print doc
}
