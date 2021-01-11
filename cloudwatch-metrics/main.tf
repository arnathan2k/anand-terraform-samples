provider "aws" {
    region =var.region
}
resource "aws_cloudwatch_log_metric_filter" "HostNotFound" {
    name           = "HostNotfoundErrorCount"
    pattern        = "WFLYCTL0013"
    log_group_name = aws_cloudwatch_log_group.custom_metric_group.name

    metric_transformation {
        name      = "EventCount"
        namespace = "Metric_Space"
        value     = "1"
    }
}
resource "aws_sns_topic" "terraform_alarm_topic" {
  name = "alarmtopic"
}
resource "aws_cloudwatch_log_group" "custom_metric_group" {
# Log group for the log
  name = "my-metric-log-example"
}

resource "aws_sns_topic" "terraform-test-alarm" {
  name = "my-test-alarms-topic"

  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF

  provisioner "local-exec" {
    command = "aws sns subscribe --topic-arn ${self.arn} --protocol email --notification-endpoint ${var.alarms_email}"
  }
}


resource "aws_cloudwatch_metric_alarm" "HostNotFoundAlm" {
  alarm_name                = "terraform-HNF-Alarm-WFLYCTL0013"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "HostNotfoundErrorCount"
  namespace                 = "Metric_Space"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "5"
  alarm_description         = "This metric monitors custom Log message"
  insufficient_data_actions = []
}   

