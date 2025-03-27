package config

import (
	"bufio"
	"database/sql"
	"fmt"
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

func InitDB() {
	var connectionFileUri string
	env := os.Getenv("ENV")
	if env == "" {
		env = "dev"
	} else {
		env = "prod"
	}

	if env == "dev" {
		err := SetupLocalDevEnv()
		if err != nil {
			panic(fmt.Sprintf("Failed to setup local dev environment: %w", err))
		}
		connectionFileUri = SetLocalConfFileUri()
	} else {
		connectionFileUri = SetProdConfFileUri()
	}
	// TODO: add URI and adjust code when we have a definitive answer to where and how to store this information
	c, err := getConnection(connectionFileUri)
	if err != nil {
		panic(fmt.Sprintf("Failed to get sql connection configuration for %s environment: %w", env, err))
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
		panic(fmt.Sprintf("Failed to open Db connections for %s environment: %w", env, err))
	}

	err = db.Ping()
	if err != nil {
		panic(fmt.Sprintf("Failed to ping Db connections for %s environment: %w", env, err))
	}

	DBConn = db
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
