package repositories

import (
	"database/sql"
	"fmt"

	"bowen/config"
	"bowen/models"

	"golang.org/x/crypto/bcrypt"
)

type UserRepository struct {
}

func (ur *UserRepository) GetById(id string) (models.User, error) {
	var user models.User

	sql := fmt.Sprintf(`
		SELECT * 
		  FROM user 
		 WHERE user_id = %s;
	`, id)
	rows, err := config.DBConn.Query(sql)
	if err != nil {
		return user, err
	}
	defer rows.Close()

	for rows.Next() {
		err := rows.Scan(&user.User_id, &user.User_uuid, &user.Email, &user.Username, &user.First_name, &user.Last_name, &user.Password, &user.Can_edit, &user.Created, &user.Modified, &user.Modified_by)
		if err != nil {
			return user, err
		}
	}

	return user, nil
}

func (ur *UserRepository) Login(terms models.UserLogin) (models.User, error) {
	var user models.User

	sql := fmt.Sprintf(`
		SELECT u.user_id, BIN_TO_UUID(u.user_uuid) as user_uuid, u.user_email, u.username, u.first_name, u.last_name, u.password, u.can_edit
		  FROM user as u
		 WHERE u.username = '%s';
	`, terms.Username)
	rows, err := config.DBConn.Query(sql)
	if err != nil {
		return user, err
	}
	defer rows.Close()

	for rows.Next() {
		err := rows.Scan(&user.User_id, &user.User_uuid, &user.Email, &user.Username, &user.First_name, &user.Last_name, &user.Password, &user.Can_edit)
		if err != nil {
			return user, err
		}
	}

	err = bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(terms.Password))
	if err != nil {
		return user, err
	}

	// could send back a jwt or something here.
	user.Password = "chucklhead"

	return user, nil
}

func (ur *UserRepository) Create(terms models.UserCreate) (sql.Result, error) {
	hpass, _ := bcrypt.GenerateFromPassword([]byte(terms.Password), 8)

	sql := fmt.Sprintf(`
		INSERT INTO user
		(user_email, username, first_name, last_name, password)
		VALUES('%s', '%s', '%s', '%s', '%s');
	`, terms.Email, terms.Username, terms.First_name, terms.Last_name, hpass)

	result, err := config.DBConn.Exec(sql)
	if err != nil {
		return result, err
	}

	return result, nil
}
