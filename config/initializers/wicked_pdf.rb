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
  orientation: "Landscape",
  page_size: "Letter",
  margin: {
    top: 12.7, #mm
    bottom: 12.7,
    left: 12.7,
    right: 12.7,
  }
)
