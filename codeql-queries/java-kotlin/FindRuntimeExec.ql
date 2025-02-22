import java

/**
 * @name Find calls to Runtime.exec
 * @description This query identifies calls to Runtime.exec which may be vulnerable to command injection.
 */

from MethodAccess call
where call.getMethod().getName() = "exec"
  and call.getMethod().getDeclaringType().getName() = "Runtime"
select call, "Call to Runtime.exec detected; review for potential command injection."

