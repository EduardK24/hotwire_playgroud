class PeopleController < ApplicationController
  before_action :set_person, only: %i[show edit update destroy]

  # GET /people or /people.json
  def index
    @persons = Person.all
    respond_to do |format|
      format.json { render json: @persons}
      format.html
    end
  end

  # GET /people/1 or /people/1.json
  def show
    @person = Person.find(params[:id])
  end


  # GET /people/new
  def new
    @person = Person.new
  end

  # POST /people or /people.json
  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to people_path, notice: "Person was successfully created." }
        format.json { render json: @person, status: :created, location: person_url(@person) }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1 or /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to people_path, notice: "Person was successfully updated." }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1 or /people/1.json
  def destroy
    @person.destroy!

    respond_to do |format|
      format.html { redirect_to people_path, notice: "Person was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_person
    @person = Person.find_by_id(params[:id])
    redirect_to people_path, alert: 'Person not found' unless @person
  end

  def person_params
    params.require(:person).permit(:name)
  end
end
