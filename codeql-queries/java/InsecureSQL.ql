import java
from Method m, string sql
where
  m.getName() = "executeQuery" and
  sql = m.getAnArgument().toString() and
  sql.toLowerCase().matches("%select%from%")
select m, "Potential SQL Injection vulnerability detected."

