class AnswersController < ApplicationController
  add_breadcrumb "answers", :answers_path

 def index

  end
  
  def show
    
  end
  
  def new
      add_breadcrumb "new", :new_answer_path

    @answer = Answer.new
  end
  
  def create
   
   @question = Question.find(params[:question_id])
   @answer = @question.answers.create(params[:answer])
      if user_signed_in?
        @answer.user_id = current_user.id
      else
        @answer.user_id = 0 + current_admin.id
      end 
    #@answer = current_user.answers.create(params[:answer])
    
    respond_to do |format|
      if @answer.save
        format.html  { redirect_to(@question,
                      :notice => 'Question was successfully submitted.') }
        format.json  { render :json => @question,
                      :status => :created, :location => @question }
      else
        format.html { render :template => "/questions/show.html.erb" }
        format.json  { render :json => @answer.errors,
                      :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end

end
