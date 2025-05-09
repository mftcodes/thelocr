package db

import (
	"database/sql"

	"github.com/go-sql-driver/mysql"
)

var (
	DBConn *sql.DB
)

func InitDB(envs map[string]string) error {
	cfg := mysql.Config{
		User:                 envs["MARIA_USER"],
		Passwd:               envs["MARIA_PASS"],
		Net:                  envs["MARIA_NET"],
		Addr:                 envs["MARIA_SERVER"],
		DBName:               envs["MARIA_DB"],
		AllowNativePasswords: true,
	}

	db, err := sql.Open("mysql", cfg.FormatDSN())
	if err != nil {
		return err
	}

	err = db.Ping()
	if err != nil {
		return err
	}

	DBConn = db

	return nil
}
