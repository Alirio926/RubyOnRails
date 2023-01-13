class ArticlesController < ApplicationController

  # Bloqueia acesso a certas paginas quando não autenticado
  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  # Index, mostra todos os artigos
  def index
	  @articles = Article.all
  end
  
  # Carrega um artigo selecionado e mostra
  def show
	  @article = Article.find(params[:id])
  end  

  # New
  def new
    @article = Article.new   
  end

  def create
    # Instancia um novo Object Article
    @article = Article.new(article_params) 

    # Se sucesso, redireciona a pagina com o novo Object
    if @article.save      
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end    
  end  

  # Update
  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Delete
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end     
  
  private
    # Define quais parametros serão permitidos via hash usando Strong params
    def article_params
      params.require(:article).permit(:title, :body, :status)
      
    end
    

end
