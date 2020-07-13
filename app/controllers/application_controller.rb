class ApplicationController < ActionController::Base
    def hello
        # render html: "hola mundo"
        include SessionHelper
    end
end
