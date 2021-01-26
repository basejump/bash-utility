---
title : File 
description : Functions for handling files. 
date : 2020-06-12T01:11:01+01:00
lastmod : 2021-01-26T13:01:45+00:00
---
<!-- START generate_readme.sh generated SHDOC please keep comment here to allow auto update -->


Functions for handling files.

### Table of Contents

- [file::make_temp_file()](#filemake_temp_file)
- [file::make_temp_dir()](#filemake_temp_dir)
- [file::name()](#filename)
- [file::basename()](#filebasename)
- [file::extension()](#fileextension)
- [file::dirname()](#filedirname)
- [file::full_path()](#filefull_path)
- [file::mime_type()](#filemime_type)
- [file::contains_text()](#filecontains_text)

---

### file::make_temp_file()

Create temporary file.
Function creates temporary file with random name. The temporary file will be deleted when script finishes.

*Function has no arguments.*

#### Exit codes

- **0**:  If successful.
- **1**: If failed to create temp file.

#### Output on stdout

- file name of temporary file created.

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

#### Arguments

- **$1** (string): Temporary directory prefix
- $2  string Flag to auto remove directory on exit trap (true)

#### Exit codes

- **0**:  If successful.
- **1**: If failed to create temp directory.
- **2**: Missing arguments.

#### Output on stdout

- directory name of temporary directory created.

#### Example

```bash
echo "$(utility::make_temp_dir)"
#Output
tmp.rtfsxy
```

---

### file::name()

Get only the filename from string path.

#### Arguments

- **$1** (string): path.

#### Exit codes

- **0**:  If successful.
- **2**: Function missing arguments.

#### Output on stdout

- name of the file with extension.

#### Example

```bash
echo "$(file::name "/path/to/test.md")"
#Output
test.md
```

---

### file::basename()

Get the basename of file from file name.

#### Arguments

- **$1** (string): path.

#### Exit codes

- **0**:  If successful.
- **2**: Function missing arguments.

#### Output on stdout

- basename of the file.

#### Example

```bash
echo "$(file::basename "/path/to/test.md")"
#Output
test
```

---

### file::extension()

Get the extension of file from file name.

#### Arguments

- **$1** (string): path.

#### Exit codes

- **0**:  If successful.
- **1**: If no extension is found in the filename.
- **2**: Function missing arguments.

#### Output on stdout

- extension of the file.

#### Example

```bash
echo "$(file::extension "/path/to/test.md")"
#Output
md
```

---

### file::dirname()

Get directory name from file path.

#### Arguments

- **$1** (string): path.

#### Exit codes

- **0**:  If successful.
- **2**: Function missing arguments.

#### Output on stdout

- directory path.

#### Example

```bash
echo "$(file::dirname "/path/to/test.md")"
#Output
/path/to
```

---

### file::full_path()

Get absolute path of file or directory.

#### Arguments

- **$1** (string): relative or absolute path to file/direcotry.

#### Exit codes

- **0**:  If successful.
- **1**:  If file/directory does not exist.
- **2**: Function missing arguments.

#### Output on stdout

- Absolute path to file/directory.

#### Example

```bash
file::full_path "../path/to/file.md"
#Output
/home/labbots/docs/path/to/file.md
```

---

### file::mime_type()

Get mime type of provided input.

#### Arguments

- **$1** (string): relative or absolute path to file/directory.

#### Exit codes

- **0**:  If successful.
- **1**:  If file/directory does not exist.
- **2**: Function missing arguments.
- **3**: If file or mimetype command not found in system.

#### Output on stdout

- mime type of file/directory.

#### Example

```bash
file::mime_type "../src/file.sh"
#Output
application/x-shellscript
```

---

### file::contains_text()

Search if a given pattern is found in file.

#### Arguments

- **$1** (string): relative or absolute path to file/directory.
- **$2** (string): search key or regular expression.

#### Exit codes

- **0**:  If given search parameter is found in file.
- **1**:  If search paramter not found in file.
- **2**: Function missing arguments.

#### Example

```bash
file::contains_text "./file.sh" "^[ @[:alpha:]]*"
file::contains_text "./file.sh" "@file"
#Output
0
```

---

<!-- END generate_readme.sh generated SHDOC please keep comment here to allow auto update -->