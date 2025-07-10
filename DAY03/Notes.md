if(today="sunday") {
    print holiday
}
else {
    print happy learning
}

if(expression) {
    expression=true
}
else {
    expression=false
}

algorithm
install git
1. you should be root user, otherwise it will fail

`id -u`: for root user root id is always zero and for normal user is it not zero

install mysql
1. check root user or not
2. If not root user, exit the program and inform user to run with sudo access
3. If root user install mysql
root user id -u -> 0
normal user id -u -> not 0
