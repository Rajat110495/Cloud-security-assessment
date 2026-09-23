$AGGREGATOR = "aws-controltower-GuardrailsComplianceAggregator"
$REGION_FILTER = "eu-central-1"
$results = @()
 
$ruleList = @(
    "FMManagedSGContentAuditConfigRule709c9f82-c209-4677-99d5-95a6ee777fe9",
    "platform-security-apigw-v2-enforce-deletion",
    "platform-security-ecr-image-count-rule",
    "FMManagedWafv2RegionalResourceConfigRule6044ad3b-575f-4dfa-8120-767ca72f011e",
    "platform-security-api-gateway-resource-policy",
    "ehs-required-tags",
    "required-tags",
    "Periodic_app_gw_resource_policy",
    "appsync-rule-showcase",
    "test-appsync-pyhton",
    "periodic-test-appsync",
    "tianyi-test-acm-certificate-expiration-check"
)
 
Write-Host "Processing $($ruleList.Count) rules for region: $REGION_FILTER..."
 
foreach ($RULE in $ruleList) {
    Write-Host "Checking rule: $RULE"
 
    $complianceSummary = aws configservice describe-aggregate-compliance-by-config-rules `
        --configuration-aggregator-name $AGGREGATOR `
        --filters "ConfigRuleName=$RULE" `
        --output json | ConvertFrom-Json
 
    foreach ($entry in $complianceSummary.AggregateComplianceByConfigRules) {
        $accountId = $entry.AccountId
        $region    = $entry.AwsRegion
 
        # Skip any region that is not Frankfurt
        if ($region -ne $REGION_FILTER) { continue }
 
        $findings = aws configservice get-aggregate-compliance-details-by-config-rule `
            --configuration-aggregator-name $AGGREGATOR `
            --config-rule-name $RULE `
            --compliance-type NON_COMPLIANT `
            --account-id $accountId `
            --aws-region $region `
            --output json | ConvertFrom-Json
 
        foreach ($item in $findings.AggregateEvaluationResults) {
            $results += [PSCustomObject]@{
                RuleName       = $RULE
                AccountId      = $accountId
                Region         = $region
                ResourceType   = $item.EvaluationResultIdentifier.EvaluationResultQualifier.ResourceType
                ResourceId     = $item.EvaluationResultIdentifier.EvaluationResultQualifier.ResourceId
                ComplianceType = $item.ComplianceType
            }
        }
    }
}
 
# Remove duplicates where same resource flagged by multiple rules
$unique = $results | Sort-Object RuleName, AccountId, ResourceType, ResourceId -Unique
 
$unique | Export-Csv -NoTypeInformation "Non_compliant_resources_Frankfurt.csv"
Write-Host "Done. $($unique.Count) resources exported."
