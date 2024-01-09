# projectbowen

## Description

API to deliver community resource information.

I worked for over 10 years in Community Mental Health and it was always a struggle to obtain, and maintain, an up-to-date list of community based resources. Many clients required far more than I was able to give them, and many of those needs are met through community based programs, services, and connections. There simply is not a one-stop place to see what all is out there to be able to provide the clients with the information they need. We do have 211 and it is a great service; however, one of the biggest complaints I heard about 211 was how quickly some of their resources were out of date. Additionally, outside of Michigan (and probably some other states) the only way to get connected is to call 211 and get the support you need. This is a great service, and one I have no desire to replace. At the same time, sometimes, it is just easier to grab your phone, or get on a library computer, and find what you need without having to be social.

My hope is that this API is the base building block to begin addressing this problem, and is but a small piece of a much larger road map.

This is a work in progress...

## Setting up the program and running it locally

Go API is based on Go version `1.21.1`, and this must be installed. See [Go docs](https://go.dev/doc/install) for details on installation.

NOTE: You must have the API running in order for the front end to function.

### Go Back End API, Option 1

1. setup MySQL in Docker
   1. `cd` into `docker` directory and run `docker compose up`
   2. once container is spun up, connect to MySQL
      1. HOST: `localhost:3308`
      2. DB: `minuchin`
      3. Username: `root`
      4. Password: _obtain from docker yaml file_
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

### Go Back End API, Option 2: Running debugger in VSCodium

1. Need to create the `launch.json` file under the `Run and Debug` tab
2. Use the following configuration:
   ```
       "configurations": [
       {
           "name": "API ONLY",
           "type": "go",
           "request": "launch",
           "mode": "auto",
           "program": "{YOUR_PATH_TO}/bowen.go"
       }
   ]
   ```
   \*Be sure to update the program path
3. You should be able to use the green `Start Debugging` button, or use `F5` to begin debugging
4. Hit the API with Insomnia or Postman
5. This will also serve up the API for the front end
6. [Digital Ocean](https://www.digitalocean.com/community/tutorials/debugging-go-code-with-visual-studio-code) has a good article about debugging go that may be helpful here

### Running the vanilla HTML/CSS/JS Front End Web Server (VSCodium specific, and likely to be deleted soon)

1. Add the `Live Server` extension from `ritwickdey` found [here](https://open-vsx.org/extension/ritwickdey/LiveServer)
2. Open the file `./frontend/index.html`
3. Click `Go Live` at the bottom of the VSC window and web server should launch
4. If you run into problems here, read the `Live Server` docs

### Running ReactJS front end

1. Ensure you have dependencies NodeJS (>= 18.x.x) and NPM (created using v10.2.3) installed
2. Navigate to `./web` in the terminal
3. Run command `npm install`, and this should install dependencies
4. Run command `npm run dev` to start up server
5. Navigate to localhost url provided in terminal

## Why "Bowen"?

Simply a former Marriage and Family Therapist (MFT) giving nod to one of the theorists who helped start the MFT field.

### To Be Continued...
