### GIT

We should use source code management system for 
* version control
* Track the changes
* Review the changes
* Security and backup
* Branching
* Collaboration

- Git is a popular distributed/decentralised control system

#### Centralized System Disadvantages
* Single point of failure </br>
    It means centralised system can't maintain multiple copies. If the central server is down or crashed entire history is gone.
* Limited offline Access </br>
    You should always connect with internet to push the changes
* Risk of Data Loss </br>
    If a developer accidentally commits or pushes incorrect or unfinished changes to the central repository, it can affect the entire team's codebase. This makes it crucial to be cautions and vigilant when commiting changes.
* Many more </br>
     Branching and working together is very difficult in centralised systems.

#### Distributed Systems
* Distributed version control system always have local copy in every developer laptop, so the history is preserved everywhere.
* Single laptop is enough when the entire system is crashed including Git server.
* Staging area is there where can selectively send the changes to the central repo. He can send completed changes and keep working on in-progress features.

#### SSH Authentication to GitHub
`ssh -i <private-key> username@IP`

#### SSH Authentication to GitHub
1. Import the public key in github server </br>
2. .ssh folder uin user directory </br>
       create a file called configno extensions like config.txt </br>

If you have existing folder, how can you psuh to GitHub </br>
1. Git init
2. Create repo in github server
3. Connect git local repo and central repo through 
       `git remote add origin <use-ssh-url>` </br>

changing url </br>
`git remote set-url <use-http-url>`

---

`#!/bin/bash - shebang`
- Inform linux server, how to execute script through shebang

- bash : shell
- sh script-name.sh

### Variables
DRY - Don't repeat yourself. </br>

* Instead of defining values inside the script directly you can follow:
person=Sumati and you can use it in script like $person so if you want to change person name you just have to change it once where you have defined. </br>

* we can pass values as arguments also while running script, so in script define
person=$1, it will take argument one value sh scriptname.sh Sumati. </br>

1. declaring inside the script 
2. how to execute a command inside shell script and get the output
3. you can always get the values of variables from command line

* To run system commands in shell script
`DATE=$(date)` -> Shell script will run command inside $() and stores output in DATE </br>

`read`: It takes input from user
`read -s`: If you don't want to show entered details in terminal

`In shell, we don't have to mention data type explicitly`

1. number is a general data type
2. boolean 0 and 1
   0 - failure
   1 - success
3. array - it can hold multiple values

