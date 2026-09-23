
# Cloud-security-assessment

Question-01-security-automation


## Objective
The purpose of this PowerShell script is to automate the retrieval of compliant and non-compliant AWS resources mapped against the AWS Config rules through an AWS Config Aggregator.
 
The script helps identify the compliance status of resources across the AWS environment without requiring manual verification through the AWS Console.

The solution is implemented using:
 
- AWS CLI for PowerShell
- AWS Config
- AWS Config Aggregator
 
The PowerShell script is executed within my AWS command-line environment, and it will fetch the list of compliant and non-compliant resources mapped against the AWS Config rules for some custom rules as mentioned in the script itself.

## Script
The PowerShell automation script is available in this directory.
 
File:
AWS_Config_automation.ps1
 
## Features
The script performs the following tasks:
- Uses the AWS Config Aggregator to access aggregated compliance information.
- Retrieves resources evaluated against AWS Config rules.
- Retrieves resources with COMPLIANT status.
- Retrieves resources with NON_COMPLIANT status.
- Displays the compliance results for security review.
