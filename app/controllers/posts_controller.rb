class PostsController < ApplicationController
  before_action :set_project
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin, except: [:show, :index]

    def index
        @project = Project.find(params[:project_id])
        @posts = @project.posts.all
        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.replace('posts', partial: 'posts/posts', locals: { posts: @posts }) }
        end
    end

    def create
      @project = Project.find(post_params[:project_id])
      @post = @project.posts.new(post_params)
       if @post.save
        redirect_to project_url(@post), notice: "Thread created successfully"
       else
        redirect_to project_url(@project), notice: "Can't create empty Thread"
       end
    end

    def new
        @project = Project.find(params[:project_id])
        @post = @project.posts.new(id: params[:id])
    end

    def edit
        @project = Project.find(params[:project_id])
        @post = @project.posts.find(params[:id])
    end



    def update
        @project = Project.find(params[:project_id])
        @post = @project.posts.find(params[:id])
          respond_to do |format|
              if @post.update(post_params)
                format.html { redirect_to @project, notice: 'Thread was successfully updated.' }
                format.json { render :show, status: :ok, location: @post }
              else
                format.html { render :edit }
                format.json { render json: @post.errors, status: :unprocessable_entity }
              end
            end
      end

      def show
        @project = Project.find(params[:project_id])
        @post = @project.posts.find(params[:id])
        @comment = @post.comments.new
      end
  
  
      def destroy

        @project = Project.find(params[:project_id])
        @post = @project.posts.find(params[:id])
        
        @post.destroy
        
        respond_to do |format|
          format.html { redirect_to project_posts_path(@project), notice: 'Thread was successfully destroyed.' }
          format.json { head :no_content }
        end
      end

    private

    def authorize_admin
      unless current_user.admin?
        redirect_to error_path, notice: "You are not authorized to perform this action."
      end
    end

    def post_params
        params.require(:post).permit(:title, :user_id, :project_id)
    end

    def set_project
      @project = Project.find(params[:project_id])
    end
    
    def set_post
        @post = @project.posts.find(params[:id])
    end

end
