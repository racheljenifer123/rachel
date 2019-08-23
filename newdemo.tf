provider "aws"{

access_key="AKIAZTIMJ7JHPVODYVZA"
secret_key="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"
region="eu-west-1"

//access_key="${var.access_key}"
//secret_key="${var.secret_key}"
//region="${var.region}"

}

resource "aws_instance" "rachelterraform2"{
ami="ami-06358f49b5839867c"
instance_type="t2.micro"
key_name="${aws_key_pair.rachelkey.id}"
tags = {
Name="rachelinstance"
}
vpc_security_group_ids =["${aws_security_group.rachelsecuritygroup.id}"]
provisioner "local-exec" {
when ="create"
command="echo ${aws_instance.rachelterraform2.public_ip}>sample.txt"
}

provisioner "chef" {
connection {
host="${self.public_ip}"
type="ssh"
user="ubuntu"
private_key ="${file("C:\\rachel\\mykey.pem")}"
}
client_options =["chef_license 'accept'"]
run_list=["rachel_tf_chef::default"]
recreate_client=true
node_name="trach.acc.come"
server_url="https://manage.chef.io/organizations/rachell"
user_name="racheljenifer"
user_key="${file("C:\\chef-starter\\chef-repo\\.chef\\racheljenifer.pem")}"
ssl_verify_mode=":verify_none"
}
}

resource "aws_eip" "racheleip" {
tags ={
Name="rachekelasticip"
}
instance="${aws_instance.rachelterraform2.id}"
}

resource "aws_eip" "racheleip12" {

}


resource "aws_s3_bucket" "rjjjjjjjjjjjjjjjjjbucket" {
bucket="rjjjjjjjjjjjjjjjjjbucket"
acl="private"
force_destroy="true"
}
output "rachelpublicip" {
value ="${aws_instance.rachelterraform2.public_ip}"
}

terraform {
backend "s3" {
bucket ="rjjjjjjjjjjjjjjjjjbucket"
key="terraform.tfstate"
region="eu-west-1"
}
}

resource "aws_key_pair" "rachelkey"{
key_name="rachelkeypair"
public_key="${file("C:\\rachel\\mykey.pub")}"
}

resource "aws_security_group"  "rachelsecuritygroup" {
name ="rachelsecgroup"
description= "To allow traffic"
ingress{
from_port="0"
to_port="0"
protocol="-1"
cidr_blocks=["0.0.0.0/0"]
}
egress{
from_port="0"
to_port="0"
protocol="-1"
cidr_blocks=["0.0.0.0/0"]
}
}

