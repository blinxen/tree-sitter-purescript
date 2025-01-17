; ----------------------------------------------------------------------------
; Literals and comments

 (integer) @constant.numeric.integer
 (exp_negation) @constant.numeric.integer
 (exp_literal (number)) @constant.numeric.float
 (char) @constant.character
 [
   (string)
   (triple_quote_string)
 ] @string

 (comment) @comment


; ----------------------------------------------------------------------------
; Punctuation

 [
   "("
   ")"
   "{"
   "}"
   "["
   "]"
 ] @punctuation.bracket

 [
 (comma)
 ";"
 ] @punctuation.delimiter


; ----------------------------------------------------------------------------
; Keywords, operators, includes

 [
   "if"
   "then"
   "else"
   "case"
   "of"
 ] @keyword.control.conditional

 [
   "import"
   "module"
 ] @keyword.control.import

 [
   (operator)
   (constructor_operator)
   (type_operator)
   (tycon_arrow)
   (qualified_module)  ; grabs the `.` (dot), ex: import System.IO
   (all_names)

   ; `_` wildcards in if-then-else and case-of expressions,
   ; as well as record updates and operator sections
   (wildcard)
   "="
   "|"
   "::"
   "∷"
   "=>"
   "⇒"
   "->"
   "→"
   "<-"
   "←"
   "\\"
   "`"
   "@"
 ] @operator

 (qualified_module (module) @constructor)
 (module) @namespace
 (qualified_type (module) @namespace)
 (qualified_variable (module) @namespace)
 (import (module) @namespace)

 [
   (where)
   "let"
   "in"
   "class"
   "instance"
   "derive"
   "foreign"
   "data"
   "newtype"
   "type"
   "as"
   "hiding"
   "do"
   "ado"
   "forall"
   "∀"
   "infix"
   "infixl"
   "infixr"
 ] @keyword


; ----------------------------------------------------------------------------
; Functions and variables

 (signature name: (variable) @type)
 (function name: (variable) @function)

 ; true or false
((variable) @constant.builtin.boolean
 (#match? @constant.builtin.boolean "^(true|false)$"))

 ; The former one works for `tree-sitter highlight` but not in Helix/Kakoune.
 ; The latter two work in Helix (but not Kakoune) and are a good compromise between not highlighting anything at all
 ; as an operator and leaving it to the child nodes, and highlighting everything as an operator.
 (exp_ticked (_) @operator)
 (exp_ticked (exp_name (variable) @operator))
 (exp_ticked (exp_name (qualified_variable (variable) @operator)))

 (variable) @variable

 ("@" @namespace)  ; "as" pattern operator, e.g. x@Constructor

; ----------------------------------------------------------------------------
; Types

 (type) @type

 (constructor) @constructor

