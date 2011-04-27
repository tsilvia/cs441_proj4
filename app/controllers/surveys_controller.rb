class SurveysController < ApplicationController
  
  def admin
    @surveys = Survey.all
	
	respond_to do |format|
	  format.html # admin.html.erb
	  format.xml { render :xml => @surveys }
	end
  end
  
  def take
	@survey = Survey.find(params[:id])
	
	respond_to do |format|
	  format.html # take.html.erb
	  format.xml { render :xml => @surveys }
	end
  end
  
  def result
    @survey = Survey.find(params[:id])
	
	respond_to do |format|
	  format.html # result.html.erb
	  format.xml { render :xml => @surveys }
	end
  end
  
  def stored
    @surveys = Survey.all
	
	@theSurveyId = params[:theSurvey]
	@theQuestions = Survey.find_by_id(@theSurveyId).questions
	@theAnswers = Array.new
	
	@theQuestions.each do |theQ|
		@theAnswers << theQ.id
	end
	
	@theAnswers.each do |anAns|
		@anAnswer = Answer.new(:value => params[:"#{anAns}"], :question_id => anAns)
		@anAnswer.save
	end
	#@firstAnswer = params[:"4"]
	#@secondAnswer = params[:"5"]
	#@thirdAnswer = params[:"6"]
	
	@AllAnswers = Answer.all
	
    respond_to do |format|
	  format.html # stored.html.erb
	  format.xml { render :xml => @surveys }
	end
  end
  
  # GET /surveys
  # GET /surveys.xml
  def index
    @surveys = Survey.all
	if @surveys.empty?
	  @emptyMessage = "No Surveys Found"
	else
	  @emptyMessage = ""
	end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @surveys }
    end
  end

  # GET /surveys/1
  # GET /surveys/1.xml
  def show
    @survey = Survey.find(params[:id])
	@theQuestions = @survey.questions

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @survey }
    end
  end

  # GET /surveys/new
  # GET /surveys/new.xml
  def new
    @survey = Survey.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @survey }
    end
  end

  # GET /surveys/1/edit
  def edit
    @survey = Survey.find(params[:id])
  end

  # POST /surveys
  # POST /surveys.xml
  def create
    @survey = Survey.new(params[:survey])

    respond_to do |format|
      if @survey.save
        format.html { redirect_to('/admin', :notice => 'Survey was successfully created.') }
        format.xml  { render :xml => @survey, :status => :created, :location => @survey }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @survey.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /surveys/1
  # PUT /surveys/1.xml
  def update
    @survey = Survey.find(params[:id])

    respond_to do |format|
      if @survey.update_attributes(params[:survey])
        format.html { redirect_to(@survey, :notice => 'Survey was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @survey.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.xml
  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy

    respond_to do |format|
      format.html { redirect_to(surveys_url) }
      format.xml  { head :ok }
    end
  end
end
