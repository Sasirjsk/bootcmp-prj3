•	The architecture is designed around three Azure App Service environments: Development, Staging, and Production.
•	Each environment is deployed within its own dedicated Azure Resource Group, which is provisioned and managed using Terraform to ensure isolation, consistency, and ease of management.
•	Azure App Service is used as the hosting platform for the .NET web application due to its fully managed infrastructure, built-in scalability, and high availability features.
•	Deployment slots are an integral part of the architecture and are used to support the blue-green deployment strategy.
•	The use of deployment slots allows multiple versions of the application to run concurrently, enabling seamless traffic switching with zero downtime.
•	Azure DevOps acts as the CI/CD orchestration platform, bringing together source code management, automated builds, artifact publishing, and multi-stage release pipelines into a unified workflow.
•	Terraform modules are created to define reusable infrastructure components, and the for_each meta-argument is used to provision all required resources consistently across the three environments—development, staging, and production—by iterating over environment-specific configurations.

The github used to execut the dotnet web app:

https://github.com/Sasirjsk/dotnetwebapp-prj.git

