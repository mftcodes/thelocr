# projectbowen
## Description
API to deliver community resource information. 

I worked for over 10 years in Community Mental Health and it was always a struggle to obtain, and maintain, an up-to-date list of community based resources. Many clients required far more than I was able to give them, and many of those needs are met through community based programs, services, and connections. There simply is not a one-stop place to see what all is out there to be able to provide the clients with the information they need. We do have 211 and it is a great service; however, one of the biggest complaints I heard about 211 was how quickly some of their resources were out of date. Additionally, outside of Michigan (and probably some other states) the only way to get connected is to call 211 and get the support you need. This is a great service, and one I have no desire to replace. At the same time, sometimes, it is just easier to grab your phone, or get on a library computer, and find what you need without having to be social.

My hope is that this API is the base building block to begin addressing this problem, and is but a small piece of a much larger road map. 

This is a work in progress...

## Setting up the program and running it locally
1. setup MySQL in Docker
    1. `cd` into `docker` directory and run `docker compose up`
    2. once container is spun up, connect to MySQL
        1. HOST: `localhost:3308`
        2. DB: `minuchin`
        3. Username: `root`
        4. Password: *obtain from docker yaml file*
    3. run the script: `docker/dbDump/initDB.sql`
        1. This will set up the db and table structures, as well as stub in a small data set
        2. A longer script for seed the db with a larger data set is currently being worked on and will be added to the repo when ready
2. initialize the project from the root directory
    ```
    go mod init bowen
    go mod tidy
    ```
3. build all modules (`go build .` should finish without errors)
    1. cd into sub-directories and build, e.g. `models` 
        ```
        cd models
        go build .
        ```
    2. rinse and repeat
        ```
        cd ../{next sub-directory}
        go build .
        ```
4. cd back to root, install managefs
    ```
    go install bowen
    ```
5. you may need to add to your PATH in order to call the compiled program from BASH
    ```
    export PATH=$PATH:$(dirname $(go list -f '{{.Target}}' .))
    ```
6. run the program
    ```
    bowen
    ```
7. Optional: clean up, run `go clean -modcache` to clean up install cache

## Why "Bowen"?
Simply a former Marriage and Family Therpist (MFT) giving nod to the theorist(s) who started the MFT field. 

### To Be Continued...
