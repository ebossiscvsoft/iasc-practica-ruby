#!/usr/bin/env ruby
require "logger"
require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require 'json'
require 'multi_json'
require "sinatra/sane_logging"
require "json-schema"


module Sinatra
  module ParsedJSONBody
    def parsed_body
      ::MultiJson.decode(request.body)
    end
  end

  module JSONValidatorSchema
    def validate(json_string_or_hash)
      JSON::Validator.fully_validate('schema.json', json_string_or_hash, :clear_cache => true)
    end
  end

  helpers JSONValidatorSchema
  helpers ParsedJSONBody
end


class IASCPractica < Sinatra::Application
  register Sinatra::SaneLogging
  helpers Sinatra::ParsedJSONBody
  helpers Sinatra::JSONValidatorSchema

  configure :production, :development do
    enable :logging
  end

  configure :development do
    register Sinatra::Reloader
  end

  post '/request_content' do
    content_type :json
    # {
    #       "lectura": {
    #               "cantidad_datos": 50000,
    #           }
    #    }

    hash = parsed_body
    errors = validate(hash)

    logger.info hash

    logger.debug errors unless errors.empty?

    unless errors.empty?
      status 422
      logger.info errors
      body ({:errors => errors}).to_json
      return
    end

  end

end
