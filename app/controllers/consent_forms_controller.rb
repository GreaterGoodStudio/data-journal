class ConsentFormsController < ApplicationController
  include ActionController::Streaming
  include Zipline

  before_action :find_consent_form

  def create
    @consent_form = @session.consent_forms.new(consent_form_params)
    if @consent_form.save
      SessionChannelWorker.perform_async @session.id, "ConsentForm", @consent_form.id
    else
    end
  end

  def update
    respond_to do |format|
      if @consent_form.update_attributes(consent_form_params)
        format.html { redirect_to(@consent_form, notice: "Consent form was successfully updated.") }
        format.json { respond_with_bip(@consent_form) }
      else
        format.html { render action: "edit" }
        format.json { respond_with_bip(@consent_form) }
      end
    end
  end

  def destroy
    if @consent_form.destroy
      flash[:notice] = "Consent form was deleted."
    else
      flash[:error] = "Problem deleting consent form."
    end

    redirect_to @consent_form.session
  end

  def download
    files = @consent_form.images.lazy.map { |image| [open(image.url), File.basename(image.path)] }
    zipline files, "#{@consent_form.slug}.zip"
  end

  private

    def find_consent_form
      @consent_form = ConsentForm.find(params[:id]) if params[:id]
    end

    def consent_form_params
      params.require(:consent_form).permit(:name, images: [])
    end
end
