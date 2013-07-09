class QuestionsController < ApplicationController
  
  before_filter :authenticate_any!, :except => [:index, :show]
  
  add_breadcrumb "questions", :questions_path
  def index
    @questions = Question.all
    
    respond_to do |format|
    format.html  # index.html.erb
    format.json  { render :json => @questions }
    end
  end
  
  def show
    
        add_breadcrumb "show", question_path
    @question = Question.find(params[:id])
    @answer = @question.answers.new
    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @question }
    end
  end
  
  def new
    add_breadcrumb "new", new_question_path

    @question = Question.new
  end
  
  def create
    @question = (current_user || current_admin).questions.new(params[:question])
    
    respond_to do |format|
      if @question.save
        format.html  { redirect_to(@question,
                      :notice => 'Question was successfully submitted.') }
        format.json  { render :json => @question,
                      :status => :created, :location => @question }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @question.errors,
                      :status => :unprocessable_entity }
      end
    end
    
  end
  
  def edit
    add_breadcrumb "edit", edit_question_path

     @question = Question.find(params[:id])
  end
  
  def update
    @question = Question.find(params[:id])
 
    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html  { redirect_to(@question,
                      :notice => 'Question was successfully updated.') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @question.errors,
                      :status => :unprocessable_entity }
       end
    end
  
  end
  
  def destroy
     @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url,:notice => 'Question was successfully deleted.' }
      format.json { head :no_content }
    end
  end
  
end
