# FOR
for-loop can help to iterate over variables, transform it, and output it in different formats
you can also change type, e.g. output variables into list, map
for-loop is typically used when assigning a value to an arguement
e.g.
security_groups = ["sg-123", "sg-456"]
this could be replaced by a for-loop if you need to transform the input data
for example:
- [for s in ["this is a", "list"] : upper(s)]


azams@eurusvm:~/dev/git$ terraform console
> [for s in ["this is a", "list", "of", "random", "strings"] : upper(s)]
[
  "THIS IS A",
  "LIST",
  "OF",
  "RANDOM",
  "STRINGS",
]
~~~json
variable "list1" {
    type = list(string)
    default = [1, 10, 9, 101, 3]
}
variable "list2" {
    type = list(string)
    default = ["apple", "pear", "banana", "mango"]
}
variable "map1" {
    type = map(number)
    default = {
        "apple" = 5
        "pear" = 3
        "banana" = 10
        "mango" = 0
    }
}
~~~
> [for s in var.list2: upper(s)]
[
  "APPLE",
  "PEAR",
  "BANANA",
  "MANGO",
]
> [for k, v in var.map1: k]
[
  "apple",
  "banana",
  "mango",
  "pear",
]
> [for k, v in var.map1: v]
[
  5,
  10,
  0,
  3,
]
> [for k, v in var.map1: upper(k)]
[
  "APPLE",
  "BANANA",
  "MANGO",
  "PEAR",
]
> {for k, v in var.map1: v=> k}
{
  "0" = "mango"
  "10" = "banana"
  "3" = "pear"
  "5" = "apple"
}



resource "aws_ebs_volume" "example" {
    availability_zone = "eu-west-1a"
    size = 8
    tags = {for k, v in merge({ Name = "Myvolume" }, var.project_tags): k => lower(v)}
}                      #<-------------------------input-------------->:  <---output--->




Terraform will perform the following actions:

  # aws_ebs_volume.example will be created
  + resource "aws_ebs_volume" "example" {
      + arn               = (known after apply)
      + availability_zone = "eu-west-1a"
      + encrypted         = (known after apply)
      + final_snapshot    = false
      + id                = (known after apply)
      + iops              = (known after apply)
      + kms_key_id        = (known after apply)
      + size              = 8
      + snapshot_id       = (known after apply)
      + tags              = {
          + "Component"   = "frontend"
          + "Environment" = "production"
          + "Name"        = "myvolume"
        }
      + tags_all          = {
          + "Component"   = "frontend"
          + "Environment" = "production"
          + "Name"        = "myvolume"
        }
      + throughput        = (known after apply)
      + type              = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.




# FOR_EACH
for_each-loops are not used when assigning a value to an arguement, but rather to repeat nested blocks
resource "aws_security_group" "sg_example" {
    name = "example"
    dynamic "ingress" {
        for_each = [22, 443]
        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
        }
    }
}

  # aws_security_group.sg_example will be created
  + resource "aws_security_group" "sg_example" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = []
              + description      = ""
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
          + {
              + cidr_blocks      = []
              + description      = ""
              + from_port        = 443
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 443
            },
        ]
      + name                   = "example"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags_all               = (known after apply)
      + vpc_id                 = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.









variable "ports" {
    type = map(list(string))
    default = {
        "22" = [ "127.0.0.1/32", "192.168.0.0/24" ]
        "443" = [ "0.0.0.0/0" ]
    }
}

resource "aws_security_group" "sg_example2" {
    name = "example2"
    dynamic "ingress" {
        for_each = var.ports
        content {
            from_port = ingress.key
            to_port = ingress.key
            cidr_blocks = ingress.value
            protocol = "tcp"
        }
    }
}
 # aws_security_group.sg_example2 will be created
  + resource "aws_security_group" "sg_example2" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 443
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 443
            },
          + {
              + cidr_blocks      = [
                  + "127.0.0.1/32",
                  + "192.168.0.0/24",
                ]
              + description      = ""
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
        ]
      + name                   = "example2"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags_all               = (known after apply)
      + vpc_id                 = (known after apply)
    }