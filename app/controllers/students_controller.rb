class StudentsController < ApplicationController
  
  def index
    @page_title = "Student Services"
  end

  def storage_redirect
    redirect_to students_storage_path
  end

  def card_redirect
    redirect_to students_card_path
  end

  def backup_redirect
    redirect_to students_sugarsync_path
  end
end
