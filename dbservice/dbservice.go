package dbservice

import (
	"bufio"
	"database/sql"
	"fmt"
	"log"
	"os"
	"strings"

	"bowen/models"
	"github.com/go-sql-driver/mysql"
)

type Connection struct {
	User   string
	Passwd string
	Net    string
	Addr   string
	DBName string
}

func Initialize() (db *sql.DB, err error) {
	// TODO: add URI and adjust code when we have a definitive answer to where and how to store this information
	c, err := getConnection("/etc/proj.bowen/minuchin.conf")
	if err != nil {
		return db, err
	}

	cfg := mysql.Config{
		User:   c.User,
		Passwd: c.Passwd,
		Net:    c.Net,
		Addr:   c.Addr,
		DBName: c.DBName,
		AllowNativePasswords: true,
	}

	db, err = sql.Open("mysql", cfg.FormatDSN())
	if err != nil {
		return db, err
	}

	err = db.Ping()
	if err != nil {
		return db, err
	}

	return db, nil
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

func GetAddrById(id string) models.Address {
	db, err := Initialize()
    if err != nil {
        panic(err)
    }
	defer db.Close()
	
	var addr models.Address
	sql := fmt.Sprintf(`
		SELECT * 
		  FROM address 
		 WHERE addr_id = %s;
	`, id)
    rows, err := db.Query(sql)
    if err != nil {
        panic(err)
    }
	defer rows.Close()

    for rows.Next() {
        err := rows.Scan(&addr.Addr_id, &addr.Addr_uuid, &addr.Line_1, &addr.Line_2, &addr.Line_3, &addr.City, &addr.County, &addr.State, &addr.Postal_code, &addr.Created, &addr.Created_by, &addr.Modified, &addr.Modified_by)
        if err != nil {
			panic(err)
        }
    }

    return addr
}

func GetAllAddrs() []models.Address {
	db, err := Initialize()
    if err != nil {
        panic(err)
    }
	defer db.Close()
	
	var addrs []models.Address
	sql := `
		SELECT * 
		  FROM address 
		 ORDER BY addr_id;
	`
    rows, err := db.Query(sql)
    if err != nil {
        panic(err)
    }
	defer rows.Close()

    for rows.Next() {
        var addr models.Address
        err := rows.Scan(&addr.Addr_id, &addr.Addr_uuid, &addr.Line_1, &addr.Line_2, &addr.Line_3, &addr.City, &addr.County, &addr.State, &addr.Postal_code, &addr.Created, &addr.Created_by, &addr.Modified, &addr.Modified_by)
        if err != nil {
			panic(err)
        }
        addrs = append(addrs, addr)
    }

    return addrs
}
