[
  "IqDL"
  "event"
  "service"
  "using"
  "namespace"
  "include"
  "alias"
  "request"
  "using"
  "senum"
  "ienum"
  "struct"
  (annotation name: (identifier))
] @keyword

[
  (scoped_type_name)
  (unscoped_type_name)
  (unscoped_contract_name)
  (type_list)
  (type_map)
]@type

(string) @string
(annotation_value) @string

[
 (version)
 (number)
  ; (code)
] @number

[
 "routing"
 "meta"
 "payload"
 "index"
 "channel"
 "responses"
  (field_name)
  (routing_field)
  ; (method_parameters (identifier))
] @property

[
  (field_modifiers)
] @constant.builtin

(doc) @comment

[
  "["
  "]"
  "{"
  "}"
]  @punctuation.bracket
