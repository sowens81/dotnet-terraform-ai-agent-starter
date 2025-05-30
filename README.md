# 🧠 dotnet-terraform-ai-agent-starter

A .NET 8-based intelligent agent that uses [Semantic Kernel](https://github.com/microsoft/semantic-kernel) and Terraform to generate infrastructure solutions from natural language prompts.

## 🚀 Features

- 🔍 Automatically discovers and parses existing Terraform modules  
- 🤖 Uses AI (OpenAI / Azure OpenAI) to interpret user intent  
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

### 3. Add your OpenAI credentials

Set these environment variables:

```bash
export OPENAI_API_KEY=your-key
export OPENAI_MODEL=gpt-4
```

Or edit `appsettings.json`.

### 4. Run the agent

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
- OpenAI or Azure OpenAI key

---

## 🧪 Roadmap

- [ ] Web UI (Blazor or React)  
- [ ] Module validation via `terraform validate`  
- [ ] Dependency-aware planning with SK Planner  

---

## 🤝 Contributing

Contributions, ideas, and issues welcome! Please open a pull request or issue.

---

## 📄 License

MIT License
