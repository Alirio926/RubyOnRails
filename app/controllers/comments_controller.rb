class CommentsController < ApplicationController

    # Bloqueia acesso a certas paginas quando não autenticado
    http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy

    # Novo comentario associado ao article
    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.create(comment_params)
        redirect_to article_path(@article)
    end
    
    def destroy
        @article = Article.find(params[:article_id])        
        @comment = @article.comments.find(params[:id])
        @comment.destroy
        redirect_to article_path(@article), status: :see_other
    end    

    private
    # Define quais parametros serão permitidos via hash usando Strong params
        def comment_params
            params.require(:comment).permit(:commenter, :body, :status)        
        end
    
end
