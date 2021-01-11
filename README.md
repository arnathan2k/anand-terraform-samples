This is a collection of terraform configuration files you can try out. I will keep adding other resources. I have been creating this to mainly for people I work with to try out out and get familliar with terraform

Use the code by cutting and pasting it into your favourite development tool.

Just in case

1. Download and install terraform
2. Install your IDE or editor of your choice
3. Make sure to have your code complete plugins installed to check for errors and make your life better

When I find time I will add some links and additional resources I used for reference.

Caveat: Make sure that the code copy from here works as you expect. I cannot be held responsible for ANY code you choose to run in your environment. Understand how much it is going to cost you in AWS before running anything.

Best Wishes

Assumptions: Set your environment variables for the AWS Access KEy and Secrect Access Key. Cheers!
USAGE: 

You should be able to run these by following these simple steps

1. Copy the code to your folder
2. run  - terraform init
3. run  - terraform plan -out yourplanfile.out
4. run  - terraform apply

to cleanup run terraform destroy.

**** MAKE SURE not to checkin your statefiles ****

