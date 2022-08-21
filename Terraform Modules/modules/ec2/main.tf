# create web servers

resource "aws_instance" "TerraformCloudChallenge_web_1" {
    ami = var.web_ami
    instance_type = var.web_instance_type
    subnet_id = var.public_subnet_1_id
    associate_public_ip_address = true
    user_data = data.template_file.user_data.rendered
    key_name = var.aws_key_name
    tags = {
        Name = "TerraformCloudChallenge_web_1"
    }


}

resource "aws_instance" "TerraformCloudChallenge_web_2" {
    ami = var.web_ami
    instance_type = var.web_instance_type
    subnet_id = var.public_subnet_2_id
    associate_public_ip_address = true
    user_data = data.template_file.user_data.rendered
    key_name = var.aws_key_name
    tags = {
        Name = "TerraformCloudChallenge_web_2"
    }
}

