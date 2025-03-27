package repositories

import (
	"database/sql"
	"fmt"
)

func boolToBit(val bool) uint8 {
	if val {
		return 1
	} else {
		return 0
	}
}

func sqlNullStrToStr(s sql.NullString) string {
	var sReturn string
	if s.Valid {
		sReturn = fmt.Sprintf(`'%s'`, s.String)
		return sReturn
	} else {
		return "null"
	}
}
