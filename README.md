# projectbowen
## Description
API to deliver community resource information. 

## Setting up the program and running it locally
1. setup MySQL in Docker
    1. `cd` into `docker` directory and run `docker compose up`
    2. once container is spun up, connect to MySQL
        1. HOST: `localhost:3308`
        2. DB: `minuchin`
        3. Username: `root`
        4. Password: *obtain from docker yaml file*
    3. run the script: `docker/dbDump/initDB.sql`
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
