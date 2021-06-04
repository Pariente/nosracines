class Admin::AliasesController < ApplicationController
  def new
    @alias = Alias.new
    @person = Person.find(params[:person_id])
  end
end