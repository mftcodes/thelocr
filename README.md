# projectbowen
## Description
API to work with Minuchin

## Setting up the program and running it locally
1.  initialize the project from the root directory
    ```
    go mod init bowen
    go mod tidy
    ```
2. build all modules (`go build .` should finish without errors)
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
3. cd back to root, install managefs
    ```
    go install bowen
    ```
4. you may need to add to your PATH in order to call the compiled program from BASH
    ```
    export PATH=$PATH:$(dirname $(go list -f '{{.Target}}' .))
    ```
5. run the program
    ```
    bowen
    ```
7. Optional: clean up, run `go clean -modcache` to clean up install cache

## Why "Bowen"?
Former Marriage and Family Therpist (MFT) giving nod to the theorist(s) who got he whole MFT thing started. 

### To Be Continued...
