variable "state_machines_name" {
    type = set(string)
    default = [ ]
  
}
variable "step_function_role_arn" {
  type    = string
  default = ""
}