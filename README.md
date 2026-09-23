# Cloud-security-assessment
Cloud Security Technical Assessment - Rajat Gupta

## Objective
The purpose of this PowerShell script is to automate the retrieval of compliant and non-compliant AWS resources using AWS Config rules through an AWS Config Aggregator.
 
The script helps identify the compliance status of resources across the AWS environment without requiring manual verification through the AWS Console.

The solution is implemented using:
 
- AWS CLI for PowerShell
- AWS Config
- AWS Config Aggregator
 
The PowerShell script is executed within my AWS command-line environment.

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

  
