class CommentsController < ApplicationController
    before_action :set_project
    before_action :set_post
    before_action :set_comment, only: [:show, :edit, :update, :destroy]


    def show
        @project = Project.find(params[:project_id])
        @post = @project.posts.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        end
  
      def create
        @project = Project.find(params[:project_id])
        @post = @project.posts.find(params[:post_id])
        @comment = @post.comments.new(comment_params.merge(user: current_user))
        respond_to do |format|
          if @comment.save
            format.html { redirect_to @project, notice: 'Message was successfully created.' }
            format.json { render :show, status: :created, location: @post }
          else
            puts @comment.errors.full_messages
            format.html { render :new }
            format.json { render json: @post.errors, status: :unprocessable_entity }
          end
        end
      end
      
  
      def new
        @project = Project.find(params[:project_id])
        @post = @project.posts.find(params[:post_id])
        @comment = @post.comments.new
      end
    
      def edit
          @project = Project.find(params[:project_id])
          @post = @project.posts.find(params[:post_id])
          @comment = @post.comments.find(params[:id])
      end
    
      def update
        @comment = @post.comments.find(params[:id])
        
        respond_to do |format|
          if @comment.update(comment_params)
              format.html { redirect_to @project, notice: 'Message was successfully Updated.' }
              format.json { render :show, status: :created, location: @comment }
            else
              format.html { render :new }
              format.json { render json: @comment.errors, status: :unprocessable_entity }
            end
          end
      end
    
      def destroy
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to project_posts_path(@project, @post), notice: "Message was successfully deleted."
      end
    
    private

    def set_project
        @project = Project.find(params[:project_id])
      end
  
      def set_post
        @post = @project.posts.find(params[:post_id])
      end
  
      def set_comment
        @comment = @post.comments.find(params[:id])
      end

    def comment_params
        params.require(:comment).permit(:content, :user_id).merge(post_id: params[:post_id], project_id: params[:project_id])
    end
  
end
