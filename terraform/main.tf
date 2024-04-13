resource "aws_instance" "valheim-instance" {
    ami = "ami-09c8d5d747253fb7a"
    instance_type = "t3.medium"
    root_block_device {
        delete_on_termination = true
        volume_size = 16
    }
    security_groups = [resource.aws_security_group.valheim-sg.name]
    key_name = "valheim-pk"
    user_data_base64 = base64encode(data.template_file.input.rendered)
    tags = {
            Name = "valheim-instance"
        }
}

resource "aws_security_group" "valheim-sg" {
    name = "valheim-sg"
    ingress {
        description = "valheim-port-allow-2456"
        from_port = 2456
        to_port = 2456
        protocol = "udp"
    }
    ingress {
        description = "valheim-port-allow-2457"
        from_port = 2457
        to_port = 2457
        protocol = "udp"
    }
    ingress {
        description = "valheim-port-allow-2458"
        from_port = 2458
        to_port = 2458
        protocol = "udp"
    }
    ingress {
        description = "ssh-allow"
        from_port = 22
        to_port = 22
        protocol = "tcp"
    }

    egress {
        description = "outbound-rule"
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}



resource "aws_cloudwatch_metric_alarm" "valheim-network-in-alarm" {
    alarm_name                = "vrisng-network-in-alarm"
    comparison_operator       = "LessThanOrEqualToThreshold"
    evaluation_periods        = 3
    metric_name               = "NetworkPacketsIn"
    namespace                 = "AWS/EC2"
    period                    = 300
    statistic                 = "Maximum"
    threshold                 = 250
    alarm_description         = "This metric monitors ec2 cpu utilization"
    dimensions = {
        InstanceId = resource.aws_instance.valheim-instance.id
    }
    actions_enabled     = "true"
    alarm_actions       = ["arn:aws:automate:ap-southeast-2:ec2:stop"]
}

output "instance-ip" {
    value = resource.aws_instance.valheim-instance.public_ip
}
output "instance-id" {
    value = resource.aws_instance.valheim-instance.id
}
