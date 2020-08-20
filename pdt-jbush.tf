# Configure the PagerDuty provider - WHhGict8qm5SVQo9jkWd - https://pdt-huggins.pagerduty.com/
provider "pagerduty" {
  #LIVE DEMO ####################  DONT FORGET TO SWITCH BACK TO LIVE DEMO FOR THE PRESENTATION!!!!  ####################
  token = "WHhGict8qm5SVQo9jkWd"
  #TEST DEMO - currently https://hug-terraform.pagerduty.com/
  #token = "6yV68ZEheDWZRwWSpW8F"
}

################################################################################################
# Create PagerDuty teams - Automation, Operations, Banking Development (DevOps), Management
resource "pagerduty_team" "automation" {
  name        = "Automation"
  description = "All automation engineers"
}
resource "pagerduty_team" "Operations" {
  name        = "Operations Team"
  description = "Operations Team"
}
resource "pagerduty_team" "bankingDev" {
  name        = "Banking DevOps Team"
  description = "Banking DevOps Team"
}
resource "pagerduty_team" "Stakeholders" {
  name        = "Stakeholders"
  description = "Management Team"
}
################################################################################################



################################################################################################
# Create a PagerDuty users
resource "pagerduty_user" "hug" {
  name  = "Huggins Terraform"
  email = "dhuggins+terraform@pagerduty.com"
  color = "firebrick"
  role = "user"
  job_title = "Terraform Administrator"
}
resource "pagerduty_user" "dylan" {
  name  = "Dylan Bower"
  email = "dbower@pagerduty.com"
  color = "blue"
  role = "user"
}
resource "pagerduty_user" "alfonso" {
name  = "Alfonso Griglen"
  email = "alfonso.griglen@example.com"
  color = "firebrick"
  role = "observer"
  }
resource "pagerduty_user" "eric" {
  name  = "Eric Cox"
  email = "eric.cox@rivertcorp.com"
  color = "green"
  role = "user"
  job_title = "The Boss from Terraform"
}
resource "pagerduty_user" "sam" {
  name  = "Sam Blake"
  email = "sam.blake@pagerduty.demo"
  color = "dark-goldenrod"
  role = "user"
}
resource "pagerduty_user" "bob" {
  name  = "Bob Smith"
  email = "bob.smith@pagerduty.demo"
  color = "chocolate"
  role = "limited_user"
}
resource "pagerduty_user" "dave" {
  name  = "Dave Bailey"
  email = "dave.bailey@pagerduty.demo"
  role = "user"
}
resource "pagerduty_user" "kate" {
  name  = "Kate Chapman"
  email = "kate.chapman@pagerduty.demo"
  role = "admin"
}
resource "pagerduty_user" "Derek" {
  name  = "DBA Derek"
  email = "dba.derek@pagerduty.demo"
}
resource "pagerduty_user" "Dora" {
  name  = "DBA Dora"
  email = "dba.dora@pagerduty.demo"
}
resource "pagerduty_user" "Nancy" {
  name  = "Network Nancy"
  email = "network.nancy@pagerduty.demo"
}
resource "pagerduty_user" "Norman" {
  name  = "Network Norman"
  email = "network.norman@pagerduty.demo"
}
resource "pagerduty_user" "Morris" {
  name  = "Management Morris"
  email = "management.morris@pagerduty.demo"
}
resource "pagerduty_user" "Martha" {
  name  = "Management Martha"
  email = "management.martha@pagerduty.demo"
}

################################################################################################
# Create user contact information

resource "pagerduty_user_contact_method" "phone" {
  user_id      = pagerduty_user.hug.id
  type         = "phone_contact_method"
  country_code = "+1"
  address      = "2025550199"
  label        = "Work"
}

resource "pagerduty_user_contact_method" "sms" {
  user_id      = pagerduty_user.hug.id
  type         = "sms_contact_method"
  country_code = "+1"
  address      = "2025550199"
  label        = "Work"
}

################################################################################################
# Assign the Users to the right Teams: -
resource "pagerduty_team_membership" "teamHug" {
  user_id = pagerduty_user.hug.id
  team_id = pagerduty_team.automation.id
}
resource "pagerduty_team_membership" "teamSam" {
  user_id = pagerduty_user.sam.id
  team_id = pagerduty_team.automation.id
}
resource "pagerduty_team_membership" "teamBob" {
  user_id = pagerduty_user.bob.id
  team_id = pagerduty_team.automation.id
}
resource "pagerduty_team_membership" "teamDave" {
  user_id = pagerduty_user.dave.id
  team_id = pagerduty_team.automation.id
}
resource "pagerduty_team_membership" "teamkate" {
  user_id = pagerduty_user.kate.id
  team_id = pagerduty_team.automation.id
}
resource "pagerduty_team_membership" "teamDerek" {
  user_id = pagerduty_user.Derek.id
  team_id = pagerduty_team.Operations.id
}
resource "pagerduty_team_membership" "teamDora" {
  user_id = pagerduty_user.Dora.id
  team_id = pagerduty_team.Operations.id
}
resource "pagerduty_team_membership" "teamNorman" {
  user_id = pagerduty_user.Norman.id
  team_id = pagerduty_team.Operations.id
}
resource "pagerduty_team_membership" "teamNancy" {
  user_id = pagerduty_user.Nancy.id
  team_id = pagerduty_team.Operations.id
}
resource "pagerduty_team_membership" "teamMorris" {
  user_id = pagerduty_user.Morris.id
  team_id = pagerduty_team.Stakeholders.id
}
resource "pagerduty_team_membership" "teamMartha" {
  user_id = pagerduty_user.Martha.id
  team_id = pagerduty_team.Stakeholders.id
}
################################################################################################



################################################################################################
# Create PagerDuty Schedules
resource "pagerduty_schedule" "automation_sch" {
  name      = "Automation On-call Schedule"
  time_zone = "Europe/London"
  layer {
    name                         = "Daily Rotation"
    start                        = "2018-11-06T20:00:00-10:00"
    rotation_virtual_start       = "2018-11-07T06:00:00+00:00"
    rotation_turn_length_seconds = 86400
    users                        = ["${pagerduty_user.sam.id}",
                                    "${pagerduty_user.bob.id}",
									"${pagerduty_user.hug.id}",
                                    "${pagerduty_user.dave.id}",
                                    "${pagerduty_user.kate.id}"]
  }
}
resource "pagerduty_schedule" "bankPayment" {
  name      = "Payment On-call Schedule"
  time_zone = "Europe/London"
  layer {
    name                         = "Daily Rotation"
    start                        = "2018-11-06T20:00:00-10:00"
    rotation_virtual_start       = "2018-11-07T06:00:00+00:00"
    rotation_turn_length_seconds = 86400
    users                        = ["${pagerduty_user.bob.id}",
                                    "${pagerduty_user.dave.id}",
                                    "${pagerduty_user.kate.id}"]
  }
}
resource "pagerduty_schedule" "bankApply" {
  name      = "Apply On-call Schedule"
  time_zone = "Europe/London"
  layer {
    name                         = "Daily Rotation"
    start                        = "2018-11-06T20:00:00-10:00"
    rotation_virtual_start       = "2018-11-07T06:00:00+00:00"
    rotation_turn_length_seconds = 86400
    users                        = ["${pagerduty_user.kate.id}"]
  }
}
resource "pagerduty_schedule" "bankTransfer" {
  name      = "Transfer On-call Schedule"
  time_zone = "Europe/London"
  layer {
    name                         = "Daily Rotation"
    start                        = "2018-11-06T20:00:00-10:00"
    rotation_virtual_start       = "2018-11-07T06:00:00+00:00"
    rotation_turn_length_seconds = 86400
    users                        = ["${pagerduty_user.dave.id}",
                                    "${pagerduty_user.kate.id}"]
  }
}
################################################################################################



################################################################################################
# Create PagerDuty EP's
resource "pagerduty_escalation_policy" "EngineeringEP" {
  name      = "eCommerce Engineering (EP)"
  num_loops = 2
  teams     = ["${pagerduty_team.automation.id}"]

  rule {
    escalation_delay_in_minutes = 15

    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.automation_sch.id
    }
  }
}
resource "pagerduty_escalation_policy" "Bank-Payment" {
  name      = "Payment Team (EP)"
  num_loops = 2
  teams     = ["${pagerduty_team.bankingDev.id}"]

  rule {
    escalation_delay_in_minutes = 10

    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.bankPayment.id
    }
  }
}
resource "pagerduty_escalation_policy" "Bank-Balance" {
  name      = "Balance Team (EP)"
  num_loops = 2
  teams     = ["${pagerduty_team.bankingDev.id}"]

  rule {
    escalation_delay_in_minutes = 10

    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.automation_sch.id
    }
  }
}
resource "pagerduty_escalation_policy" "Bank-Transfer" {
  name      = "Transfer Team (EP)"
  num_loops = 2
  teams     = ["${pagerduty_team.bankingDev.id}"]

  rule {
    escalation_delay_in_minutes = 10

    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.bankTransfer.id
    }
  }
}
resource "pagerduty_escalation_policy" "Bank-Apply" {
  name      = "Apply Team (EP)"
  num_loops = 2
  teams     = ["${pagerduty_team.bankingDev.id}"]

  rule {
    escalation_delay_in_minutes = 10

    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.bankApply.id
    }
  }
}
################################################################################################



################################################################################################
# Create PagerDuty Services - eCommerce
resource "pagerduty_service" "eCommerce_FrontEnd" {
  name                    = "eCommerce FrontEnd"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.EngineeringEP.id
  alert_creation          = "create_alerts_and_incidents"

  incident_urgency_rule {
    type = "constant"
    urgency = "severity_based"
  }
}
resource "pagerduty_service" "eCommerce_Search" {
  name                    = "eCommerce Search"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.EngineeringEP.id
  alert_creation          = "create_alerts_and_incidents"

  incident_urgency_rule {
    type = "constant"
    urgency = "severity_based"
  }
}
resource "pagerduty_service" "eCommerce_Payment" {
  name                    = "eCommerce Payment"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.EngineeringEP.id
  alert_creation          = "create_alerts_and_incidents"

  incident_urgency_rule {
    type = "constant"
    urgency = "severity_based"
  }

}
################################################################################################



################################################################################################
# Create PagerDuty Services - Banking
resource "pagerduty_service" "Bank-Payment" {
  name                    = "DutyBank Payment"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.Bank-Payment.id
  alert_creation          = "create_alerts_and_incidents"
  alert_grouping          = "time"
  alert_grouping_timeout  = "10"

  incident_urgency_rule {
    type = "constant"
    urgency = "severity_based"
  }

}
resource "pagerduty_service" "Bank-Apply" {
  name                    = "DutyBank Apply"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.Bank-Apply.id
  alert_creation          = "create_alerts_and_incidents"
  alert_grouping          = "time"
  alert_grouping_timeout  = "10"

  incident_urgency_rule {
    type = "constant"
    urgency = "severity_based"
  }
}
resource "pagerduty_service" "Bank-Balance" {
  name                    = "DutyBank Balance"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.Bank-Balance.id
  alert_creation          = "create_alerts_and_incidents"
  alert_grouping          = "time"
  alert_grouping_timeout  = "10"

  incident_urgency_rule {
    type = "constant"
    urgency = "severity_based"
  }
}
resource "pagerduty_service" "Bank-Transfer" {
  name                    = "DutyBank Transfer"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.Bank-Transfer.id
  alert_creation          = "create_alerts_and_incidents"
  alert_grouping          = "intelligent"

  incident_urgency_rule {
    type = "constant"
    urgency = "severity_based"
  }

}
################################################################################################
