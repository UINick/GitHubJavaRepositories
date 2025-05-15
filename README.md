# GitHubJavaRepositories

O projeto contém duas viewControllers, onde uma mostra a lista dos repositorios mais populares de Java,
e na outra os Pull requests do repositório em questão:

-> Java_Repositories > Modules > Repositories > JavaRepositoriesViewController

-> Java_Repositories > Modules > PullRequests > PullRequestViewController


Estou utilizando o padrão de arquitetura MVVM.

Nas viewModels ("JavaRepositoriesViewModel", "PullRequestViewModel") estou utlizando o framework da apple "Combine" para atualizar
as informações obtidas, para a camada da viewController.


