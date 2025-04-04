package config

import (
	"bufio"
	"database/sql"
	"log"
	"os"
	"strings"

	"github.com/go-sql-driver/mysql"
)

type Connection struct {
	User   string
	Passwd string
	Net    string
	Addr   string
	DBName string
}

var (
	DBConn *sql.DB
)

func InitDB() (string, error) {
	var connectionFileUri string
	env := os.Getenv("ENV")
	if env != "prod" {
		env = "dev"
	}

	if env == "dev" {
		err := SetupLocalDevEnv()
		if err != nil {
			return env, err
		}
		connectionFileUri = SetLocalConfFileUri()
	} else {
		connectionFileUri = SetProdConfFileUri()
	}
	// TODO: add URI and adjust code when we have a definitive answer to where and how to store this information
	c, err := getConnection(connectionFileUri)
	if err != nil {
		return env, err
	}

	cfg := mysql.Config{
		User:                 c.User,
		Passwd:               c.Passwd,
		Net:                  c.Net,
		Addr:                 c.Addr,
		DBName:               c.DBName,
		AllowNativePasswords: true,
	}

	db, err := sql.Open("mysql", cfg.FormatDSN())
	if err != nil {
		return env, err
	}

	err = db.Ping()
	if err != nil {
		return env, err
	}

	DBConn = db

	return env, nil
}

func getConnection(configUri string) (c Connection, err error) {
	f, err := os.Open(configUri)
	if err != nil {
		return c, err
	}
	defer f.Close()

	scanner := bufio.NewScanner(f)

	for scanner.Scan() {
		key, value, found := strings.Cut(scanner.Text(), "=")
		if !found {
			continue
		}

		// TODO: adjust format  when we define our config file
		switch key {
		case "USER":
			c.User = value
		case "PASSWD":
			c.Passwd = value
		case "NET":
			c.Net = value
		case "SERVER":
			c.Addr = value
		case "DB":
			c.DBName = value
		default:
			log.Output(1, "Get Connection: Invalid Key in configuration file.")
		}
	}

	if err := scanner.Err(); err != nil {
		return c, err
	}

	return c, nil
}
