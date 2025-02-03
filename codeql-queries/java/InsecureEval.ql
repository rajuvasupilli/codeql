/**
 * @name Insecure Use of eval
 * @description Detects the use of insecure eval calls.
 * @kind problem
 * @problem.severity error
 * @tags security
 */

import java

from MethodCall call
where call.getTarget().getName() = "eval"
select call, "Avoid using 'eval' due to security risks."
