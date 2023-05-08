export AMI_ID="ami-0fc3f9b45ccdac997"
export AMI_NAME="CIS Amazon Linux 2 Benchmark v2.0.0.19 - Level 2-c41d38c4-3f6a-4434-9a86-06dd331d3f9c"
export AMI_OWNER_ACCOUNT_ID="679593333241"
export AWS_REGION=ap-southeast-2
VPC_ID=$(aws ec2 describe-vpcs --query 'Vpcs[0].VpcId' --region ap-southeast-2 --output text)
echo $VPC_ID

SUBNET_ID=$(aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VPC_ID" --region ap-southeast-2 | jq '.Subnets[0].SubnetId')
SUBNET_ID=`sed -e 's/^"//' -e 's/"$//' <<<"$SUBNET_ID"`
echo $SUBNET_ID

make 1.22 aws_region=$AWS_REGION source_ami_id=$AMI_ID source_ami_owners=$AMI_OWNER_ACCOUNT_ID source_ami_filter_name="$AMI_NAME" subnet_id="$SUBNET_ID"
