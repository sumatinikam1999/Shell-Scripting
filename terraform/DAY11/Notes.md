✅ Why We Use tags in Terraform (AWS)
1. Cost Tracking & Billing
- AWS allows cost allocation based on tags.

- Example: You can track how much money is spent on each Project, Environment, or Team.

- Helps Finance teams split bills by teams or business units.

2. Resource Organization
- In AWS Console, tags help identify and group resources.

- Example: If you’re managing 500+ EC2 instances, filtering by Project = roboshop is very helpful.

3. Automation
- Tags can be used by scripts or tools (like Ansible, backup tools, or cleanup jobs).

- For example, a Lambda function might shut down all EC2s with Environment = DEV every evening to save cost.

4. Security & Access Control
- Some organizations use tags in IAM policies to allow/deny access to resources with specific tags.

5. Compliance and Auditing
- Helps in auditing which resources are related to which team or purpose.

- Some companies enforce tagging policies using AWS Config or Service Control Policies (SCP).

- Tags in Azure work just like AWS.

- Tags are optional but strongly recommended.

- You can filter, organize, and apply policies in Azure using tags (via Azure Policy).



- outputs
```
output "output-variable-name" {
    value = "value"
}
```