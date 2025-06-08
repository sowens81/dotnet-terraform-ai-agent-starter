# 🧠 dotnet-terraform-ai-agent-starter

A .NET 8-based intelligent agent that uses [Semantic Kernel](https://github.com/microsoft/semantic-kernel) and Terraform to generate infrastructure solutions from natural language prompts.

## 🚀 Features

- 🔍 Automatically discovers and parses existing Terraform modules  
- 🤖 Uses AI (Azure AI Foundry) to interpret user intent  
- 🧱 Dynamically assembles Terraform `main.tf`, `variables.tf`, and `outputs.tf`  
- 🔌 Plugin-based architecture powered by Semantic Kernel  
- 🧪 Ready for CLI or Web API integration  

---

## 📦 Architecture Overview

```plaintext
/Plugins
  ├── ModuleDiscoveryPlugin
  ├── IntentAnalyzerPlugin
  └── TerraformGeneratorPlugin

/Kernel
  └── KernelBuilder.cs

/Models
  ├── ModuleMetadata.cs
  └── UserIntent.cs

/Modules
  └── (Your Terraform modules here)

/Outputs
  └── Generated Terraform files

Program.cs
```

---

## 🛠️ Getting Started

### 1. Clone the repo

```bash
git clone https://github.com/YOUR_USERNAME/dotnet-terraform-ai-agent-starter.git
cd dotnet-terraform-ai-agent-starter
```

### 2. Install dependencies

```bash
dotnet restore
```

### 3. Add your Azure AI Foundry credentials

Set these environment variables or update `appsettings.json`:

```bash
export AZURE_AI_FOUNDARY_ENDPOINT="https://${azure_ai_foundry_resource}.services.ai.azure.com/api/projects/${azure_ai_foundry_project}"
export AZURE_AI_FOUNDARY_MODEL_DEPLOYMENT_NAME="gpt-4"
```

Alternatively, you can configure this directly in `appsettings.json` as follows:

```json
{
  "AzureAiFoundry": {
    "Endpoint": "https://${azure_ai_foundry_resource}.services.ai.azure.com/api/projects/${azure_ai_foundry_project}",
    "ModelDeploymentName": "gpt-4"
  }
}
```

Replace `${azure_ai_foundry_resource}` and `${azure_ai_foundry_project}` with your actual Azure AI Foundry resource name and project name.

### 4. Create an Azure Service Principal for Terraform Authentication

To deploy to Azure using Terraform in GitHub Actions, you'll need to authenticate via an **Azure Service Principal**. Follow the steps below to create one and store the credentials in GitHub Secrets.

#### Create a Service Principal

1. **Login to Azure CLI**: 
   If you don't already have the Azure CLI installed, download and install it from [here](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli). Once installed, log in using your Azure account:
   
   ```bash
   az login
   ```

2. **Create a Service Principal**: 
   Run the following command to create a Service Principal with the necessary permissions (e.g., `Contributor` role):
   
   ```bash
   az ad sp create-for-rbac --name terraform-github-action --role Contributor --scopes /subscriptions/{subscription-id}
   ```

   Replace `{subscription-id}` with your Azure subscription ID. This will output credentials like this:
   
   ```json
   {
     "appId": "00000000-0000-0000-0000-000000000000",
     "displayName": "terraform-github-action",
     "password": "your-client-secret",
     "tenant": "00000000-0000-0000-0000-000000000000"
   }
   ```

   You'll need to save the following information:
   - `appId` → **ARM_CLIENT_ID**
   - `password` → **ARM_CLIENT_SECRET**
   - `tenant` → **ARM_TENANT_ID**

3. **Find Your Azure Subscription ID**:
   To get the Subscription ID, run:
   
   ```bash
   az account show --query id --output tsv
   ```

   This will output your Subscription ID, which you'll need to store as **ARM_SUBSCRIPTION_ID**.

#### Add the Service Principal Credentials to GitHub Secrets

1. Go to your GitHub repository.
2. Navigate to **Settings** → **Secrets** → **New repository secret**.
3. Add the following secrets with the corresponding values:
   - `ARM_CLIENT_ID`: The **appId** from the Service Principal output.
   - `ARM_CLIENT_SECRET`: The **password** from the Service Principal output.
   - `ARM_TENANT_ID`: The **tenant** from the Service Principal output.
   - `ARM_SUBSCRIPTION_ID`: Your Azure **subscription ID**.

### 5. Run the agent

```bash
dotnet run
```

---

## 💡 Example Prompt

```plaintext
Create a VPC with 3 public subnets, 2 private subnets, and a NAT gateway.
```

The AI will:
1. Identify the required modules  
2. Generate a Terraform solution  
3. Write files to the `/Outputs` directory  

---

## 📚 Prerequisites

- [.NET 8 SDK](https://dotnet.microsoft.com/download)
- [Terraform CLI](https://developer.hashicorp.com/terraform/install)
- Azure AI Foundry credentials (explained above)
- Azure Service Principal for authentication (explained above)

---

## 🧪 Roadmap

- [ ] TBD

---

## 🤝 Contributing

Contributions, ideas, and issues welcome! Please open a pull request or issue.

---

## 📄 License

[MIT License](./LICENSE)
