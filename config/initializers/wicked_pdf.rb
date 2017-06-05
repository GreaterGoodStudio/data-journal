# WickedPDF Global Configuration
#
# Use this to set up shared configuration options for your entire application.
# Any of the configuration options shown here can also be applied to single
# models by passing arguments to the `render :pdf` call.
#
# To learn more, check out the README:
#
# https://github.com/mileszs/wicked_pdf/blob/master/README.md

# Need to merge for Heroku gem to work
WickedPdf.config ||= {}
WickedPdf.config.merge!(
  layout: "download",
  template: "shared/download",
  # disposition: "attachment",
  orientation: "Landscape",
  margin: {
    top: 0,
    bottom: 0,
    left: 0,
    right: 0
  }
)
