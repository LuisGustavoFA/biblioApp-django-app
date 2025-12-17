## biblioApp-django-app
Django application for the biblioApp project with Oracle Database integration and an admin-oriented interface 

---

## Deployed with Render at 🔗 https://biblioapp-django-app.onrender.com

---

# Class Diagram
```mermaid
classDiagram
  class Autor {
    -nome: String
    -idade: int
  }

  class Editora {
    -nome: String
    -anoFundacao: int
  }

  class Categoria {
    -nome: String
    -descricao: String
  }

  class Cliente {
    -nome: String
    -sobrenome: String
    -email: Email
    -celular: String
    -endereco: String
    -genero: "Masculino" | "Feminino" | "Outro"
  }

  class Livro {
    -titulo: String
    -Autor: Autor
    -Categoria: Categoria
    -Editora: Editora
    -anoPublicacao: int
  }

  class LivroCategoria {
    -livro: Livro
    -categoria: Categoria
  }

  class Emprestimo {
    -Cliente: Cliente
    -status: "em andamento", "finalizado"
  }

  class ItemEmprestimo {
    -Livro: Livro
    -Emprestimo: Emprestimo
  }

  Categoria o--> LivroCategoria : ManyToMany
  LivroCategoria o--> Livro : ManyToMany
  Autor "1" o--> "*" Livro
  Editora "1" o--> "*" Livro
  Cliente "1" o--> "*" Emprestimo
  Livro "1" o--> "*" ItemEmprestimo

  Emprestimo "1" o--> "*" ItemEmprestimo

