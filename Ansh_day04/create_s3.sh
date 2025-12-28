#!/bin/bash
set -euo pipefail

check_awscli() {
    if ! command -v aws &> /dev/null; then
        echo "AWS CLI is not installed. Please install it first." >&2
    return 1

    fi
}

install_awscli() {
    echo "Installing AWS CLI v2 on Linux..."

    # Download and install AWS CLI v2
    curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    sudo apt-get install -y unzip &> /dev/null
    unzip -q awscliv2.zip
    sudo ./aws/install

    # Verify installation
    aws --version

    # Clean up
    rm -rf awscliv2.zip ./aws
}


create_s3_bucket() {
    local bucket_name="$1"
    local region="$2"

    if [[ "$region" == "us-east-1" ]]; then
	    aws s3api create-bucket --bucket "$bucket_name"
    else
	    aws s3api create-bucket --bucket "$bucket_name" --region "$region" \
		    --create-bucket-configuration LocationConstraint="$region"
    fi
    
    if [[ $? -ne 0 ]]; then
	echo "Failed to crrate s3 bucket" >&2
	exit 1
    fi

    aws s3api put-bucket-versioning --bucket "$bucket_name" --versioning-configuration Status=Enabled 
}

main() {
    if ! check_awscli ; then
       install_awscli || exit 1

    fi 

    echo "Creating S3 bucket..."

    # Specify the parameters for creating the S3 bucket
    BUCKET_NAME="shell-script-s3-demo"
    REGION="us-east-2"
    

    # Call the function to create the EC2 instance
    create_s3_bucket "$BUCKET_NAME" "$REGION"

    echo "S3 bucket provisioned."
}

main "$@"
