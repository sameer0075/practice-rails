class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy,:toggle_status]

  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.published
    #@notes = current_user.notes.published
  end

  def toggle_status
    if @note.draft?
      @note.published!
    elsif @note.published?
      @note.draft!
    end
   redirect_to notes_url, notice: 'Status Has Been Updated.'
  end

  def draft
    if current_user
      @notes = Note.draft
      #@notes = current_user.notes.draft
    else
      redirect_to notes_url
    end
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    if current_user
      @note = Note.new
    else
      redirect_to notes_url
    end
  end

  # GET /notes/1/edit
  def edit
    if !current_user
      redirect_to notes_url
    end
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)
    @note.user = current_user
    respond_to do |format|
      if current_user
        if @note.save
          format.html { redirect_to @note, notice: 'Note was successfully created.' }
          format.json { render :show, status: :created, location: @note }
        else
          format.html { render :new }
          format.json { render json: @note.errors, status: :unprocessable_entity }
        end
      else
        format.html {redirect_to new_user_session_path,notice: 'Login Before Creating Any Note'}
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if current_user
        if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
        else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
        end
      else
        format.html {redirect_to new_user_session_path,notice: 'Login Before Updating Any Note'}
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:title, :body)
    end
end
