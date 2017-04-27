class ConsentFormsController < ApplicationController
  def create
    @consent_form = @session.consent_forms.new(consent_form_params)
    if @consent_form.save
      SessionChannelWorker.perform_async @session.id, "ConsentForm", @consent_form.id
    else
    end
  end

  private

    def consent_form_params
      params.require(:consent_form).permit(:name, images: [])
    end
end
