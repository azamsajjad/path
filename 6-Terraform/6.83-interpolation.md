# Interpolation


In Terraform, you can interpolate other values
Resources                   ${aws_instance.name.id} 
Data Sources                ${data.templatre_file.name.rendered}

String Variable             var.name                ${var.var_name}
MAP variable                var.MAP["key"]          ${var.AMIS["us-east-1"]}
                                                    ${lookup(var.AMIS, var.AWS_REGION)}
List Variable               var.LIST, var.LIST[i]   ${var.subnets[i]}
                                                    ${join(",", var.subnets)}
Output of a Module          module.NAME.output      ${module.aws_vpc.vpcid}
Count Information           count.FIELD             ${count.index} - when using the attribute count = number in a resource


# Conditionals 
(Interpolation can contain Conditionals)
> Operators
    ==
    !=
    > < >= <=
    && || !unary



e.g.
resource "aws_instance" "my_instance" {
    ...
    count = "${var.env == "prod" ? 2 : 1 }"
    # 2 instances provisioned in Prod for redundancy, 1 in any other environment 
    ...
    subnet_id = "${var.ENV == "prod" ? module.vpc-prod.public_subnets[0] : module.vpc-dev.public_subnets[0] }"
    vpc_security_group_ids = ["${var.ENV == prod ? aws_security_group.allow-ssh-prod.id : aws_security_group.allow-ssh-dev.id }"]
}

