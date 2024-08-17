Documentação
**Explicação**
- **Bucket S3 & CloudFront**: Cria um bucket S3 para servir conteúdo estático e uma distribuição CloudFront para armazenar em cache e entregar esse conteúdo globalmente.
- **Cognito User Pool**: Configura um Cognito User Pool para autenticação de usuários.
- **API Gateway**: Define um API Gateway para gerenciar solicitações HTTP.
- **Função Lambda**: Implanta uma função Lambda para lidar com a lógica de negócios.
- **Função IAM**: Fornece a função IAM necessária para a Lambda.
- **RDS & DynamoDB**: Configura um banco de dados relacional com RDS e um banco de dados NoSQL com DynamoDB.
- **Fila SQS**: Configura uma fila SQS para mensagens.
- **CloudWatch**: Configura um grupo de logs do CloudWatch para monitoramento e registro.

**Implantação**
1. Salve este código em `main.tf`.
2. Inicialize o Terraform com `terraform init`.
3. Revise o plano com `terraform plan`.
4. Aplique a configuração com `terraform apply`.

Este exemplo cobre os principais componentes do seu diagrama. Personalize os parâmetros dos recursos, como nomes, regiões e configurações, de acordo com suas necessidades.