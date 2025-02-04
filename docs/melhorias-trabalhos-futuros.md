# Melhorias

### Backend

- Aumentar a cobertura de testes e refatorar implementações que dificultam testes unitários, como o uso de `LocalData.now()`.
- Implementar autenticação e uso de tokens nas requisições, pois atualmente qualquer pessoa que conheça os endpoints pode enviar dados para o servidor e acessar os relatórios.
- Reforçar a segurança no upload de arquivos JSON, já que, no momento, há apenas uma validação básica para garantir que o arquivo seja um JSON válido e contenha todos os dados esperados.
- Para maior proteção dos dados, considerar a implementação de autenticação com diferentes tipos de usuários.
- Revisar as associações das tabelas no banco de dados. Atualmente, há apenas uma tabela `candidates`, mas, com essas melhorias, pode ser vantajoso quebrá-la em entidades separadas, como `user`, `user_type`, `candidate_information`, `states`, entre outras.

  - **Usuário Padrão**: Apenas visualiza os relatórios.
  - **Usuário Avançado**: Pode fazer upload de arquivos JSON e visualizar os relatórios.
  - **Usuário Desenvolvedor**: Tem acesso a todas as funcionalidades e ferramentas de depuração (DEBUG).

### Frontend

- Implementar um **service locator** para evitar a instanciação direta de `Services` e `Repositories` nos construtores. Sugestão: [get_it](https://pub.dev/packages/get_it).
- Finalizar `ReportsRepositoryMock` com dados mais próximos da implementação real.
- Melhorar a cobertura de testes do projeto. Com as melhorias acima, a criação de testes unitários será mais fácil.
- Desenvolver UIs mais complexas para aprimorar a experiência do usuário.

---

# Possíveis Trabalhos Futuros

- **Área do Doador**: Exibir a data da próxima doação, histórico de doações, entre outras informações.
- **Área do Receptor**: Mostrar a posição na fila para receber uma doação de sangue.
- **Área do Administrador**: Desenvolver uma aplicação web para edição de dados e reprocessamentos.
 ---