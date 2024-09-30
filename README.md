
# Foodtech Infra EKS

Este repositório contém a infraestrutura necessária para o projeto **Foodtech** usando **Amazon EKS** (Elastic Kubernetes Service) e é gerenciado usando **Terraform**. Este guia vai ajudá-lo a entender como configurar e executar o projeto.
 
## Visão Geral do Projeto

Este projeto utiliza a **infraestrutura como código** (IaC) para criar e gerenciar clusters Kubernetes na AWS, que hospedarão o sistema **Foodtech**. O sistema usa o **AWS Cognito** para autenticação e o **PostgreSQL** como banco de dados.

## Pré-requisitos

- **Terraform**: `^1.0`
- **AWS CLI** configurado
- **Kubectl** para gerenciar o cluster
- Credenciais da AWS com permissões para criar recursos EKS

## Estrutura do Repositório

- **modules/eks/**: Configuração do cluster EKS.
- **modules/iam/**: Configuração das permissões e políticas IAM.
- **modules/vpc/**: Criação da VPC para o cluster.

## Como Configurar

### 1. Clonar o Repositório

```sh
git clone https://github.com/grupo27/foodtech-infra-eks.git
cd foodtech-infra-eks
```

### 2. Inicializar o Terraform

Inicialize o Terraform para configurar os módulos e o backend:

```sh
terraform init
```

### 3. Aplicar as Configurações

Aplique as configurações para criar a infraestrutura:

```sh
terraform apply
```

Isso criará o cluster EKS na **região us-east-1** com o nome `my-eks-cluster`.

## Fluxo de CI/CD

Este projeto utiliza **GitHub Actions** para provisionar a infraestrutura de maneira automática. O workflow pode ser encontrado em `.github/workflows/terraform.yml`.

### Detalhes do Workflow

- **Deploy da Infraestrutura**: Toda vez que um push é feito na branch `main`, o workflow executa o script `deploy.sh` que cuida do deploy da Lambda e dos recursos no cluster.
- **Variáveis de Ambiente**: Utilizamos o **Git Actions** para gerenciar variáveis de ambiente de forma segura.

## Tecnologias Utilizadas

- **Terraform**: Gerenciamento de infraestrutura
- **AWS EKS**: Serviço de Kubernetes gerenciado
- **AWS Cognito**: Autenticação de usuários
- **DynamoDB**: Banco de dados para armazenar informações de sessão
- **GitHub Actions**: Automatização de deploy

## Como Contribuir

1. Faça um fork do projeto.
2. Crie uma nova branch: `git checkout -b feature/nova-feature`.
3. Faça suas alterações e commit: `git commit -m 'Adicionando nova feature'`.
4. Faça push para a branch: `git push origin feature/nova-feature`.
5. Abra um Pull Request.

## Contato

Para dúvidas, entre em contato com a equipe via [email](mailto:support@foodtech.com).

---

> **Nota**: Certifique-se de que as credenciais da AWS estejam configuradas corretamente antes de aplicar qualquer configuração.

