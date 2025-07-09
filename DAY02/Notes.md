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
2. .ssh folder uin user directory
       create a file called configno extensions like config.txt

If you have existing folder, how can you psuh to GitHub
1. Git init
2. Create repo in github server
3. Connect git local repo and central repo through 
       `git remote add origin <use-ssh-url>`

changing url
`git remote set-url <use-http-url>`

---

`#!/bin/bash - shebang`
- Inform linux server, how to execute script through shebang

- bash : shell
- sh script-name.sh