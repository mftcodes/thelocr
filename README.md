# The Library of Online Community Resources (TheLOCR)

## Description

This project works toward a community driven and maintained Community Resource Repository for all types of services.

I worked for over 10 years in Community Mental Health and it was always a struggle to obtain, and maintain, an up-to-date list of community based resources. Many clients required far more than I was able to give them, and many of those needs are met through community based programs, services, and connections. There simply is not a one-stop place to see what all is out there to be able to provide the clients with the information they need. We do have 211 and it is a great service; however, one of the biggest complaints I heard about 211 was how quickly some of their resources were out of date. Additionally, outside of Michigan (and probably some other states) the only way to get connected is to call 211 and get the support you need. This is a great service, and one I have no desire to replace. However, sometimes, it is just simpler to grab your phone, or get on a library computer, and find what you need without having to be social.

My hope is that this app is the base building block to begin addressing this problem, and is small piece of a much larger road map.

This is a work in progress...

## Setting up the program and running it locally

Go API is based on Go version `1.21.1`, and this must be installed. See [Go docs](https://go.dev/doc/install) for details on installation.

For Windows OS we also recommend installing [Docker Desktop](https://www.docker.com/products/docker-desktop/) and [DBeaver](https://dbeaver.io/download/)

___NOTE___: You must have the API running in order for the front end to function.

## Database Setup:

### Setup MySQL in Docker

1.  `cd` into `docker` directory and run `docker compose up`
2.  once container is spun up, connect to MySQL\*:
    1. HOST: `localhost:3308`
    2. DB: `minuchin`
    3. Username: `root`
    4. Password: _obtain from docker yaml file_
3.  run the script: `docker/dbDump/initDB.sql`
    1. This will set up the db and table structures, as well as stub in a small data set
    2. A longer script for seed the db with a larger data set is currently being worked on and will be added to the repo when ready
4.  run the script: `docker/dbDump/initSProcs.sql`, which adds store procedures for `insert`, `search`, and `update`

#### Connect to MySql using DBeaver:

1.  install Dbeaver if you haven't already
2.  connect to the MySql Instance:
3.  HOST: `localhost:3308`
4.  DB: `minuchin`
5.  Username: `root`
6.  Password: _obtain from docker yaml file_
7.  Under `connection settings > driver properties >` set `allowPublicKeyRetrieval` to `TRUE`
8.  Open a query window for the db and run the initDB.sql script

## Go Back End API

### Option 1: Build, install, run

1. initialize the project from the root directory
   ```
   go mod init thelocr.go
   go mod tidy
   go mod vendor
   ```
2. build api
   ```
   go build .
   ```
3. install
   ```
   go install thelocr
   ```
4. you may need to add to your PATH in order to call the compiled program from BASH
   ```
   export PATH=$PATH:$(dirname $(go list -f '{{.Target}}' .))
   ```
5. run the program
   ```
   thelocr
   ```
6. Optional: clean up, run `go clean -modcache` to clean up install cache

### Option 2: Running debugger in VSCodium

1. Need to create the `launch.json` file under the `Run and Debug` tab
2. Use the following configuration:
   ```
   "configurations": [
       {
           "name": "API ONLY",
           "type": "go",
           "request": "launch",
           "mode": "auto",
           "program": "${workspaceFolder}/thelocr.go"
       }
   ]
   ```
   \*Be sure to update the program path
3. You should be able to use the green `Start Debugging` button, or use `F5` to begin debugging
4. Hit the API with Insomnia or Postman
5. This will also serve up the API for the front end
6. [Digital Ocean](https://www.digitalocean.com/community/tutorials/debugging-go-code-with-visual-studio-code) has a good article about debugging go that may be helpful here

### Running ReactJS front end

1. Ensure you have dependencies NodeJS (>= 18.x.x) and NPM (created using v10.2.3) installed
2. Navigate to `./web` in the terminal
3. Run command `npm install`, and this should install dependencies
4. Run command `npm run dev` to start up server
5. Navigate to localhost url provided in terminal

## Auth0

Signup and signin are dependent upon Auth0. This will require an Auth0 account, setting up an Application and an API, and then creating the file `web/src/auth_config.json`. There is a sample file for reference as well. 

### Setup

1. Signup for a free account from [their website](https://auth0.com/) 
2. Create an Application
   1. Left side menu, click `Applications > Applications`
   2. Click `+ Create Applications`
   3. Set a name
   4. Select `Single Page Web Applications`
   5. Click `Create`
   6. Open application settings
   7. Set `Allowed Callback URLs`
      - e.g. `http://localhost:{port}, http://localhost:{port}/callback`
   8. Set `Allowed logout URLs`
      - e.g. `http://localhost:{port}`
   9. Set `Allowed Web Origins`
      - e.g. `http://localhost:{port}`
   10. Click `Save Changes` at the bottom of the screen
3. Create an API
   1. Left side menu, click `Applications > APIs`
   2. Click `+ Create API`
   3. Set a name
   4. Set an identifier, e.g. `https://auth0.domain.com/api`
   5. click `Create`
   6. Go to the `Permissions` tab
      1. Set permissions
         - e.g. `read:messages` | `Read messages`
4. Copy the `Domain` and `ClientId` of the Applications and paste into the `auth_config.json` file
5. Copy the `API Audience` and paste into the `auth_config.json` file
6. Save and run the app

If you run into any problems, Auth0 maintains good documentation to read through. The docs can help with setup, as well as features like adjusting how users sign in, e.g. using a password, or a social media account, through the settings of your Auth0 tenant. 

If you run into errors signing in through TheLOCR's web page, pay attention to the Auth0 errors as they will give good information on how to fix the problems you run into. 
