#!/bin/bash

project_dir="$(basename https://github.com/kodekloudhub/solar-system-9 .git)"


clone_project() {
  cd /home/bob/git/
  git clone https://github.com/kodekloudhub/solar-system-9.git
}
clone_project

find "/home/bob/git/${project_dir}" -type f | wc -l



//////////////////////////////////

#!/bin/bash
project=${1}
project_dir="$(basename ${project} .git)"

clone_project() {
  cd /home/bob/git/
  git clone ${project}
}

find_files() {
  find "/home/bob/git/${project_dir}" -type f | wc -l
}
clone_project
find_files




////////////////////////////////


#!/bin/bash
project=${1}
branch=${2}
project_dir="$(basename ${project} .git)"

clone_project() {
  if [ ! -d "/home/bob/git/${project_dir}" ]; then
    cd /home/bob/git/
    git clone ${project}
  fi
}

find_files() {
  find "/home/bob/git/${project_dir}" -type f | wc -l
}
clone_project
find_files




///////////////////////////////
This version of the script will be able to count the files on different branches of the same repo.

git checkout command needs to be executed from within the repo. So to make this work, follow below steps:

Update the clone_project function to add below commands after the clone command:

cd "${project_dir}"
git checkout "${branch}"

Then change the find command inside the find_files function to use “.” as the search path. This is needed because at the moment the find command gets called by the shell script, we’re already inside ${project_dir} directory.



#!/bin/bash
project=${1}
branch=${2}
project_dir="$(basename ${project} .git)"

clone_project() {
  if [ ! -d "/home/bob/git/${project_dir}" ]; then
    cd /home/bob/git/
    git clone ${project}
    cd "${project_dir}"
    git checkout "${branch}"
  fi
}

find_files() {
  find . -type f | wc -l
}
clone_project
find_files





///////////////////////////////
Now, let’s convert the previously added two commands to a function called git_checkout and then execute this function too.


#!/bin/bash
project=${1}
branch=${2}
project_dir="$(basename ${project} .git)"

clone_project() {
  if [ ! -d "/home/bob/git/${project_dir}" ]; then
    cd /home/bob/git/
    git clone ${project}
  fi
}
git_checkout() {
  cd "${project_dir}"
  git checkout "${branch}"
}

find_files() {
  find . -type f | wc -l
}
clone_project
git_checkout
find_files








///////////////////////////

When executed without passing a command line argument, the script returns an error message which might be unclear.

To fix this, we will use a guard clause that checks if the value of a variable is empty, for example:

if [[ -z "${var}" ]]; then
   echo "Variable is empty"
fi

This should be a straight forward implementation, as the value of a command line argument that isn’t passed defaults to empty string, making it suitable for this guard clause implementation.

Please add a check to verify if the project variable is empty, if the project variable is empty then the script should print Error: Git project is not specified to the screen and should exit with status 1.

After making the changes, please try to execute the script without passing the command line arguments.




#!/bin/bash
project="${1}"
branch="${2}"
if [[ -z "${project}" ]]; then
   echo "Error: Git project is not specified"
   exit 1
fi

project_dir="$(basename ${project} .git)"

clone_project() {
  if [ ! -d "/home/bob/git/${project_dir}" ]; then
    cd /home/bob/git/
    git clone "${project}"
  fi
}
git_checkout() {
  cd "/home/bob/git/${project_dir}"
  git checkout "${branch}"
}

find_files() {
  find . -type f | wc -l
}
clone_project
git_checkout
find_files

 
Great, now that we created a guard clause to check if the command line argument at position 1 is being passed or not, let’s run the script again, but this time we’ll pass a git repository URL https://github.com/kodekloudhub/webapp-color.git as first argument and and v2 branch as second argument.











/////////////

Git by itself, won’t produce an error if we don’t pass an argument to git checkout. The default behaviour of bash script is to assign an empty value to the command line arguments if not passed.

Let’s add a fix to the script, so that we only do a git checkout if the branch variable contains a value. For this, we’re going to use the -z flag again with if statement, but this time it will be a little different.

Since git uses a default branch as part of its normal behavior, the branch name should be an optional value. So instead of using the if statement as a Guard Clause technique, we will surround the git checkout function with an if statement. This way, git checkout will only run if we explicitly pass a value.

Below is a technique we can use for this:

if [[ ! -z "${var}" ]]; then
  echo "This variable isn't empty"
fi

Finally try to execute the script, it will not display any error even if you don't pass any branch argument.





#!/bin/bash
project="${1}"
branch="${2}"
if [[ -z "${project}" ]]; then
   echo "Error: Git project is not specified"
   exit 1
fi

project_dir="$(basename ${project} .git)"

clone_project() {
  if [ ! -d "/home/bob/git/${project_dir}" ]; then
    cd /home/bob/git/
    git clone "${project}"
  fi
}
git_checkout() {
  cd "/home/bob/git/${project_dir}"
  if [[ ! -z "${branch}" ]]; then
    git checkout "${branch}"
  fi
}

find_files() {
  find . -type f | wc -l
}
clone_project
git_checkout
find_files

sh clone_project.sh  https://github.com/kodekloudhub/webapp-color.git









/////////////
