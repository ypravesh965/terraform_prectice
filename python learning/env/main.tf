provider "aws" {

    region = "us-east-1"
  
}

resource "aws_sfn_state_machine" "state_machine" {
    for_each = var.state_machines_name
    name       = "${each.value}"
    role_arn   = var.step_function_role_arn
    definition = file("./state_machine/${each.value}.json") 
}