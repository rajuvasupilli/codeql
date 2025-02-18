import javascript
from CallExpression call
where
  call.getCallee().getName() = "eval"
select call, "Avoid using eval() due to security risks."
